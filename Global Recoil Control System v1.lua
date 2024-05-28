--[[
This is the script that works with all Logitech mouses. 
It is a simple script that allows you to control the recoil of a weapon in a game. 
The script is activated by pressing the fifth mouse button, and you can switch between different modifiers by pressing the fourth mouse button. 
The script will then move the mouse in a specific pattern to control the recoil of the weapon. You can adjust the pattern and the delay as needed.

To use the script, you need to install the Logitech G Hub and create a new script in the profile you desire. 
Then copy and paste the script into the editor and save it.

This script is for educational purposes only. Using macros are against the terms of service of most games and can get you banned. Use at your own risk.
--]]


local isActive = false
local mouseButtonPressed = false
local movePattern = {10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 13}
local moveIndex = 1
local modifiers = {1, 2, 3, 4}
local currentModifierIndex = 1

function OnEvent(event, arg)
    if event == "PROFILE_ACTIVATED" then
        EnablePrimaryMouseButtonEvents(true)
    end

    if event == "MOUSE_BUTTON_PRESSED" then
        if arg == 5 then
            isActive = not isActive
            moveIndex = 1
            OutputLogMessage("Script %s\n", isActive and "activated" or "deactivated")
        elseif arg == 4 then
            currentModifierIndex = (currentModifierIndex % #modifiers) + 1
            OutputLogMessage("Switched to modifier %d\n", modifiers[currentModifierIndex])
        elseif arg == 1 and isActive then
            mouseButtonPressed = true
            OutputLogMessage("Mouse button 1 pressed - starting movement\n")
            StartMouseMovement()
        end
    elseif event == "MOUSE_BUTTON_RELEASED" then
        if arg == 1 then
            mouseButtonPressed = false
            OutputLogMessage("Mouse button 1 released - stopping movement\n")
        end
    end
end

function StartMouseMovement()
    while mouseButtonPressed do
        MoveMouseRelative(0, movePattern[moveIndex] * modifiers[currentModifierIndex])
        Sleep(5) -- Adjust the delay as needed
        moveIndex = (moveIndex % #movePattern) + 1
        if not IsMouseButtonPressed(1) then
            break
        end
    end
end

--[[ This script is developed by Tris The Kitten and you can request feature updates or report bugs on the GitHub page:
I will be updating the script with new features and improvements. Thank you for using the script! --]]
