-- Japanese Eisuu & Kana

local escape = 0x35
local fn = 0x3F
local leftOption = 0x3A
local leftCommand = 0x37
local rightCommand = 0x36
local rightOption = 0x3D
local kanaKey = 0x68
local eisuuKey = 0x66

local function jp()
  -- hs.alert("かな")
  hs.eventtap.keyStroke({}, kanaKey)
end

local function eng()
  -- hs.alert("英数")
  hs.keycodes.setLayout("U.S.")
end

local function swe()
  hs.keycodes.setLayout("Swedish - US")
end

local function albert()
  hs.eventtap.keyStroke({'⌘'}, 'F12')
end

modifierEvents = {}

local function flagsChanged(event)
  local flags = event:getFlags()
  -- require 'pl.pretty'.dump(flags)
  -- require 'pl.pretty'.dump(modifierEvents)
  local keyCode = event:getKeyCode()
  if keyCode == 0 then
    return
  end
  local modifierEvent = modifierEvents[keyCode]
  -- require 'pl.pretty'.dump(modifierEvent)
  if modifierEvent == nil then
    --key down
    modifierEvents[keyCode] = {
      modifierOnly = true,
      timePressed = hs.timer.absoluteTime() --nanoseconds
    }
  else
    --key up
    modifierEvents[keyCode] = nil
    local timePassed = hs.timer.absoluteTime() - modifierEvent.timePressed
    local timedOut = timePassed > 700*10^6
    -- print(keyCode)
    if modifierEvent.modifierOnly and not timedOut then
      if keyCode == leftCommand then
        eng()
      elseif keyCode == rightCommand then
        jp()
      elseif keyCode == leftOption then
        swe()
      elseif keyCode == rightOption then
        albert()
      end
    end
  end
  if next(flags) == nil then
    modifierEvents = {}
  end
end

local function nonModifierKeyDown(event)
    for _, event in pairs(modifierEvents) do
      event.modifierOnly = false
    end
end

flagsChange = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, flagsChanged)
flagsChange:start()
eventtap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, nonModifierKeyDown)
eventtap:start()
