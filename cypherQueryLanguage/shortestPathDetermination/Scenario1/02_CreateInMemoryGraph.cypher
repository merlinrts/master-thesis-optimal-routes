// Set edgeId to match relationships in GDS
MATCH ()-[r]->() SET r.edgeId = id(edge);

// MATCH entities for Sub-Graph
MATCH (source)-[r]->(target)
WHERE 
    r.containerType = "22G1" 
    AND r.freightType = "GENERAL" 
    AND (r.isRestricted IS NULL OR r.isRestricted = false)
    AND ( 
        (source:VirtualStartNode AND source.id = "UUID-1") 
        OR NOT source:VirtualStartNode )
    AND ( 
        (target:VirtualEndNode AND target.id = "UUID-1") 
        OR NOT target:VirtualEndNode )

// Create the Sub-Graph
WITH gds.graph.project(
    'UUID-1-GRAPH', 
    source, 
    target, 
    { relationshipProperties: r {.weight, .edgeId} }) AS g
RETURN
  g.graphName AS graph, g.nodeCount AS nodes, g.relationshipCount AS rels;