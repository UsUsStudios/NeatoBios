function loadfile(filename, disk, mode, env)
	-- The `disk` argument refers to the parameter that many of
	-- NEETComputers'  `files` methods have. This argument lets yo
	-- load files from other disks, but makes this function
	-- incompatible with the lua's default `loadfile` function.
	-- All other arguments are identical the lua's default `loadfile`.
	local handle = files.open(filename, "r", disk or 0)
	local data = handle.read("a")
	handle.close()
	return load(data, filename, mode, env or _ENV)
end

local font = loadfile("bios:/psf.lua")()("bios:/Lat15-VGA16.psf")
local fontHeight = font.getHeight()
local fontWidth = font.getWidth()
local screenWidth, screenHeight = screen.getSize()

local bootCfg = {}
local selectedOption = 1

function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

local function drawBootOptions()
	for k, v in pairs(bootCfg) do
		local options = {}
		if selectedOption == k then
			options = { background = 0xffffffff, foreground = 0 }
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
	local start = chip.getTime()
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
	print(chip.getTime() - start)
end

local function main()
	if files.isFile("system:/boot/cfg/boot.lua") then
		bootCfg = loadfile("system:/boot/cfg/boot.lua")()
	else
		return
	end

	--local prevSelectedOption = 0

	while true do
		screen.fill(0, 0, 0)

		local data = event.getFirst("user", "keyPressed")
		while data ~= nil do
			local _, keyPressed, code, letter, modifiers = table.unpack(data)
			if keyPressed == 130 and selectedOption > 1 then
				selectedOption = selectedOption - 1
			elseif keyPressed == 131 and selectedOption < #bootCfg then
				selectedOption = selectedOption + 1
			end

			data = event.getFirst("user", "keyPressed")
		end
		--if selectedOption ~= prevSelectedOption then
		render()
		--end
		--prevSelectedOption = selectedOption
	end
end

main()
