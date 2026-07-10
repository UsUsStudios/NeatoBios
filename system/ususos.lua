local function main(arg1, arg2)
	local a1 = arg1 or "1"
	local a2 = arg2 or "2"
	local font = require("psf")("0:bios:/Lat15-VGA16.psf")

	screen.fill(0, 0, 0)
	font.drawLine(3, 3, "Hello")
	font.drawLine(3, 16, a1)
	font.drawLine(3, 29, a2)
	screen.draw()
end

return main
