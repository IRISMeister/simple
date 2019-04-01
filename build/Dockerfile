FROM store/intersystems/iris:2019.1.0.510.0-community 

ENV ISC_TEMP_DIR=/tmp/isc
COPY simple-atelier-prj/ $ISC_TEMP_DIR/

# Temporary folder
RUN mkdir -p $ISC_TEMP_DIR \
 && cd $ISC_TEMP_DIR \
 && iris start iris EmergencyID=1,1 \ 
 && printf '1\n1\n \
 zn "USER"\ndo $system.OBJ.Load("/tmp/isc/MyApps/Installer.cls","ck")\n \
 do ##class(MyApps.Installer).setup()\n \
 halt\n' | iris session iris \
 && printf '1\n1\n' | iris stop iris quietly \
 && iris start iris nostu quietly \
 && printf "kill ^%%SYS(\"JOURNAL\") kill ^SYS(\"NODE\") Do INT^SHUTDOWN" | irissession IRIS -B | cat \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/journal.log \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/IRIS.WIJ \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/iris.ids \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/alerts.log \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/journal/* \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/messages.log \
 && rm -rf $ISC_TEMP_DIR

WORKDIR /

