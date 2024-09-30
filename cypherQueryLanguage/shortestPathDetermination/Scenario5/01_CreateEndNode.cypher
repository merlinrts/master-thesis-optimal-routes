// Create the virtualEndNode
MERGE (virtualEndNode:VirtualEndNode {id: "UUID-5"})

// Ensure the virtualEndNode is available in the next part of the query
WITH virtualEndNode

// Find possible MH end nodes
MATCH (:Location {locode: "CAMTR"})
    -[:HAS_CHILD]->
    (:Terminal)
    -[:IS_TIME_EXPANDED_TO]->
    (timeExpandedTerminal:TimeExpandedTerminal)
WHERE 
    timeExpandedTerminal.timestamp >= localdatetime("2024-01-01T10:00:00") 
    AND timeExpandedTerminal.timestamp <= localdatetime("2024-03-02T10:00:00")

// Connect possible physical end nodes to virtual end node
MERGE 
    (timeExpandedTerminal)
    -[:ENDS_AT {
        weight: 0, 
        containerType: "22G1", 
        freightType: "GENERAL"}]->
    (virtualEndNode);
