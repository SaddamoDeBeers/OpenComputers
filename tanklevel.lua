
-- I was so bored today, that I made this stupid program, it shows tank max capacity and level.

local component = require("component")
local computer = require("computer")
local event = require("event")
local term = require("term")
local sides = require("sides")

local gpu = component.gpu
local beep = component.computer.beep


local tank=component.tank_controller

--
capacity=tank.getTankCapacity
level=tank.getTankLevel

--timer
local tickCnt = 0
local running = true
local hours = 0
local mins = 0
--timer

local start_time = computer.uptime()

local modem = component.modem

local w,h = gpu.getResolution()

term.clear()


local function centerF(row, msg, ...)
  local mLen = string.len(msg)
  w, h = gpu.getResolution()
  term.setCursor((w - mLen)/2,row)
  print(msg:format(...))
end


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
  
  capacity(4)
  level(4)

  
  
  
  wtf=level(4)/capacity(4)*100
  
  term.setCursor(5,5)
  print( "Tank capacity is:", capacity(4) )
  
  term.setCursor(5,6)
  print( "Tank level is:", level(4)  )
  
  term.setCursor(5,7)
  print( "Tank level % is:", wtf)
  
  centerF(30, "Data updates every second: %2d", tickCnt)
  centerF(31, "Current up time: %2d hours %2d min", hours, mins)
  
   os.sleep(1)

end
