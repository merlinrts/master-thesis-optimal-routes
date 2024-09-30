// Find Edges between TE Nodes
MATCH (startNode)-[r]->(endNode)
WHERE startNode.timestamp IS NOT NULL 
  AND endNode.timestamp IS NOT NULL

WITH startNode, endNode, r, 
    // Calculate duration in hours
     duration.inSeconds(
         startNode.timestamp, 
         endNode.timestamp
     ).hours AS hoursDuration

// Update the relationship with the duration
SET r.duration = hoursDuration;
