scriptId = 'com.enghack.myfirstscript'

locked = true

function onActiveChange(isActive)
    myo.debug("Mouse in my control")
    myo.controlMouse(true)
    yawAndClick()
end

function onPeriodic()
	yaw_current = myo.getYaw()
	myo.debug("Now yaw = " .. yaw_current);
end

function toggleLock()
	locked = not locked
	myo.vibrate("short")
	if (not locked) then
		-- Vibrate twice on unlock
		myo.debug("Unlocked")
		myo.vibrate("short")
	else 
		myo.debug("Locked")
	end
end

function onForegroundWindowChange(app, title)
    if title == "Temple Run Online - Play this Game at Plonga.com" then
    	myo.debug("onForegroundWindowChange: " .. app .. ", " .. title)
    	return true
    end
end

function onPoseEdge(pose, edge)
	myo.debug("onPoseEdge: " .. pose .. ": " .. edge)

	pose = conditionallySwapWave(pose)
	
	if (edge == "on") then
		if (pose == "waveOut") then
			onWaveOut()		
		elseif (pose == "waveIn") then
			onWaveIn()
		elseif (pose == "fist") then
			onFist()
		elseif (pose == "fingersSpread") then
			onFingersSpread()			
		elseif (pose == "thumbToPinky") then
			myo.mouse("left", "click")
			yaw_initial = myo.getYaw()
			myo.debug("Yaw = " .. yaw_initial)	
		end
	end
end

function onWaveOut()
	myo.debug("Right")
	myo.keyboard("right_arrow", "press")
end

function onWaveIn()
	myo.debug("Left")	
	myo.keyboard("left_arrow","press")
end
 
function onFist()
	myo.debug("Duck")	
	myo.keyboard("down_arrow","press")
end
 
function onFingersSpread()
	myo.debug("Jump")
	myo.keyboard("up_arrow", "press")
end

function conditionallySwapWave(pose)
	if myo.getArm() == "left" then
        if pose == "waveIn" then
            pose = "waveOut"
        elseif pose == "waveOut" then
            pose = "waveIn"
        end
    end
    return pose
end
--]]