<cffunction name="tagscanGhostArgument" output="false"><!--- <cfargument name="ghost" default="g"> ---><cfargument name="real" default="r"><cfreturn listSort(structKeyList(arguments), "textnocase")></cffunction>
<cffunction name="tagscanArgumentsAfterComment" output="false"><!--- note: <cfset> is not used here ---><cfargument name="first"><cfargument name="second"><cfreturn "first=" & (arguments.first ?: "-") & " second=" & (arguments.second ?: "-")></cffunction>
<cfset request.tagscan.ghostArgument = tagscanGhostArgument()>
<cfset request.tagscan.argumentsAfterComment = tagscanArgumentsAfterComment("A", "B")>
