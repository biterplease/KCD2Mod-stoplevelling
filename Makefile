.PHONY: export test
EXPORTDIR := "./biter_please_stop_levelling"

export:
	@rm -rf ./biter_please_stop_levelling ./zips/*
	mkdir -p "${EXPORTDIR}/Data" ./zips/
	@cp ./src/mod.cfg "${EXPORTDIR}/"
	@cp ./src/mod.manifest "${EXPORTDIR}/"
	@7z a -tzip "${EXPORTDIR}/Data/StopLevelling.pak" ./src/Data/Scripts ./src/Data/Libs -r -mtm=off -mtc=off -mta=off

	@zip ./zips/biter_please_stop_levelling.zip \
		./biter_please_stop_levelling/Data/StopLevelling.pak \
		./biter_please_stop_levelling/mod.manifest \
		./biter_please_stop_levelling/mod.cfg \

test:
	@lua ./src/stoplevelling_test.lua