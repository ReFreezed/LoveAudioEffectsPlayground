--[[============================================================
--=
--=  App
--=
--=-------------------------------------------------------------
--=
--=  LÖVE Audio Effects Playground
--=  by Marcus 'ReFreezed' Thunström
--=
--============================================================]]



-- Setup.
io.stdout:setvbuf("no")
io.stderr:setvbuf("no")

love.keyboard.setKeyRepeat(true)

-- Constants.
_G.TAU                     = 2*math.pi
local APP_STATE_SAVE_DELAY = 5.00
local FLIP_TIME            = 0.40
local FLIP_TIME_FIRST      = 1.20 -- :)

-- Modules.
_G.LA         = love.audio
_G.LG         = love.graphics
local EFFECTS = require"effects"
local PRESETS = require"presets"

require"functions"

-- Variables.
local time = 0.00

local saveAppStateQueued = false
local saveAppStateTime   = 0.00

local actionMessage     = ""
local actionMessageTime = -1/0

local ignoreInput = false

local flipped    = false
local flipAmount = 0
local hasFlipped = false

local theSource        = nil
local currentSoundPath = ""
local gui



-- Misc.
--==============================================================



local function showActionMessage(s, ...)
	actionMessage     = s:format(...)
	actionMessageTime = love.timer.getTime()
	print("[Message] "..actionMessage)
end

local function showActionErrorMessage(s, ...)
	actionMessage     = ("Error: "..s):format(...)
	actionMessageTime = love.timer.getTime()
	printError("[Message] "..actionMessage)
end



local function getSliderValue(guiSlider, min,max, exp)
	return denormalize(guiSlider:getValue(), min,max, exp)
end

local function setSliderValue(guiSlider, min,max, exp, v)
	guiSlider:setValue(normalize(v, min,max, exp))
end



local function loadAppState()
	local appState = {}

	local contents = love.filesystem.read("state")
	if not contents then  return appState  end

	for line in contents:gmatch"[^\n]+" do
		local k, vStr = line:match"^([%a_][%w_]*)%s*=%s*(%S.*)$"
		if k then
			appState[k] = deserialize(vStr)
		else
			printError("state: Error: Bad line format: "..line)
		end
	end

	return appState
end

-- value       = readAppState( appState, key, fallbackValue [, validValues=any ] )
-- validValues = { {value1}, ... }
local function readAppState(appState, k, fallback, validValues)
	if type(appState[k]) == type(fallback) and not (validValues and not itemWith1(validValues, 1, appState[k])) then
		return appState[k]
	else
		return fallback
	end
end

local function saveAppStateNow()
	print("Saving app state.")
	saveAppStateQueued = false
	local buffer       = {}

	-- App.
	-- @Incomplete: Save window state.
	writeKvPair(buffer, "copyToClipboard_effects", gui:find"copyToClipboard_effects":isToggled())
	writeKvPair(buffer, "copyToClipboard_filters", gui:find"copyToClipboard_filters":isToggled())
	writeKvPair(buffer, "hasFlipped", hasFlipped)

	-- Source.
	writeKvPair(buffer, "sourceSound"          , gui:find"sourceSound":findToggled().data.value)
	writeKvPair(buffer, "sourceCustomSoundPath", gui:find"sourceCustomSoundPath":getValue())
	writeKvPair(buffer, "sourceVolume"         , theSource:getVolume())
	writeKvPair(buffer, "filterParam_active"   , gui:find"filterParam_active"  :isToggled())
	writeKvPair(buffer, "filterParam_volume"   , gui:find"filterParam_volume"  :getValue()^2)
	writeKvPair(buffer, "filterParam_type"     , gui:find"filterParam_type"    :findToggled().data.value)
	writeKvPair(buffer, "filterParam_lowgain"  , gui:find"filterParam_lowgain" :getValue()^2)
	writeKvPair(buffer, "filterParam_highgain" , gui:find"filterParam_highgain":getValue()^2)

	-- Effects.
	for _, effectInfo in ipairs(EFFECTS) do
		writeKvPair(buffer, "param_"..effectInfo.type.."_active", gui:find("param_"..effectInfo.type.."_active"):isToggled())

		for _, param in ipairs(effectInfo) do
			local paramId = "param_"..effectInfo.type.."_"..param.name

			if     param.type == "constant" then  writeKvPair(buffer, paramId, param.value)
			elseif param.type == "boolean"  then  writeKvPair(buffer, paramId, gui:find(paramId):isToggled())
			elseif param.type == "number"   then  writeKvPair(buffer, paramId, getSliderValue(gui:find(paramId), param.min,param.max, param.exp))
			elseif param.type == "enum"     then  writeKvPair(buffer, paramId, gui:find(paramId):findToggled().data.value)
			else
				error(param.type)
			end
		end

		writeKvPair(buffer, "filterParam_"..effectInfo.type.."_active"  , gui:find("filterParam_"..effectInfo.type.."_active"  ):isToggled())
		writeKvPair(buffer, "filterParam_"..effectInfo.type.."_volume"  , gui:find("filterParam_"..effectInfo.type.."_volume"  ):getValue()^2)
		writeKvPair(buffer, "filterParam_"..effectInfo.type.."_type"    , gui:find("filterParam_"..effectInfo.type.."_type"    ):findToggled().data.value)
		writeKvPair(buffer, "filterParam_"..effectInfo.type.."_lowgain" , gui:find("filterParam_"..effectInfo.type.."_lowgain" ):getValue()^2)
		writeKvPair(buffer, "filterParam_"..effectInfo.type.."_highgain", gui:find("filterParam_"..effectInfo.type.."_highgain"):getValue()^2)
	end

	love.filesystem.write("state", table.concat(buffer))
end

local function queueSaveAppState()
	saveAppStateQueued = true
	saveAppStateTime   = love.timer.getTime() + APP_STATE_SAVE_DELAY
end

local appState = loadAppState()
hasFlipped     = readAppState(appState, "hasFlipped", hasFlipped)



-- Audio.
--==============================================================

print("getMaxSceneEffects ", LA.getMaxSceneEffects())
print("getMaxSourceEffects", LA.getMaxSourceEffects())

local DEFAULT_MASTER_VOLUME = .75
LA.setVolume(DEFAULT_MASTER_VOLUME^2) -- Note: This just affects output from sources - not output from effects!

local function updateActiveEffects()
	-- print("updateActiveEffects "..time)
	-- @Speed: Don't recreate all these tables and stuff every time - just update what's needed!

	-- Effects.
	for _, effectInfo in ipairs(EFFECTS) do
		if gui:find("param_"..effectInfo.type.."_active"):isToggled() then
			local settings = {}

			for _, param in ipairs(effectInfo) do
				local paramId = "param_"..effectInfo.type.."_"..param.name

				if     param.type == "constant" then  settings[param.name] = param.value
				elseif param.type == "boolean"  then  settings[param.name] = gui:find(paramId):isToggled()
				elseif param.type == "number"   then  settings[param.name] = getSliderValue(gui:find(paramId), param.min,param.max, param.exp)
				elseif param.type == "enum"     then  settings[param.name] = gui:find(paramId):findToggled().data.value
				else
					error(param.type)
				end
			end

			local enabledOrFilterSettings = true

			if gui:find("filterParam_"..effectInfo.type.."_active"):isToggled() then
				local filterType = gui:find("filterParam_"..effectInfo.type.."_type"):findToggled().data.value
				enabledOrFilterSettings = {
					volume   = gui:find("filterParam_"..effectInfo.type.."_volume"  ):getValue()^2,
					type     = filterType,
					lowgain  = (filterType ~= "lowpass" ) and gui:find("filterParam_"..effectInfo.type.."_lowgain" ):getValue()^2 or nil,
					highgain = (filterType ~= "highpass") and gui:find("filterParam_"..effectInfo.type.."_highgain"):getValue()^2 or nil,
				}
			end

			if not LA.setEffect(effectInfo.type, settings) then
				showActionErrorMessage("Failed defining effect '%s'.", effectInfo.type)
			end
			if not theSource:setEffect(effectInfo.type, enabledOrFilterSettings) then
				showActionErrorMessage("Failed adding effect '%s'.", effectInfo.type)
			end

		else
			if not theSource:setEffect(effectInfo.type, false) and indexOf(theSource:getActiveEffects(), effectInfo.type) then
				showActionErrorMessage("Failed removing effect '%s'.", effectInfo.type)
			end
			if not LA.setEffect(effectInfo.type, false) and indexOf(LA.getActiveEffects(), effectInfo.type) then
				showActionErrorMessage("Failed undefining effect '%s'.", effectInfo.type)
			end
		end
	end

	-- Filter.
	if gui:find"filterParam_active":isToggled() then
		local filterType = gui:find"filterParam_type":findToggled().data.value
		theSource:setFilter{
			volume   = gui:find"filterParam_volume":getValue()^2,
			type     = filterType,
			lowgain  = (filterType ~= "lowpass" ) and gui:find"filterParam_lowgain" :getValue()^2 or nil,
			highgain = (filterType ~= "highpass") and gui:find"filterParam_highgain":getValue()^2 or nil,
		}
	else
		theSource:setFilter()
	end

	queueSaveAppState()
end

-- success, error = loadSound( internal, path )
local function loadSound(internal, path)
	if path == currentSoundPath then  return true  end

	print("Loading sound: "..path)
	local pathOrFileData

	if internal then
		pathOrFileData = path
	else
		local file, err = io.open(path, "rb") -- @Incomplete: UTF-8!
		if not file then
			err = err:gsub("%.?$", ".", 1)
			if love.system.getOS() == "Windows" and path:find"[\128-\255]" then
				printError("Error: "..err.." (Paths with non-ASCII characters are not supported.)")
				err = "Paths with non-ASCII characters are not supported."
			else
				printError("Error: "..err)
			end
			return false, err
		end
		pathOrFileData = love.filesystem.newFileData(file:read"*a", path)
		file:close()
		print("File size: "..formatBytes(pathOrFileData:getSize()))
	end

	local ok, source = pcall(LA.newSource, pathOrFileData, "static")
	if type(pathOrFileData) == "userdata" then
		pathOrFileData:release()
	end
	if not ok then
		printError("Error: "..source)
		return false, source
	end

	local isPlaying = false
	local vol       = 1

	if theSource then
		isPlaying = theSource:isPlaying()
		vol       = theSource:getVolume()
		theSource:stop()
		theSource:release()
	end

	theSource = source
	theSource:setVolume(vol)
	theSource:setLooping(true)

	currentSoundPath = path

	if isPlaying then  theSource:play()  end
	return true
end

if readAppState(appState, "sourceSound", "") == "" then
	loadSound(false, readAppState(appState, "sourceCustomSoundPath", ""))
else
	loadSound(true, readAppState(appState, "sourceSound", "sounds/guitar.wav"))
end
if not theSource then
	appState.sourceSound = nil
	loadSound(true, "sounds/guitar.wav")
end
theSource:setVolume(readAppState(appState, "sourceVolume", 1))



-- GUI.
--==============================================================

local canvasSideFront, canvasSideBack = nil

local function createCanvases()
	if canvasSideFront then  canvasSideFront:release()  end
	if canvasSideBack  then  canvasSideBack :release()  end

	canvasSideFront = LG.newCanvas()
	canvasSideBack  = LG.newCanvas()
end

createCanvases()

local SPACING           = 8
local LABEL_EXTRA_WIDTH = 5

local fontSmall   = LG.newFont("fonts/NotoSans-Medium.ttf"  , 10)
local fontNormal  = LG.newFont("fonts/NotoSans-Medium.ttf"  , 13)
local fontButtons = LG.newFont("fonts/NotoSans-SemiBold.ttf", 13)
local fontLarge   = LG.newFont("fonts/NotoSans-SemiBold.ttf", 16)
local fontHuge    = LG.newFont("fonts/NotoSans-SemiBold.ttf", 24)

local imageHeart         = LG.newImage("gfx/heart.png")
local imageWhale         = LG.newImage("gfx/whale.png")
local imageWhale2        = LG.newImage("gfx/whale2.png")
local imageBackConnector = LG.newImage("gfxgen/backConnector.png")
local imageBackPlug      = LG.newImage("gfxgen/backPlug.png")
local imageBackWireEnd   = LG.newImage(love.image.newImageData(4,4, "rgba8", table.concat{
	"\255\255\255\100", "\255\255\255\255", "\255\255\255\255", "\255\255\255\100",
	"\255\255\255\255", "\255\255\255\255", "\255\255\255\255", "\255\255\255\255",
	"\255\255\255\255", "\255\255\255\255", "\255\255\255\255", "\255\255\255\255",
	"\255\255\255\100", "\255\255\255\255", "\255\255\255\255", "\255\255\255\100",
}))

-- showTextPrompt( title, label, initialValue, callback )
-- callback( path|nil )
local function showTextPrompt(title, label, v, cb)
	local guiPrompt = gui:getRoot():insert{"container", background="faded", relativeWidth=1, relativeHeight=1, closable=true, captureInput=true, confineNavigation=true,
		{"vbar", background="shadowbox", width=300, padding=SPACING, anchorX=.5, anchorY=.5, originX=.5, originY=.5,
			{"text", text=title, spacing=SPACING},
			{"hbar",
				{"text", text=label, spacing=2},
				{"input", value=v, weight=1},
			},
			{"hbar", homogeneous=true,
				{"button", style="button", weight=1, id="ok"   , text="OK"    },
				{"button", style="button", weight=1, close=true, text="Cancel"},
			},
		},
	}

	local guiInput = guiPrompt:findType"input"
	guiInput:focus()
	guiInput:getField():selectAll()

	local vOnClose = nil

	guiInput:on("submit", function(guiInput, event)
		vOnClose = guiInput:getValue()
		guiPrompt:close()
	end)
	guiPrompt:find"ok":on("press", function(guiButton, event)
		vOnClose = guiInput:getValue()
		guiPrompt:close()
	end)

	guiPrompt:on("keypressed", function(guiPrompt, event, key, scancode, isRepeat)
		if key == "return" or key == "kpenter" then
			guiInput:trigger("submit")
			return true
		end
	end)
	guiPrompt:on("closed", function(guiPrompt, event)
		guiPrompt:remove()
		cb(vOnClose)
	end)
end

-- showButtonPrompt( title, buttonLabels, submitChoice, callback )
-- callback( choice|0 )
local function showButtonPrompt(title, buttonLabels, submitChoice, cb)
	local guiPrompt = gui:getRoot():insert{"container", background="faded", relativeWidth=1, relativeHeight=1, closable=true, captureInput=true, confineNavigation=true,
		{"vbar", background="shadowbox", minWidth=300, padding=SPACING, anchorX=.5, anchorY=.5, originX=.5, originY=.5,
			{"text", text=title, spacing=SPACING},
			{"hbar", id="buttons", homogeneous=true},
		},
	}

	local guiButtons = guiPrompt:find"buttons"
	local choice     = 0

	for i, buttonLabel in ipairs(buttonLabels) do
		local guiButton = guiButtons:insert{"button", style="button", weight=1, text=buttonLabel}

		guiButton:on("press", function(guiButton, event)
			choice = i
			guiPrompt:close()
		end)
	end

	guiPrompt:on("keypressed", function(guiPrompt, event, key, scancode, isRepeat)
		if key == "return" or key == "kpenter" then
			guiButtons[submitChoice]:press()
			return true
		end
	end)
	guiPrompt:on("closed", function(guiPrompt, event)
		guiPrompt:remove()
		cb(choice)
	end)
end

local function showMenuWithTitle(title, buttonLabels, cb)
	local mx,my = love.mouse.getPosition()

	local guiMenu = gui:getRoot():insert{"container", background="faded", relativeWidth=1, relativeHeight=1, closable=true, captureInput=true, confineNavigation=true,
		{"vbar", id="buttons", background="shadowbox", minWidth=150, padding=2, x=mx, y=my,
			{"text", text=title, align="left"},
		},
	}

	local guiButtons = guiMenu:find"buttons"
	local choice     = 0

	for i, buttonLabel in ipairs(buttonLabels) do
		local guiButton = guiButtons:insert{"button", style="button", text=buttonLabel, align="left"}

		guiButton:on("press", function(guiButton, event)
			choice = i
			guiMenu:close()
		end)
	end

	local x,y, w,h = guiButtons:getLayout()
	guiButtons:setPosition(
		clamp(x, 0, LG.getWidth ()-w),
		clamp(y, 0, LG.getHeight()-h)
	)

	guiMenu:on("mousepressed", function(guiButton, event, mx,my, mbutton, pressCount)
		guiMenu:close()
	end)
	guiMenu:on("closed", function(guiMenu, event)
		guiMenu:remove()
		cb(choice)
	end)
end

local function guiAddConstantParam(guiParent, labelWidth, label, v)
	local guiRow = guiParent:insert{"hbar",
		{"text", width=labelWidth, align="left", text=label..":"},
		{"text", align="left", text=tostring(v)},
	}
	return guiRow
end

local function guiAddToggleParam(guiParent, labelWidth, id, label, toggled, onToggle)
	local guiRow = guiParent:insert{"hbar",
		{"button", style="button", id=id, canToggle=true, toggled=toggled, text=label, weight=1},
	}

	guiRow:findType"button":on("toggle", function(guiButton, event)
		if onToggle then  onToggle(guiButton, event)  end
	end)

	return guiRow
end

local function guiAddSliderParam(guiParent, labelWidth, outputWidth, id, label, min,max, defaultValue,currentValue, exp, vFormat, onChange)
	local guiRow = guiParent:insert{"hbar",
		{"text", width=labelWidth, align="left", text=label..":"},
		{"slider", id=id, min=0, max=1, value=normalize(currentValue, min,max, exp), weight=1},
		{"text", style="output", width=outputWidth, text=string.format(vFormat, currentValue)},
	}

	guiRow:findType"slider":on("valuechange", function(guiSlider)
		guiRow:find"output":setText(string.format(vFormat, getSliderValue(guiSlider, min,max, exp)))
		if onChange then  onChange(guiSlider)  end
	end)

	guiRow:findType"slider":on("mousepressed", function(guiSlider, event, mx,my, mbutton, pressCount)
		if not guiSlider:isActive() then  return  end
		if mbutton ~= 2             then  return  end

		local v              = getSliderValue(guiSlider, min,max, exp)
		local clipboardValue = tonumber(love.system.getClipboardText())

		local items = {
			"Enter value...",
			"Copy ("..v..")",
			clipboardValue and "Paste ("..clipboardValue..")" or "Paste",
			"Reset ("..defaultValue..")",
		}

		local guiMenu = showMenuWithTitle(label, items, function(choice)
			if choice == 1 then
				showTextPrompt("Enter value", label..":", tostring(v), function(vStr)
					if vStr and vStr:find"%%$" then
						v = tonumber(vStr:sub(1, -2))
						if not v then  return  end
						guiSlider:setValue(v/100)
						guiSlider:trigger("valuechange")
					else
						v = tonumber(vStr)
						if not v then  return  end
						setSliderValue(guiSlider, min,max, exp, v)
						guiSlider:trigger("valuechange")
					end
				end)

			elseif choice == 2 then
				love.system.setClipboardText(tostring(v))

			elseif choice == 3 then
				if not clipboardValue then  return  end
				setSliderValue(guiSlider, min,max, exp, clipboardValue)
				guiSlider:trigger("valuechange")

			elseif choice == 4 then
				setSliderValue(guiSlider, min,max, exp, defaultValue)
				guiSlider:trigger("valuechange")
			end
		end)
	end)

	return guiRow
end

local function guiAddRadioParam(guiParent, labelWidth, id, label, maxValuesPerRow, values--[[{ {value1,label[,tooltip]}, ... }]], selectedValue, onChange)
	local guiParam = guiParent:insert{"hbar",
		{"text", width=labelWidth, align="left", text=label..":"},
		{"vbar", id=id, weight=1},
	}
	local guiRows = guiParam:findType"vbar"
	local guiRow

	for i, valueInfo in ipairs(values) do
		if i % maxValuesPerRow == 1 then
			guiRow = guiRows:insert{"hbar"}
		end

		local guiButton = guiRow:insert{"button",
			style     = "button",
			data      = {value=valueInfo[1]},
			weight    = 1,
			radio     = id,
			canToggle = true,
			toggled   = (valueInfo[1]==selectedValue),
			text      = valueInfo[2],
			tooltip   = valueInfo[3],
		}
		guiButton:on("toggleon", function(guiButton, event)
			if onChange then  onChange(guiButton, event)  end
		end)
	end

	return guiParam
end

gui = require"Gui"()
gui:setFont(fontNormal)
gui:setTheme(require"theme")

gui:defineStyle("_MENU", {background="faded",
	{background="shadowbox", padding=2},
})
gui:defineStyle("button", {font=fontButtons})
gui:defineStyle("output", {id="output", align="right", font=fontSmall})
gui:defineStyle("biglabel", {font=fontLarge})

gui:load{"root", width=LG.getWidth(), height=LG.getHeight(),
	{"vbar", relativeWidth=1, relativeHeight=1, padding=SPACING, canScrollY=true,
		{"hbar", spacing=SPACING, background="box", padding=SPACING,
			{"text", text="LÖVE Audio Effects Playground", spacing=2*SPACING, font=fontLarge},
			{"vbar", spacing=SPACING,
				{"button", style="button", id="play", text="Play sound!", tooltip="Shortcut: Space", canToggle=true, weight=1}, -- @Cleanup: Move to Source section.
				{"canvas", id="position", height=2},
			},
			{"hbar", spacing=SPACING, hidden=1==1,
				{"text", text="Master:"},
				{"slider", id="masterVolume", min=0, max=1, value=DEFAULT_MASTER_VOLUME, width=100},
			},
			{"hbar", spacing=SPACING,
				{"text", text="Export:"},
				{"button", style="button", id="copyToClipboard"        , text="To clipboard"},
				{"button", style="button", id="copyToClipboard_effects", text="Include effects", canToggle=true, toggled=readAppState(appState, "copyToClipboard_effects", true)},
				{"button", style="button", id="copyToClipboard_filters", text="Include filters", canToggle=true, toggled=readAppState(appState, "copyToClipboard_filters", true)},
			},
			{"container", weight=1},
			{"hbar", spacing=SPACING,
				{"button", style="button", id="resetAll", text="Reset all", data={danger=true}},
			},
			{"hbar", spacing=SPACING,
				{"button", style="button", id="backside", text="Backside >", data={dark=true}},
			},
		},
		{"hbar", id="columns", spacing=SPACING, homogeneous=true,
			{"vbar", spacing=SPACING, weight=1},
			{"vbar", spacing=SPACING, weight=1},
			{"vbar", spacing=SPACING, weight=1},
			{"vbar", spacing=SPACING, weight=1},
		},
	},
}

gui:find"copyToClipboard_effects":on("toggle", queueSaveAppState)
gui:find"copyToClipboard_filters":on("toggle", queueSaveAppState)

gui:find"resetAll":on("press", function(guiButton)
	showButtonPrompt("Reset all parameters and everything?", {"Reset and restart","Cancel"}, 1, function(choice)
		if choice == 1 then
			love.filesystem.remove("state")
			saveAppStateQueued = false
			love.event.quit("restart")
		end
	end)
end)

gui:find"backside":on("press", function(guiButton)
	flipped     = not flipped
	ignoreInput = true
end)

gui:find"play":on("toggle", function(guiButton)
	if guiButton:isToggled() then
		theSource:play()
	else
		theSource:stop()
	end
end)

gui:find"position":on("draw", function(guiCanvas, event, cw,ch)
	LG.clear(Color"b1e3fa")
	LG.setColor(Color"1b4d68")
	LG.rectangle("fill", 0,0, 2+(cw-2)*theSource:tell()/theSource:getDuration(),ch)
end)

gui:find"masterVolume":on("valuechange", function(guiSlider)
	LA.setVolume(guiSlider:getValue()^2)
end)

gui:find"copyToClipboard":on("press", function(guiButton)
	local buffer = {}

	--
	-- Effect definitions.
	--
	if gui:find"copyToClipboard_effects":isToggled() then
		for _, effectInfo in ipairs(EFFECTS) do
			if gui:find("param_"..effectInfo.type.."_active"):isToggled() then
				table.insert(buffer, "love.audio.setEffect(")
				table.insert(buffer, serialize("cool"..effectInfo.type))
				table.insert(buffer, ", {")

				for i, param in ipairs(effectInfo) do
					local paramId = "param_"..effectInfo.type.."_"..param.name

					if i > 1 then  table.insert(buffer, ",")  end
					table.insert(buffer, param.name)
					table.insert(buffer, "=")

					if     param.type == "constant" then  table.insert(buffer, serialize(param.value))
					elseif param.type == "boolean"  then  table.insert(buffer, serialize(gui:find(paramId):isToggled()))
					elseif param.type == "number"   then  table.insert(buffer, serialize(getSliderValue(gui:find(paramId), param.min,param.max, param.exp)))
					elseif param.type == "enum"     then  table.insert(buffer, serialize(gui:find(paramId):findToggled().data.value))
					else
						error(param.type)
					end
				end

				table.insert(buffer, "})\n")
			end
		end
	end

	--
	-- Source.
	--
	table.insert(buffer, "mySource:setVolume(")
	table.insert(buffer, serialize(theSource:getVolume()))
	table.insert(buffer, ")\n")

	-- Filter.
	if gui:find"copyToClipboard_filters":isToggled() and gui:find"filterParam_active":isToggled() then
		local filterType = gui:find"filterParam_type":findToggled().data.value

		table.insert(buffer, "mySource:setFilter{")

		table.insert(buffer, "volume=")
		table.insert(buffer, serialize(gui:find"filterParam_volume":getValue()^2))

		table.insert(buffer, ",type=")
		table.insert(buffer, serialize(filterType))

		if filterType ~= "lowpass" then
			table.insert(buffer, ",lowgain=")
			table.insert(buffer, serialize(gui:find"filterParam_lowgain" :getValue()^2))
		end

		if filterType ~= "highpass" then
			table.insert(buffer, ",highgain=")
			table.insert(buffer, serialize(gui:find"filterParam_highgain":getValue()^2))
		end

		table.insert(buffer, "}\n")
	end

	-- Effects.
	if gui:find"copyToClipboard_effects":isToggled() then
		for _, effectInfo in ipairs(EFFECTS) do
			if gui:find("param_"..effectInfo.type.."_active"):isToggled() then
				table.insert(buffer, "mySource:setEffect(")
				table.insert(buffer, serialize("cool"..effectInfo.type))

				if gui:find"copyToClipboard_filters":isToggled() and gui:find("filterParam_"..effectInfo.type.."_active"):isToggled() then
					local filterType = gui:find("filterParam_"..effectInfo.type.."_type"):findToggled().data.value
					table.insert(buffer, ", {")

					table.insert(buffer, "volume=")
					table.insert(buffer, serialize(gui:find("filterParam_"..effectInfo.type.."_volume"  ):getValue()^2))

					table.insert(buffer, ",type=")
					table.insert(buffer, serialize(filterType))

					if filterType ~= "lowpass" then
						table.insert(buffer, ",lowgain=")
						table.insert(buffer, serialize(gui:find("filterParam_"..effectInfo.type.."_lowgain" ):getValue()^2))
					end

					if filterType ~= "highpass" then
						table.insert(buffer, ",highgain=")
						table.insert(buffer, serialize(gui:find("filterParam_"..effectInfo.type.."_highgain"):getValue()^2))
					end

					table.insert(buffer, "}")
				end

				table.insert(buffer, ")\n")
			end
		end
	end

	--
	-- Done!
	--
	if not buffer[1] then
		showActionMessage("Nothing to export")
		return
	end

	local s = table.concat(buffer):gsub("\n$", "")
	print("--------------------------------")
	print(s)
	print("--------------------------------")
	love.system.setClipboardText(s)

	showActionMessage("Exported Lua to clipboard")
end)

-- Source.
do
	local labelWidth = math.max(
		fontNormal:getWidth"sound:",
		fontNormal:getWidth"custom:",
		fontNormal:getWidth"volume:",
		fontNormal:getWidth"lowgain:",
		fontNormal:getWidth"highgain:",
	0) + LABEL_EXTRA_WIDTH

	local guiSource = gui:find"columns"[1]:insert{"vbar", id="source", spacing=SPACING, background="box", padding=SPACING}

	-- Header.
	guiSource:insert{"hbar", spacing=SPACING,
		{"text", align="left", text="Source", font=fontLarge, weight=1},
		{"button", style="button", id="filterParam_active", text="Filter", canToggle=true, toggled=readAppState(appState, "filterParam_active", false)},
	}
	guiSource:find"filterParam_active":on("toggle", function(guiButton)
		guiSource:find"filterParams":setVisible(guiButton:isToggled())
		updateActiveEffects()
	end)

	-- Source parameters.
	local values = {{"sounds/fight.ogg","Fight"},{"sounds/guitar.wav","Guitar"},{"sounds/speech.ogg","Speech"},{"sounds/suspense.wav","Suspense"},{"sounds/walk.wav","Walk"},{"","Custom"}}
	local v      = readAppState(appState, "sourceSound", "sounds/guitar.wav", values)
	guiAddRadioParam(guiSource, labelWidth, "sourceSound", "sound", 3, values, v, function(guiButton)
		if guiButton.data.value == "" then
			guiSource:find"sourceCustomSoundPath":trigger("submit")
		else
			loadSound(true, guiButton.data.value)
			guiSource:find"sourceCustomSoundError":hide()
			updateActiveEffects()
		end
	end)

	guiSource:insert{"hbar",
		{"text", width=labelWidth, align="left", text="custom:"},
		{"input", id="sourceCustomSoundPath", value=readAppState(appState, "sourceCustomSoundPath", ""), placeholder="C:/path/to/sound", weight=1, tooltip="You can drag files into the window too!"},
	}
	guiSource:find"sourceCustomSoundPath":on("change", function(guiInput)
		queueSaveAppState()
	end)
	guiSource:find"sourceCustomSoundPath":on("submit", function(guiInput)
		local path = guiInput:getValue()
		if path == ""               then  return  end
		if path == currentSoundPath then  return  end -- Prevents this function from sometimes being called recursively by setToggled() below.

		local ok, err = loadSound(false, path)
		if not ok then
			local textW = guiInput:getLayoutWidth() - 4
			guiSource:find"sourceCustomSoundError":show()
			guiSource:find"sourceCustomSoundError":find"_text":setText("Error: "..err)
			guiSource:find"sourceCustomSoundError":find"_text"._textWrapLimit = textW -- @Hack: No fitting library method!
			gui:scheduleLayoutUpdate()
			return
		end

		local guiButtons = guiSource:find"sourceSound":matchAll"button"
		for i, guiButton in ipairs(guiButtons) do
			guiButton:setToggled(i == #guiButtons)
		end
		guiSource:find"sourceCustomSoundError":hide()
		updateActiveEffects()
	end)

	guiSource:insert{"hbar", id="sourceCustomSoundError", hidden=true,
		{"text", width=labelWidth},
		{"text", id="_text", wrapText=true, align="left", textColor={.9,.1,.1}},
	}

	guiAddSliderParam(guiSource, labelWidth, fontSmall:getWidth"1.00", "sourceVolume", "volume", 0,1, 1,theSource:getVolume(), 2, "%.2f", function(guiSlider)
		theSource:setVolume(guiSlider:getValue()^2)
		queueSaveAppState()
	end)

	-- Filter parameters.
	local guiFilterRows = guiSource:insert{"vbar", id="filterParams", hidden=not readAppState(appState, "filterParam_active", false),
		{"text", style="biglabel", text="Filter"},
	}

	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_volume", "volume", 0,1, 1,readAppState(appState, "filterParam_volume", 1), 2, "%.2f", function()updateActiveEffects()end)

	local values = {{"lowpass","LP","Lowpass"},{"highpass","HP","Highpass"},{"bandpass","BP","Bandpass"}}
	local v      = readAppState(appState, "filterParam_type", "lowpass", values)
	guiAddRadioParam(guiFilterRows, labelWidth, "filterParam_type", "type", 99, values, v, function(guiButton)
		guiFilterRows:find"filterParam_lowgain" :setActive(guiButton.data.value ~= "lowpass" )
		guiFilterRows:find"filterParam_highgain":setActive(guiButton.data.value ~= "highpass")
		updateActiveEffects()
	end)

	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_lowgain" , "lowgain" , 0,1, 1,readAppState(appState, "filterParam_lowgain" , 1), 2, "%.2f", function()updateActiveEffects()end):findType"slider":setActive(v ~= "lowpass" )
	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_highgain", "highgain", 0,1, 1,readAppState(appState, "filterParam_highgain", 1), 2, "%.2f", function()updateActiveEffects()end):findType"slider":setActive(v ~= "highpass")
end

-- Effects.
for _, effectInfo in ipairs(EFFECTS) do
	local labelWidth = math.max(
		fontNormal:getWidth"volume:",
		fontNormal:getWidth"lowgain:",
		fontNormal:getWidth"highgain:",
	0)
	local numberOutputWidth = fontSmall:getWidth"1.00"

	for _, param in ipairs(effectInfo) do
		if param.type == "constant" or param.type == "number" or param.type == "enum" then
			labelWidth = math.max(labelWidth, fontNormal:getWidth(param.name..":"))
		end
		if param.type == "number" then
			numberOutputWidth = math.max(
				numberOutputWidth,
				fontSmall:getWidth(string.format(param.format, param.min)),
				fontSmall:getWidth(string.format(param.format, param.max))
			)
		end
	end

	labelWidth        = labelWidth + LABEL_EXTRA_WIDTH
	numberOutputWidth = numberOutputWidth + 5

	local guiColumn = gui:find"columns"[effectInfo.column]
	local guiEffect = guiColumn:insert{"vbar", spacing=SPACING, background="box", padding=SPACING}

	-- Header.
	guiEffect:insert{"hbar", spacing=SPACING,
		{"text", align="left", text=effectInfo.title, font=fontLarge, weight=1},
		{"button", style="button", id="presets_"    ..effectInfo.type           , text="Presets"},
		{"button", style="button", id="filterParam_"..effectInfo.type.."_active", text="Filter", canToggle=true, toggled=readAppState(appState, "filterParam_"..effectInfo.type.."_active", false)},
		{"button", style="button", id="param_"      ..effectInfo.type.."_active", text="Active", canToggle=true, toggled=readAppState(appState, "param_"      ..effectInfo.type.."_active", false)},
	}

	guiEffect:find("param_"..effectInfo.type.."_active"):on("toggle", function(guiButton)
		guiEffect:find"body":setVisible(guiButton:isToggled())
		updateActiveEffects()
	end)

	guiEffect:find("filterParam_"..effectInfo.type.."_active"):on("toggle", function(guiButton)
		guiEffect:find"filterParams":setVisible(guiButton:isToggled())
		updateActiveEffects()
	end)

	guiEffect:find("presets_"..effectInfo.type):on("press", function(guiButton)
		local presets = PRESETS[effectInfo.type]
		local items   = {"Defaults"}

		for _, preset in ipairs(presets) do
			table.insert(items, preset.title)
		end

		guiButton:showMenu(items, function(choice)
			if choice == 0 then  return  end

			local preset = presets[choice-1]

			local _updateActiveEffects = updateActiveEffects
			updateActiveEffects        = function()end -- @Hack: This prevents many updates from happening during this loop. @Speed @Cleanup: updateActiveEffects() should probably just queue an update.

			for _, param in ipairs(effectInfo) do
				if param.type ~= "constant" then
					local v = preset and preset.params[param.name]
					if v == nil then  v = param.default  end

					local paramId = "param_"..effectInfo.type.."_"..param.name
					local guiEl   = gui:find(paramId)

					if     param.type == "boolean" then  guiEl:setToggled(v)
					elseif param.type == "number"  then  setSliderValue(guiEl, param.min,param.max, param.exp, v) ; guiEl:trigger("valuechange")
					elseif param.type == "enum"    then  for guiButton in guiEl:traverseType"button" do  guiButton:setToggled(guiButton.data.value == v)  end
					else
						error(param.type)
					end
				end
			end

			updateActiveEffects = _updateActiveEffects
			updateActiveEffects()
		end)
	end)

	local guiBody = guiEffect:insert{"vbar", id="body", spacing=SPACING, hidden=not readAppState(appState, "param_"..effectInfo.type.."_active", false)}

	-- Effect parameters.
	for _, param in ipairs(effectInfo) do
		local paramId = "param_"..effectInfo.type.."_"..param.name

		if     param.type == "constant" then  guiAddConstantParam(guiBody, labelWidth,                             param.name, param.value)
		elseif param.type == "boolean"  then  guiAddToggleParam  (guiBody, labelWidth,                    paramId, param.name, readAppState(appState, paramId, param.default), function()updateActiveEffects()end)
		elseif param.type == "number"   then  guiAddSliderParam  (guiBody, labelWidth, numberOutputWidth, paramId, param.name, param.min,param.max, param.default,readAppState(appState, paramId, param.default), param.exp, param.format, function()updateActiveEffects()end)
		elseif param.type == "enum"     then  guiAddRadioParam   (guiBody, labelWidth,                    paramId, param.name, 99, param.values, readAppState(appState, paramId, param.default, param.values), function()updateActiveEffects()end)
		else
			error(param.type)
		end
	end

	-- Filter parameters.
	local guiFilterRows = guiBody:insert{"vbar", id="filterParams", hidden=not readAppState(appState, "filterParam_"..effectInfo.type.."_active", false),
		{"text", style="biglabel", text="Pre-filter"},
	}

	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_"..effectInfo.type.."_volume", "volume", 0,1, 1,readAppState(appState, "filterParam_"..effectInfo.type.."_volume", 1), 2, "%.2f", function()updateActiveEffects()end)

	local values = {{"lowpass","LP","Lowpass"},{"highpass","HP","Highpass"},{"bandpass","BP","Bandpass"}}
	local v      = readAppState(appState, "filterParam_"..effectInfo.type.."_type", "lowpass", values)
	guiAddRadioParam(guiFilterRows, labelWidth, "filterParam_"..effectInfo.type.."_type", "type", 99, values, v, function(guiButton)
		guiFilterRows:find("filterParam_"..effectInfo.type.."_lowgain" ):setActive(guiButton.data.value ~= "lowpass" )
		guiFilterRows:find("filterParam_"..effectInfo.type.."_highgain"):setActive(guiButton.data.value ~= "highpass")
		updateActiveEffects()
	end)

	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_"..effectInfo.type.."_lowgain" , "lowgain" , 0,1, 1,readAppState(appState, "filterParam_"..effectInfo.type.."_lowgain" , 1), 2, "%.2f", function()updateActiveEffects()end):findType"slider":setActive(v ~= "lowpass" )
	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_"..effectInfo.type.."_highgain", "highgain", 0,1, 1,readAppState(appState, "filterParam_"..effectInfo.type.."_highgain", 1), 2, "%.2f", function()updateActiveEffects()end):findType"slider":setActive(v ~= "highpass")
end

updateActiveEffects()

if not LA.isEffectsSupported() then
	showButtonPrompt("Your system doesn't seem to support audio effects.", {"Exit"}, 1, function(choice)
		love.event.quit()
	end)
end



-- LÖVE callbacks.
--==============================================================

local whale = {
	x        = 100.0,
	y        = 0.0,
	velocity = 3.0,
	angle    = 0.0,

	velocityChangeTime = 0.00,
	angleChangeTime    = 0.00,

	targetVelocity = 3.0,
	targetAngle    = 0.0,
}

local hearts = {}

function love.keypressed(key, scancode, isRepeat)
	if ignoreInput then  return  end

	if key == "q" and love.keyboard.isDown("lctrl", "rctrl") then
		love.event.quit()

	elseif not flipped and gui:keypressed(key, scancode, isRepeat) then
		-- void

	elseif key == "escape" then
		if flipped then
			flipped = false
		else
			showButtonPrompt("Exit program?", {"Exit","Cancel"}, 1, function(choice)
				if choice == 1 then
					love.event.quit()
				end
			end)
		end

	elseif key == "space" then
		if isRepeat then  return  end
		gui:find"play":setToggled(not gui:find"play":isToggled())
	end
end
function love.keyreleased(key, scancode)
	gui:keyreleased(key, scancode)
end
function love.textinput(text)
	if ignoreInput then  return  end

	if not flipped then
		gui:textinput(text)
	end
end

local function spawnHeart()
	table.insert(hearts, {
		spawnTime      = time,
		x              = whale.x + randomf(-30, -10),
		y              = whale.y + randomf(-40, -35),
		angle          = TAU*2.75/4 + .15*TAU*randomf(-1, 1),
		wiggleInterval = randomf(4.00, 6.00),
	})
end

function love.mousepressed(mx, my, mbutton, isTouch, pressCount)
	if ignoreInput then  return  end

	if not flipped then
		gui.canScrollMeansSolid = false -- @Hack
		if
			mbutton == 1
			and not flipped
			and ((mx - whale.x) / imageWhale:getWidth()) ^ 2 + ((my - (LG.getHeight()/2 + whale.y)) / imageWhale:getHeight()) ^ 2 < .5^2
			and not gui:getElementAt(mx, my)
		then
			spawnHeart()
		end
		gui.canScrollMeansSolid = true

		gui:mousepressed(mx, my, mbutton, pressCount)
	end
end
function love.mousemoved(mx, my, dx, dy, isTouch)
	if ignoreInput then  return  end
	if not flipped then
		gui:mousemoved(mx, my, dx, dy)
	end
end
function love.mousereleased(mx, my, mbutton, isTouch, pressCount)
	if not ignoreInput and flipped and mbutton == 1 then
		flipped = false
	end
	gui:mousereleased(mx, my, mbutton, pressCount)
end
function love.wheelmoved(dx, dy)
	if ignoreInput then  return  end
	if not flipped then
		gui:wheelmoved(dx, dy)
	end
end

local autoSpawnHeartTime = randomf(20.00, 30.00)

function love.update(dt)
	-- dt = dt * 20 -- DEBUG
	time  = time + dt

	gui:update(dt)

	if saveAppStateQueued and love.timer.getTime() >= saveAppStateTime then
		saveAppStateNow()
	end

	-- Lovely stuff.
	local reached

	whale.velocity, reached = moveTowards(whale.velocity, whale.targetVelocity, .3*dt)
	if reached and time >= whale.velocityChangeTime then
		whale.targetVelocity     = randomf(3, 6)
		whale.velocityChangeTime = time + randomf(4.00, 8.00)
	end

	whale.angle, reached = moveTowards(whale.angle, whale.targetAngle, .02*TAU*dt)
	if reached and time >= whale.angleChangeTime then
		local targetY         = randomf(-.5, .5) * .7*LG.getHeight()
		whale.targetAngle     = math.atan2(targetY-whale.y, 100)
		whale.angleChangeTime = time + randomf(2.00, 8.00)
	end

	whale.x = whale.x + whale.velocity * math.cos(whale.angle) * dt
	whale.y = whale.y + whale.velocity * math.sin(whale.angle) * dt

	if whale.x > LG.getWidth() + imageWhale:getWidth()/2 + 10 then
		whale.x = -(imageWhale:getWidth()/2 + 10)
	end

	if time >= autoSpawnHeartTime then
		spawnHeart()
		autoSpawnHeartTime = time + randomf(40.00, 60.00)
	end

	-- The backside.
	local flipTime = hasFlipped and FLIP_TIME or FLIP_TIME_FIRST
	flipAmount     = clamp(flipAmount+(flipped and 1 or -1)/flipTime*dt, 0, 1)
	ignoreInput    = flipAmount > 0 and flipAmount < 1

	if not hasFlipped and flipAmount == 1 then
		hasFlipped = true
		queueSaveAppState() -- hasFlipped
	end
end

local perspectiveShader = LG.newShader("src/perspective.gl")
local mesh              = LG.newMesh(4, "fan", "stream")
local vertices          = {{0,0, 0,0, 1,1,1,1}, {0,0, 1,0, 1,1,1,1}, {0,0, 1,1, 1,1,1,1}, {0,0, 0,1, 1,1,1,1}}

local function drawPerspectiveQuad(texture, x1,y1--[[topleft]], x2,y2--[[topright]], x3,y3--[[bottomright]], x4,y4--[[bottomleft]])
	shaderSend(perspectiveShader, "heights", y4-y1, y3-y2)
	mesh:setTexture(texture)
	vertices[1][1], vertices[1][2] = x1,y1
	vertices[2][1], vertices[2][2] = x2,y2
	vertices[3][1], vertices[3][2] = x3,y3
	vertices[4][1], vertices[4][2] = x4,y4
	mesh:setVertices(vertices)
	LG.draw(mesh)
end

local function getConnectorPosition(conn)
	local groupInfo = require"back".groups[conn.group] or error(conn.group)
	return math.floor(groupInfo.ox*LG.getWidth () + groupInfo.x - groupInfo.ax*groupInfo.w + conn.x)
	     , math.floor(groupInfo.oy*LG.getHeight() + groupInfo.y - groupInfo.ay*groupInfo.h + conn.y)
end

local function checkFlags(flags)
	if not flags then  return true  end
	for _, id in ipairs(flags) do
	-- for _, id in pairs(flags) do -- What is LuaJIT doing? This seems to break randomly? Solve it for now with :AvoidPairsWhenCheckingFlags.
		if gui:find(id):isToggled() ~= flags[id] then  return false  end
	end
	return true
end

function love.draw()
	local ww, wh = LG.getDimensions()
	LG.clear(0, 0, 0, 1)

	--
	-- The front side.
	--
	if flipAmount < 1 then
		LG.setCanvas(canvasSideFront)
		LG.clear(Color"b1e3fa")

		-- Lovely stuff.
		LG.push("all")
			LG.translate(0, wh/2)

			LG.setColor(1, 1, 1)
			LG.draw(imageWhale, whale.x,whale.y, 0, 1,1, imageWhale:getWidth()/2,imageWhale:getHeight()/2)

			LG.setColor(Color"da5d86")

			for i, heart in ipairsr(hearts) do
				local dist = 10 * (time - heart.spawnTime)
				local x    = heart.x + dist*math.cos(heart.angle) + 4*math.cos(time*TAU/heart.wiggleInterval)
				local y    = heart.y + dist*math.sin(heart.angle)

				if x < -imageHeart:getWidth() or y < -imageHeart:getHeight()-wh/2 then
					table.remove(hearts, i)
				else
					LG.draw(imageHeart, x,y, 0, 1,1, imageHeart:getWidth()/2,imageHeart:getHeight()/2)
				end
			end
		LG.pop()

		-- GUI.
		gui:draw()

		LG.setCanvas(nil)
	end

	--
	-- The backside.
	--
	if flipAmount > 0 then
		LG.setCanvas(canvasSideBack)
		LG.clear(.2, .2, .2)

		-- Lovely stuff.
		LG.push("all")
			LG.translate(0, wh/2)

			LG.setColor(1, 1, 1)
			LG.draw(imageWhale2, whale.x,whale.y, 0, 1,1, imageWhale:getWidth()/2,imageWhale:getHeight()/2)
		LG.pop()

		-- Connections.
		local SEGMENTS              = 30
		local MAX_SAG               = 45
		local MAX_SWING_REL         = .05
		local MAX_SWING_ABS         = 5
		local MAX_SWING_TIME_OFFSET = .3
		local SWING_TIME            = 3.00

		LG.push("all")
			local connectors = require"back".connectors

			-- Group backgrounds, links and labels.
			LG.setFont(fontSmall)

			for group, groupInfo in pairs(require"back".groups) do
				local x1 =  1/0
				local x2 = -1/0
				local y1 =  1/0
				local y2 = -1/0

				for _, conn in ipairs(connectors) do
					if conn.group == group then
						x1 = math.min(x1, conn.x)
						x2 = math.max(x2, conn.x)
						y1 = math.min(y1, conn.y)
						y2 = math.max(y2, conn.y)
					end
				end

				groupInfo.w = x2 - x1
				groupInfo.h = y2 - y1

				x1 =  1/0
				x2 = -1/0
				y1 =  1/0
				y2 = -1/0

				for _, conn in ipairs(connectors) do
					if conn.group == group then
						local x,y = getConnectorPosition(conn)
						x1        = math.min(x1, x)
						x2        = math.max(x2, x)
						y1        = math.min(y1, y)
						y2        = math.max(y2, y)
					end
				end

				local textW = LG.getFont():getWidth(groupInfo.label)
				local textH = LG.getFont():getHeight()
				local textX = math.floor((x1 + x2 - textW) / 2)
				local textY = y1 - 19 - textH

				local boxX1 = x1    - 20
				local boxX2 = x2    + 20
				local boxY1 = textY - 4
				local boxY2 = y2    + 20

				LG.setColor(0, 0, 0, .15)  ; require"Gui".draw9SliceScaled(boxX1+1,boxY1+4, boxX2-boxX1-2,boxY2-boxY1, boxBackgroundImage,unpack(boxBackgroundQuads))
				LG.setColor(.10, .10, .10) ; require"Gui".draw9SliceScaled(boxX1  ,boxY1+2, boxX2-boxX1  ,boxY2-boxY1, boxBackgroundImage,unpack(boxBackgroundQuads))
				LG.setColor(.40, .40, .40) ; require"Gui".draw9SliceScaled(boxX1  ,boxY1-2, boxX2-boxX1  ,boxY2-boxY1, boxBackgroundImage,unpack(boxBackgroundQuads))
				LG.setColor(.25, .25, .25) ; require"Gui".draw9SliceScaled(boxX1  ,boxY1  , boxX2-boxX1  ,boxY2-boxY1, boxBackgroundImage,unpack(boxBackgroundQuads))

				for _, link in ipairs(require"back".links) do
					if connectors[link.from].group == group then
						local x1,y1 = getConnectorPosition(connectors[link.from])
						local x2,y2 = getConnectorPosition(connectors[link.to  ])

						if x1 == x2 then
							LG.setLineWidth(3)
						else
							LG.setLineWidth(2)
							LG.setColor(.3, .3, .3) ; LG.line(link.x+x1,link.y+y1+1, link.x+x2,link.y+y2+1)
						end
						LG.setColor(.2, .2, .2) ; LG.line(link.x+x1,link.y+y1, link.x+x2,link.y+y2)
					end
				end

				LG.setColor(.15, .15, .15) ; require"Gui".draw9SliceScaled(textX-10,textY, textW+2*10,textH, boxBackgroundImage,unpack(boxBackgroundQuads))
				if groupInfo.faded then
					LG.setColor(.7, .7, .7 ) ; LG.print(groupInfo.label, textX,textY)
				else
					LG.setColor(1, 1, 1    ) ; LG.print(groupInfo.label, textX,textY)
					LG.setColor(1, 1, 1, .3) ; LG.print(groupInfo.label, textX,textY)
				end
			end

			-- Connectors.
			for _, conn in ipairs(connectors) do
				local x,y = getConnectorPosition(conn)

				if conn.out then  LG.setColor(1, 1, 1  )
				else              LG.setColor(.9, .7, 1)  end

				drawImage(imageBackConnector, .5,.5, x,y)
			end

			-- Plugs.
			local relevantWires = {}

			for _, wire in ipairs(require"back".wires) do
				if checkFlags(wire.flags) then
					local conn1 = connectors[wire.from] or error(wire.from)
					local conn2 = connectors[wire.to  ] or error(wire.to  )
					local x1,y1 = getConnectorPosition(conn1)
					local x2,y2 = getConnectorPosition(conn2)

					table.insert(relevantWires, wire)

					LG.setColor(1, 1, 1  ) ; drawImage(imageBackPlug, .5,.5, x1,y1)
					LG.setColor(.9, .7, 1) ; drawImage(imageBackPlug, .5,.5, x2,y2)
				end
			end

			-- Wires.
			LG.setColor(0, 0, 0)
			LG.setLineWidth(4)

			for _, wire in ipairs(relevantWires) do
				local conn1 = connectors[wire.from] or error(wire.from)
				local conn2 = connectors[wire.to  ] or error(wire.to  )
				local x1,y1 = getConnectorPosition(conn1)
				local x2,y2 = getConnectorPosition(conn2)

				-- Put wire 1 high.
				if y1 > y2 then
					x1, x2 = x2, x1
					y1, y2 = y2, y1
				end

				local line     = {}
				local maxSwing = math.min(math.abs(x2-x1)*MAX_SWING_REL, MAX_SWING_ABS)
				local time01   = love.timer.getTime() / SWING_TIME + MAX_SWING_TIME_OFFSET * love.math.noise((x1+x2)*1753.72, (y1+y2)*367.813)
				local swing    = maxSwing * math.sin(time01*TAU)/2

				for seg = 0, SEGMENTS do
					local t   = seg/SEGMENTS
					t         = t^1.5 -- More segments lower where the wire bends the most.
					-- t      = (expKeepSign(t*2-1, 2) + 1) / 2 -- More segments in the middle where the wire bends the most.
					local sag = math.sin(t*TAU/2)

					table.insert(line, lerp(x1, x2, t)+swing*sag)
					table.insert(line, lerp(y1, y2, math.sin(t*TAU/4))+MAX_SAG*sag)

					-- line[#line-1] = line[#line-1] + 3*(math.random()*2-1) -- DEBUG
				end

				LG.line(line)
				drawImage(imageBackWireEnd, .5,.5, x1,y1)
				drawImage(imageBackWireEnd, .5,.5, x2,y2)
			end
		LG.pop()

		LG.setCanvas(nil)
	end

	--
	-- Composition.
	--
	local flipAmount   = lerp(1-math.cos(flipAmount*TAU/4), math.sin(flipAmount*TAU/4), flipAmount)
	local cubeRotation = flipAmount * TAU/4

	local x1   = ww/2 + ww/2 * math.cos( 3/8*TAU+cubeRotation) / math.sin(TAU/8)
	local x2   = ww/2 + ww/2 * math.cos( 1/8*TAU+cubeRotation) / math.sin(TAU/8)
	local x3   = ww/2 + ww/2 * math.cos(-1/8*TAU+cubeRotation) / math.sin(TAU/8)
	local x1y1 = -.2*wh * (math.sin( 3/8*TAU+cubeRotation) - math.sin(TAU/8))
	local x2y1 = -.2*wh * (math.sin( 1/8*TAU+cubeRotation) - math.sin(TAU/8))
	local x3y1 = -.2*wh * (math.sin(-1/8*TAU+cubeRotation) - math.sin(TAU/8))
	local x1y2 = wh - x1y1
	local x2y2 = wh - x2y1
	local x3y2 = wh - x3y1

	-- LG.translate(ww/2, wh/2) ; LG.scale(.5, .5) ; LG.translate(-ww/2, -wh/2) -- DEBUG
	LG.setShader(perspectiveShader)
	if flipAmount < 1 then  local gray = lerp(.2, 1, math.cos(flipAmount*TAU/4)) ; LG.setColor(gray, gray, gray) ; drawPerspectiveQuad(canvasSideFront, x1,x1y1, x2,x2y1, x2,x2y2, x1,x1y2)  end
	if flipAmount > 0 then  local gray = lerp(.2, 1, math.sin(flipAmount*TAU/4)) ; LG.setColor(gray, gray, gray) ; drawPerspectiveQuad(canvasSideBack , x2,x2y1, x3,x3y1, x3,x3y2, x2,x2y2)  end
	LG.setShader(nil)

	-- Action message.
	local DURATION  = 2.00
	local FADE_TIME = 1.50
	local a         = math.min(1-(love.timer.getTime()-actionMessageTime-(DURATION-FADE_TIME))/FADE_TIME, 1)

	if a > 0 then
		local w = fontHuge:getWidth(actionMessage)
		local h = fontHuge:getHeight()
		local x = math.floor((ww-w)/2)
		local y = math.floor((wh-h)/2)
		LG.setFont(fontHuge)
		LG.setColor(1, 1, 1, a^1.5)
		LG.rectangle("fill", x-4,y-4, w+2*4,h+2*4)
		LG.setColor(0, 0, 0, a^1.5)
		LG.print(actionMessage, x,y)
	end

	-- LG.setColor(0, 0, 0) ; LG.print(whale.angle.."\n"..whale.velocity) -- DEBUG
end

function love.resize(ww, wh)
	gui:getRoot():setDimensions(ww, wh)
	createCanvases()
end

function love.filedropped(file)
	local guiInput = gui:find"source":find"sourceCustomSoundPath"
	guiInput:setValue(file:getFilename())
	guiInput:trigger("submit")
end

function love.quit()
	if saveAppStateQueued then
		saveAppStateNow()
	end
	return false
end


