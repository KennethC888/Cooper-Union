# System Design and Architecture
NOTE: 
The system implements a Master-Worker architecture. Master re-election is not implemented, prioritizing worker-node resilience and task-state consistency.

graph TD
    subgraph ZooKeeper_Cluster [ZooKeeper Cluster]
        LL["leader_lock (Ephemeral)"]
        W["workers"]
        TP["tasks/pending"]
        TR["tasks/running"]
    end

    subgraph Compute_Nodes [Compute Nodes]
        Master[Master Node]
        Worker1[Worker Node 1]
        Worker2[Worker Node 2]
    end

    %% Leader Election
    Master -- "1. Wins Election" --> LL
    Worker1 -. "Fails Election" .-> LL
    Worker2 -. "Fails Election" .-> LL

    %% Worker Registration
    Worker1 -- "2. Creates Ephemeral Node" --> W
    Worker2 -- "2. Creates Ephemeral Node" --> W

    %% Task Processing
    Worker1 -- "3. Pulls Task" --> TP
    Worker1 -- "4. Writes Checkpoint State" --> TR
    Worker2 -- "3. Pulls Task" --> TP
    Worker2 -- "4. Writes Checkpoint State" --> TR

    %% Failure Detection & Recovery
    Master -- "5. Monitors for dropped nodes" --> W
    Master -- "6. Reads failed task state" --> TR
    Master -- "7. Re-queues task from checkpoint" --> TP

    classDef zk fill:#e6f3ff,stroke:#3399ff,stroke-width:2px;
    classDef compute fill:#f9f0ff,stroke:#cc99ff,stroke-width:2px;
    class LL,W,TP,TR zk;
    class Master,Worker1,Worker2 compute;