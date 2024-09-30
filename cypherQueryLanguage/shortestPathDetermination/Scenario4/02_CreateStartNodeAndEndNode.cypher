// Create the virtualStartNode
MERGE (virtualStartNode:VirtualStartNode {id: "UUID-4"})

// Find possible CH start nodes
WITH virtualStartNode
MATCH (:Location {locode: "USATL"})
    -[:HAS_TIME_EXPANDED_TRUCK_DEPARTURE]->
    (timeExpandedTruckDeparture:TimeExpandedTruckDeparture)
WHERE 
    timeExpandedTruckDeparture.timestamp >= 
        localdatetime("2024-01-01T10:00:00")
    AND timeExpandedTruckDeparture.timestamp <= 
        localdatetime("2024-01-08T10:00:00")

// Connect virtual start node to each possible physical start node
MERGE 
    (virtualStartNode)
    -[:STARTS_AT {
        weight: 0, 
        containerType: "22G1", 
        freightType: "GENERAL"}]->
    (timeExpandedTruckDeparture)

// Create the virtualEndNode
MERGE (virtualEndNode:VirtualEndNode {id: "UUID-4"})

// Find possible MH end nodes
WITH virtualStartNode, virtualEndNode
MATCH (:Location {locode: "SGSIN"})
    -[:HAS_CHILD]->
    (:Terminal)
    -[:IS_TIME_EXPANDED_TO]->
    (timeExpandedTerminal:TimeExpandedTerminal)
WHERE 
    timeExpandedTerminal.timestamp >= 
        localdatetime("2024-01-01T10:00:00")
    AND timeExpandedTerminal.timestamp <= 
        localdatetime("2024-03-02T10:00:00")

// Connect possible physical end nodes to virtual end node
MERGE 
    (timeExpandedTerminal)
    -[:ENDS_AT {
        weight: 0, 
        containerType: "22G1", 
        freightType: "GENERAL"}]->
    (virtualEndNode);