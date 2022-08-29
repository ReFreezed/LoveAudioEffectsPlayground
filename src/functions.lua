--[[============================================================
--=
--=  Functions
--=
--=-------------------------------------------------------------
--=
--=  LÖVE Audio Effects Playground
--=  by Marcus 'ReFreezed' Thunström
--=
--==============================================================

	clamp
	Color
	drawImage
	expKeepSign
	indexOf, itemWith1
	ipairsr
	lerp, normalize, denormalize
	moveTowards
	printError, printfError
	randomf
	serialize, deserialize
	shaderSend
	writeKvPair

--============================================================]]



function _G.expKeepSign(v, exp) -- @Cleanup: Rename to powKeepSign.
	return (v < 0) and -(-v)^exp or v^exp
end



function _G.lerp(x1, x2, t)
	return x1 + t*(x2-x1)
end

function _G.normalize(v, min,max, exp)
	v   = expKeepSign(v  , 1/exp)
	min = expKeepSign(min, 1/exp)
	max = expKeepSign(max, 1/exp)
	return (v-min) / (max-min)
end

function _G.denormalize(v01, min,max, exp)
	min = expKeepSign(min, 1/exp)
	max = expKeepSign(max, 1/exp)
	return expKeepSign(min+v01*(max-min), exp)
end



function _G.formatBytes(n)
	if     n >= 1024^3 then  return string.format("%.2f GiB"  , n/(1024^3))
	elseif n >= 1024^2 then  return string.format("%.2f MiB"  , n/(1024^2))
	elseif n >= 1024   then  return string.format("%.2f KiB"  , n/(1024  ))
	elseif n ~= 1      then  return string.format("%.0f bytes", n)
	else                     return                  "1 byte"  end
end



-- r, g, b = Color"rrggbb"
function _G.Color(hexStr)
	return tonumber(hexStr:sub(1, 2), 16) / 255
	     , tonumber(hexStr:sub(3, 4), 16) / 255
	     , tonumber(hexStr:sub(5, 6), 16) / 255
end



-- value, targetReached = moveTowards( currentValue, targetValue, speed )
function _G.moveTowards(current, target, speed)
	if current < target then
		current = math.min(current+speed, target)
	elseif current > target then
		current = math.max(current-speed, target)
	end
	return current, (current == target)
end



function _G.randomf(min, max)
	return min + (max-min) * math.random()
end



local function iprev(arr, i)
	i = i - 1
	local v = arr[i]
	if v ~= nil then  return i, v  end
end

function _G.ipairsr(arr)
	return iprev, arr, #arr+1
end



function _G.serialize(v)
	if type(v) == "string" then
		return string.format("%q", v)
	elseif type(v) == "number" or type(v) == "boolean" or v == nil then
		return (tostring(v):gsub("^(%-?)0.", "%1."))
	else
		error(type(v))
	end
end

function _G.deserialize(vStr)
	return assert(loadstring("return "..vStr, "@(deserialize)"))()
end



function _G.writeKvPair(buffer, k, v)
	table.insert(buffer, k)
	table.insert(buffer, " = ")
	table.insert(buffer, serialize(v))
	table.insert(buffer, "\n")
end


-- index|nil = indexOf( array, value )
function _G.indexOf(arr, v)
	for i = 1, #arr do
		if arr[i] == v then  return i  end
	end
	return nil
end

-- item, index = itemWith1( array, key, value )
-- Returns nil if the item isn't found.
function _G.itemWith1(arr, k, v)
	for i = 1, #arr do
		if arr[i][k] == v then  return arr[i], i  end
	end
	return nil
end



function _G.clamp(v, min, max)
	return math.max(math.min(v, max), min)
end



function _G.printError(...)
	for i = 1, select("#", ...) do
		if i > 1 then  io.stderr:write("\n")  end
		io.stderr:write(tostring((select(i, ...))))
	end
	io.stderr:write("\n")
end

function _G.printfError(s, ...)
	io.stderr:write(s:format(...), "\n")
end



function _G.shaderSend(shader, var, ...)
	pcall(shader.send, shader, var, ...)
end



function _G.drawImage(image, ax,ay, x,y, r, sx,sy)
	local iw,ih = image:getDimensions()
	LG.draw(image, x,y, r, sx,sy, ax*iw,ay*ih)
end


