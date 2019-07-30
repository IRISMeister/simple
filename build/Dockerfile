FROM store/intersystems/iris:2019.1.0.511.0-community 

ARG COMMIT_ID="unknown"

ENV DEBIAN_FRONTEND noninteractive
# leave tzdata package to allow choosing arbitary timezone, later
RUN apt-get update && apt-get install -y tzdata

# IRIS itself doesn't require ja language pack
#RUN apt-get install -y language-pack-ja && update-locale LANG=ja_JP.UTF-8

ENV ISC_TEMP_DIR=/tmp/isc
COPY simple-atelier-prj/ $ISC_TEMP_DIR/

# Temporary folder
RUN cd $ISC_TEMP_DIR \
 && iris start iris EmergencyID=1,1 \ 
 && printf '1\n1\n \
 zn "USER" Do $system.OBJ.Load("/tmp/isc/MyApps/Installer.cls","ck") \
 do ##class(MyApps.Installer).setup() \
 zn "MYAPP" do $system.OBJ.ImportDir("/tmp/isc/MyApps/",,"ck",,1) \
 zn "%%SYS" Do INT^SHUTDOWN\n' | iris session iris | cat \
 && iris start iris nostu quietly \
 && printf "kill ^%%SYS(\"JOURNAL\") kill ^SYS(\"NODE\") Do INT^SHUTDOWN" | irissession IRIS -B | cat \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/journal.log \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/IRIS.WIJ \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/iris.ids \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/alerts.log \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/journal/* \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/messages.log \
 && rm -rf $ISC_TEMP_DIR \
 && echo $COMMIT_ID > /commit.txt

WORKDIR /

