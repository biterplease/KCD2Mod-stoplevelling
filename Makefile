.PHONY: build test build-local
MODID := biterplease_stop_levelling
EXPORTDIR := ./${MODID}
GAMEDIR := /mnt/c/Steam/steamapps/common/KingdomComeDeliverance2
MODSDIR := ${GAMEDIR}/Mods
LANGUAGES := English Spanish
LUA_INIT := "src/setup_test"

build:
	@rm -rf "${EXPORTDIR}" ./zips/*
	mkdir -p "${EXPORTDIR}/Data" ./zips/
	@cp ./src/mod.cfg "${EXPORTDIR}/"
	@cp ./src/mod.manifest "${EXPORTDIR}/"
	@for lang in ${LANGUAGES}; do \
		cp "./src/Localization/text_ui_soul__${MODID}_$${lang}".xml \
			./src/Localization/text_ui_soul__${MODID}.xml; \
		7z a -tzip "${EXPORTDIR}/Localization/$${lang}_xml.pak" \
			./src/Localization/text_ui_soul__${MODID}.xml \
			-r -mtm=off -mtc=off -mta=off; \
		rm ./src/Localization/text_ui_soul__${MODID}.xml; \
	done
	@7z a -tzip "${EXPORTDIR}/Data/StopLevelling.pak" \
		./src/Data/Scripts \
		./src/Data/Libs \
		-r -mtm=off -mtc=off -mta=off

	@zip ./zips/StopLevelling.zip \
		./${MODID}/Data/StopLevelling.pak \
		./${MODID}/Localization/*.pak \
		./${MODID}/mod.manifest \
		./${MODID}/mod.cfg

build-local: build
	@rm -rf "${MODSDIR}/${MODID}"
	@mkdir -p "${MODSDIR}/${MODID}/Data" "${MODSDIR}/${MODID}/Localization"
	@cp "${EXPORTDIR}/Data/StopLevelling.pak" "${MODSDIR}/${MODID}/Data/"
	for lang in ${LANGUAGES}; do \
		cp "${EXPORTDIR}/Localization/$${lang}_xml.pak" "${MODSDIR}/${MODID}/Localization/"; \
	done
	@cp "${EXPORTDIR}/mod.cfg" "${MODSDIR}/${MODID}/"
	@cp "${EXPORTDIR}/mod.manifest" "${MODSDIR}/${MODID}/"
	${GAMEDIR}/Bin/Win64MasterMasterSteamPGO/KingdomCome.exe -devmode +exec user.cfg

test:
	@lua -l ${LUA_INIT} ./src/stoplevelling_test.lua -v