// Load the CSV and update the relationship properties
LOAD CSV WITH HEADERS FROM 'file:///wait_at_terminal.csv' AS row
MATCH (t1:TimeExpandedTerminal {terminalCode: row.terminalCode})-[:HAS_DIRECT_SUCCESSOR]->(t2)
WITH t1, t2, row
CREATE (t1)-[:WAIT_AT_TERMINAL {
    costs: toInteger(row.costs),
    kgCO2e: toInteger(row.kgCO2e),
    containerType: row.containerType,
    freightType: row.freightType,
    transshipment: false
}]->(t2);
