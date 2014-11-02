scriptId = "com.MyFirstScript"

position = 0

function onForegroundWindowChange(app, title)
	if (title == "Myo Runaway") then
		return true
	end
end

function onActiveChange(isActive)
	myo.controlMouse(true)
	xStart = myo.getRoll()
end


function onPeriodic()
	xRoll = myo.getRoll()
	changeInX = xRoll - xStart
	if (changeInX < -0.1) then
		if (not(position == -1)) then
			position = -1
			myo.keyboard("a", "press")
		end
	elseif (changeInX > 0.1) then
		if (not(position == 1)) then
			position = 1
			myo.keyboard("d", "press")
		end
	elseif (changeInX > -0.05 and changeInX < 0.05) then
		if (position == -1) then
			myo.keyboard("d", "press")
		elseif (position == 1) then
			myo.keyboard("a", "press")
		end
		position = 0
	end
end	

function onPoseEdge(pose, edge)

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
		end
	end
end

function onWaveOut()
	myo.keyboard("right_arrow", "press")
end

function onWaveIn()
	myo.keyboard("left_arrow", "press")
end

function onFist()
	myo.mouse("left", "click")
end

function onFingersSpread()
	myo.keyboard("up_arrow", "press")
end

function conditionallySwapWave(pose)
	if (myo.getArm() == "left") then
		if (pose == "waveIn") then
            pose = "waveOut"
        elseif (pose == "waveOut") then
            pose = "waveIn"
        end
    end
    return pose
end

