local inspect = require "inspect";
System = {
    logBuffer = {}
}
System["AddCCommand"] = function(cmdName, cmdFunc, cmdHelp)
end
System["LogAlways"] = function(line)
    table.insert(System.logBuffer, line);    
end
System["ExecuteCommand"] = function()
end
Script = {}
Script["SetTimer"] = function()
end
Script["KillTimer"] = function()
end
UIAction = {}
UIAction["RegisterActionListener"] = function()
end
UIAction["RegisterElementListener"] = function()
end
UIAction["RegisterEventSystemListener"] = function()
end

local StopLevelling = require "src.Data.Scripts.Startup.stoplevelling";

-- mock for player.soul methods
player = {
    calls={
        -- GetStatProgress = {},
        -- GetStatLevel = {},
        -- GetSkillProgress = {},
        -- GetSkillLevel = {},
        -- AddStatXP = {},
        -- AddSkillXP = {},
        -- AddPerk = {},
        -- RemovePerk = {},
    },
    expectations={
        -- GetStatProgress = {},
        -- GetStatLevel = {},
        -- GetSkillProgress = {},
        -- GetSkillLevel = {},
        -- AddStatXP = {},
        -- AddSkillXP = {},
        -- AddPerk = {},
        -- RemovePerk = {},
    }
}
player.soul  = {}
function player:called(method, arg1,arg2)

    local call = {arg1= arg1};
    if arg2 ~= nil then
        call["arg2"] = arg2;
    end
    if player.calls[method] == nil then
        player.calls[method] = {}
    end
    table.insert(player.calls[method], call);
end


function player:expect(method, arg1, arg2, returnValue)
    local call = {arg1 = arg1};
    if arg2 ~= nil then
        call.arg2 = arg2;
    end
    if returnValue ~= nil then
        call.returnValue = returnValue;
    end
    if player.expectations[method] == nil then
        player.expectations[method] = {}
    end
    table.insert(player.expectations[method], call);
end

function player:assertExpectations()
    local ok = true;
    for key, expectation in pairs(player.expectations) do
        if expectation ~= nil then
            local call = player.calls[key];

            if call == nil then
                Runner:raise(string.format("expected call to method %s, but there is none", key))
                ok = false;
            else
                if expectation["arg1"] ~= call["arg1"] then
                    Runner:raise(string.format("expected call to method %s with arg1 %s, got %s instead", key, tostring(expectation["arg1"]), tostring(call["arg1"])))
                    ok = false
                end
                if expectation["arg2"] ~= nil then
                    if expectation["arg2"] ~= call["arg2"] then
                        Runner:raise(string.format("expected call to method %s with arg1 %s, got %s instead", key, tostring(expectation["arg2"]), tostring(call["arg2"])))
                        ok = false
                    end
                end
            end
        end
    end
    return ok
end

function player:getExpectedReturnValue(method, arg1)
    for key, expectationSet in pairs(player.expectations) do
        for _, expectation in ipairs(expectationSet) do
            if key == method then
                if expectation["arg1"] ~= nil then
                    if expectation["arg1"] == arg1 then
                        return expectation["returnValue"]
                    end    
                end
            end
        end
    end
    return nil
end
function player:clear()
    player.expectations = nil;
    player.calls = nil;
    player.expectations = {};
    player.calls = {};
end

function player.soul:GetStatProgress(stat)
    player:called("GetStatProgress", stat)
    local r = player:getExpectedReturnValue("GetStatProgress", stat);
    return r
end

function player.soul:GetStatLevel(stat)
    player:called("GetStatLevel", stat)
    local r = player:getExpectedReturnValue("GetStatLevel",stat)
    return r
end

function player.soul:GetSkillProgress(skill)
    player:called("GetSkillProgress", skill)
    return player:getExpectedReturnValue("GetSkillProgress",skill)
end

function player.soul:GetSkillLevel(skill)
    player:called("GetSkillLevel", skill)
    return player:getExpectedReturnValue("GetSkillLevel",skill)
end

function player.soul:AddStatXP(stat, amt)
    player:called("AddStatXP", stat, amt)
end

function player.soul:AddSkillXP(skill, amt)
    player:called("AddSkillXP", skill, amt)
end

function player.soul:AddPerk(perkid)
    player:called("AddPerk", perkid)
end

function player.soul:HasPerk(perkid, booly)
    player:called("HasPerk", perkid, booly)
    return player:getExpectedReturnValue("HasPerk", perkid)
end

function player.soul:RemovePerk(perkid)
    player:called("RemovePerk", perkid)
end

-- testrunner
Runner = {}
function Runner:raise(errMessage)
    io.stderr:write("\tFAIL: Error: "..errMessage.."\n");
end

function Runner:assertEqual(a,b,errMessage)
    if type(a) ~= type(b) then
        Runner:raise(string.format("different types %s and %", type(a), type(b)))
        return false
    end
    if not (a == b) then
        if errMessage ~= nil then
            Runner:raise(string.format("want %d got %d: %s", a, b, errMessage))
            return false
        end
        Runner:raise(string.format("want %d got %d", a, b))
        return false
    end
    return true
end

function Runner:assertHasValue(tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    Runner:raise(string.format("want %s to exist in table [%s], but its missing", val, table.concat(tab,",")))
    return false
end


function Runner:assertLogged(want)
    local found = false;
    for _, line in ipairs(System.logBuffer) do
        if string.find(line, want) then
            found = true;
        end
    end
    if not found then
        Runner:raise(string.format("want %s in logs, but could not find it", want))
    end
    return found
end

function Runner:Test()
    for k, testfn in pairs(Runner) do
        if string.match(tostring(k), "test_") then
            print(k..":")
            testfn(Runner)
        end
    end
end

function Runner:test_set_limit_value()
    local want = 1;
    StopLevelling:set_limit_value("strength", tostring(want));
    local got = StopLevelling.limit_strength;
    if Runner:assertEqual(want,got) then print("\tOK") else print("\tFAIL") end
end
function Runner:test_set_limits()
    local currentValue = StopLevelling.skills_limits_inherit_stats;
    StopLevelling.skills_limits_inherit_stats = false;
    local values = {
        "strength",
        "agility",
        "vitality",
        "speech",
        "craftsmanship",
        "heavy_weapons",
        "survival",
        "weapon_large",
        "fencing",
        "marksmanship",
        "stealth",
        "thievery",
        "weapon_sword",
        "alchemy",
        "houndmaster",
        "scholarship",
        "drinking",
        "horse_riding",
        "weapon_unarmed",
    }
    for _, attr in ipairs(values) do
        local want = 1;
        StopLevelling["set_limit_"..attr](StopLevelling, tostring(want))
        local got = StopLevelling["limit_"..attr];
        if Runner:assertEqual(want,got) then
            print("\ttest_limit_"..attr..": OK")
        end
    end
    StopLevelling.skills_limits_inherit_stats = currentValue;
end

function Runner:test_set_stat_deps()
    local currentSpeechDeps = StopLevelling.skills_speech;
    StopLevelling:set_stat_deps("speech", "craftsmanship,survival,thievery");
    local currentSpeechLevel = StopLevelling.limit_speech
    local currentCraftsmanshipLevel = StopLevelling.limit_craftsmanship
    local currentSurvivalLevel = StopLevelling.limit_survival
    local currentThieveryLevel = StopLevelling.limit_thievery
    local got = StopLevelling.skills_speech;
    
    if Runner:assertHasValue(got, "craftsmanship") then print("\t craftsmanship OK") end
    if Runner:assertHasValue(got, "survival") then print("\t survival OK") end
    if Runner:assertHasValue(got, "thievery") then print("\t thievery OK") end
    StopLevelling:set_stat_deps("speech", table.concat(currentSpeechDeps, ","));
    StopLevelling:set_limit_speech(tostring(currentSpeechLevel))
    StopLevelling:set_limit_craftsmanship(tostring(currentCraftsmanshipLevel))
    StopLevelling:set_limit_survival(tostring(currentSurvivalLevel))
    StopLevelling:set_limit_thievery(tostring(currentThieveryLevel))
end

function Runner:test_set_limits_sets_stats_when_inherit_true()
    local currentValue = StopLevelling.skills_limits_inherit_stats;
    StopLevelling:set_skills_limits_inherit_stats("true");

    
    local want = 1;
    StopLevelling:set_limit_value("vitality", tostring(want))

    local a = Runner:assertEqual(want, StopLevelling.limit_vitality, "vitality")
    local b = Runner:assertEqual(want, StopLevelling.limit_drinking, "drinking")
    local c = Runner:assertEqual(want, StopLevelling.limit_horse_riding, "horse_riding")
    local d = Runner:assertEqual(want, StopLevelling.limit_weapon_unarmed, "weapon_unarmed")

    if a and b and c and d then
        print("\tOK")
    end

    StopLevelling:set_skills_limits_inherit_stats(tostring(currentValue));
end

function Runner:test_logs_on_init()
    local want = "STOP LEVELLING";
    if Runner:assertLogged(want) then print("\tOK") end
end


function Runner:test_add_all_perks()
    player:clear()
    local perks = {
        '59fb8183-8474-4f60-aed0-eb6afe572e53',
        '03b7b530-0f9d-41e6-996f-8a39bb0d070c',
        '74251454-09b1-4c22-b36e-ac6177bc4c3b',
        '77368463-bda8-4043-b872-dab47857580b',
        '2f2b9d82-9a91-40f0-bedb-ab53cb333127',
        '52a593f8-3fc7-46d8-a389-4ca47cd3a22e',
        '1ede484d-b2bf-4c4b-a275-e9fa765bc7d3',
        '98bb8ae8-1fc3-4ac0-8784-58106a421abf',
        '4e0a8900-d9bc-49f8-bd36-fcded2c1ad79',
        '643ff10b-534d-4a1b-99ae-971fb085d1d8',
        '4d0d74ce-3e4e-4683-908e-61546b0b0b2e',
        '743554e5-5af4-4cd0-9844-f579c2020392',
        '9a28f2ca-c48c-4747-a574-c0d233144206',
        'da9a2ea7-06c2-4b51-bd11-bc0be2c95cf2',
        'c76cce08-5fa9-4441-a44e-01c5d4a4a9d9',
        '0341d739-e37b-4b10-84c2-eee6e323493c',
        'e3da758a-3c05-4109-a7b9-8fa7bbf48824',
        '89ac270e-20b2-4381-96d6-27cf791e944f',
        '93551fe9-bb0c-4242-8aea-8de2db44952e',
    }
    for _, perkid in ipairs(perks) do
        player:expect("AddPerk", perkid)
    end
    StopLevelling:add_all_perks();
    if player:assertExpectations() then print("\tOK") end
end

function Runner:test_remove_all_perks()
    player:clear()
    local perks = {
        '59fb8183-8474-4f60-aed0-eb6afe572e53',
        '03b7b530-0f9d-41e6-996f-8a39bb0d070c',
        '74251454-09b1-4c22-b36e-ac6177bc4c3b',
        '77368463-bda8-4043-b872-dab47857580b',
        '2f2b9d82-9a91-40f0-bedb-ab53cb333127',
        '52a593f8-3fc7-46d8-a389-4ca47cd3a22e',
        '1ede484d-b2bf-4c4b-a275-e9fa765bc7d3',
        '98bb8ae8-1fc3-4ac0-8784-58106a421abf',
        '4e0a8900-d9bc-49f8-bd36-fcded2c1ad79',
        '643ff10b-534d-4a1b-99ae-971fb085d1d8',
        '4d0d74ce-3e4e-4683-908e-61546b0b0b2e',
        '743554e5-5af4-4cd0-9844-f579c2020392',
        '9a28f2ca-c48c-4747-a574-c0d233144206',
        'da9a2ea7-06c2-4b51-bd11-bc0be2c95cf2',
        'c76cce08-5fa9-4441-a44e-01c5d4a4a9d9',
        '0341d739-e37b-4b10-84c2-eee6e323493c',
        'e3da758a-3c05-4109-a7b9-8fa7bbf48824',
        '89ac270e-20b2-4381-96d6-27cf791e944f',
        '93551fe9-bb0c-4242-8aea-8de2db44952e',
    }
    for _, perkid in ipairs(perks) do
        player:expect("RemovePerk", perkid)
    end
    StopLevelling:remove_all_perks();
    if player:assertExpectations() then print("\tOK") end
end

function Runner:test_trimxp_strength_over_limit()
    player:clear()
    -- setup
    for k, v in pairs(StopLevelling.data) do
        if k ~= "strength" then
            StopLevelling.data[k]["limit"] = 25;
            if v.is_stat then
                player:expect("GetStatProgress", tostring(k), nil, 0.15);
                player:expect("GetStatLevel", tostring(k), nil, 20);
            else
                player:expect("GetSkillProgress", tostring(k), nil, 0.15);
                player:expect("GetSkillLevel", tostring(k), nil, 20);
            end
        else 
            player:expect("GetStatProgress", tostring(k), nil, 0.50);
            player:expect("GetStatLevel", tostring(k), nil, 20);
            player:expect("HasPerk", v.perk_id);
            player:expect("AddPerk", v.perk_id);
            StopLevelling.data[k]["limit"] = 5;
        end
    end

    player:expect("AddStatXP", "strength", -50);

    StopLevelling:trimxp();

    if player:assertExpectations() then print("\tOK") end
end

function Runner:test_trimxp_alchemy_over_limit()
    local inheritValue = StopLevelling.skills_limits_inherit_stats;
    StopLevelling:set_skills_limits_inherit_stats("false");
    player:clear()
    -- setup
    for k, v in pairs(StopLevelling.data) do
        if k == "alchemy" then
            player:expect("GetSkillProgress", tostring(k), nil, 0.60);
            player:expect("GetSkillLevel", tostring(k), nil, 6);
            player:expect("HasPerk", v.perk_id);
            player:expect("AddPerk", v.perk_id);
            StopLevelling.data[k]["limit"] = 5;
        else 
            StopLevelling.data[k]["limit"] = 25;
            if v.is_stat then
                player:expect("GetStatProgress", tostring(k), nil, 0.12);
                player:expect("GetStatLevel", tostring(k), nil, 21);
            else
                player:expect("GetSkillProgress", tostring(k), nil, 0.12);
                player:expect("GetSkillLevel", tostring(k), nil, 21);
            end
        end
    end

    player:expect("AddSkillXP", "alchemy", -50);

    StopLevelling:trimxp();

    if player:assertExpectations() then print("\tOK") end

    StopLevelling:set_skills_limits_inherit_stats(tostring(inheritValue));
end

Runner:Test()