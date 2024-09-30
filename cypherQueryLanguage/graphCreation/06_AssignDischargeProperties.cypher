LOAD CSV WITH HEADERS FROM 'file:///discharge.csv' AS row

// Find Vessel Load Relationship for Terminal
MATCH (:VesselArrival)
    -[r:VESSEL_DISCHARGE {containerType: row.containerType, freightType: row.freightType}]->
    (:TimeExpandedTerminal {terminalCode: row.terminalCode})

// Assign costs, emissions, and transshipments
SET r.costs = toInteger(row.costs),
    r.kgCO2e = toInteger(row.kgCO2e),
    r.transshipment = true;
