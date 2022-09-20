Class MyApps.Installer
{

XData setup [ XMLNamespace = INSTALLER ]
{
<Manifest>
  <Var Name="DATADB" Value="${Namespace}-DATA"/>
  <Var Name="CODEDB" Value="${Namespace}-CODE"/>

  <User Username="appuser" PasswordVar="appuserpwd" Roles="" Namespace="" Routine="" ExpirationDate="" Enabled="1" Comment="appilication user"/>

  <Log Text="Creating namespace ${Namespace}" Level="0"/>
  <Namespace Name="${Namespace}" Create="yes" Code="${CODEDB}" Ensemble="0" Data="${DATADB}">
    <Configuration>
      <Database Name="${CODEDB}" Dir="${DBDIR}${CODEDB}" Create="yes" Resource="%DB_${CODEDB}"/>
      <Database Name="${DATADB}" Dir="${DBDIR}${DATADB}" Create="yes" Resource="%DB_${DATADB}"/>
    </Configuration>

    <CSPApplication Url="/csp/${Namespace}" Directory="${CSPDIR}${Namespace}" Resource=""/>
    <Import File="${SRCDIR}" Flags="ck" Recurse="true"/>
    <Invoke Class="MyApp.Utils" Method="Init" CheckStatus="1" Return="RetVal">
    </Invoke>
  </Namespace>

  <Log Text="End Creating namespace ${Namespace}" Level="0"/>

</Manifest>
}

ClassMethod setupMethod(ByRef pVars, pLogLevel As %Integer = 3, pInstaller As %Installer.Installer, pLogger As %Installer.AbstractLogger) As %Status [ CodeMode = objectgenerator, Internal ]
{
  Quit ##class(%Installer.Manifest).%Generate(%compiledclass, %code, "setup")
}

ClassMethod setup(ByRef tVars) As %Status
{
  Set tSC='$$$OK
  Try {
    Set Namespace="MYAPP"
    Set webapp="/csp/"_Namespace

    If '$D(tVars("Namespace")) { Set tVars("Namespace")=Namespace }
    If '$D(tVars("appuserpwd")) { Set tVars("appuserpwd")="sys" }
    If '$D(tVars("SRCDIR")) { Set tVars("SRCDIR")="/home/irisowner/src/MyApp/" }

    #; specify database dir
    If '$D(tVars("DBDIR")) { Set tVars("DBDIR")="/home/irisowner/" }

    Set tSC=..setupMethod(.tVars)
    $$$ThrowOnError(tSC)

    Set oldns=$NAMESPACE
    New $NAMESPACE
    Set $NAMESPACE="%SYS"

#If 1
    #; install ZPM (because I want to use UnitTest related utilities)
    Do ##class(Security.SSLConfigs).Create("z")
    Set r=##class(%Net.HttpRequest).%New(),r.Server="pm.community.intersystems.com",r.SSLConfiguration="z",r.Https=1
    Set tSC=r.Get("/packages/zpm/latest/installer")
    $$$ThrowOnError(tSC)
    Set tSC=$system.OBJ.LoadStream(r.HttpResponse.Data,"c")
    $$$ThrowOnError(tSC)
#EndIf

    Set tSC = ##Class(Security.Applications).Get(webapp,.props)
    $$$ThrowOnError(tSC)
    Set props("DispatchClass")="MyApp.disp"
    Set props("Resource")=""
    Set props("DeepSeeEnabled")=1
    Set props("MatchRoles")=":%All"
    Set props("NameSpace")=Namespace
    Kill props("Type")
    Set tSC = ##Class(Security.Applications).Modify(webapp,.props)
    $$$ThrowOnError(tSC)

    Set $NAMESPACE=oldns

  } Catch(e) {
	  Set tSC=e.AsStatus()
    zw tSC
  }
  Return tSC
}

}
