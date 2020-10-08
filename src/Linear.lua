local Linear = {}
Linear.__index = Linear

function Linear.new(targetValue, options)
    assert(targetValue, "Missing argument #1: targetValue")
    
	options = options or {
        velocity = 1
    }

	return setmetatable({
        _targetValue = targetValue,
        _targetVelocity = options.velocity
	}, Linear)
end

function Linear:step(state, dt)
	local position = state.value
	local velocity = self._targetVelocity -- Linear motion ignores the state's velocity
	local goal = self._targetValue

	local dPos = dt * velocity

	local complete = math.abs(goal - position) <= dPos
	position = position + dPos * (goal > position and 1 or -1)

	if complete then
		position = self._targetValue
		velocity = 0
	end

	return {
		complete = complete,
		value = position,
		velocity = velocity
	}
end

return Linear