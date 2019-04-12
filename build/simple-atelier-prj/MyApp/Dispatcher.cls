Class MyApp.Dispatcher Extends %CSP.REST
{

Parameter CONVERTINPUTSTREAM = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/get" Method="GET" Call="Get"/>
<Route Url="/history" Method="GET" Call="History"/>
</Routes>
}

ClassMethod Get() As %Status
{
	#; curl -H "Content-Type: application/json; charset=UTF-8" -H "Accept:application/json" "http://localhost:52773/csp/myapp/test" --user "user:pass"

	Set %response.ContentType="application/json"
	Set %response.CharSet=%request.CharSet
	Set ret={"HostName":($SYSTEM.INetInfo.LocalHostName()),"UserName":($USERNAME),"Status":"OK","TimeStamp":($ZDATETIME($H))}
	Set ^log($INCREMENT(^log))=ret.TimeStamp
	Do ret.%ToJSON() W !
	Return $$$OK
}

ClassMethod History() As %Status
{
	Set %response.ContentType="application/json"
	Set %response.CharSet=%request.CharSet
	Set ret=[]
	
	Set c="" For { 
		Set c=$O(^log(c)) q:c=""
		Do ret.%Push({"TimeStamp":(^log(c))})
	}
	Do ret.%ToJSON() W !
	Return $$$OK
}

}
