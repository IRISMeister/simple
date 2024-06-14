Class MyApp.TraditionalDisp Extends %CSP.REST [ ProcedureBlock ]
{

Parameter CHARSET = "utf-8";

Parameter CONTENTTYPE = "application/json";

Parameter CONVERTINPUTSTREAM = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
    <Route Url="/post" Method="POST" Call="PostRequest"/>
    </Routes>
}

ClassMethod PostRequest() As %Status
{
    #dim %request As %CSP.Request
    #dim ex As %Exception.AbstractException
    set status=$$$OK
    try {
        #;Set ^deb($INCREMENT(^deb))=$LISTBUILD(%request.CharSet,%request.ContentType,%request.Content.CharSet,%request.Content.ContentType,%request.Content)
        //Bodyに含まれているJSON文字を取得しJSONダイナミックオブジェクトに変換する
        set body={}.%FromJSON(%request.Content)
		If $ISOBJECT(body) {
			set Value=body.Value
		}
		Set ^log2($INCREMENT(^log2))=Value

        //応答作成
		Set res={"HostName":($SYSTEM.INetInfo.LocalHostName()),"UserName":($USERNAME),"Status":"OK","TimeStamp":($ZDATETIME($H)),"EchoValue":(Value)}
        do res.%ToJSON()
    }
    catch ex {
        set status=ex.AsStatus()
    }
    return status
}

}
