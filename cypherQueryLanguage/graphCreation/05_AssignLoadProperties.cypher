LOAD CSV WITH HEADERS FROM 'file:///load.csv' AS row

// Find Vessel Load Relationship for Terminal
MATCH (:TimeExpandedTerminal {terminalCode: row.terminalCode})
    -[r:VESSEL_LOAD {containerType: row.containerType, freightType: row.freightType}]->
    (:VesselDeparture)

// Assign costs, emissions, and transshipments
SET r.costs = toInteger(row.costs),
    r.kgCO2e = toInteger(row.kgCO2e),
    r.transshipment = false;
