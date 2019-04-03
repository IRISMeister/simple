Class MyApp.Dispatcher Extends %CSP.REST
{

Parameter CONVERTINPUTSTREAM = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/test" Method="GET" Call="Test"/>
<Route Url="/get" Method="GET" Call="Get"/>
</Routes>
}

ClassMethod Test() As %Status
{
	
	#; curl -H "Content-Type: application/json; charset=UTF-8" -H "Accept:application/json" "http://localhost:52773/csp/myapp/test" --user "SuperUser:sys"
	s ret={"HostName":($SYSTEM.INetInfo.LocalHostName()),"User":($USERNAME),"Status":"OK","TimeStamp":($ZDATETIME($H))}
	Set ^log($INCREMENT(^log))=ret.TimeStamp
	w ret.%ToJSON(),!
    return $$$OK
}

ClassMethod Get() As %Status
{
	
	Set c="" For { 
		Set c=$O(^log(c)) q:c=""
		s ret={"TimeStamp":(^log(c))}
		w ret.%ToJSON(),!
	}
    return $$$OK
}

}

