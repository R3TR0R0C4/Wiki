+-----------------------------+
|        VM #1: Database Server|
|-----------------------------|
| - Runs DBMS (e.g., HANA,    |
|   Oracle, SQL Server)        |
| - Stores all SAP data & logs |
| - Handles SQL queries         |
+-------------^---------------+
              |
              |
+-------------|---------------+
|        VM #2: Central Instance|
|------------------------------|
| - Message Server             |
|   (Inter-instance communication &|
|    load balancing)           |
| - Enqueue Server             |
|   (Lock management for data  |
|    consistency)              |
| - Primary application server |
| - SAP Kernel processes       |
+-------------^----------------+
              |
      Communicates for locking, messaging,
      and application coordination
              |
+-------------|----------------+------------------+------------------+
|             |                |                  |                  |
|             |                |                  |                  |
|      VM #3: Dialog Instance 1| VM #4: Dialog Instance 2 | VM #5: Dialog Instance 3 |
|-----------------------------|------------------|------------------|------------------|
| - Handles user dialog & batch| - Same as DI 1   | - Same as DI 1   |
|   processing requests        |                  |                  |
| - Runs dispatchers and work  |                  |                  |
|   processes                 |                  |                  |
| - Connects to DB directly   |                  |                  |
+-----------------------------+------------------+------------------+

