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
