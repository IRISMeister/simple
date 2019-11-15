FROM store/intersystems/iris-community:2019.3.0.309.0
# need this. http://turbo.iscinternal.com/prodlog/devview.csp?Key=CTW030

ARG COMMIT_ID="unknown"

#USER root
#ENV DEBIAN_FRONTEND noninteractive
#RUN apt-get update && apt-get install -y tzdata

# IRIS itself doesn't require ja language pack
#RUN apt-get install -y language-pack-ja && update-locale LANG=ja_JP.UTF-8

USER irisowner

ENV SRCDIR=src
COPY simple-atelier-prj/ $SRCDIR/
COPY externalize.txt /home/$ISC_PACKAGE_MGRGROUP/

RUN  iris start $ISC_PACKAGE_INSTANCENAME \ 
 && printf 'Do ##class(Config.NLS.Locales).Install("jpuw") h\n' | iris session $ISC_PACKAGE_INSTANCENAME -U %SYS \
 && printf 'Do $system.OBJ.Load("'$HOME/$SRCDIR'/MyApps/Installer.cls","ck") Set tSC=##class(MyApps.Installer).setup() Do:+tSC=0 $SYSTEM.Process.Terminate($JOB,1) h\n' | iris session $ISC_PACKAGE_INSTANCENAME \
 && iris stop $ISC_PACKAGE_INSTANCENAME quietly

#++ until imageBuildSteps.sh is chnaged++
RUN iris start $ISC_PACKAGE_INSTANCENAME nostu quietly \
 && printf "kill ^%%SYS(\"JOURNAL\") kill ^SYS(\"NODE\") h\n" | iris session $ISC_PACKAGE_INSTANCENAME -B | cat \
 && iris stop $ISC_PACKAGE_INSTANCENAME quietly \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/journal.log \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/IRIS.WIJ \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/iris.ids \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/alerts.log \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/journal/* \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/messages.log
#-- until imageBuildSteps.sh is chnaged--

USER root
# imageBuildSteps makes appuser 'ForceChangePassword' state....
#RUN /usr/irissys/dev/Container/imageBuildSteps.sh

# need to be root because $SRCDIR's owner is root:root.
RUN rm -rf $SRCDIR
USER irisowner
RUN echo $COMMIT_ID > $HOME/commit.txt
