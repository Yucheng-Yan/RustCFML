<cfsavecontent variable="request.tagscan.hashExpression"><cfoutput>#replace("a<!---b", "<!---", "-")#</cfoutput></cfsavecontent>
<cfsavecontent variable="request.tagscan.scriptString"><cfoutput><cfscript>tagscanScript = "<!---";</cfscript>[#tagscanScript#]</cfoutput></cfsavecontent>
<cfsavecontent variable="request.tagscan.hashThenHtmlComment"><cfoutput>[#len("<!---")#]</cfoutput><!-- footer --></cfsavecontent>
<cfsavecontent variable="request.tagscan.hashThenCloser"><cfoutput>[#len("<!---")#]</cfoutput><cfoutput>[#len("--->")#]</cfoutput></cfsavecontent>
<cfsavecontent variable="request.tagscan.scriptThenHtmlComment"><cfoutput><cfscript>tagscanOpener = "<!---";</cfscript>[#len(tagscanOpener)#]</cfoutput><!-- footer --></cfsavecontent>
<cfsavecontent variable="request.tagscan.attributeThenHtmlComment"><cfsilent><cfparam name="tagscanAttribute" default="<!---"></cfsilent>A<!-- footer --></cfsavecontent>
<cfset tagscanBranch = "b">
<cfsavecontent variable="request.tagscan.caseThenHtmlComment"><cfoutput><cfswitch expression="#tagscanBranch#"><cfcase value="a">[a=#len("<!---")#]</cfcase><cfcase value="b">[b]<!-- note --></cfcase></cfswitch></cfoutput></cfsavecontent>
<cfimport taglib="." prefix="tsct">
<cfsavecontent variable="request.tagscan.customTagThenHtmlComment"><tsct:tagscan_wrap><cfparam name="tagscanWrapAttribute" default="<!---">A</tsct:tagscan_wrap><!-- footer --></cfsavecontent>
<cffunction name="tagscanOutputFunction" output="true">[#len("<!---")#]</cffunction>
<cfsavecontent variable="request.tagscan.functionThenCloser"><cfset tagscanOutputFunction()><cfoutput>[#len("--->")#]</cfoutput></cfsavecontent>
