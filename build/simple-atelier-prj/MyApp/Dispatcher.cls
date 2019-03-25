Class MyApp.Dispatcher Extends %CSP.REST
{

Parameter CONVERTINPUTSTREAM = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/test" Method="GET" Call="Test"/>
</Routes>
}

ClassMethod Test() As %Status
{
	
	#; curl -H "Content-Type: application/json; charset=UTF-8" -H "Accept:application/json" "http://localhost:52773/csp/myapp/test" --user "SuperUser:ISC-Japan"
	s ret={"Status":"OK","TimeStamp":($ZDATETIME($H))}
	w ret.%ToJSON(),!
    return $$$OK
}

}

