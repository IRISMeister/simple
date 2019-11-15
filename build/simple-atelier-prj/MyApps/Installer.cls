Class MyApps.Installer
{

XData setup [ XMLNamespace = INSTALLER ]
{
<Manifest>
<Var Name="DATADB" Value="${DB}-DATA-I"/>
<Var Name="CODEDB" Value="${DB}-CODE-I"/>

<User Username="appuser" PasswordVar="appuserpwd" Roles="" Namespace="" Routine="" ExpirationDate="" Enabled="1" Comment="appilication user"/>

<If Condition='(##class(Config.Namespaces).Exists("${Namespace}")=0)'>
  <Log Text="Creating namespace ${Namespace}" Level="0"/>
  <Namespace Name="${Namespace}" Create="yes" Code="${CODEDB}" Ensemble="0" Data="${DATADB}">
    <Configuration>
      <Database Name="${CODEDB}" Dir="${DBDIR}${CODEDB}" Create="overwrite" Resource="%DB_${CODEDB}"/>
      <Database Name="${DATADB}" Dir="${DBDIR}${DATADB}" Create="overwrite" Resource="%DB_${DATADB}"/>
    </Configuration>

    <CSPApplication Url="/csp/${Namespace}" Directory="${CSPDIR}${Namespace}" Resource=""/>
    <Import File="${SRCDIR}" Flags="ck" Recurse="true"/>
    <Invoke Class="myapp.Utils" Method="Init" CheckStatus="1" Return="RetVal">
    </Invoke>
  </Namespace>

  <!-- durable sys makes original(inside container image) user namespace/database inaccesible -->
  <Namespace Name="USERI" Create="yes" Code="USERI" Ensemble="0" Data="USERI">
    <Configuration>
      <Database Name="USERI" Dir="${MGRDIR}/user/" Create="no" MountRequired="0" Resource="%DB_USER" />
    </Configuration>

    <CSPApplication Url="/csp/${Namespace}" Directory="${CSPDIR}${Namespace}" Resource=""/>
    <Import File="${SRCDIR}" Flags="ck" Recurse="true"/>
  </Namespace>

  <Log Text="End Creating namespace ${Namespace}" Level="0"/>
</If>

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
    If '$D(tVars("SRCDIR")) { Set tVars("SRCDIR")="/home/irisowner/src/myapp/" }
    #; create app db in other place than MGRDIR so that
    #; you can change R/W depending on whether you are in dev/test/prod environment
    #; Is this really a good idea??
    If '$D(tVars("DB")) { Set tVars("DB")=Namespace }
    If '$D(tVars("DBDIR")) { Set tVars("DBDIR")="/home/irisowner/db/" }
    Set tSC=..setupMethod(.tVars)
    If $$$ISERR(tSC) { Return tSC}

    Set oldns=$NAMESPACE
    New $NAMESPACE   ; just in case
    Set $NAMESPACE="%SYS"

    Set tSC = ##Class(Security.Applications).Get(webapp,.props)
    Set props("DispatchClass")="myapp.disp"
    Set props("Resource")=""
    Set props("DeepSeeEnabled")=1
    Set props("MatchRoles")=":%All"
    Set props("NameSpace")=Namespace
    Kill props("Type")
    Set tSC = ##Class(Security.Applications).Modify(webapp,.props)

    Set $NAMESPACE=oldns

  } Catch(e) {
	  Set tSC=e.AsStatus()
  }
  Return tSC
}

ClassMethod externalize() As %Status
{
  Set tSC='$$$OK
  Try {

	  Set oldns=$NAMESPACE
	  New $NAMESPACE   ; just in case
	  Set $NAMESPACE="%SYS"

    #; make app databases external to container.
    Set dbname="MYAPP-DATA"
    Set dbpath="/vol-data/myapp-data"
    Set db=##Class(SYS.Database).%New()
    Set db.Directory=dbpath
    Set status=db.%Save()

    Set Properties("Directory")=dbpath
    Set Status=##Class(Config.Databases).Create(dbname,.Properties)
    Set tSC=##Class(Config.Namespaces).Get("myapp",.Properties)
    Set Properties("Globals")=dbname
    Set tSC=##Class(Config.Namespaces).Modify("myapp",.Properties)

	  Set $NAMESPACE=oldns
  } Catch(e) {
	  Set tSC=e.AsStatus()
  }
  Return tSC
}

}
