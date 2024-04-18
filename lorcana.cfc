<cfcomponent  displayname="lorcana">
    <cffunction name="getLorcanaData" access="public" returntype="any">
        <cfargument name="endpoint" default="cards/all" required="true" >
        <cfargument name="ReturnJson" default="true" >
        <cfset var apiUrl = "https://api.lorcana-api.com/">


        <!--- Construct the URL for the specific API endpoint you want to access --->
        <!--- Replace with the actual endpoint path --->

        <!--- Make the API request using <cfhttp> --->
        <cfhttp url="#apiUrl##arguments.endpoint#" method="GET" result="apiResult">
            <cfhttpparam type="header" name="Content-Type" value="application/json" />
        </cfhttp>

        <!--- Parse the API response (assuming it's in JSON format) --->
        <cfif arguments.ReturnJson eq true>
            <cfset apiData = apiResult.fileContent>
        <cfelse>    
            <cfset var apiData = deserializeJSON(apiResult.fileContent)>
        </cfif>
        <!--- Return the parsed data --->
        <cfreturn apiData>
    </cffunction>
</cfcomponent>

