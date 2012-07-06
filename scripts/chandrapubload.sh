#!/bin/bash

PARENT=Chandra
MISSION=chandra
LOGFILE=../${MISSION}.log
RDFSTORE=../chandra-rdf
MISSIONSTORE=../AstroExplorer/Missions/${PARENT}/${MISSION}/transferdata

# run the stage, logging start and end time, as well as
# the status, to $LOGFILE
#
# Arguments:
#    label  - used for logging
#    python script
#    arguments to script
#
runStage() {
    if [ $# -gt 1 ]; then
	lbl=$1
	shift
	echo "START  ${lbl} `date`" >> $LOGFILE
	python $@
	if [ $? -eq 0 ]; then
	    echo "END    ${lbl} `date`" >> $LOGFILE
	else
	    echo "FAILED ${lbl} `date`" >> $LOGFILE
	fi
    fi
}

echo "# Logging to $LOGFILE"
touch $LOGFILE
echo "######################################" >> $LOGFILE
echo "# Starting script: `date`" >> $LOGFILE

runStage "adsload aa"    loadfiles.py ${MISSIONSTORE}/pubsaa.biblist.txt
runStage "simbadload aa" loadfiles-simbad.py ${MISSIONSTORE}/pubsaa.biblist.txt
runStage "pubload aa"    chandra/loadfiles.py ${MISSIONSTORE}/pubsaa.biblist.txt pub
runStage "adsload ab"    loadfiles.py ${MISSIONSTORE}/pubsab.biblist.txt
runStage "simbadload ab" loadfiles-simbad.py ${MISSIONSTORE}/pubsab.biblist.txt
runStage "pubload ab"    chandra/loadfiles.py ${MISSIONSTORE}/pubsab.biblist.txt pub
runStage "adsload ac"    loadfiles.py ${MISSIONSTORE}/pubsac.biblist.txt
runStage "simbadload ac" loadfiles-simbad.py ${MISSIONSTORE}/pubsac.biblist.txt
runStage "pubload ac"    chandra/loadfiles.py ${MISSIONSTORE}/pubsac.biblist.txt pub
runStage "adsload ad"    loadfiles.py ${MISSIONSTORE}/pubsad.biblist.txt
runStage "simbadload ad" loadfiles-simbad.py ${MISSIONSTORE}/pubsad.biblist.txt
runStage "pubload ad"    chandra/loadfiles.py ${MISSIONSTORE}/pubsad.biblist.txt pub
runStage "adsload ae"    loadfiles.py ${MISSIONSTORE}/pubsae.biblist.txt
runStage "simbadload ae" loadfiles-simbad.py ${MISSIONSTORE}/pubsae.biblist.txt
runStage "pubload ae"    chandra/loadfiles.py ${MISSIONSTORE}/pubsae.biblist.txt pub
runStage "adsload af"    loadfiles.py ${MISSIONSTORE}/pubsaf.biblist.txt
runStage "simbadload af" loadfiles-simbad.py ${MISSIONSTORE}/pubsaf.biblist.txt
runStage "pubload af"    chandra/loadfiles.py ${MISSIONSTORE}/pubsaf.biblist.txt pub
runStage "adsload ag"    loadfiles.py ${MISSIONSTORE}/pubsag.biblist.txt
runStage "simbadload ag" loadfiles-simbad.py ${MISSIONSTORE}/pubsag.biblist.txt
runStage "pubload ag"    chandra/loadfiles.py ${MISSIONSTORE}/pubsag.biblist.txt pub
runStage "adsload ah"    loadfiles.py ${MISSIONSTORE}/pubsah.biblist.txt
runStage "simbadload ah" loadfiles-simbad.py ${MISSIONSTORE}/pubsah.biblist.txt
runStage "pubload ah"    chandra/loadfiles.py ${MISSIONSTORE}/pubsah.biblist.txt pub
runStage "adsload ai"    loadfiles.py ${MISSIONSTORE}/pubsai.biblist.txt
runStage "simbadload ai" loadfiles-simbad.py ${MISSIONSTORE}/pubsai.biblist.txt
runStage "pubload ai"    chandra/loadfiles.py ${MISSIONSTORE}/pubsai.biblist.txt pub
runStage "adsload aj"    loadfiles.py ${MISSIONSTORE}/pubsaj.biblist.txt
runStage "simbadload aj" loadfiles-simbad.py ${MISSIONSTORE}/pubsaj.biblist.txt
runStage "pubload aj"    chandra/loadfiles.py ${MISSIONSTORE}/pubsaj.biblist.txt pub
runStage "adsload ak"    loadfiles.py ${MISSIONSTORE}/pubsak.biblist.txt
runStage "simbadload ak" loadfiles-simbad.py ${MISSIONSTORE}/pubsak.biblist.txt
runStage "pubload ak"    chandra/loadfiles.py ${MISSIONSTORE}/pubsak.biblist.txt pub
runStage "adsload al"    loadfiles.py ${MISSIONSTORE}/pubsal.biblist.txt
runStage "simbadload al" loadfiles-simbad.py ${MISSIONSTORE}/pubsal.biblist.txt
runStage "pubload al"    chandra/loadfiles.py ${MISSIONSTORE}/pubsal.biblist.txt pub
echo "# Ending script: `date`" >> $LOGFILE
