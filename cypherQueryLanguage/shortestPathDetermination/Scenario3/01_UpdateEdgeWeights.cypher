// Find Edges between TE Nodes
MATCH (startNode)-[r]->(endNode)
WHERE startNode.timestamp IS NOT NULL 
    AND r.containerType = "22G1"
    AND r.freightType = "GENERAL"
    AND endNode.timestamp IS NOT NULL
    AND r.costs IS NOT NULL
    AND r.duration IS NOT NULL
    AND r.kgCO2e IS NOT NULL
    AND r.transshipment IS NOT NULL

// Calculate the weight of the edge
SET r.weight = round(
    0 * r.costs + 
    0.1 * r.duration + 
    1 * r.kgCO2e + 
    CASE WHEN r.transshipment THEN 0 ELSE 0 END, 
    2
);