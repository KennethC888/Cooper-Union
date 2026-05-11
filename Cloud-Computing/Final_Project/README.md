# ECE 465 Final Project: Distributed Prime Number Cruncher

**Student:** [Your Name]
**Demo Video:** [Insert Unlisted YouTube URL Here]

## Overview
This system is a distributed, fault-tolerant prime number calculator. It demonstrates a Master-Worker architecture, backward error recovery, and strict ZooKeeper consistency protocols (as discussed in Week 10).

## How to Run
1. Ensure Docker and Docker Compose are installed.
2. In the project directory, run:
   ```bash
   docker compose up --build

   Run this if you Ctrl + C to end the task: docker compose down

   Run this while running to see what happens: docker compose kill node2