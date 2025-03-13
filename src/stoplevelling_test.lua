local lu = require "luaunit";
local mockagne = require "mockagne"

-- fakes
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
RPG = {};

local StopLevelling = require "src.Data.Scripts.mods.biterplease_stop_levelling";

-- mock for player.soul methods
player = {}

TestSetLimitValue = {}
function TestSetLimitValue.test()
    local want = 1;
    StopLevelling:setLimitValue("strength", tostring(want));
    local got = StopLevelling.limit_strength;
    lu.assertEquals(got,want);
    -- if Runner:assertEqual(want,got) then print("\tOK") else print("\tFAIL") end
end

TestSetLimits = {
    currentValue = nil,
    values = {
        {f="Strength", v="strength"},
        {f="Agility", v="agility"},
        {f="Vitality", v="vitality"},
        {f="Speech", v="speech"},
        {f="Craftsmanship", v="craftsmanship"},
        {f="HeavyWeapons", v="heavy_weapons"},
        {f="Survival", v="survival"},
        {f="WeaponLarge", v="weapon_large"},
        {f="Fencing", v="fencing"},
        {f="Marksmanship", v="marksmanship"},
        {f="Stealth", v="stealth"},
        {f="Thievery", v="thievery"},
        {f="WeaponSword", v="weapon_sword"},
        {f="Alchemy", v="alchemy"},
        {f="Houndmaster", v="houndmaster"},
        {f="Scholarship", v="scholarship"},
        {f="Drinking", v="drinking"},
        {f="HorseRiding", v="horse_riding"},
        {f="WeaponUnarmed", v="weapon_unarmed"},
    },
}
    function TestSetLimits:setUp()
        TestSetLimits.currentValue = StopLevelling.skills_limits_inherit_stats;
        StopLevelling.skills_limits_inherit_stats = false;
    end
    function TestSetLimits:testSetLimitsSetsValues()
        for _, attr in ipairs(TestSetLimits.values) do
            local want = 1;
            StopLevelling["setLimit"..(attr.f)](StopLevelling, tostring(want))
            local got = StopLevelling["limit_"..(attr.v)];
            lu.assertEquals(got, want, attr.v)
        end
    end
    function TestSetLimits:tearDown()
        StopLevelling.skills_limits_inherit_stats = TestSetLimits.currentValue;
    end

TestSetStatDeps = {
    currentSpeechDeps = nil,
    currentSpeechLevel = nil,
    currentCraftsmanshipLevel = nil,
    currentSurvivalLevel = nil,
    currentThieveryLevel = nil,
}
    function TestSetStatDeps:setUp()
        TestSetStatDeps.currentSpeechDeps = StopLevelling.skills_speech;
        TestSetStatDeps.currentSpeechLevel = StopLevelling.limit_speech
        TestSetStatDeps.currentCraftsmanshipLevel = StopLevelling.limit_craftsmanship
        TestSetStatDeps.currentSurvivalLevel = StopLevelling.limit_survival
        TestSetStatDeps.currentThieveryLevel = StopLevelling.limit_thievery
    end
    function TestSetStatDeps:testSetStatDeps()
        StopLevelling:setStatDeps("speech", "craftsmanship,survival,thievery");
        local got = StopLevelling.skills_speech;
        
        lu.assertTableContains(got, "craftsmanship","craftsmanship");
        lu.assertTableContains(got, "survival","survival");
        lu.assertTableContains(got, "thievery","thievery");
    end
    function TestSetStatDeps:tearDown()
        StopLevelling:setStatDeps("speech", table.concat(TestSetStatDeps.currentSpeechDeps, ","));
        StopLevelling:setLimitSpeech(tostring(TestSetStatDeps.currentSpeechLevel))
        StopLevelling:setLimitCraftsmanship(tostring(TestSetStatDeps.currentCraftsmanshipLevel))
        StopLevelling:setLimitSurvival(tostring(TestSetStatDeps.currentSurvivalLevel))
        StopLevelling:setLimitThievery(tostring(TestSetStatDeps.currentThieveryLevel))
    end


TestSetLimitsSetsStatsWhenInheritTrue = {
    currentValue = nil,
    dataSnapshot = nil,
}
    function TestSetLimitsSetsStatsWhenInheritTrue:setUp()
        TestSetLimitsSetsStatsWhenInheritTrue.currentValue = StopLevelling.skills_limits_inherit_stats;
        TestSetLimitsSetsStatsWhenInheritTrue.dataSnapshot = StopLevelling.data;
        StopLevelling:setSkillLimitsInheritStats("true");
    end
    function TestSetLimitsSetsStatsWhenInheritTrue:test()
        local want = 1;
        StopLevelling:setLimitValue("vitality", tostring(want))
        lu.assertEquals(StopLevelling.limit_vitality,want, "vitality")
        lu.assertEquals(StopLevelling.limit_drinking,want, "drinking")
        lu.assertEquals(StopLevelling.limit_horse_riding,want, "horse_riding")
        lu.assertEquals(StopLevelling.limit_weapon_unarmed,want, "weapon_unarmed")
    end
    function TestSetLimitsSetsStatsWhenInheritTrue:tearDown()
        StopLevelling.data = TestSetLimitsSetsStatsWhenInheritTrue.dataSnapshot;
        StopLevelling:setSkillLimitsInheritStats(tostring(TestSetLimitsSetsStatsWhenInheritTrue.currentValue));
    end

TestAddPerk = {
    dataSnapshot = nil,
}
    function TestAddPerk:setUp()
        TestAddPerk.dataSnapshot = StopLevelling.data;
        player.soul = mockagne.getMock();
    end
    function TestAddPerk:test()
        StopLevelling:addPerk("alchemy");
        mockagne.verify(player.soul:AddPerk(TestAddPerk.dataSnapshot["alchemy"].perk_id))
        lu.assertIsTrue(StopLevelling.data["alchemy"].perk_added)
        lu.assertTableContains(System.logBuffer, "$3[DEBUG][StopLevelling] Added XP blocking perk for Alchemy (key=alchemy)")
    end
    function TestAddPerk:tearDown()
        StopLevelling.data = TestAddPerk.dataSnapshot;
        player.soul = nil;
    end

TestRemovePerk = {
    dataSnapshot = nil,
}
        function TestRemovePerk:setUp()
            TestRemovePerk.dataSnapshot = StopLevelling.data;
            player.soul = mockagne.getMock();
            StopLevelling:addPerk("alchemy");
        end
        function TestRemovePerk:test()
            StopLevelling:removePerk('alchemy');
            mockagne.verify(player.soul:RemovePerk(TestRemovePerk.dataSnapshot['alchemy'].perk_id))
            lu.assertIsFalse(StopLevelling.data["alchemy"].perk_added)
            lu.assertTableContains(System.logBuffer, "$3[DEBUG][StopLevelling] Removed XP blocking perk for Alchemy (key=alchemy)")
        end
        function TestRemovePerk:tearDown()
            StopLevelling.data = TestRemovePerk.dataSnapshot;
            player.soul = nil;
        end

TestTrimXPOnStatWithXPModifier = {
    inheritValue = nil,
    dataSnapshot = nil,
}
    function TestTrimXPOnStatWithXPModifier:setUp()
        TestTrimXPOnStatWithXPModifier.inheritValue = StopLevelling.skills_limits_inherit_stats;
        TestTrimXPOnStatWithXPModifier.dataSnapshot = StopLevelling.data;
        StopLevelling:setSkillLimitsInheritStats("false");
        player.soul = mockagne.getMock()
        -- setup
        for k, v in pairs(StopLevelling.data) do
            k = tostring(k)
            if k == "strength" then
                mockagne.when(player.soul:GetStatLevel(k)).thenAnswer(6);
                mockagne.when(player.soul:HasPerk(v.perk_id, false)).thenAnswer(false);
                mockagne.when(player.soul:AddPerk(k));
                StopLevelling:setLimitValue(k, 5)
            else 
                StopLevelling:setLimitValue(k, 25)
                if v.is_stat then
                    mockagne.when(player.soul:GetStatLevel(k)).thenAnswer(21);
                else
                    mockagne.when(player.soul:GetSkillLevel(k)).thenAnswer(21);
                end
            end
        end
    end
    function TestTrimXPOnStatWithXPModifier:testStrength()

        StopLevelling:trimxp();
        mockagne.verify(player.soul:AddPerk("59fb8183-8474-4f60-aed0-eb6afe572e53"));
        --assert logs
        lu.assertTableContains(System.logBuffer, "$5[INFO][StopLevelling] adding XP blocking perk for Stat strength (Strength)")
    end
    function TestTrimXPOnStatWithXPModifier:tearDown()
        StopLevelling:setSkillLimitsInheritStats(
            tostring(TestTrimXPOnStatWithXPModifier.inheritValue));
        StopLevelling.data = TestTrimXPOnStatWithXPModifier.dataSnapshot;
        player.soul = nil;
    end

TestTrimXPOnStatWithoutXPModifier = {
    inheritValue = nil,
    dataSnapshot = nil,
}
        function TestTrimXPOnStatWithoutXPModifier:setUp()
            TestTrimXPOnStatWithoutXPModifier.inheritValue = StopLevelling.skills_limits_inherit_stats;
            TestTrimXPOnStatWithoutXPModifier.dataSnapshot = StopLevelling.data;
            StopLevelling:setSkillLimitsInheritStats("false");
            player.soul = mockagne.getMock()
            -- setup
            for k, v in pairs(StopLevelling.data) do
                k = tostring(k)
                if k == "speech" then
                    mockagne.when(player.soul:GetStatLevel(k)).thenAnswer(6);
                    mockagne.when(player.soul:GetStatProgress(k)).thenAnswer(0.50);
                    mockagne.when(player.soul:GetNextLevelStatXP(k, 6)).thenAnswer(100);
                    mockagne.when(player.soul:HasPerk(v.perk_id, false)).thenAnswer(false);
                    mockagne.when(player.soul:AddPerk(k));
                    StopLevelling:setLimitValue(k, 5)
                else 
                    StopLevelling:setLimitValue(k, 25)
                    if v.is_stat then
                        mockagne.when(player.soul:GetStatLevel(k)).thenAnswer(21);
                    else
                        mockagne.when(player.soul:GetSkillLevel(k)).thenAnswer(21);
                    end
                end
            end
        end
        function TestTrimXPOnStatWithoutXPModifier:testSpeech()
            StopLevelling:trimxp();
            mockagne.verify(player.soul:AddPerk("77368463-bda8-4043-b872-dab47857580b"));
            mockagne.verify(player.soul:AddStatXP("speech", -25 )); -- 50%
            --assert logs
            lu.assertTableContains(System.logBuffer, "$5[INFO][StopLevelling] adding XP blocking perk for Stat speech (Speech)")
            lu.assertTableContains(System.logBuffer, "$5[INFO][StopLevelling] trimming -25 XP for Stat speech (Speech)")
        end
        function TestTrimXPOnStatWithoutXPModifier:tearDown()
            StopLevelling:setSkillLimitsInheritStats(
                tostring(TestTrimXPOnStatWithoutXPModifier.inheritValue));
            StopLevelling.data = TestTrimXPOnStatWithoutXPModifier.dataSnapshot;
            player.soul = nil;
        end
    

TestTrimXPOnSkillWithXPModifier = {
    inheritValue = nil,
    dataSnapshot = nil,
}
    function TestTrimXPOnSkillWithXPModifier:setUp()
        TestTrimXPOnSkillWithXPModifier.inheritValue = StopLevelling.skills_limits_inherit_stats;
        TestTrimXPOnSkillWithXPModifier.dataSnapshot = StopLevelling.data;
        StopLevelling:setSkillLimitsInheritStats("false");
        player.soul = mockagne.getMock()
        -- setup
        for k, v in pairs(StopLevelling.data) do
            k = tostring(k)
            if k == "craftsmanship" then
                mockagne.when(player.soul:GetSkillLevel(k)).thenAnswer(6);
                mockagne.when(player.soul:HasPerk(v.perk_id, false)).thenAnswer(false);
                mockagne.when(player.soul:AddPerk(k));
                StopLevelling:setLimitValue(k, 5)
            else 
                StopLevelling:setLimitValue(k, 25)
                if v.is_stat then
                    mockagne.when(player.soul:GetStatLevel(k)).thenAnswer(21);
                else
                    mockagne.when(player.soul:GetSkillLevel(k)).thenAnswer(21);
                end
            end
        end
    end
    function TestTrimXPOnSkillWithXPModifier:testCraftsmanship()
        StopLevelling:trimxp();
        mockagne.verify(player.soul:AddPerk("2f2b9d82-9a91-40f0-bedb-ab53cb333127"));
        --assert logs
        lu.assertTableContains(System.logBuffer, "$5[INFO][StopLevelling] adding XP blocking perk for Skill craftsmanship (Craftsmanship)")
    end
    function TestTrimXPOnSkillWithXPModifier:tearDown()
        StopLevelling:setSkillLimitsInheritStats(
            tostring(TestTrimXPOnSkillWithXPModifier.inheritValue));
        StopLevelling.data = TestTrimXPOnSkillWithXPModifier.dataSnapshot;
        player.soul = nil;
    end

TestTrimXPOnSkillWithoutXPModifier = {
    inheritValue = nil,
    dataSnapshot = nil,
}
    function TestTrimXPOnSkillWithoutXPModifier:setUp()
        TestTrimXPOnSkillWithoutXPModifier.inheritValue = StopLevelling.skills_limits_inherit_stats;
        TestTrimXPOnSkillWithoutXPModifier.dataSnapshot = StopLevelling.data;
        StopLevelling:setSkillLimitsInheritStats("false");
        player.soul = mockagne.getMock()
        -- setup
        for k, v in pairs(StopLevelling.data) do
            k = tostring(k)
            if k == "alchemy" then
                mockagne.when(player.soul:GetSkillLevel(k)).thenAnswer(6);
                mockagne.when(player.soul:GetSkillProgress(k)).thenAnswer(0.50);
                mockagne.when(player.soul:GetNextLevelSkillXP(k, 6)).thenAnswer(100);
                mockagne.when(player.soul:HasPerk(v.perk_id, false)).thenAnswer(false);
                mockagne.when(player.soul:AddPerk(k));
                StopLevelling:setLimitValue(k, 5)
            else 
                StopLevelling:setLimitValue(k, 25)
                if v.is_stat then
                    mockagne.when(player.soul:GetStatLevel(k)).thenAnswer(21);
                else
                    mockagne.when(player.soul:GetSkillLevel(k)).thenAnswer(21);
                end
            end
        end
    end
    function TestTrimXPOnSkillWithoutXPModifier:testAlchemy()

        StopLevelling:trimxp();
        mockagne.verify(player.soul:AddPerk("da9a2ea7-06c2-4b51-bd11-bc0be2c95cf2"));
        mockagne.verify(player.soul:AddSkillXP("alchemy", -25 ));
        --assert logs
        lu.assertTableContains(System.logBuffer, "$5[INFO][StopLevelling] adding XP blocking perk for Skill alchemy (Alchemy)")
        lu.assertTableContains(System.logBuffer, "$5[INFO][StopLevelling] trimming -25 XP for Skill alchemy (Alchemy)")
    end
    function TestTrimXPOnSkillWithoutXPModifier:tearDown()
        StopLevelling:setSkillLimitsInheritStats(
            tostring(TestTrimXPOnSkillWithoutXPModifier.inheritValue));
        StopLevelling.data = TestTrimXPOnSkillWithoutXPModifier.dataSnapshot;
        player.soul = nil;
    end



os.exit(lu.LuaUnit.run())