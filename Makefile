.PHONY: export test
EXPORTDIR := "./biterplease_stop_levelling"

export:
	@rm -rf "${EXPORTDIR}" ./zips/*
	mkdir -p "${EXPORTDIR}/Data" ./zips/
	@cp ./src/mod.cfg "${EXPORTDIR}/"
	@cp ./src/mod.manifest "${EXPORTDIR}/"
	@7z a -tzip "${EXPORTDIR}/Localization/English_xml.pak" \
		./src/Localization/text_ui_soul__stoplevelling.xml \
		-r -mtm=off -mtc=off -mta=off
	@7z a -tzip "${EXPORTDIR}/Data/StopLevelling.pak" \
		./src/Data/Scripts \
		./src/Data/Libs \
		-r -mtm=off -mtc=off -mta=off

	@zip ./zips/StopLevelling.zip \
		./biterplease_stop_levelling/Data/StopLevelling.pak \
		./biterplease_stop_levelling/Localization/English_xml.pak \
		./biterplease_stop_levelling/mod.manifest \
		./biterplease_stop_levelling/mod.cfg \

test:
	@lua ./src/stoplevelling_test.lua