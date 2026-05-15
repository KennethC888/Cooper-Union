# ECE 465 Final Project: Distributed Prime Number Cruncher

Kenneth Chan
**Demo Video:** https://youtu.be/YZgNuAoJt6I

---

## Overview

This system is a distributed, fault-tolerant prime number calculator. It demonstrates a Master-Worker architecture, backward error recovery, and strict ZooKeeper consistency protocols.

## How to Run

1. Ensure Docker and Docker Compose are installed.
2. In the project directory, run:
   ```bash
   docker compose up --build
   ```

### Helpful Commands

* **To stop the project gracefully** (after pressing `Ctrl + C`):
  ```bash
  docker compose down
  ```

* **To test fault tolerance:** Run one of these commands in a separate terminal while the project is running to see how the system reacts to dropped nodes:
  ```bash
  docker compose kill node1
  docker compose kill node2
  docker compose kill node3
  ```

> **Note:** If you kill the master node, the other two worker nodes will be waiting for tasks, and the project will not progress in checking primes.
