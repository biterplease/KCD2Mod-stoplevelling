.PHONY: build test
EXPORTDIR := ./biterplease_stop_levelling
MODSDIR := /mnt/c/Steam/steamapps/common/KingdomComeDeliverance2/Mods
LANGUAGES := English
LUA_INIT := "src/setup_test"

build:
	@rm -rf "${EXPORTDIR}" ./zips/*
	mkdir -p "${EXPORTDIR}/Data" ./zips/
	@cp ./src/mod.cfg "${EXPORTDIR}/"
	@cp ./src/mod.manifest "${EXPORTDIR}/"
	@for lang in ${LANGUAGES}; do \
		cp "./src/Localization/text_ui_soul__stoplevelling_$${lang}".xml \
			./src/Localization/text_ui_soul__stoplevelling.xml; \
		7z a -tzip "${EXPORTDIR}/Localization/$${lang}_xml.pak" \
			./src/Localization/text_ui_soul__stoplevelling.xml \
			-r -mtm=off -mtc=off -mta=off; \
		rm ./src/Localization/text_ui_soul__stoplevelling.xml; \
	done
	@7z a -tzip "${EXPORTDIR}/Data/StopLevelling.pak" \
		./src/Data/Scripts \
		./src/Data/Libs \
		-r -mtm=off -mtc=off -mta=off

	@zip ./zips/StopLevelling.zip \
		./biterplease_stop_levelling/Data/StopLevelling.pak \
		./biterplease_stop_levelling/Localization/English_xml.pak \
		./biterplease_stop_levelling/mod.manifest \
		./biterplease_stop_levelling/mod.cfg

buildtogame: build
	@rm -f "${MODSDIR}/biterplease_stop_levelling/Data/StopLevelling.pak"
	@cp "${EXPORTDIR}/Data/StopLevelling.pak" "${MODSDIR}/biterplease_stop_levelling/Data/"
	@rm -f "${MODSDIR}/biterplease_stop_levelling/Localization/English_xml.pak"
	@cp "${EXPORTDIR}/Localization/English_xml.pak" "${MODSDIR}/biterplease_stop_levelling/Localization/"
	@rm -f "${MODSDIR}/biterplease_stop_levelling/mod.cfg"
	@cp "${EXPORTDIR}/mod.cfg" "${MODSDIR}/biterplease_stop_levelling/"
	@rm -f "${MODSDIR}/biterplease_stop_levelling/mod.manifest"
	@cp "${EXPORTDIR}/mod.manifest" "${MODSDIR}/biterplease_stop_levelling/"

test:
	@lua -l ${LUA_INIT} ./src/stoplevelling_test.lua -v