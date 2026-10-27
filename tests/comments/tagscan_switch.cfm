<cfset tagscanValue = 2>
<cfsavecontent variable="request.tagscan.switchCase"><cfswitch expression="#tagscanValue#"><cfcase value="1">one</cfcase><!--- <cfcase value="2">commented</cfcase> ---><cfcase value="2">two</cfcase></cfswitch></cfsavecontent>
<cfset tagscanValue = 9>
<cfsavecontent variable="request.tagscan.switchDefault"><cfswitch expression="#tagscanValue#"><cfcase value="1">one</cfcase><!--- <cfdefaultcase>commented</cfdefaultcase> ---><cfdefaultcase>default</cfdefaultcase></cfswitch></cfsavecontent>
