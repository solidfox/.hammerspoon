
-- Hyper modal keyboard shortcut environment
local hyperModal = hs.hotkey.modal.new({}, "F17")

-- HYPER+E: Edit these shortcuts.
hyperModal:bind({}, 'e', nil, function()
  hs.execute('atom ~/.hammerspoon', true)
  hyperModal.modifierOnly = false
end)

-- HYPER+D: Divvy.
hyperModal:bind({}, 'd', nil, function()
  hs.application.launchOrFocus('Divvy')
  hyperModal.modifierOnly = false
end)

-- HYPER+L: Locks screen
hyperModal:bind({}, 'l', nil, function()
  lockscreen = "/System/Library/CoreServices/Menu\\ Extras/User.menu/Contents/Resources/CGSession -suspend"
  hs.execute(lockscreen)
  hyperModal.modifierOnly = false
end)

-- HYPER+R: Reloads config
hyperModal:bind({}, 'r', nil, function()
  hs.reload()
  hyperModal.modifierOnly = false
end)

-- HYPER+T: Open terminal
hyperModal:bind({}, 't', nil, function()
  hs.application.launchOrFocus("Terminal")
  hyperModal.modifierOnly = false
end)

-- hyperModal:bind({}, 'p', nil, function()
--   hs.osascript.applescript('tell application "System Events" to keystroke "hey"')
--   hyperModal.modifierOnly = false
-- end)

local function pressedF18()
  hyperModal.modifierOnly = true
  hyperModal:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is released,
--   send ESCAPE if no other keys are pressed.
local function releasedF18()
  hyperModal:exit()
  if not hyperModal.modifierOnly then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind the Hyper key
local hyperKey = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)
