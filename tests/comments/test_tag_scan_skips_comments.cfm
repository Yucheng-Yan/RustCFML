<cfscript>
suiteBegin("Comments: a tag written inside a CFML comment is not part of the tag structure");

// Lucee strips CFML comments before it reads a tag's structure, so a tag
// written inside one opens, closes and declares nothing. RustCFML's
// preprocessor found a body tag's closing tag, its cfcase branches, its
// cfargument list and its child tags by scanning the raw text, comments
// included, before stripping them:
//   - a comment naming an opening tag left the body unbalanced: "No matching
//     end tag found for tag [cfoutput]";
//   - a comment naming the closing tag ended the body early and the rest of
//     the comment was written to the page;
//   - a commented-out cfcase or cfdefaultcase ran;
//   - a commented-out cfargument became a parameter, and a comment that
//     mentioned another tag ended the argument scan before the real arguments;
//   - a commented-out detail cfoutput became a grouped cfoutput's inner loop;
//   - a commented-out cfinvokeargument was passed.
// A comment opener inside a string, a tag attribute or a cfscript block is
// data, not a comment, even when something later in the page (an HTML
// comment, say) would close one: tagscan_text.cfm.
//
// Fixtures tagscan_*.cfm in this directory. Each is included on its own so
// that one failing to compile cannot hide the others. Expected values were
// measured on Lucee 7.0.4 and 5.3.10.

request.tagscan = {};

function tagscanSquash(required string text) {
	return reReplace(arguments.text, "\s+", "", "all");
}

function tagscanText(required string key) {
	if (!structKeyExists(request.tagscan, arguments.key)) {
		return "(not set)";
	}
	return tagscanSquash(request.tagscan[arguments.key]);
}
</cfscript>

<cftry><cfsavecontent variable="openOut"><cfinclude template="tagscan_open.cfm"></cfsavecontent><cfcatch><cfset openOut = "THREW: " & cfcatch.message></cfcatch></cftry>
<cftry><cfsavecontent variable="bodiesOut"><cfinclude template="tagscan_bodies.cfm"></cfsavecontent><cfcatch><cfset bodiesOut = "THREW: " & cfcatch.message></cfcatch></cftry>
<cftry><cfsavecontent variable="switchOut"><cfinclude template="tagscan_switch.cfm"></cfsavecontent><cfcatch><cfset switchOut = "THREW: " & cfcatch.message></cfcatch></cftry>
<cftry><cfsavecontent variable="argsOut"><cfinclude template="tagscan_args.cfm"></cfsavecontent><cfcatch><cfset argsOut = "THREW: " & cfcatch.message></cfcatch></cftry>
<cftry><cfsavecontent variable="groupedOut"><cfinclude template="tagscan_grouped.cfm"></cfsavecontent><cfcatch><cfset groupedOut = "THREW: " & cfcatch.message></cfcatch></cftry>
<cftry><cfsavecontent variable="invokeOut"><cfinclude template="tagscan_invoke.cfm"></cfsavecontent><cfcatch><cfset invokeOut = "THREW: " & cfcatch.message></cfcatch></cftry>
<cftry><cfsavecontent variable="textOut"><cfinclude template="tagscan_text.cfm"></cfsavecontent><cfcatch><cfset textOut = "THREW: " & cfcatch.message></cfcatch></cftry>

<cfscript>
assert("a comment naming an opening cfoutput leaves the body balanced", tagscanSquash(openOut), "AB");

assert("bodies fixture runs", tagscanSquash(bodiesOut), "");
assert("a comment naming the closing cfoutput does not end the body", tagscanText("cfoutputClose"), "AB");
assert("nested comments are skipped whole", tagscanText("nested"), "AB");
assert("cfsavecontent", tagscanText("savecontent"), "AB");
assert("cfsilent body still runs to its real end", tagscanText("silent"), "");
assert("cfsilent: the code after the comment ran", tagscanText("silentSet"), "set");
assert("cflock", tagscanText("lock"), "AB");
assert("cffunction body", tagscanText("function"), "AB");
assert("a custom tag pair", tagscanText("customTag"), "[wrap:AB]");

assert("switch fixture runs", tagscanSquash(switchOut), "");
assert("a commented-out cfcase does not run", tagscanText("switchCase"), "two");
assert("a commented-out cfdefaultcase does not run", tagscanText("switchDefault"), "default");

assert("arguments fixture runs", tagscanSquash(argsOut), "");
assert("a commented-out cfargument is not a parameter", tagscanText("ghostArgument"), "real");
assert("a comment mentioning another tag does not end the argument list",
	tagscanText("argumentsAfterComment"), "first=Asecond=B");

assert("grouped fixture runs", tagscanSquash(groupedOut), "");
assert("a commented-out detail cfoutput is not the inner loop", tagscanText("grouped"), "[a:12][b:3]");

assert("invoke fixture runs", tagscanSquash(invokeOut), "");
assert("a commented-out cfinvokeargument is not passed", tagscanText("invoke"), "none");

assert("text fixture runs", tagscanSquash(textOut), "");
assert("an unclosed comment opener in a hash-expression string is text", tagscanText("hashExpression"), "a-b");
assert("an unclosed comment opener in a cfscript string is text", tagscanText("scriptString"), "[" & chr(60) & "!---]");
// The same openers followed later in the page by something that ends a
// comment: an HTML comment, or a string holding the closer.
assert("an opener in a hash-expression string, then an HTML comment", tagscanText("hashThenHtmlComment"), "[5]<!--footer-->");
assert("an opener in one cfoutput, a closer string in the next", tagscanText("hashThenCloser"), "[5][4]");
assert("an opener in a cfscript string, then an HTML comment", tagscanText("scriptThenHtmlComment"), "[5]<!--footer-->");
assert("an opener in a tag attribute, then an HTML comment", tagscanText("attributeThenHtmlComment"), "A<!--footer-->");
assert("an opener in one cfcase, an HTML comment in the next", tagscanText("caseThenHtmlComment"), "[b]<!--note-->");
assert("an opener in a custom tag body, then an HTML comment", tagscanText("customTagThenHtmlComment"), "[wrap:A]<!--footer-->");
assert("an opener in an output function body, a closer string after it", tagscanText("functionThenCloser"), "[5][4]");

structDelete(request, "tagscan");

suiteEnd();
</cfscript>
