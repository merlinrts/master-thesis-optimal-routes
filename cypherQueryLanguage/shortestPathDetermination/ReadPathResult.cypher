// Code used to define the node IDs and edge IDs
WITH 
    <Insert List of Nodes here> AS nodeIds,
    <Insert List of Edges here> AS edgeIds

// Unwind the nodeIds list to create pairs of consecutive nodes
UNWIND range(0, size(nodeIds) - 2) AS idx
MATCH (n)-[r]->(m)
WHERE id(n) = nodeIds[idx] AND id(m) = nodeIds[idx + 1] AND id(r) = edgeIds[idx]

// Collect the matched nodes and relationships to return the path
RETURN 
    collect(n) AS nodes,
    collect(r) AS relationships