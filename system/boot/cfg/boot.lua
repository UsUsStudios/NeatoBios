return {
	["Config"] = {
		["DefaultEntry"] = 2, -- the option that appears highlighted first when entering the boot menu
		["Autoboot"] = 1, -- or: index number for .Bootlist[i]
	},
	["Bootlist"] = {
		{
			["OS Name"] = "UsUsOS",
			["OS Version"] = "1.2.3", -- semver style (possibly?) enforced
			["OS Description"] = "The UsUsOS Operating System",
			["OS Boot Path"] = "0:system:/ususos.lua",
			["OS Environment Variable Definition"] = { --optional
				["EXAMPLEVAR"] = 1,
				["VAR2"] = "Hello",
			},
		},
		{
			["OS Name"] = "UsUsOS",
			["OS Version"] = "2.2.2", -- semver style (possibly?) enforced
			["OS Description"] = "The UsUsOS Operating System",
			["OS Args"] = "-v -f", --optional
			["OS Boot Path"] = "0:system:/ususos.lua",
			["OS Environment Variable Definition"] = { --optional
				["EXAMPLEVAR"] = 2,
				["VAR2"] = "Hi",
			},
		},
		{
			["OS Name"] = "UsUsOS",
			["OS Version"] = "3.2.1", -- semver style (possibly?) enforced
			["OS Description"] = "The UsUsOS Operating System",
			["OS Args"] = { "-v", "-f" }, --optional
			["OS Boot Path"] = "0:system:/ususos.lua",
			["OS Environment Variable Definition"] = { --optional
				["EXAMPLEVAR"] = 3,
				["VAR2"] = "Hippy",
			},
		},
	},
}
