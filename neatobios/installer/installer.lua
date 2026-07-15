package.path = table.concat({
	"0:neatobios:/?.lua",
}, ";")

local wget = require("installer/wget")

local function main()
	wget("example.com", "0:system:/test.txt")
end

return main
