// Load Geographical Hierarchy

// Create Country Nodes
LOAD CSV WITH HEADERS FROM 'file:///countries.csv' AS row
CREATE (country:Country {countryCode: row.countryCode, name: row.name});

// Create Region Nodes
// Link Regions to Parent Countries
LOAD CSV WITH HEADERS FROM 'file:///regions.csv' AS row
MATCH (country:Country {countryCode: row.countryCode})
CREATE (region:Region {regionCode: row.regionCode, name: row.name})
WITH country, region
CREATE (country)-[:HAS_CHILD]->(region);

// Create Location Nodes
// Link Locations to Parent Regions
LOAD CSV WITH HEADERS FROM 'file:///locations.csv' AS row
MATCH (region:Region {regionCode: row.regionCode})
CREATE (location:Location {locode: row.locode, name: row.name, lat:toFloat(row.lat), lon:toFloat(row.lon)})
WITH region, location
CREATE (region)-[:HAS_CHILD]->(location);

// Create Terminal Nodes
// Link Terminals to Parent Locations
LOAD CSV WITH HEADERS FROM 'file:///terminals.csv' AS row
MATCH (location:Location {locode: row.locode})
CREATE (terminal:Terminal {
    terminalCode: row.terminalCode, 
    name: row.name, 
    lat:location.lat, 
    lon:location.lon})
WITH location, terminal
CREATE (location)-[:HAS_CHILD]->(terminal);
