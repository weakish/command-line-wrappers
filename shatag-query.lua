#!/usr/bin/env luajit

local pwd = os.getenv("PWD")
local workdir = {}
-- Assumes that directory names *only* contains **alphanum**.
for dir in string.gmatch(pwd, "%w+") do
  table.insert(workdir, dir)
end

local name = workdir[3]

local dbname
if #arg == 2 then
  dbname = arg[2]
else
  dbname = workdir[#workdir]
end
local shatagdb = string.format("/pool/repos/private/shatagdb/%s", dbname)

local record = string.format(
  "shatag -d %s -n %s -pqrt .",
  shatagdb, name)
local lookup = string.format([[
  shatag -d %s -rl . |
  egrep '^[^ ]+- ' |
  sed -r 's/^\[33;1m- //' |
  sed -e 's/\[0m$//']],
  shatagdb)
local check = string.format([[
  shatag -d %s -rl . |
  egrep -v '^[^ ]+- ' |
  sed -r 's/^[^ ]+[*+=] //' |
  sed -e 's/\[0m$//']],
  shatagdb)
local function help()
  print("Usage: shatag-query -h|-l|-L|-r [<databasename>]")
end

local command
if #arg < 1 then
  print("shatag-query: got no optino")
  help()
  os.exit(64)
elseif string.find(arg[1], '-r', 1, true) then
  command = record
elseif string.find(arg[1], '-l', 1, true) then
  command = lookup
elseif string.find(arg[1], '-L', 1, true) then
  command = check
elseif string.find(arg[1], '-h', 1, true) then
  help()
else
  print(string.format("shatag-query: invalid option -- '%s'", arg[1]))
  help()
  os.exit(64)
end

os.execute(command)


-- debug
-- print(command)
