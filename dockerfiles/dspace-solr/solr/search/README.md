| Field | Type | Multi | New Type | Note |
| --- | --- | --- | --- | --- |
| `_version_` | long | false | | |
| search_text | text | true | | |  
| fulltext | text | true | | |  
| search.resourceid | true | | | |
| search.resourcetype | sint | | | |
| search.uniqueid | true | | | |
| handle | string | | | |
| withdrawn | string | | | |
| discoverable | string | | | |
| read | string | | | |
| has_content_in_original_bundle | string | true | | |
| handle | string | | | |
| location | lowerCaseSort | true | | |
| location.comm | lowerCaseSort | true | | |
| location.coll | lowerCaseSort | true | | |
| a_spell | textSpell | | | Note copyField directive|
| SolrIndexer.lastIndexed | date | | | |
| lastModified | date | | | |
| *_stored | dspaceMetadataProjection | true | | |
| *_ac | keywordFilter |  true | | |
| *_acid | keywordFilter |  true | | |
| *_filter| keywordFilter |  true | | |
| *_authority | keywordFilter |  true | | |
| *_keyword | keywordFilter |  true | | |
| *_partial | text |  true | | |
| *_hl | text |  true | | |
| *_sort | lowerCaseSort | | | |
| *_mlt | text | true | | |
| *_year | sint | true | | |
| *_dt | date | | | |
