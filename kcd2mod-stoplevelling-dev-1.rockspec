package = "KCD2Mod-stoplevelling"
version = "dev-1"
rockspec_format = "3.0"
source = {
   url = "git+ssh://git@github.com/biterplease/KCD2Mod-stoplevelling.git"
}
description = {
   summary = "Block the player's xp at desired levels.",
   detailed = "Block the player's xp at desired levels.",
   homepage = "*** please enter a project homepage ***",
   license = "*** please specify a license ***"
}
dependencies = {
   "lua >= 5.1, < 5.5"
}
build = {
   type = "builtin",
   modules = {
      ["Data.Scripts.Systems.stoplevelling"] = "src/Data/Scripts/Systems/stoplevelling.lua",
      stoplevelling_test = "src/stoplevelling_test.lua"
   }
}
test = {
   type = "command",
   command = "lua src/stoplevelling_test.lua -o TAP"
}
test_dependencies = {
   "luaunit >= 3.4"
}