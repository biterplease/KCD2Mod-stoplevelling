System.LogAlways("$5[INFO][StopLevelling] ### STOP LEVELLING ###");
stoplevelling = {};
stoplevelling.devHome = ""
stoplevelling.isCommandLineBuild = false

-- ########################################
--      Stop levelling USER editable
-- ########################################
--
-- Time in milliseconds to check XP levels and reduce it.
stoplevelling.xp_nerf_timer_period = 30000;

-- Stat limits for your build.
stoplevelling.limit_strength = 20;
stoplevelling.limit_agility = 20;
stoplevelling.limit_vitality = 20;
stoplevelling.limit_speech = 20;

-- Forces Skill max level to the Stat max level.
stoplevelling.skills_limits_inherit_stats = true;

-- ---------------------------------------
-- ------- Skill Tree configuration
-- ---------------------------------------
-- Here you set stat to skill dependencies
-- Only works if STOPLEVELLING-SET-skills_limits_inherit_stats is true
--
-- weapon_large == polearms
-- fencing == warfare
stoplevelling.skills_strength =  {'craftsmanship','heavy_weapons','survival','weapon_large','fencing'};
stoplevelling.skills_agility =  {'marksmanship','stealth','thievery','weapon_sword'};
stoplevelling.skills_vitality =  {'drinking','horse_riding','weapon_unarmed'};
stoplevelling.skills_speech =  {'alchemy','houndmaster','scholarship'};


-- ---------------------------------------
-- ------- Individual skill limits
-- ---------------------------------------
-- Only works if STOPLEVELLING-SET-skills_limits_inherit_stats is false

-- Reminder that
--   weapon_large == polearms
--   fencing == warfare
stoplevelling.limit_craftsmanship = 20;
stoplevelling.limit_heavy_weapons = 20;
stoplevelling.limit_survival = 20;
stoplevelling.limit_weapon_large = 20;
stoplevelling.limit_fencing = 20;
stoplevelling.limit_marksmanship = 20;
stoplevelling.limit_stealth = 20;
stoplevelling.limit_thievery = 20;
stoplevelling.limit_weapon_sword = 20;
stoplevelling.limit_alchemy = 20;
stoplevelling.limit_houndmaster = 20;
stoplevelling.limit_scholarship = 20;
stoplevelling.limit_drinking = 20;
stoplevelling.limit_horse_riding = 20;
stoplevelling.limit_weapon_unarmed = 20;

stoplevelling.data = {
    strength =          {name = "Strength",      governing_stat = nil,        perk_id = '59fb8183-8474-4f60-aed0-eb6afe572e53', is_stat = true , limit = 20},
    agility =           {name = "Agility",       governing_stat = nil,        perk_id = '03b7b530-0f9d-41e6-996f-8a39bb0d070c', is_stat = true , limit = 20},
    vitality =          {name = "Vitality",      governing_stat = nil,        perk_id = '74251454-09b1-4c22-b36e-ac6177bc4c3b', is_stat = true , limit = 20},
    speech =            {name = "Speech",        governing_stat = nil,        perk_id = '77368463-bda8-4043-b872-dab47857580b', is_stat = true , limit = 20},
    craftsmanship =     {name = "Craftsmanship", governing_stat = 'strength', perk_id = '2f2b9d82-9a91-40f0-bedb-ab53cb333127', is_stat = false, limit = 20},
    heavy_weapons =     {name = "Heavy Weapons", governing_stat = 'strength', perk_id = '52a593f8-3fc7-46d8-a389-4ca47cd3a22e', is_stat = false, limit = 20},
    survival =          {name = "Survival",      governing_stat = 'strength', perk_id = '1ede484d-b2bf-4c4b-a275-e9fa765bc7d3', is_stat = false, limit = 20},
    weapon_large =      {name = "Polearms",      governing_stat = 'strength', perk_id = '98bb8ae8-1fc3-4ac0-8784-58106a421abf', is_stat = false, limit = 20},
    fencing =           {name = "Warfare",       governing_stat = 'strength', perk_id = '4e0a8900-d9bc-49f8-bd36-fcded2c1ad79', is_stat = false, limit = 20},
    marksmanship =      {name = "Marksmanship",  governing_stat = 'agility',  perk_id = '643ff10b-534d-4a1b-99ae-971fb085d1d8', is_stat = false, limit = 20},
    stealth =           {name = "Stealth",       governing_stat = 'agility',  perk_id = '4d0d74ce-3e4e-4683-908e-61546b0b0b2e', is_stat = false, limit = 20},
    thievery =          {name = "Thievery",      governing_stat = 'agility',  perk_id = '743554e5-5af4-4cd0-9844-f579c2020392', is_stat = false, limit = 20},
    weapon_sword =      {name = "Swords",        governing_stat = 'agility',  perk_id = '9a28f2ca-c48c-4747-a574-c0d233144206', is_stat = false, limit = 20},
    alchemy =           {name = "Alchemy",       governing_stat = 'speech',   perk_id = 'da9a2ea7-06c2-4b51-bd11-bc0be2c95cf2', is_stat = false, limit = 20},
    houndmaster =       {name = "Houndmaster",   governing_stat = 'speech',   perk_id = 'c76cce08-5fa9-4441-a44e-01c5d4a4a9d9', is_stat = false, limit = 20},
    scholarship =       {name = "Scholarship",   governing_stat = 'speech',   perk_id = '0341d739-e37b-4b10-84c2-eee6e323493c', is_stat = false, limit = 20},
    drinking =          {name = "Drinking",      governing_stat = 'vitality', perk_id = 'e3da758a-3c05-4109-a7b9-8fa7bbf48824', is_stat = false, limit = 20},
    horse_riding =      {name = "Horseriding",   governing_stat = 'vitality', perk_id = '89ac270e-20b2-4381-96d6-27cf791e944f', is_stat = false, limit = 20},
    weapon_unarmed =    {name = "Unarmed",       governing_stat = 'vitality', perk_id = '93551fe9-bb0c-4242-8aea-8de2db44952e', is_stat = false, limit = 20},
};


function stoplevelling:init()
    System.LogAlways("$5[INFO][StopLevelling] StopLevelling Initialized");

    System.AddCCommand("STOPLEVELLING-SET-xp_nerf_timer_period", "stoplevelling:set_xp_nerf_timer_period(%line)", "");
    System.AddCCommand("STOPLEVELLING-SET-skills_limits_inherit_stats", "stoplevelling:set_skills_limits_inherit_stats(%line)", "");
    System.AddCCommand("STOPLEVELLING-SET-skills_strength", "stoplevelling:set_skills_strength(%line)", "");
    System.AddCCommand("STOPLEVELLING-SET-skills_agility", "stoplevelling:set_skills_agility(%line)", "");
    System.AddCCommand("STOPLEVELLING-SET-skills_vitality", "stoplevelling:set_skills_vitality(%line)", "");
    System.AddCCommand("STOPLEVELLING-SET-skills_speech", "stoplevelling:set_skills_speech(%line)", "");
    System.AddCCommand("STOPLEVELLING-SET-limit_strength", "stoplevelling:set_limit_strength(%line)", "Set limit for Stat strength");
    System.AddCCommand("STOPLEVELLING-SET-limit_agility", "stoplevelling:set_limit_agility(%line)", "Set limit for Stat agility");
    System.AddCCommand("STOPLEVELLING-SET-limit_vitality", "stoplevelling:set_limit_vitality(%line)", "Set limit for Stat vitality");
    System.AddCCommand("STOPLEVELLING-SET-limit_speech", "stoplevelling:set_limit_speech(%line)", "Set limit for Stat speech");
    System.AddCCommand("STOPLEVELLING-SET-limit_craftsmanship", "stoplevelling:set_limit_craftsmanship(%line)", "Set limit for Skill craftsmanship");
    System.AddCCommand("STOPLEVELLING-SET-limit_heavy_weapons", "stoplevelling:set_limit_heavy_weapons(%line)", "Set limit for Skill heavy_weapons");
    System.AddCCommand("STOPLEVELLING-SET-limit_survival", "stoplevelling:set_limit_survival(%line)", "Set limit for Skill survival");
    System.AddCCommand("STOPLEVELLING-SET-limit_weapon_large", "stoplevelling:set_limit_weapon_large(%line)", "Set limit for Skill weapon_large (Polearms)");
    System.AddCCommand("STOPLEVELLING-SET-limit_fencing", "stoplevelling:set_limit_fencing(%line)", "Set limit for Skill fencing (Warfare)");
    System.AddCCommand("STOPLEVELLING-SET-limit_marksmanship", "stoplevelling:set_limit_marksmanship(%line)", "Set limit for Skill marksmanship");
    System.AddCCommand("STOPLEVELLING-SET-limit_stealth", "stoplevelling:set_limit_stealth(%line)", "Set limit for Skill stealth");
    System.AddCCommand("STOPLEVELLING-SET-limit_thievery", "stoplevelling:set_limit_thievery(%line)", "Set limit for Skill thievery");
    System.AddCCommand("STOPLEVELLING-SET-limit_weapon_sword", "stoplevelling:set_limit_weapon_sword(%line)", "Set limit for Skill weapon_sword");
    System.AddCCommand("STOPLEVELLING-SET-limit_alchemy", "stoplevelling:set_limit_alchemy(%line)", "Set limit for Skill alchemy");
    System.AddCCommand("STOPLEVELLING-SET-limit_houndmaster", "stoplevelling:set_limit_houndmaster(%line)", "Set limit for Skill houndmaster");
    System.AddCCommand("STOPLEVELLING-SET-limit_scholarship", "stoplevelling:set_limit_scholarship(%line)", "Set limit for Skill scholarship");
    System.AddCCommand("STOPLEVELLING-SET-limit_drinking", "stoplevelling:set_limit_drinking(%line)", "Set limit for Skill drinking");
    System.AddCCommand("STOPLEVELLING-SET-limit_horse_riding", "stoplevelling:set_limit_horse_riding(%line)", "Set limit for Skill horse_riding");
    System.AddCCommand("STOPLEVELLING-SET-limit_weapon_unarmed", "stoplevelling:set_limit_weapon_unarmed(%line)", "Set limit for Skill weapon_unarmed");

    System.AddCCommand("stoplevelling_limits", "stoplevelling:limits()", "show stat and skill limits")
    System.AddCCommand("stoplevelling_skill_deps", "stoplevelling:skillDeps()", "show skill-stat relation")
    System.AddCCommand("stoplevelling_add_all_perks", "stoplevelling:addAllPerks()", "Add all xp-blocking perks to the player.")
    System.AddCCommand("stoplevelling_remove_all_perks", "stoplevelling:removeAllPerks()", "Add all xp-blocking perks to the player.")
end


--
-- Config setters
-- 
function stoplevelling:set_xp_nerf_timer_period(line)
    stoplevelling.xp_nerf_timer_period = tonumber(line);
end

function stoplevelling:set_skills_limits_inherit_stats(line)
    if tostring(line) == "true" then
        stoplevelling.skills_limits_inherit_stats = true;
    elseif tostring(line) == "false" then
        stoplevelling.skills_limits_inherit_stats = false;
    end
end

function stoplevelling:set_skills_strength(line)
    stoplevelling:set_stat_deps("strength", line)
end
function stoplevelling:set_skills_agility(line)
    stoplevelling:set_stat_deps("agility", line)
end
function stoplevelling:set_skills_vitality(line)
    stoplevelling:set_stat_deps("vitality", line)
end
function stoplevelling:set_skills_speech(line)
    stoplevelling:set_stat_deps("speech", line)
end
function stoplevelling:set_stat_deps(stat, line)
    local original = stoplevelling["skills_"..stat];
    if original ~= nil then
        stoplevelling["skills_"..stat] = {};
        for word in string.gmatch(line, "([^,]+)") do
            if not (word == "strength" or word == "agility" or word == "vitality" or word == "speech") then
                if stoplevelling.data[word] ~= nil then
                    table.insert(stoplevelling["skills_"..stat],word)
                end
            end
        end
    end
    stoplevelling:set_data_skill_dependencies();
end

-- set data from config values
function stoplevelling:set_data_skill_dependencies()
    local all = {
        strength=stoplevelling.skills_strength,
        agility=stoplevelling.skills_agility,
        vitality=stoplevelling.skills_vitality,
        speech=stoplevelling.skills_speech,
    }
    for k,v  in pairs(all) do
        for statOrSkillKey, values in pairs(v) do
            if not (statOrSkillKey == "strength" or statOrSkillKey == "agility" or statOrSkillKey == "vitality" or statOrSkillKey == "speech") then
                if stoplevelling.data[statOrSkillKey] ~= nil then
                    stoplevelling.data[statOrSkillKey]["governing_stat"] = tostring(k);
                end
            end
        end
    end
end

function stoplevelling:set_limit_strength(line)
     stoplevelling:set_limit_value("strength", line)
end
function stoplevelling:set_limit_agility(line)
     stoplevelling:set_limit_value("agility", line)
end
function stoplevelling:set_limit_vitality(line)
     stoplevelling:set_limit_value("vitality", line)
end
function stoplevelling:set_limit_speech(line)
     stoplevelling:set_limit_value("speech", line)
end
function stoplevelling:set_limit_craftsmanship(line)
    stoplevelling:set_limit_value("craftsmanship", line)
end
function stoplevelling:set_limit_heavy_weapons(line)
    stoplevelling:set_limit_value("heavy_weapons", line)
end
function stoplevelling:set_limit_survival(line)
    stoplevelling:set_limit_value("survival", line)
end
function stoplevelling:set_limit_weapon_large(line)
    stoplevelling:set_limit_value("weapon_large", line)
end
function stoplevelling:set_limit_fencing(line)
    stoplevelling:set_limit_value("fencing", line)
end
function stoplevelling:set_limit_marksmanship(line)
    stoplevelling:set_limit_value("marksmanship", line)
end
function stoplevelling:set_limit_stealth(line)
    stoplevelling:set_limit_value("stealth", line)
end
function stoplevelling:set_limit_thievery(line)
    stoplevelling:set_limit_value("thievery", line)
end
function stoplevelling:set_limit_weapon_sword(line)
    stoplevelling:set_limit_value("weapon_sword", line)
end
function stoplevelling:set_limit_alchemy(line)
    stoplevelling:set_limit_value("alchemy", line)
end
function stoplevelling:set_limit_houndmaster(line)
    stoplevelling:set_limit_value("houndmaster", line)
end
function stoplevelling:set_limit_scholarship(line)
    stoplevelling:set_limit_value("scholarship", line)
end
function stoplevelling:set_limit_drinking(line)
    stoplevelling:set_limit_value("drinking", line)
end
function stoplevelling:set_limit_horse_riding(line)
    stoplevelling:set_limit_value("horse_riding", line)
end
function stoplevelling:set_limit_weapon_unarmed(line)
    stoplevelling:set_limit_value("weapon_unarmed", line)
end

function stoplevelling:set_limit_value(statOrSkillKey, line)
    if stoplevelling["limit_"..statOrSkillKey] ~= nil then
        stoplevelling["limit_"..statOrSkillKey] = tonumber(line);
        stoplevelling.data[statOrSkillKey]["limit"] = tonumber(line);
    end
end

--
-- Config getters
-- 
function stoplevelling:get_xp_nerf_timer_period()
    return stoplevelling.xp_nerf_timer_period;
end
function stoplevelling:get_limit_strength()
    return stoplevelling.limit_strength;
end
function stoplevelling:get_limit_agility()
    return stoplevelling.limit_agility;
end
function stoplevelling:get_limit_vitality()
    return stoplevelling.limit_vitality;
end
function stoplevelling:get_limit_speech()
    return stoplevelling.limit_speech;
end
function stoplevelling:get_skills_limits_inherit_stats()
    return stoplevelling.skills_limits_inherit_stats;
end
function stoplevelling:get_skills_strength()
    return stoplevelling.skills_strength;
end
function stoplevelling:get_skills_agility()
    return stoplevelling.skills_agility;
end
function stoplevelling:get_skills_vitality()
    return stoplevelling.skills_vitality;
end
function stoplevelling:get_skills_speech()
    return stoplevelling.skills_speech;
end
function stoplevelling:get_limit_craftsmanship()
    return stoplevelling.limit_craftsmanship;
end
function stoplevelling:get_limit_heavy_weapons()
    return stoplevelling.limit_heavy_weapons;
end
function stoplevelling:get_limit_survival()
    return stoplevelling.limit_survival;
end
function stoplevelling:get_limit_weapon_large()
    return stoplevelling.limit_weapon_large;
end
function stoplevelling:get_limit_fencing()
    return stoplevelling.limit_fencing;
end
function stoplevelling:get_limit_marksmanship()
    return stoplevelling.limit_marksmanship;
end
function stoplevelling:get_limit_stealth()
    return stoplevelling.limit_stealth;
end
function stoplevelling:get_limit_thievery()
    return stoplevelling.limit_thievery;
end
function stoplevelling:get_limit_weapon_sword()
    return stoplevelling.limit_weapon_sword;
end
function stoplevelling:get_limit_alchemy()
    return stoplevelling.limit_alchemy;
end
function stoplevelling:get_limit_houndmaster()
    return stoplevelling.limit_houndmaster;
end
function stoplevelling:get_limit_scholarship()
    return stoplevelling.limit_scholarship;
end
function stoplevelling:get_limit_drinking()
    return stoplevelling.limit_drinking;
end
function stoplevelling:get_limit_horse_riding()
    return stoplevelling.limit_horse_riding;
end
function stoplevelling:get_limit_weapon_unarmed()
    return stoplevelling.limit_weapon_unarmed;
end

function stoplevelling:limits()
    System.LogAlways("$3[DEBUG][StopLevelling] Stat limits:");
    for k, v in pairs(stoplevelling.data) do
        System.LogAlways(string.format("$3[DEBUG][StopLevelling] \t %s %d", tostring(k), tonumber(v)));
    end
end

function stoplevelling:skillDeps()
    System.LogAlways("$3[DEBUG][StopLevelling] Skill dependencies:");
    for k, v in pairs(stoplevelling.data) do
        if v.is_stat then
            System.LogAlways(string.format("$3[DEBUG][StopLevelling] \t %s %s", tostring(v.governing_stat), tostring(k)));
        end
    end
end

function stoplevelling:trimxp()
    System.LogAlways("$3[DEBUG][StopLevelling] trimxp:");
    for k, v in pairs(stoplevelling.data) do
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

        if not v.is_stat and stoplevelling.skills_limits_inherit_stats then
            limit = stoplevelling.data[v.governing_stat]["limit"];
        end

        -- only > 20% progress, above limit level, gets XP trimmed
        if currentProgress > 0.2 and currentLevel >= limit then
            if v.is_stat then
                player.soul:AddStatXP(tostring(k), -50);
            else
                player.soul:AddSkillXP(tostring(k), -50);
            end
        end
    end
    System.LogAlways(string.format("$3[DEBUG][StopLevelling] \t %s %s", tostring(v.governing_stat), tostring(k)));
        
end

function stoplevelling:addAllPerks()
    for k, v in pairs(stoplevelling.data) do
        player.soul:AddPerk(tostring(v.perk_id))
        System.LogAlways(string.format("$3[DEBUG][StopLevelling] Added XP blocking perk for %s (key=%s)", tostring(v.name), tostring(k)));
    end
end

function stoplevelling:removeAllPerks()
    for k, v in pairs(stoplevelling.data) do
        player.soul:RemovePerk(tostring(v.perk_id))
        System.LogAlways(string.format("$3[DEBUG][StopLevelling] Removed XP blocking perk for %s (key=%s)", tostring(v.name), tostring(k)));
    end
end


-- ============================================================================
-- uiActionListener
-- ============================================================================
function stoplevelling:uiActionListener(actionName, eventName, argTable)
    System.LogAlways("$5[INFO][StopLevelling] stoplevelling:uiActionListener called")
end
UIAction.RegisterActionListener(stoplevelling, "", "", "uiActionListener");

-- ============================================================================
-- uiElementListener
-- ============================================================================
function stoplevelling:uiElementListener(elementName, instanceId, eventName, argTable)
    System.LogAlways("$5[INFO][StopLevelling] stoplevelling:uiElementListener called")
end
UIAction.RegisterElementListener(stoplevelling, "", "", "", "uiElementListener");

-- ============================================================================
-- uiEventSystemListener
-- ============================================================================
function stoplevelling:uiEventSystemListener(actionName, eventName, argTable)
    System.LogAlways("$5[INFO][StopLevelling] stoplevelling:uiEventSystemListener called")
end
UIAction.RegisterEventSystemListener(stoplevelling, "", "", "uiEventSystemListener");

stoplevelling:init();