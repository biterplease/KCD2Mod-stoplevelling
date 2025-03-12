.PHONY: build test
EXPORTDIR := ./biterplease_stop_levelling
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

# WSL doesn't like spaces in its paths. Make sure the directories exist first in $GAMEDIR/Mods/biterplease_stop_levelling/Data and $GAMEDIR/Mods/biterplease_stop_levelling/Localization
buildtogame: build
	@cp "${EXPORTDIR}/Data/StopLevelling.pak" "/mnt/c/Program Files (x86)/Steam/steamapps/common/KingdomComeDeliverance2/Mods/biterplease_stop_levelling/Data/"
	@cp "${EXPORTDIR}/Localization/English_xml.pak" "/mnt/c/Program Files (x86)/Steam/steamapps/common/KingdomComeDeliverance2/Mods/biterplease_stop_levelling/Localization/"
	@cp "${EXPORTDIR}/mod.cfg" "/mnt/c/Program Files (x86)/Steam/steamapps/common/KingdomComeDeliverance2/Mods/biterplease_stop_levelling/mod.cfg"
	@cp "${EXPORTDIR}/mod.manifest" "/mnt/c/Program Files (x86)/Steam/steamapps/common/KingdomComeDeliverance2/Mods/biterplease_stop_levelling/mod.manifest"

test:
	@lua -l ${LUA_INIT} ./src/stoplevelling_test.lua -v