
local version="7.0"

local component = require("component")
local computer = require("computer")
local event = require("event")
local term = require("term")
local fs = require("filesystem")
local gpu = component.gpu
local beep = component.computer.beep
local reactor=component.reactor_chamber

--reactor
local Heat=reactor.getMaxHeat()
local getHeat=reactor.getHeat() 
local EUOutput=reactor.getReactorEUOutput() 
--reactor

--colors
local black = 0x000000
local red = 0xFF0000
local yellow = 0xFFFF00
local white = 0xffffff
--colors

--gpu.setForeground(0xffffff)

local start_time = computer.uptime()

local modem = component.modem

local w,h = gpu.getResolution()

--maxResolution() 160x50 if 3x2blocks w,h

-- place for config
-------------------
-- end of config


--start_time

--timer
local tickCnt = 0
local running = true
local hours = 0
local mins = 0
--timer

local function centerF(row, msg, ...)
  local mLen = string.len(msg)
  w, h = gpu.getResolution()
  term.setCursor((w - mLen)/2,row)
  print(msg:format(...))
end

--more functions
local function status()
  if EUOutput == 0 then 
  return "offline" 
  else
  return "online "
  end
end --forgot end

local function maxheat()
  return reactor.getMaxHeat()
  end
  
local function getheat()
  if getHeat == 0 then
  return "0   "
  else
  return reactor.getHeat()
  end
end
  
local function getEU()
  if EUOutput == 0 then
  return "0   "
  else
  return reactor.getReactorEUOutput()
  end
end
  
--more functions  

gpu.setForeground(0xffffff)


-----
term.clear()
term.setCursor(1,1)

centerF(5,  "-----------------------------------------")
centerF(6,  "-       IC2 Reactor Controller V4       -")
centerF(7,  "-----------------------------------------")
centerF(12, "-                                       -")
centerF(14, "                                        -")   
centerF(17, "-----------------------------------------")

  
while true do 

  
  tickCnt = tickCnt + 1
  if tickCnt == 60 then
    mins = mins + 1
    tickCnt = 0
  end
  
  if mins == 60 then
    hours = hours + 1
    mins = 0
  end

  os.sleep(1)
  
  centerF(8, string.format("- Reactor is:             %s       -",status())) --added this to get current value if reactor shuts down since script startup
  centerF(9, string.format("- Reactor maxheat:        %s         -",maxheat())) --added this to get current value if reactor shuts down since script startup
  centerF(10, string.format("- Reactor heat:           %s          -",  getheat())) --added this to get current value if reactor shuts down since script startup
  centerF(11, string.format("- Reactor EU Output:      %s          -",  getEU())) --added this to get current value if reactor shuts down since script startup
  centerF(40, "Data updates every second: %2d", tickCnt)
  centerF(41, "Current up time: %2d hours %2d min", hours, mins)
end
