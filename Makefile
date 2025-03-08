.PHONY: export test
EXPORTDIR := "./export/biter_please_stop_levelling"

export:
	@rm -rf ./pkg/* ./export/*
	mkdir -p ./pkg "${EXPORTDIR}/Data"
	@cp ./src/mod.cfg "${EXPORTDIR}/"
	@cp ./src/mod.manifest "${EXPORTDIR}/"
	@7z a -tzip "${EXPORTDIR}/StopLevelling.pak" ./src/Data/Scripts ./src/Data/Libs -r -mtm=off -mtc=off -mta=off
	@cp ./pkg/StopLevelling.pak "${EXPORTDIR}/Data/"