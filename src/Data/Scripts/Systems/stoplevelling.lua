System.LogAlways("$5[INFO][StopLevelling] ### STOP LEVELLING ###");
StopLevelling = {};
StopLevelling.devHome = ""
StopLevelling.isCommandLineBuild = false

-- ########################################
--      Stop levelling USER editable
-- ########################################

-- Time in milliseconds to check XP levels and reduce it.
StopLevelling.xp_trim_timer_period = 30000;

-- Stat limits for your build.
StopLevelling.limit_strength = 20;
StopLevelling.limit_agility = 20;
StopLevelling.limit_vitality = 20;
StopLevelling.limit_speech = 20;

-- Forces Skill max level to the Stat max level.
StopLevelling.skills_limits_inherit_stats = true;

-- ---------------------------------------
-- ------- Skill Tree configuration
-- ---------------------------------------
-- Here you set stat to skill dependencies
-- Only works if STOPLEVELLING-SET-skills_limits_inherit_stats is true
--
-- weapon_large == polearms
-- fencing == warfare

StopLevelling.skills_strength =  {'craftsmanship','heavy_weapons','survival','weapon_large','fencing'};
StopLevelling.skills_agility =  {'marksmanship','stealth','thievery','weapon_sword'};
StopLevelling.skills_vitality =  {'drinking','horse_riding','weapon_unarmed'};
StopLevelling.skills_speech =  {'alchemy','houndmaster','scholarship'};


-- ---------------------------------------
-- ------- Individual skill limits
-- ---------------------------------------
-- Only works if STOPLEVELLING-SET-skills_limits_inherit_stats is false

-- Reminder that
--   weapon_large == polearms
--   fencing == warfare
StopLevelling.limit_craftsmanship = 20;
StopLevelling.limit_heavy_weapons = 20;
StopLevelling.limit_survival = 20;
StopLevelling.limit_weapon_large = 20;
StopLevelling.limit_fencing = 20;
StopLevelling.limit_marksmanship = 20;
StopLevelling.limit_stealth = 20;
StopLevelling.limit_thievery = 20;
StopLevelling.limit_weapon_sword = 20;
StopLevelling.limit_alchemy = 20;
StopLevelling.limit_houndmaster = 20;
StopLevelling.limit_scholarship = 20;
StopLevelling.limit_drinking = 20;
StopLevelling.limit_horse_riding = 20;
StopLevelling.limit_weapon_unarmed = 20;

StopLevelling.data = {
    strength =          {name = "Strength",      governing_stat = nil,        perk_id = '59fb8183-8474-4f60-aed0-eb6afe572e53', is_stat = true , limit = 20, perk_blocks_fully=true, perk_added=false},
    agility =           {name = "Agility",       governing_stat = nil,        perk_id = '03b7b530-0f9d-41e6-996f-8a39bb0d070c', is_stat = true , limit = 20, perk_blocks_fully=true, perk_added=false},
    vitality =          {name = "Vitality",      governing_stat = nil,        perk_id = '74251454-09b1-4c22-b36e-ac6177bc4c3b', is_stat = true , limit = 20, perk_blocks_fully=true, perk_added=false},
    speech =            {name = "Speech",        governing_stat = nil,        perk_id = '77368463-bda8-4043-b872-dab47857580b', is_stat = true , limit = 20, perk_blocks_fully=false, perk_added=false},
    craftsmanship =     {name = "Craftsmanship", governing_stat = 'strength', perk_id = '2f2b9d82-9a91-40f0-bedb-ab53cb333127', is_stat = false, limit = 20, perk_blocks_fully=true, perk_added=false},
    heavy_weapons =     {name = "Heavy Weapons", governing_stat = 'strength', perk_id = '52a593f8-3fc7-46d8-a389-4ca47cd3a22e', is_stat = false, limit = 20, perk_blocks_fully=true, perk_added=false},
    survival =          {name = "Survival",      governing_stat = 'strength', perk_id = '1ede484d-b2bf-4c4b-a275-e9fa765bc7d3', is_stat = false, limit = 20, perk_blocks_fully=true, perk_added=false},
    weapon_large =      {name = "Polearms",      governing_stat = 'strength', perk_id = '98bb8ae8-1fc3-4ac0-8784-58106a421abf', is_stat = false, limit = 20, perk_blocks_fully=false, perk_added=false},
    fencing =           {name = "Warfare",       governing_stat = 'strength', perk_id = '4e0a8900-d9bc-49f8-bd36-fcded2c1ad79', is_stat = false, limit = 20, perk_blocks_fully=false, perk_added=false},
    marksmanship =      {name = "Marksmanship",  governing_stat = 'agility',  perk_id = '643ff10b-534d-4a1b-99ae-971fb085d1d8', is_stat = false, limit = 20, perk_blocks_fully=true, perk_added=false},
    stealth =           {name = "Stealth",       governing_stat = 'agility',  perk_id = '4d0d74ce-3e4e-4683-908e-61546b0b0b2e', is_stat = false, limit = 20, perk_blocks_fully=false, perk_added=false},
    thievery =          {name = "Thievery",      governing_stat = 'agility',  perk_id = '743554e5-5af4-4cd0-9844-f579c2020392', is_stat = false, limit = 20, perk_blocks_fully=false, perk_added=false},
    weapon_sword =      {name = "Swords",        governing_stat = 'agility',  perk_id = '9a28f2ca-c48c-4747-a574-c0d233144206', is_stat = false, limit = 20, perk_blocks_fully=true, perk_added=false},
    alchemy =           {name = "Alchemy",       governing_stat = 'speech',   perk_id = 'da9a2ea7-06c2-4b51-bd11-bc0be2c95cf2', is_stat = false, limit = 20, perk_blocks_fully=false, perk_added=false},
    houndmaster =       {name = "Houndmaster",   governing_stat = 'speech',   perk_id = 'c76cce08-5fa9-4441-a44e-01c5d4a4a9d9', is_stat = false, limit = 20, perk_blocks_fully=false, perk_added=false},
    scholarship =       {name = "Scholarship",   governing_stat = 'speech',   perk_id = '0341d739-e37b-4b10-84c2-eee6e323493c', is_stat = false, limit = 20, perk_blocks_fully=true, perk_added=false},
    drinking =          {name = "Drinking",      governing_stat = 'vitality', perk_id = 'e3da758a-3c05-4109-a7b9-8fa7bbf48824', is_stat = false, limit = 20, perk_blocks_fully=false, perk_added=false},
    horse_riding =      {name = "Horseriding",   governing_stat = 'vitality', perk_id = '89ac270e-20b2-4381-96d6-27cf791e944f', is_stat = false, limit = 20, perk_blocks_fully=false, perk_added=false},
    weapon_unarmed =    {name = "Unarmed",       governing_stat = 'vitality', perk_id = '93551fe9-bb0c-4242-8aea-8de2db44952e', is_stat = false, limit = 20, perk_blocks_fully=false, perk_added=false},
};

StopLevelling.xp_trim_timer_id = nil;


function StopLevelling:init()
    System.LogAlways("$5[INFO][StopLevelling] StopLevelling Initialized");

    System.AddCCommand("STOPLEVELLING-SET-xp_trim_timer_period", "StopLevelling:setXpTrimTimerPeriod(%line)", "");
    System.AddCCommand("STOPLEVELLING-SET-skills_limits_inherit_stats", "StopLevelling:setSkillLimitsInheritStats(%line)", "");
    System.AddCCommand("STOPLEVELLING-SET-skills_strength", "StopLevelling:setSkillsStrength(%line)", "");
    System.AddCCommand("STOPLEVELLING-SET-skills_agility", "StopLevelling:setSkillsAgility(%line)", "");
    System.AddCCommand("STOPLEVELLING-SET-skills_vitality", "StopLevelling:setSkillsVitality(%line)", "");
    System.AddCCommand("STOPLEVELLING-SET-skills_speech", "StopLevelling:setSkillsSpeech(%line)", "");
    System.AddCCommand("STOPLEVELLING-SET-limit_strength", "StopLevelling:setLimitStrength(%line)", "Set limit for Stat strength");
    System.AddCCommand("STOPLEVELLING-SET-limit_agility", "StopLevelling:setLimitAgility(%line)", "Set limit for Stat agility");
    System.AddCCommand("STOPLEVELLING-SET-limit_vitality", "StopLevelling:setLimitVitality(%line)", "Set limit for Stat vitality");
    System.AddCCommand("STOPLEVELLING-SET-limit_speech", "StopLevelling:setLimitSpeech(%line)", "Set limit for Stat speech");
    System.AddCCommand("STOPLEVELLING-SET-limit_craftsmanship", "StopLevelling:setLimitCraftsmanship(%line)", "Set limit for Skill craftsmanship");
    System.AddCCommand("STOPLEVELLING-SET-limit_heavy_weapons", "StopLevelling:setLimitHeavyWeapons(%line)", "Set limit for Skill heavy_weapons");
    System.AddCCommand("STOPLEVELLING-SET-limit_survival", "StopLevelling:setLimitSurvival(%line)", "Set limit for Skill survival");
    System.AddCCommand("STOPLEVELLING-SET-limit_weapon_large", "StopLevelling:setLimitWeaponLarge(%line)", "Set limit for Skill weapon_large (Polearms)");
    System.AddCCommand("STOPLEVELLING-SET-limit_fencing", "StopLevelling:setLimitFencing(%line)", "Set limit for Skill fencing (Warfare)");
    System.AddCCommand("STOPLEVELLING-SET-limit_marksmanship", "StopLevelling:setLimitMarksmanship(%line)", "Set limit for Skill marksmanship");
    System.AddCCommand("STOPLEVELLING-SET-limit_stealth", "StopLevelling:setLimitStealth(%line)", "Set limit for Skill stealth");
    System.AddCCommand("STOPLEVELLING-SET-limit_thievery", "StopLevelling:setLimitThievery(%line)", "Set limit for Skill thievery");
    System.AddCCommand("STOPLEVELLING-SET-limit_weapon_sword", "StopLevelling:setLimitWeaponSword(%line)", "Set limit for Skill weapon_sword");
    System.AddCCommand("STOPLEVELLING-SET-limit_alchemy", "StopLevelling:setLimitAlchemy(%line)", "Set limit for Skill alchemy");
    System.AddCCommand("STOPLEVELLING-SET-limit_houndmaster", "StopLevelling:setLimitHoundmaster(%line)", "Set limit for Skill houndmaster");
    System.AddCCommand("STOPLEVELLING-SET-limit_scholarship", "StopLevelling:setLimitScholarship(%line)", "Set limit for Skill scholarship");
    System.AddCCommand("STOPLEVELLING-SET-limit_drinking", "StopLevelling:setLimitDrinking(%line)", "Set limit for Skill drinking");
    System.AddCCommand("STOPLEVELLING-SET-limit_horse_riding", "StopLevelling:setLimitHorseRiding(%line)", "Set limit for Skill horse_riding");
    System.AddCCommand("STOPLEVELLING-SET-limit_weapon_unarmed", "StopLevelling:setLimitWeaponUnarmed(%line)", "Set limit for Skill weapon_unarmed");

    System.AddCCommand("stoplevelling_limits", "StopLevelling:limits()", "show stat and skill limits")
    System.AddCCommand("stoplevelling_skill_deps", "StopLevelling:skillDeps()", "show skill-stat relation")
    System.AddCCommand("stoplevelling_add_all_perks", "StopLevelling:addAllPerks()", "Add all xp-blocking perks to the player.")
    System.AddCCommand("stoplevelling_remove_all_perks", "StopLevelling:removeAllPerks()", "Add all xp-blocking perks to the player.")
    System.AddCCommand("stoplevelling_trim_xp", "StopLevelling:trimxp()", "")
    System.AddCCommand("stoplevelling_kill_timers", "StopLevelling:killTimers()", "")
end


--
-- Config setters
-- 
function StopLevelling:setXpTrimTimerPeriod(line)
    StopLevelling.xp_trim_timer_period = tonumber(line);
end

function StopLevelling:setSkillLimitsInheritStats(line)
    if tostring(line) == "true" then
        StopLevelling.skills_limits_inherit_stats = true;
    elseif tostring(line) == "false" then
        StopLevelling.skills_limits_inherit_stats = false;
    end
end

function StopLevelling:setSkillsStrength(line)
    StopLevelling:setStatDeps("strength", line)
end

function StopLevelling:setSkillsAgility(line)
    StopLevelling:setStatDeps("agility", line)
end

function StopLevelling:setSkillsVitality(line)
    StopLevelling:setStatDeps("vitality", line)
end

function StopLevelling:setSkillsSpeech(line)
    StopLevelling:setStatDeps("speech", line)
end

function StopLevelling:setStatDeps(stat, line)
    local original = StopLevelling["skills_"..stat];
    if original ~= nil then
        StopLevelling["skills_"..stat] = {};
        for word in string.gmatch(line, "([^,]+)") do
            if not (word == "strength" or word == "agility" or word == "vitality" or word == "speech") then
                if StopLevelling.data[word] ~= nil then
                    table.insert(StopLevelling["skills_"..stat],word)
                end
            end
        end
    end
    StopLevelling:setDataSkillDependencies();
end

-- set data from config values
function StopLevelling:setDataSkillDependencies()
    local all = {
        strength=StopLevelling.skills_strength,
        agility=StopLevelling.skills_agility,
        vitality=StopLevelling.skills_vitality,
        speech=StopLevelling.skills_speech,
    }
    for k,v  in pairs(all) do
        for statOrSkillKey, values in pairs(v) do
            if not (statOrSkillKey == "strength" or statOrSkillKey == "agility" or statOrSkillKey == "vitality" or statOrSkillKey == "speech") then
                if StopLevelling.data[statOrSkillKey] ~= nil then
                    StopLevelling.data[statOrSkillKey]["governing_stat"] = tostring(k);
                end
            end
        end
    end
end

function StopLevelling:setLimitStrength(line)
     StopLevelling:setLimitValue("strength", line)
end

function StopLevelling:setLimitAgility(line)
     StopLevelling:setLimitValue("agility", line)
end

function StopLevelling:setLimitVitality(line)
     StopLevelling:setLimitValue("vitality", line)
end

function StopLevelling:setLimitSpeech(line)
     StopLevelling:setLimitValue("speech", line)
end

function StopLevelling:setLimitCraftsmanship(line)
    StopLevelling:setLimitValue("craftsmanship", line)
end

function StopLevelling:setLimitHeavyWeapons(line)
    StopLevelling:setLimitValue("heavy_weapons", line)
end

function StopLevelling:setLimitSurvival(line)
    StopLevelling:setLimitValue("survival", line)
end

function StopLevelling:setLimitWeaponLarge(line)
    StopLevelling:setLimitValue("weapon_large", line)
end

function StopLevelling:setLimitFencing(line)
    StopLevelling:setLimitValue("fencing", line)
end

function StopLevelling:setLimitMarksmanship(line)
    StopLevelling:setLimitValue("marksmanship", line)
end

function StopLevelling:setLimitStealth(line)
    StopLevelling:setLimitValue("stealth", line)
end

function StopLevelling:setLimitThievery(line)
    StopLevelling:setLimitValue("thievery", line)
end

function StopLevelling:setLimitWeaponSword(line)
    StopLevelling:setLimitValue("weapon_sword", line)
end

function StopLevelling:setLimitAlchemy(line)
    StopLevelling:setLimitValue("alchemy", line)
end

function StopLevelling:setLimitHoundmaster(line)
    StopLevelling:setLimitValue("houndmaster", line)
end

function StopLevelling:setLimitScholarship(line)
    StopLevelling:setLimitValue("scholarship", line)
end

function StopLevelling:setLimitDrinking(line)
    StopLevelling:setLimitValue("drinking", line)
end

function StopLevelling:setLimitHorseRiding(line)
    StopLevelling:setLimitValue("horse_riding", line)
end

function StopLevelling:setLimitWeaponUnarmed(line)
    StopLevelling:setLimitValue("weapon_unarmed", line)
end

function StopLevelling:setLimitValue(statOrSkillKey, line)
    if StopLevelling["limit_"..statOrSkillKey] ~= nil then
        StopLevelling["limit_"..statOrSkillKey] = tonumber(line);
        StopLevelling.data[statOrSkillKey]["limit"] = tonumber(line);

        if StopLevelling.data[statOrSkillKey].is_stat and StopLevelling.skills_limits_inherit_stats then
            for k, v in pairs(StopLevelling.data) do  
                if not (k == "strength" or k == "agility" or k == "vitality" or k == "speech") then
                    if v.governing_stat == statOrSkillKey then
                        StopLevelling.data[k]["limit"] = tonumber(line);
                        StopLevelling["limit_"..k] = tonumber(line);
                    end
                end
            end
        end
    end
end



function StopLevelling:limits()
    System.LogAlways("$3[DEBUG][StopLevelling] Stat limits:");
    for k, v in pairs(StopLevelling.data) do
        System.LogAlways(string.format("$3[DEBUG][StopLevelling] \t %s %d", tostring(k), tonumber(v.limit)));
    end
end

function StopLevelling:skillDeps()
    System.LogAlways("$3[DEBUG][StopLevelling] Skill dependencies:");
    for k, v in pairs(StopLevelling.data) do
        if v.is_stat then
            System.LogAlways(string.format("$3[DEBUG][StopLevelling] \t %s %s", tostring(v.governing_stat), tostring(k)));
        end
    end
end

function StopLevelling:trimxp()
    System.LogAlways("$3[DEBUG][StopLevelling] trimxp:");
    for k, v in pairs(StopLevelling.data) do
        local currentProgress = 0.0;
        local currentLevel = 0;
        local limit = v.limit;

        if v.is_stat then
            currentProgress = player.soul:GetStatProgress(tostring(k));
            currentLevel = player.soul:GetStatLevel(tostring(k));
        else
            currentProgress = player.soul:GetSkillProgress(tostring(k));
            currentLevel = player.soul:GetSkillLevel(tostring(k));
        end
        
        if not v.is_stat and StopLevelling.skills_limits_inherit_stats then
            limit = StopLevelling.data[v.governing_stat]["limit"];
        end
        
        if currentLevel ~= nil then
            if tonumber(currentLevel) >= limit then
                local alreadyHasPerk = player.soul:HasPerk(v.perk_id, false);
                if alreadyHasPerk ~= nil then
                    if not alreadyHasPerk and not v.perk_added then
                        System.LogAlways(string.format("$5[INFO][StopLevelling] adding XP blocking perk for attribute %s", tostring(k)));
                        player.soul:AddPerk(v.perk_id)
                        v.perk_added = true;
                    end
                end
            end
        end
        if not v.perk_blocks_fully then
            -- only > 20% progress, above limit level, gets XP trimmed
            if currentProgress ~= nil and currentLevel ~= nil then
                if tonumber(currentProgress) >= 0.2 and tonumber(currentLevel) >= limit then
                    -- ideally we would call player.soul:GetNextLevelStatXP or player.soul:GetNextLevelSkillXP
                    -- to get the exact amount and remove all XP, but those methods don't seem to return anything
                    -- at the moment
                    System.LogAlways(string.format("$5[INFO][StopLevelling] trimming XP for %s", tostring(k)));
                    if v.is_stat then
                        player.soul:AddStatXP(tostring(k), -50);
                    else
                        player.soul:AddSkillXP(tostring(k), -50);
                    end
                end
            end
        end
    end
        
end

function StopLevelling:addAllPerks()
    for k, v in pairs(StopLevelling.data) do
        player.soul:AddPerk(tostring(v.perk_id))
        System.LogAlways(string.format("$3[DEBUG][StopLevelling] Added XP blocking perk for %s (key=%s)", tostring(v.name), tostring(k)));
    end
end

function StopLevelling:removeAllPerks()
    for k, v in pairs(StopLevelling.data) do
        player.soul:RemovePerk(tostring(v.perk_id))
        System.LogAlways(string.format("$3[DEBUG][StopLevelling] Removed XP blocking perk for %s (key=%s)", tostring(v.name), tostring(k)));
    end
end

function StopLevelling:initTimers()
	System.LogAlways("$5[INFO][StopLevelling] Init timers");
    if StopLevelling.xp_trim_timer_id ~= nil then
        Script.KillTimer(StopLevelling.xp_trim_timer_id)
        StopLevelling.xp_trim_timer_id = nil
    end
    StopLevelling.xp_trim_timer_id = Script.SetTimer(StopLevelling.xp_trim_timer_period, function(nTimerId)
        StopLevelling:xpTrimTimerCallback(nTimerId)
    end)
end

function StopLevelling:killTimers()
	System.LogAlways("$5[INFO][StopLevelling] Killing timers");
    if StopLevelling.xp_trim_timer_id ~= nil then
        Script.KillTimer(StopLevelling.xp_trim_timer_id)
        StopLevelling.xp_trim_timer_id = nil
    end
end

function StopLevelling:xpTrimTimerCallback(nTimerId)
    -- Restart timer
    StopLevelling.xp_trim_timer_id = Script.SetTimer(StopLevelling.xp_trim_timer_period, function(nTimerId)
        StopLevelling:xpTrimTimerCallback(nTimerId)
    end)
	StopLevelling:trimxp();
end

function StopLevelling:GameLoaded(elementName, instanceId, eventName, argTable)
    System.LogAlways(tostring(elementName)..tostring(eventName)..tostring(argTable))
    System.LogAlways("$5[INFO][StopLevelling] Load config");
    System.ExecuteCommand("exec Mods/biter_please_stop_levelling/mod.cfg")
    StopLevelling:init();
    StopLevelling:initTimers()
end
UIAction.RegisterEventSystemListener(StopLevelling, "", "OnGameplayStarted", "GameLoaded")

return StopLevelling;