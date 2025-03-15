.PHONY: build test
MODID := biterplease_stop_levelling
EXPORTDIR := ./${MODID}
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
		./${MODID}/Data/StopLevelling.pak \
		./${MODID}/Localization/English_xml.pak \
		./${MODID}/mod.manifest \
		./${MODID}/mod.cfg

buildtogame: build
	@rm -rf "${MODSDIR}/${MODID}"
	@mkdir -p "${MODSDIR}/${MODID}/Data" "${MODSDIR}/${MODID}/Localization"
	@cp "${EXPORTDIR}/Data/StopLevelling.pak" "${MODSDIR}/${MODID}/Data/"
	@cp "${EXPORTDIR}/Localization/English_xml.pak" "${MODSDIR}/${MODID}/Localization/"
	@cp "${EXPORTDIR}/mod.cfg" "${MODSDIR}/${MODID}/"
	@cp "${EXPORTDIR}/mod.manifest" "${MODSDIR}/${MODID}/"

test:
	@lua -l ${LUA_INIT} ./src/stoplevelling_test.lua -v