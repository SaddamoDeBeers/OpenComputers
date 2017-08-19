
local version="4.0"

local component = require("component")
local computer = require("computer")
local event = require("event")
local term = require("term")
local fs = require("filesystem")
local gpu = component.gpu
local beep = component.computer.beep
local reactor=component.reactor_chamber

--reactor
local maxheat=reactor.getMaxHeat()
local heat=reactor.getHeat --changed from variable value to function, call heat() if you want to get the current heat value, just storing it in a local variable once is of no use (except maxheat if reactor does not change)
local EUOutput=reactor.getReactorEUOutput --changed from variable value to function
--reactor

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
  if EUOutput() == 0 then --calling function to get current value
  return "offline" --had to be strings, also changed function to return values insteat of setting global variables
  else
  return "online "
  end
end --forgot end
--more functions  

gpu.setForeground(0xffffff)


-----
term.clear()
term.setCursor(1,1)

centerF(5,  "-----------------------------------------")
centerF(6,  "-       IC2 Reactor Controller V4       -")
centerF(7,  "-----------------------------------------")
--centerF(8, string.format("- Reactor is:             %s       -",status())) --changed to insert value of variable
centerF(9,  "- Reactor maxheat:        10000         -")
centerF(10, "- Reactor heat:           1500          -")
centerF(11, "- Reactor EU output:      3200          -")
centerF(12, "-                                       -")
centerF(13, "-                                       -")
centerF(14, "- Minecraft time:         111           -")
centerF(15, "- Status uptime:          555           -")
centerF(16, "- Refresh rate:           5             -")   
centerF(17, "-----------------------------------------")
----- wrap these calls into a function and call it every second from the while loop
  
while true do --indentation not necessary but makes reading the code a lot easier

  
  tickCnt = tickCnt + 1
  if tickCnt == 60 then
    mins = mins + 1
    tickCnt = 0
  end
  
  if mins == 60 then
    hours = hours + 1
    mins = 0
  end
  
  beep()

  os.sleep(1)
  centerF(8, string.format("- Reactor is:             %s       -",status())) --added this to get current value if reactor shuts down since script startup
  centerF(40, "Data updates every second: %2d", tickCnt)
  centerF(41, "Current up time: %2d hours %2d min", hours, mins)
end