LOAD CSV WITH HEADERS FROM 'file:///voyages.csv' AS row

// MATCH vessel schedule nodes for voyage
MATCH 
    (vesselScheduleNode:VesselDeparture|VesselArrival {
        voyageId: toInteger(row.voyageId)})

// Create voyage node
MERGE
    (voyage:Voyage {
        voyageId: toInteger(row.voyageId),
        service: row.service,
        vesselId: toInteger(row.vesselId)
    })    

// Link voyage to vessel schedule
MERGE (vesselScheduleNode)-[:IS_PART_OF]->(voyage)

WITH voyage, row

// Match vessel utilized for voyage
MATCH (vessel:Vessel {vesselId: toInteger(row.vesselId)})

// Link voyage to vessel
MERGE (voyage)-[:HAS_VESSEL]->(vessel);