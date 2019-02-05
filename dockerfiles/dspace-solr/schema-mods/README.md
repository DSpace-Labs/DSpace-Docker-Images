# search

| Field | Type | Multi | New Type | Note |
| --- | --- | --- | --- | --- |
| search_text | text | true | text_general | |  
| fulltext | text | true | text_general | |  
| search.resourceid | true | false | pint | |
| search.resourcetype | sint | false | pint | |
| search.uniqueid | string | true | string | |
| handle | string | false | | |
| withdrawn | string | false | | |
| discoverable | string | false | | |
| read | string | true | string | |
| has_content_in_original_bundle | string | true | string | |
| location | lowerCaseSort | true | string | New type needed? |
| location.comm | lowerCaseSort | true | string | New type needed? |
| location.coll | lowerCaseSort | true | string | New type needed? |
| a_spell | textSpell | n/a | string | Note copyField directive, set multiValued=true |
| SolrIndexer.lastIndexed | date | false | pdate | |
| lastModified | date | false | pdate| |
| *_stored | dspaceMetadataProjection | true | string | New type needed? |
| *_ac | keywordFilter |  true | string | New type needed? |
| *_acid | keywordFilter |  true | string | New type needed? |
| *_filter| keywordFilter |  true | string | New type needed? |
| *_authority | keywordFilter |  true | string | New type needed? |
| *_keyword | keywordFilter |  true | string | New type needed? |
| *_partial | text |  true | text_general | |
| *_hl | text |  true | text_general  | |
| *_sort | lowerCaseSort | false | string | New type needed?  |
| *_mlt | text | true | text_general | |
| *.year | sint | true | pint | |

# statistics

## Migrate Data Types
- integer --> pint
- float --> pfloat
- date --> pdate

## Set uid to be the uniqueid field

## Do not set defaultSearchId (from old schema)

## Date Faceting - Potential code change needed

There seems to be a change in the mechanism for formulating a date faceted query.  When I attempt to perform a date faceted query in the SolrAdmin screen it appears that some parameters may have changed.
```

ID: 8bb27889-eaff-4600-905b-af3a1c39429b and type 3 and handle: 123456789/2
java.lang.NullPointerException
        at org.dspace.statistics.SolrLoggerServiceImpl.queryFacetDate(SolrLoggerServiceImpl.java:935)
        at org.dspace.statistics.content.StatisticsDataVisits.createDataset(StatisticsDataVisits.java:220)
        at org.dspace.statistics.content.StatisticsDisplay.getDataset(StatisticsDisplay.java:88)
```

# oai

| Field | Type | Multi | New Type | Note |
| --- | --- | --- | --- | --- |
| item.id | uuid | false | string | TBD: need a different type? |  
| item.public | boolean | false | boolean |  |  
| item.handle | string | false | string |  |  
| item.collections | string | true | string |  |  
| item.communities | string | true | string |  |  
| item.lastmodified | date | false | pdate |  |  
| item.submitter | string | false | string |  |  
| item.deleted | boolean | false | boolean |  |  
| item.willChangeStatus | boolean | false | boolean |  |  
| item.compile | string | false | string | |  
| metadata.*" | lengthfilter | true | text | TBD: need a different type? |  

# authority

## Migrate Data Types

Note that these changes are untested.

- text --> text_general
- date --> pdate
