FROM intersystems/iris:2019.1.0.510.0-community 

ENV ISC_TEMP_DIR=/tmp/isc
COPY build/ $ISC_TEMP_DIR/

# Temporary folder
RUN mkdir -p $ISC_TEMP_DIR \
 && cd $ISC_TEMP_DIR \
 && echo abc123 > pwd.txt \
 && $ISC_PACKAGE_INSTALLDIR/dev/Cloud/ICM/changePassword.sh $ISC_TEMP_DIR/pwd.txt \
 && iris start iris  && \printf '_SYSTEM\nabc123\ndo $system.OBJ.Load("/tmp/isc/simple-atelier-prj/MyApps/Installer.cls","ck")\ndo ##class(MyApps.Installer).setup()\nhalt\n' | iris session iris \
 && printf "%s\n%s\n%s\n%s\n%s\n%s\n" "_SYSTEM" "abc123" "zn \"%SYS\"" "do INT^JRNSTOP" "kill ^%SYS(\"JOURNAL\") kill ^SYS(\"NODE\") Halt" | iris session iris \
 && iris stop iris quietly \
 && rm -f pwd.txt.done \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/journal.log \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/IRIS.WIJ \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/iris.ids \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/alerts.log \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/journal/* \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/messages.log \
 && head /dev/urandom | tr -dc A-Za-z0-9 | head -c 26 > pwd.txt \
 && $ISC_PACKAGE_INSTALLDIR/dev/Cloud/ICM/changePassword.sh $ISC_TEMP_DIR/pwd.txt \
 && rm -rf $ISC_TEMP_DIR

WORKDIR /

