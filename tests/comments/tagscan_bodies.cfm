<cfsavecontent variable="request.tagscan.cfoutputClose"><cfoutput>A<!--- </cfoutput> --->B</cfoutput></cfsavecontent>
<cfsavecontent variable="request.tagscan.nested"><cfoutput>A<!--- x <!--- </cfoutput> ---> <cfoutput> y --->B</cfoutput></cfsavecontent>
<cfsavecontent variable="request.tagscan.savecontent">A<!--- </cfsavecontent> --->B</cfsavecontent>
<cfsavecontent variable="request.tagscan.silent"><cfsilent>X<!--- </cfsilent> ---><cfset request.tagscan.silentSet = "set"></cfsilent></cfsavecontent>
<cfsavecontent variable="request.tagscan.lock"><cflock name="tagscanLock" timeout="5">A<!--- </cflock> --->B</cflock></cfsavecontent>
<cffunction name="tagscanFunctionBody" output="true">A<!--- </cffunction> --->B</cffunction>
<cfsavecontent variable="request.tagscan.function"><cfset tagscanFunctionBody()></cfsavecontent>
<cfimport taglib="." prefix="tsc">
<cfsavecontent variable="request.tagscan.customTag"><tsc:tagscan_wrap>A<!--- </tsc:tagscan_wrap> --->B</tsc:tagscan_wrap></cfsavecontent>
