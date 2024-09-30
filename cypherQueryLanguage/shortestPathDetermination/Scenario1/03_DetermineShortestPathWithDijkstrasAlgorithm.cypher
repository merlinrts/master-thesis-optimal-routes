CALL gds.shortestPath.dijkstra.stream('UUID-1-GRAPH', {
    sourceNode: <Insert Start ID>
    targetNode: <Insert End ID>
    relationshipWeightProperty: 'weight'
})
YIELD path
RETURN path;
