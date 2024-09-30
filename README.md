# Modeling and Development of a Prototype for Intermodal Networks in Graph Databases to Optimize Container Transport Routes

This repository contains the implementation code for the master's thesis titled "Modeling and Development of a Prototype for Intermodal Networks in Graph Databases to Optimize Container Transport Routes" by Merlin Ritsch. The project demonstrates how graph databases can be used to model complex intermodal transportation networks and determine the shortest path for container shipping routes using Neo4j.

## Project Structure

The project is divided into several directories based on different aspects of graph creation, data management, and path determination. Each folder contains Cypher scripts that contribute to the overall functionality of the system.

### 1. conceptualDataset
This directory contains data related to the conceptual dataset introduced in Chapter 4.2 of the thesis.

- **geographicalStructure**: Defines the hierarchical geographical structure.
- **transport**: Contains schedules for vessel, barge and rail as well as possible truck connections.
- **terminalOperations**: Holds data related to operations at terminals.
- **img**: Holds a map of the conceptual dataset, reflecting the connections. Further, it contains a graphic where the developed model is applied to the European part of the network.


### 2. cypherQueryLanguage
This directory contains Cypher scripts for CRUD operations, graph creation, and path determination in Neo4j. The code is referenced in Chapter 5 of the thesis.

- **crudOperations**
Contains scripts for managing data entities in the graph database, including creating, reading, updating, and deleting nodes and relationships, referenced in Section 5.2.

- **graphCreation** Contains graph creation scripts, referenced in Section 5.1. Validation can be done with `99_Validation.cypher`.

- **shortestPathDetermination** Scripts in this folder are used to determine the shortest paths (Section 5.3). The folder also includes several scenario scripts:

    - **Scenario 1:** Regular DEMUC to USCHI with (CH/MH)
    - **Scenario 2:** Restricted Graph due to labor strike
    - **Scenario 3:** Optimize for emission reduction
    - **Scenario 4:** Vessel Transshipment
    - **Scenario 5:** Flexible Start Point

- **ReadPathResult.cypher**: Reads the result from GDS shortest path and presents the whole route with all available details.

## Installation and Usage

1. **Setup Neo4j**:
   - Install Neo4j and ensure that the GDS library is enabled. 
   - Create a new database.

2. **Import Dataset**:
   - Import the conceptual dataset to the import folder of your Neo4j Graph Database.
   - Use the scripts in the graphCreation directory to create the initial graph structure.

3. **Running CRUD Operations**:
   - Use scripts in the crudOperations directory to add, read, or update entities.

4. **Determining the Shortest Path**:
   - Execute scripts in the shortestPathDetermination directory to find the optimal route based on cost, emissions, time, or transshipments. Each scenario can be run to validate different use cases.
   - Adjust the code for testing other cases.

## Additional Information

For more details, please refer to the thesis document, which provides an in-depth explanation of the graph modeling approach, dataset structure, and evaluation of the prototype.
