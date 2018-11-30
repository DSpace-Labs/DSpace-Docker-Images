## Migrate Data Types
integer --> pint
float --> pfloat
date --> float

## Set uid to be the uniqueid field

## Do not set defaultSearchId (from old schema)

## Date Faceting - Potential code change needed

There seems to be a change in the mechanism for formulating a date faceted query.  When I attempt to perform a date faceted query in the SolrAdmin screen it appears that some parameters may have changed.

h ID: 8bb27889-eaff-4600-905b-af3a1c39429b and type 3 and handle: 123456789/2
java.lang.NullPointerException
        at org.dspace.statistics.SolrLoggerServiceImpl.queryFacetDate(SolrLoggerServiceImpl.java:935)
        at org.dspace.statistics.content.StatisticsDataVisits.createDataset(StatisticsDataVisits.java:220)
        at org.dspace.statistics.content.StatisticsDisplay.getDataset(StatisticsDisplay.java:88)
