﻿/**
 * Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
 * www.ortussolutions.com
 * ---
 * I model an Exception
 */
component accessors="true" {

	/**
	 * Exception Struct
	 */
	property name="exceptionStruct";
	/**
	 * Custom error messages
	 */
	property name="extraMessage";
	/**
	 * Extra info for exception tracking
	 */
	property name="extraInfo";

	// STATIC Constructs
	variables.STRINGNULL = "";
	variables.ARRAYNULL  = [];

	/**
	 * Constructor
	 *
	 * @errorStruct  The CFML error structure
	 * @extraMessage Custom error messages
	 * @extraInfo    Extra info to store in the error
	 */
	ExceptionBean function init(
		any errorStruct  = {},
		any extraMessage = "",
		any extraInfo    = ""
	){
		// init exception to empty struct
		variables.exceptionStruct = {};
		// If valid arguments, then populate it.
		if ( isObject( arguments.errorStruct ) || isStruct( arguments.errorStruct ) ) {
			variables.exceptionStruct = arguments.errorStruct;
		}
		variables.extraMessage = arguments.extraMessage;
		variables.extraInfo    = arguments.extraInfo;

		return this;
	}

	/**
	 * Get memento representation
	 */
	struct function getMemento(){
		return {
			"exceptionStruct" : variables.exceptionStruct,
			"extraMessage"    : variables.extraMessage,
			"extraInfo"       : variables.extraInfo
		};
	}

	/**
	 * Set Memento
	 *
	 * @memento The mento to set
	 */
	ExceptionBean function setMemento( required memento ){
		structAppend( variables, arguments.memento, true );
		return this;
	}

	/**
	 * Get error type
	 */
	function getType(){
		if ( structKeyExists( variables.exceptionStruct, "type" ) ) {
			return variables.exceptionStruct.type;
		}
		return variables.STRINGNULL;
	}

	/**
	 * Get error message
	 */
	function getMessage(){
		if ( structKeyExists( variables.exceptionStruct, "message" ) ) {
			return variables.exceptionStruct.message;
		}
		return variables.STRINGNULL;
	}

	/**
	 * Get error detail
	 */
	function getDetail(){
		if ( structKeyExists( variables.exceptionStruct, "detail" ) ) {
			return variables.exceptionStruct.detail;
		}
		return variables.STRINGNULL;
	}

	/**
	 * Get error stackTrace
	 */
	function getStackTrace(){
		if ( structKeyExists( variables.exceptionStruct, "StackTrace" ) ) {
			return variables.exceptionStruct.StackTrace;
		}
		return variables.STRINGNULL;
	}

	/**
	 * Get error tag context
	 */
	array function getTagContext(){
		if ( structKeyExists( variables.exceptionStruct, "TagContext" ) ) {
			return variables.exceptionStruct.TagContext;
		}
		return variables.ARRAYNULL;
	}

	/**
	 * Get tag context as string
	 */
	function getTagContextAsString(){
		var thisTagContext = getTagContext();

		if ( arrayLen( thisTagContext ) ) {
			var entry     = "";
			var rtnString = "";
			for ( var thisRow in thisTagContext ) {
				savecontent variable="entry" {
					writeOutput( " ID: " );
					if ( not structKeyExists( thisRow, "ID" ) ) {
						writeOutput( "N/A;" );
					} else {
						writeOutput( "#thisRow.id#;" );
					}
					writeOutput( " LINE: #thisRow.line#; TEMPLATE: #thisRow.template# #chr( 13 )##chr( 10 )#" );
				}
				rtnString &= entry;
			}
			return rtnString;
		}

		return variables.STRINGNULL;
	}

	/**
	 * Get native error code
	 */
	function getNativeErrorCode(){
		if ( structKeyExists( variables.exceptionStruct, "nativeErrorCode" ) ) {
			return variables.exceptionStruct.nativeErrorCode;
		}
		return variables.STRINGNULL;
	}

	/**
	 * Get SQL State
	 */
	function getSqlState(){
		if ( structKeyExists( variables.exceptionStruct, "sqlState" ) ) {
			return variables.exceptionStruct.sqlState;
		}
		return variables.STRINGNULL;
	}

	/**
	 * Get SQL
	 */
	function getSql(){
		if ( structKeyExists( variables.exceptionStruct, "sql" ) ) {
			return variables.exceptionStruct.sql;
		}
		return variables.STRINGNULL;
	}

	/**
	 * Get queryError
	 */
	function getQueryError(){
		if ( structKeyExists( variables.exceptionStruct, "queryError" ) ) {
			return variables.exceptionStruct.queryError;
		}
		return variables.STRINGNULL;
	}

	/**
	 * Get where portion
	 */
	function getWhere(){
		if ( structKeyExists( variables.exceptionStruct, "where" ) ) {
			return variables.exceptionStruct.where;
		}
		return variables.STRINGNULL;
	}

	/**
	 * Get err number
	 */
	function getErrNumber(){
		if ( structKeyExists( variables.exceptionStruct, "errNumber" ) ) {
			return variables.exceptionStruct.errNumber;
		}
		return variables.STRINGNULL;
	}

	/**
	 * Get missing file name
	 */
	function getMissingFileName(){
		if ( structKeyExists( variables.exceptionStruct, "missingFileName" ) ) {
			return variables.exceptionStruct.missingFileName;
		}
		return variables.STRINGNULL;
	}

	/**
	 * Get lock name
	 */
	function getLockName(){
		if ( structKeyExists( variables.exceptionStruct, "lockName" ) ) {
			return variables.exceptionStruct.lockName;
		}
		return variables.STRINGNULL;
	}

	/**
	 * Get lock operation
	 */
	function getLockOperation(){
		if ( structKeyExists( variables.exceptionStruct, "lockOperation" ) ) {
			return variables.exceptionStruct.lockOperation;
		}
		return variables.STRINGNULL;
	}

	/**
	 * Get error code
	 */
	function getErrorCode(){
		if ( structKeyExists( variables.exceptionStruct, "errorCode" ) ) {
			return variables.exceptionStruct.errorCode;
		}
		return variables.STRINGNULL;
	}

	/**
	 * Get error extended info
	 */
	function getExtendedInfo(){
		if ( structKeyExists( variables.exceptionStruct, "extendedInfo" ) ) {
			return variables.exceptionStruct.extendedInfo;
		}
		return variables.STRINGNULL;
	}

	/**
	 * String representation of this error
	 */
	function $toString(){
		var buffer = "";

		// Prepare String Buffer
		buffer = createObject( "java", "java.lang.StringBuilder" ).init( getExtraMessage() & chr( 13 ) );

		if ( getType() neq "" ) {
			buffer.append( "CFErrorType=" & getType() & chr( 13 ) );
		}
		if ( getDetail() neq "" ) {
			buffer.append( "CFDetails=" & getDetail() & chr( 13 ) );
		}
		if ( getMessage() neq "" ) {
			buffer.append( "CFMessage=" & getMessage() & chr( 13 ) );
		}
		if ( getStackTrace() neq "" ) {
			buffer.append( "CFStackTrace=" & getStackTrace() & chr( 13 ) );
		}
		if ( getTagContextAsString() neq "" ) {
			buffer.append( "CFTagContext=" & getTagContextAsString() & chr( 13 ) );
		}
		if ( isSimpleValue( getExtraInfo() ) ) {
			buffer.append( "CFExtraInfo=" & getExtraInfo() & chr( 13 ) );
		} else {
			buffer.append(
				"CFExtraInfo=" & new coldbox.system.core.util.Util().toJson( getExtraInfo() ) & chr( 13 )
			);
		}
		return buffer.toString();
	}

	/**
	 * Process Stack trace for errors
	 *
	 * @str The stacktrace to process
	 *
	 * @return The nicer trace
	 */
	function processStackTrace( required str ){
		// cfformat-ignore-start

		// Not using encodeForHTML() as it is too destructive and ruins whitespace chars and other stuff
		arguments.str = HTMLEditFormat( arguments.str );
		// process functions e.g. $funcINDEX.runFunction(
		arguments.str = reReplaceNoCase( arguments.str, "\$([^(\(|\:)]+)(\:|\()", "<span class='method'>$\1</span>(", "ALL" );
		// process characters within parentheses e.g. (ServletAuthenticationCallHandler.java:57)
		arguments.str = reReplaceNoCase( arguments.str, "\(([^\)]+)\)", "<span class='highlight'>(\1)</span>", "ALL" );
		// process characters in brackets e.g. [hello world]
		arguments.str = reReplaceNoCase( arguments.str, "\[([^\]]+)\]", "<span class='highlight'>[\1]</span>", "ALL" );
		arguments.str = replace( arguments.str, chr( 13 ) & chr( 10 ), chr( 13 ) , 'all' );
		arguments.str = replace( arguments.str, chr( 10 ), chr( 13 ) , 'all' );
		arguments.str = replace( arguments.str, chr( 13 ), '<br>' , 'all' );
		arguments.str = replaceNoCase( arguments.str, chr(9), repeatString( "&nbsp;", 4 ), "all" );

		// cfformat-ignore-end

		return arguments.str;
	}

	/**
	 * Process a message for display
	 *
	 * @str The string to process
	 */
	function processMessage( required str ){
		reMatchNoCase( "\[[^\]]*\]", arguments.str ).each( function( item ){
			str = replace(
				str,
				arguments.item,
				"<span class='highlight'>#arguments.item#</span>
",
				"all"
			);
		} );
		return arguments.str;
	}

	/**
	 * String limiting utility
	 *
	 * @str    The target
	 * @limit  The limiting number
	 * @ending The postfix
	 */
	function stringLimit( str, limit, ending = "..." ){
		if ( len( arguments.str ) <= arguments.limit ) {
			return arguments.str;
		}
		return mid( arguments.str, 1, arguments.limit ) & arguments.ending;
	}

	/**
	 * Build a table for a specific scope to be displayed
	 *
	 * @scope The scope to display
	 *
	 * @return The HTML of the scope data
	 */
	function displayScope( required scope ){
		var list = createObject( "java", "java.lang.StringBuilder" ).init(
			"<table class="" data-table "">
	<tbody>
		"
		);
		var orderedArr = arguments.scope;

		if ( structKeyExists( arguments.scope, "itemorder" ) ) {
			orderedArr = arguments.scope.itemorder;
		}

		for ( var i in orderedArr ) {
			list.append(
				"<tr>
			"
			);

			// Null Checks
			if ( !structKeyExists( arguments.scope, i ) || isNull( arguments.scope[ i ] ) ) {
				arguments.scope[ i ] = "<span style='color: red'>
				<strong>Java Null</strong>
			</span>
			";
			}

			if ( isDate( arguments.scope[ i ] ) ) {
				list.append(
					"<td width="" 250 "">" & i & "</td>
			"
				);
				list.append(
					"<td class="" overflow-scroll "">" &
					dateFormat( arguments.scope[ i ], "mm/dd/yyyy" ) & " " &
					timeFormat( arguments.scope[ i ], "HH:mm:ss" ) & "</td>
			"
				);
			} else if ( isSimpleValue( arguments.scope[ i ] ) && i == "SQL Sent" ) {
				// Special highlighing for SQL
				var exceptionMessage = "";
				var lines            = 0;
				try {
					// Get error line from position in error details
					exceptionMessage      = arguments.scope[ "Exception Detail" ];
					var lineNumberResults = reFind(
						"Position\: ([0-9]+)",
						exceptionMessage,
						0,
						true,
						"all"
					);
					if (
						isArray( lineNumberResults )
						&& arrayLen( lineNumberResults )
						&& arrayLen( lineNumberResults[ 1 ].match ) == 2
					) {
						var lineBreaks = reFind(
							"\n",
							trim( left( arguments.scope[ i ], lineNumberResults[ 1 ].match[ 2 ] ) ),
							0,
							false,
							"all"
						);
						lines = isArray( lineBreaks ) ? arrayLen( lineBreaks ) : 0;
						lines++; // starts at 1 not 0
						exceptionMessage &= " (line #lines#)"
					}
				} catch ( e any ) {
				}

				list.append( "<td class="" code-cell "" width="" 250 "">" & i & "</td>" );

				list.append(
					"<td class="" code-cell overflow-scroll ""><pre>"
					& ( len( exceptionMessage ) ? exceptionMessage : "<em>---</em>" ) &
					"</pre><pre  class=""brush:sql;gutter:false;highlight: #lines#"">
			" & ( len( arguments.scope[ i ] ) ? arguments.scope[ i ] : "<em>---</em>" ) & "</pre></td>"
				);
			} else if (
				isJSON( arguments.scope[ i ] ) && arrayFind( [ "{", "[" ], left( arguments.scope[ i ], 1 ) ) > 0
			) {
				// Special formatting for JSON Strings
				list.append( "<td class="" code-cell "" width="" 250 "">" & i & "</td>" );

				list.append(
					"<td class="" code-cell overflow-scroll ""><pre class=""brush:js;gutter:false"">"
					& ( len( arguments.scope[ i ] ) ? formatJSON( arguments.scope[ i ] ) : "<em>---</em>" ) & "</pre></td>"
				);
			} else if ( isSimpleValue( arguments.scope[ i ] ) ) {
				list.append(
					"<td width="" 250 "">" & i & "</td>
			"
				);
				list.append(
					"<td class="" overflow-scroll "">
				" & (
						len( arguments.scope[ i ] ) ? arguments.scope[ i ] : "<em>---</em>
				"
					) & "
			</td>
			"
				);
			} else if ( isObject( arguments.scope[ i ] ) ) {
				list.append(
					"<td width="" 250 "">" & i & "</td>
			"
				);
				list.append(
					"<td class="" overflow-scroll "">[" & getMetadata( arguments.scope[ i ] ).name & "] Instance</td>
			"
				);
			} else {
				savecontent variable="local.myContent" {
					try {
						writeDump(
							var    = arguments.scope[ i ],
							format = "html",
							top    = 2,
							expand = false
						)
					} catch ( any e ) {
						writeDump(
							var    = arguments.scope[ i ].toString(),
							format = "html",
							top    = 2,
							expand = false
						)
					}
				}
				list.append(
					"<td width="" 250 "">" & i & "</td>
			"
				);
				list.append(
					"<td class="" overflow-scroll "">" & local.myContent & "</td>
			"
				);
			}
			list.append(
				"
		</tr>
		"
			);
		}

		if ( !structCount( arguments.scope ) ) {
			list.append(
				"<tr>
			<td>
				<em>No details found!</em>
			</td>
		</tr>
		"
			);
		}

		list.append(
			"
	</tbody>
</table>
"
		);

		return list.toString();
	}


	/**
	 * Formats a JSON string with indents &amp; new lines.
	 * v1.0 by Ben Koshy
	 *
	 * @param   str      JSON string (Required)
	 * @author  Ben Koshy (cf@animex.com)
	 * @version 0, September 16, 2012
	 *
	 * @return Returns a string of indent-formated JSON
	 */
	// formatJSON() :: formats and indents JSON string
	// based on blog post @ http://ketanjetty.com/coldfusion/javascript/format-json/
	// modified for CFScript By Ben Koshy @animexcom
	// usage: result = formatJSON('STRING TO BE FORMATTED') OR result = formatJSON(StringVariableToFormat);

	public string function formatJSON( str ){
		var fjson     = "";
		var pos       = 0;
		var regex     = ":""([^""]+)?.*";
		var strLen    = len( arguments.str );
		var indentStr = "  "; // Adjust Indent Token If you Like
		var newLine   = chr( 10 ); // Adjust New Line Token If you Like

		var string      = "";
		var prev        = "";
		var char        = "";
		var commaPos    = 0;
		var commaPosArr = [];
		for ( var i = 1; i < strlen; i++ ) {
			char = mid( arguments.str, i, 1 );
			prev = "";
			if ( i != 1 ) {
				prev = mid( arguments.str, i - 1, 1 );
			}
			strhascomma = false;

			if ( prev == ":" && char == """" ) {
				string      = mid( arguments.str, i - 1, ( strLen - i ) );
				string      = reReplaceNoCase( string, regex, "\1" );
				commaposarr = reFindNoCase( ",", string, 1, true );
				if ( commaposarr.pos[ 1 ] != 0 ) {
					commapos = "i" + commaposarr.pos[ arrayLen( commaposarr.pos ) ];
				}
			}

			if ( char == "}" || char == "]" ) {
				fjson &= newLine;
				pos = pos - 1;
				for ( var j = 1; j <= pos; j++ ) {
					fjson &= indentStr;
				}
			}

			fjson &= char;
			if ( char == "{" || char == "[" || ( char == "," && i != commaPos ) ) {
				commapos = 0;
				fjson &= newLine;
				if ( char == "{" || char == "[" ) {
					pos = pos + 1;
				}
				for ( var k = 1; k <= pos; k++ ) {
					fjson &= indentStr;
				}
			}
		}
		fjson &= newLine & "}";
		return trim( fjson );
	}




	/**
	 * Compose a screen for a file to open in an editor
	 *
	 * @event    The request context
	 * @instance An instance of a tag context array
	 *
	 * @return The string for the IDE
	 */
	function openInEditorURL( required event, required struct instance ){
		var editor = arguments.event.getController().getSetting( name: "exceptionEditor", defaultValue: "vscode" );
		switch ( editor ) {
			case "vscode":
				return "vscode://file/#arguments.instance.template#:#arguments.instance.line#";
			case "vscode-insiders":
				return "vscode-insiders://file/#arguments.instance.template#:#arguments.instance.line#";
			case "sublime":
				return "subl://open?url=file://#arguments.instance.template#&line=#arguments.instance.line#";
			case "textmate":
				return "txmt://open?url=file://#arguments.instance.template#&line=#arguments.instance.line#";
			case "emacs":
				return "emacs://open?url=file://#arguments.instance.template#&line=#arguments.instance.line#";
			case "macvim":
				return "mvim://open/?url=file://#arguments.instance.template#&line=#arguments.instance.line#";
			case "idea":
				return "idea://open?file=#arguments.instance.template#&line=#arguments.instance.line#";
			case "atom":
				return "atom://core/open/file?filename=#arguments.instance.template#&line=#arguments.instance.line#";
			case "espresso":
				return "x-espresso://open?filepath=#arguments.instance.template#&lines=#arguments.instance.line#";
			default:
				return "";
		}
	}

}
