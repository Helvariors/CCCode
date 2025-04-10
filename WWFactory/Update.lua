-- 0.1.4

local util = require("util")

shell.run("delete", "update")
os.sleep(.4)
shell.run("delete", "util")
os.sleep(.4)


shell.run("wget", "https://raw.githubusercontent.com/Helvariors/CCCode/main/WWFactory/update.lua", "update")
os.sleep(.4)
shell.run("wget", "https://raw.githubusercontent.com/Helvariors/CCCode/main/WWFactory/util.lua", "util")
os.sleep(.4)


local fileList = {"util", "update"}

term.clear()

local previousVersionsTable = nil

if fs.exists("VersionHistory.txt") then
	previousVersionsTable = util.loadTable("VersionHistory.txt")
end

if util.isEmpty(previousVersionsString) then
	local previousVersionsTable = {util = "0", update = "0"}
	util.saveTable(previousVersionsTable, "VersionHistory.txt")
end

for _,i in ipairs(fileList) do

	local file = fs.open(i, "r")
	local line = file.readLine()
	local version = string.gsub(line, "-", "")
	local version = util.trimSpaces(version)

	if not (previousVersionsTable[i] == version) then
		print(i, ": ", version, " (prev. ", previousVersionsTable[i], ")")
	else
		print(i, " version: ", version)
	end
	
	previousVersionsTable[i] = version
end

util.saveTable(previousVersionsTable, "VersionHistory.txt")