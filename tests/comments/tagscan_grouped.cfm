<cfset tagscanQuery = queryNew("g,v", "varchar,varchar", [["a","1"],["a","2"],["b","3"]])>
<cfsavecontent variable="request.tagscan.grouped"><cfoutput query="tagscanQuery" group="g">[#g#:<!--- <cfoutput>x</cfoutput> ---><cfoutput>#v#</cfoutput>]</cfoutput></cfsavecontent>
