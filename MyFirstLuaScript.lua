scriptId = 'com.enghack.myfirstscript'

function onForegroundWindowChange(app, title)
    myo.debug("onForegroundWindowChange: " .. app .. ", " .. title)
    return true
end

function onActiveChange(isActive)
    myo.debug("Mouse in my control")
    myo.controlMouse(true)
    myo.debug("Get roll: " .. myo.getRoll())
    myo.debug("Get X: " .. myo.getXDirection())
end

--[[function onPeriodic()
	yaw_current = myo.getYaw()
	yaw_diff = yaw_current - yaw_initial
	myo.debug("Now yaw = " .. yaw_current)
	if( yaw_diff > 0.7 ) then 
		myo.keyboard("left_arrow", "press")
	end
	if( yaw_diff < 0.7 and yaw_diff > 0) then
		myo.keyboard("right_arrow", "press")
	end
	if( yaw_diff < -0.6) then
		myo.keyboard("left_arrow", "press")
	end
	if( yaw_diff > -0.6 and yaw_diff < 0) then
		myo.keyboard("right_arrow", "press")
	end
end
--]]

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
			myo.mouse("left", "click")
			yaw_initial = myo.getYaw()
			myo.debug("Yaw = " .. yaw_initial)
		elseif (pose == "fingersSpread") then
			onFingersSpread()			
		end
	end
end

function onWaveOut()
	myo.debug("Right")
	myo.keyboard("z", "press")
end

function onWaveIn()
	myo.debug("Left")	
	myo.keyboard("x","press")
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