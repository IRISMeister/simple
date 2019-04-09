Class MyApp.Utils [ Abstract ]
{

ClassMethod Init(webapp = "") As %Status
{
	Set $NAMESPACE="%SYS"
	Set tSC = ##Class(Security.Applications).Get(webapp,.props)
	Set props("DispatchClass")="MyApp.Dispatcher"
	Set props("Resource")=""
	Kill props("Type")
	Set tSC = ##Class(Security.Applications).Modify(webapp,.props)
	Quit tSC
}

}
