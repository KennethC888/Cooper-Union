import os
import time
import json
import math
from kazoo.client import KazooClient
from kazoo.exceptions import NodeExistsError, NoNodeError

NODE_ID = os.environ.get("NODE_ID", "unknown")
ZK_HOST = os.environ.get("ZK_HOST", "zookeeper:2181")

# Connect to ZooKeeper
zk = KazooClient(hosts=ZK_HOST)
zk.start()

# Ensure base directory structure exists in ZooKeeper
zk.ensure_path("/workers")
zk.ensure_path("/tasks/pending")
zk.ensure_path("/tasks/running")

def is_prime(n):
    """Simple CPU-bound MapReduce task payload."""
    if n < 2: return False
    for i in range(2, int(math.sqrt(n)) + 1):
        if n % i == 0: return False
    return True

def worker_loop():
    print(f"[{NODE_ID}] Running as WORKER.")
    
    # Failure Detection Mechanism: Create an Ephemeral Node
    # If this container crashes, ZooKeeper natively drops this node!
    try:
        zk.create(f"/workers/{NODE_ID}", ephemeral=True)
    except NodeExistsError:
        pass 

    while True:
        my_task_path = f"/tasks/running/{NODE_ID}"
        
        # 1. Grab a task if we don't have one
        if not zk.exists(my_task_path):
            pending_tasks = zk.get_children("/tasks/pending")
            if pending_tasks:
                task_name = pending_tasks[0]
                pending_path = f"/tasks/pending/{task_name}"
                try:
                    # Read from pending and atomically move to running
                    data, stat = zk.get(pending_path)
                    zk.create(my_task_path, data)
                    zk.delete(pending_path)
                except NoNodeError:
                    pass # Another worker grabbed it first
        
        # 2. Process Task and Manage State
        if zk.exists(my_task_path):
            data, stat = zk.get(my_task_path)
            task = json.loads(data.decode('utf-8'))
            
            print(f"[{NODE_ID}] Working on {task['id']} | Checking {task['current']} to {task['end']}")
            
           # 1. Shrink the chunk size from 500 to 100
            chunk_end = min(task["current"] + 250, task["end"])
            
            for num in range(task["current"], chunk_end + 1):
                if is_prime(num):
                    print(f"[{NODE_ID}] 🎯 FOUND PRIME: {num}")
            
            if chunk_end >= task["end"]:
                print(f"[{NODE_ID}] COMPLETED {task['id']}!")
                zk.delete(my_task_path)
            else:
                # Distributed State Management: Save checkpoint back to ZK
                task["current"] = chunk_end + 1
                print(f"[{NODE_ID}] 💾 SAVING CHECKPOINT: {task['current']}")
                zk.set(my_task_path, json.dumps(task).encode('utf-8'))
            
            # 2. Increase the delay to 3 seconds! 
            # This gives you tons of time to switch windows and type the kill command.
            time.sleep(2)
        else:
            print(f"[{NODE_ID}] Waiting for tasks...")
            time.sleep(1)

def master_loop():
    print(f"[{NODE_ID}] 👑 Elected as MASTER. (DO NOT KILL ME!)")
    time.sleep(10)
    
    # Initialize tasks if the queue is completely empty
    pending = zk.get_children("/tasks/pending")
    running = zk.get_children("/tasks/running")
    if not pending and not running:
        tasks = [
            {"id": "Block_A", "current": 1, "end": 2500},
            {"id": "Block_B", "current": 2501, "end": 5000},
            {"id": "Block_C", "current": 5001, "end": 7500}
        ]
        for t in tasks:
            zk.create(f"/tasks/pending/{t['id']}", json.dumps(t).encode('utf-8'))
            print(f"[{NODE_ID}] Seeded task {t['id']} into pending queue.")
    
    known_workers = set()
    
    while True:
        # Passively monitor the workers directory
        current_workers = set(zk.get_children("/workers"))
        
        # Failure Detection Mechanism
        for worker in list(known_workers):
            if worker not in current_workers:
                print(f"[{NODE_ID}] 🚨 FAILURE DETECTED: {worker} dropped off the network!")
                
                # State Retrieval & Fault Notification
                failed_task_path = f"/tasks/running/{worker}"
                if zk.exists(failed_task_path):
                    data, stat = zk.get(failed_task_path)
                    failed_task = json.loads(data.decode('utf-8'))
                    print(f"[{NODE_ID}] 🔄 RECOVERY: Re-queueing {failed_task['id']} from checkpoint {failed_task['current']}")
                    
                    # Backward Error Recovery: Push back to pending queue
                    zk.create(f"/tasks/pending/{failed_task['id']}", data)
                    zk.delete(failed_task_path)
                
                known_workers.remove(worker)
        
        known_workers.update(current_workers)
        time.sleep(2)

def main():
    print(f"[{NODE_ID}] Node booting up...")
    time.sleep(5) # Give ZooKeeper a moment to start
    
    # Leader Election: The first node to create the ephemeral lock node becomes Master
    is_leader = False
    try:
        zk.create("/leader_lock", b"leader", ephemeral=True)
        is_leader = True
    except NodeExistsError:
        is_leader = False
        
    if is_leader:
        master_loop()
    else:
        worker_loop()

if __name__ == "__main__":
    main()