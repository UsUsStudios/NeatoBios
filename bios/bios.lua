-- Load jojotastic777's files shim and require shim
do
	local handle = files.open("bios:/files-shim.lua")
	local data = handle.read("a")
	handle.close()
	load(data, "0:bios:/files-shim.lua")()
	loadfile("0:bios:/require.lua")()
end

local font = require("psf")("0:bios:/Lat15-VGA16.psf")
local fontHeight = font.getHeight()
local fontWidth = font.getWidth()
local screenWidth, screenHeight = screen.getSize()

local bootCfg = {}
local selectedOption = 1

local function drawBootOptions()
	for k, v in pairs(bootCfg) do
		local options = {}
		if selectedOption == k then
			options = { background = 0xffffffff, foreground = 0x000000ff }
			screen.fill(
				3 + fontWidth * 4,
				3 + fontHeight * (5 + k),
				screenWidth - 3 - fontWidth * 4,
				3 + fontHeight * (6 + k),
				255,
				255,
				255
			)
		end

		font.drawLine(3 + fontWidth * 4, 3 + fontHeight * (5 + k), v["OS Name"] .. " v" .. v["OS Version"], options)
		font.drawLine(3 + fontWidth * 27, 3 + fontHeight * (5 + k), v["OS Boot Path"], options)
		font.drawRightAlignedLine(
			screenWidth - 3 - fontWidth * 4,
			3 + fontHeight * (5 + k),
			v["OS Description"],
			options
		)
	end
end

local function render()
	screen.fill(0, 0, 0)
	screen.drawRectangle(
		fontWidth * 3,
		3 + fontHeight * 5,
		screenWidth - fontWidth * 3,
		screenHeight - 3 - fontHeight * 2,
		255,
		255,
		255
	)

	font.drawCenteredLine(
		3 + fontHeight * 2,
		"Welcome to NeatoBoot. You have " .. #bootCfg .. " operating system(s) installed."
	)
	font.drawCenteredLine(
		3 + fontHeight * 3,
		"Time since startup: " .. math.floor(chip.getTime()) .. "   In-game lunar time: " .. chip.getLunarTime()
	)

	drawBootOptions()
	screen.draw()
end

local function launchBootOption(bootOption)
	local env = _G
	local envVars = bootOption["OS Environment Variable Definition"]
	if envVars ~= nil then
		for var, val in pairs(envVars) do
			env[var] = val
		end
	end

	local args = bootOption["OS Args"]
	local OS = loadfile(bootOption["OS Boot Path"], nil, env)()
	if args == nil then
		OS()
	elseif type(args) == "table" then
		OS(table.unpack(args))
	else
		OS(args)
	end
	render()
end

local function loadBootCfg()
	for _, disk in pairs(files.getDisks()) do
		for _, bootOption in ipairs(loadfile(disk .. ":system:/boot/cfg/boot.lua")()) do
			table.insert(bootCfg, bootOption)
		end
	end
end

local function main()
	loadBootCfg()

	local prevSelectedOption = 0

	while true do
		local data = event.getFirst("user", "keyPressed")
		while data ~= nil do
			local _, keyPressed, code, letter, modifiers = table.unpack(data)
			if keyPressed == 130 and selectedOption > 1 then
				selectedOption = selectedOption - 1
			elseif keyPressed == 131 and selectedOption < #bootCfg then
				selectedOption = selectedOption + 1
			elseif keyPressed == 32 or keyPressed == 13 then
				launchBootOption(bootCfg[selectedOption])
			end

			data = event.getFirst("user", "keyPressed")
		end
		if selectedOption ~= prevSelectedOption then
			render()
		end
		prevSelectedOption = selectedOption
	end
end

local function benchmark()
	local start = chip.getTime()
	print("Test suite started")
	require("benchmarks.binarytrees")(10)
	print(chip.getTime() - start)
	require("benchmarks.array3d")(130)
	print(chip.getTime() - start)
	require("benchmarks.chameos")(200000)
	print(chip.getTime() - start)
	require("benchmarks.coroutine_ring")(500000)
	print(chip.getTime() - start)
	require("benchmarks.fannkuch_redux")(50)
	print(chip.getTime() - start)
	require("benchmarks.fasta")(90)
	print("Test suite finished in " .. chip.getTime() - start .. " seconds")
end

main()
