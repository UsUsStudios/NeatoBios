return {
	[1] = {
		["OS Name"] = "UsUsOS",
		["OS Version"] = "1.2.3", -- semver style (possibly?) enforced
		["OS Description"] = "The UsUsOS Operating System",
		["OS Boot Path"] = "0:system:/ususos.lua",
		["OS Environment Variable Definition"] = { --optional
			["EXAMPLEVAR"] = 0,
			["VAR2"] = "Hi",
		},
	},
	[2] = {
		["OS Name"] = "UsUsOS",
		["OS Version"] = "2.2.2", -- semver style (possibly?) enforced
		["OS Description"] = "The UsUsOS Operating System",
		["OS Args"] = "-v -f", --optional
		["OS Boot Path"] = "0:system:/ususos.lua",
		["OS Environment Variable Definition"] = { --optional
			["EXAMPLEVAR"] = 0,
			["VAR2"] = "Hi",
		},
	},
	[3] = {
		["OS Name"] = "UsUsOS",
		["OS Version"] = "3.2.1", -- semver style (possibly?) enforced
		["OS Description"] = "The UsUsOS Operating System",
		["OS Args"] = { "-v", "-f" }, --optional
		["OS Boot Path"] = "0:system:/ususos.lua",
		["OS Environment Variable Definition"] = { --optional
			["EXAMPLEVAR"] = 0,
			["VAR2"] = "Hi",
		},
	},
}
