local component = require("component")
local event = require("event")
local term = require("term")
local fs = require("filesystem")
local gpu = component.gpu
local reactor=component.reactor_chamber

local modem=component.modem

local w,h = gpu.getResolution()

--maxResolution() 160x50 if 3x2blocks w,h

-- place for config
-------------------
-- end of config


term.clear()
term.setCursor(1,1)

  gpu.setForeground(0xffffff)

print("---------------------------------------")
print("+ Loading Reactor Shit Controller V1  +")
print("---------------------------------------")
  term.setCursor(1,11)
print("---------------------------------------")
  
  while true do
  

--  gpu.setForeground(0xffffff)  

  gpu.set(4,5, "Reactor maxheat:")
  term.setCursor(30,5)
  print(reactor.getMaxHeat())

    gpu.set(4,6, "Reactor heat:")
    term.setCursor(30,6)
    print(reactor.getHeat())

      gpu.set(4,7, "Reactor EU Output:")
      term.setCursor(30,7)
      print(reactor.getReactorEUOutput())

      gpu.set(4,9, "Reactor is:")

      term.setCursor(30,9)

      gpu.setForeground(0x00FF00)
      if reactor.producesEnergy() == true then
      print("running")
      else
      gpu.setForeground(0xff0000)
      print("offline")
      end

      gpu.setForeground(0xffffff)      
      
      gpu.set(4,10, "Minecraft time:")
      gpu.set(30, 10, os.date("%H:%M:%S", os.time()))

          
  os.sleep(5)
  end
  