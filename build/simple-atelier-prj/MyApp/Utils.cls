Class myapp.Utils [ Abstract ]
{

/// App level initialization if any
ClassMethod Init() As %Status
{
	Set ^ImageBuildDate=$ZDATETIME($H)
	Quit $$$OK
}

}
