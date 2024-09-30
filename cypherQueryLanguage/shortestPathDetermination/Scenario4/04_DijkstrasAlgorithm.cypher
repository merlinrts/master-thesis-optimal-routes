// Find shortest Path with Dijkstra
CALL gds.shortestPath.dijkstra.stream('UUID-4-GRAPH', {
    sourceNode: <Insert Start ID>
    targetNode: <Insert End ID>,
    relationshipWeightProperty: 'weight'
})
YIELD index, totalCost, nodeIds, costs

// Use nodeIds to determine the relationships in the shortest path
WITH nodeIds, totalCost, costs
UNWIND range(0, size(nodeIds) - 2) AS idx

// Use gds.util.asNode to get the nodes in the shortest path
WITH gds.util.asNode(nodeIds[idx]) AS n, gds.util.asNode(nodeIds[idx + 1]) AS m, nodeIds, totalCost, costs, idx

// Match the relationships in the GDS subgraph between those nodes
MATCH (n)-[r]->(m)
WHERE r.containerType = "22G1" AND r.freightType = "GENERAL"

// Return the nodeIds, edgeIds, and totalCost
WITH collect(r.edgeId) AS edgeIds, nodeIds, totalCost
RETURN 
    nodeIds,
    edgeIds,
    totalCost
LIMIT 1;
