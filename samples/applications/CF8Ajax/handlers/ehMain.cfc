<!-----------------------------------------------------------------------********************************************************************************Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corpwww.coldboxframework.com | www.luismajano.com | www.ortussolutions.com********************************************************************************Author     :	Sana UllahDate        :	March 05 2008Description :	This proxy is an inherited coldbox remote proxy used for enabling	coldbox as a model framework.-----------------------------------------------------------------------><cfcomponent name="main" extends="coldbox.system.eventhandler" output="false">	<!--- This init format is mandatory if you are writing init code else is optional,	      include the super.init(arguments.controller).	<cffunction name="init" access="public" returntype="any" output="false">		<cfargument name="controller" type="any">		<cfset super.init(arguments.controller)>		<!--- Any constructor code here --->		<cfreturn this>	</cffunction>	--->	<cffunction name="onAppInit" access="public" returntype="void" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<cfset var locColdBoxProxy = "">		<cfset var qry1 = queryNew('idt,fname,lname,phone,location') />				<cfloop from="1" to="40" index="i">			<cfset queryAddRow(qry1,1) />			<cfset querySetCell(qry1, 'idt', '#i#')>			<cfset querySetCell(qry1, 'fname', 'fname-q1-#chr(RandRange(65,85))#')>			<cfset querySetCell(qry1, 'lname', 'lname-q1-#chr(RandRange(65,85))#')>			<cfset querySetCell(qry1, 'phone', 'phone-q1-954-555-5555-#i#')>			<cfset querySetCell(qry1, 'location', 'location-q1-#chr(RandRange(65,85))#')>		</cfloop>				<cfset getColdBoxOCM().set("qry1",qry1, 0)>				<!--- Get the location of this app's coldboxproxy.cfc --->		<cfif len(getSetting('AppMapping')) gt 1>			<cfset locColdBoxProxy = getSetting("AppMapping") & ".coldboxproxy">		<cfelse>			<cfset locColdBoxProxy = "coldboxproxy">		</cfif>		 Place it on the cache --->		<cfset getColdBoxOCM().set("locColdBoxProxy",locColdBoxProxy, 0)>	</cffunction>	<cffunction name="onRequestStart" access="public" returntype="void" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<!--- Place the proxy location on the rc for ease of use. --->		<cfset event.setValue('locColdBoxProxy', getColdboxOCM().get('locColdBoxProxy') )>	</cffunction>	<cffunction name="onRequestEnd" access="public" returntype="void" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<!--- ON Request End Here --->	</cffunction>		<cffunction name="onSessionStart" access="public" returntype="void" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<!--- ON session start Here --->	</cffunction>		<cffunction name="onSessionEnd" access="public" returntype="void" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<!--- ON session End Here --->		<cfset var sessionScope = event.getValue("sessionReference")>			</cffunction>	<cffunction name="onException" access="public" returntype="void" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<!--- ON Exception Handler Here --->		<cfscript>			//Grab Exception From request collection, placed by ColdBox			var exceptionBean = event.getValue("ExceptionBean");			//Place exception handler below:		</cfscript>	</cffunction></cfcomponent>