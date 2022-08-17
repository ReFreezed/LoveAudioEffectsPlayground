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
if not DEV then
	love.window.maximize()
end

io.stdout:setvbuf("no")
io.stderr:setvbuf("no")

love.keyboard.setKeyRepeat(true)

-- Constants.
_G.TAU                  = 2*math.pi
_G.APP_STATE_SAVE_DELAY = 5.00

-- Modules.
_G.LG         = love.graphics
local EFFECTS = require"effects"
local PRESETS = require"presets"

require"functions"

-- Variables.
local theSource          = nil
local currentSoundPath   = ""
local saveAppStateQueued = false
local saveAppStateTime   = 0.00
local gui



-- Misc.
--==============================================================



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
			io.stderr:write("state: Error: Bad line format: ", line, "\n")
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
	print("Saving app state.") -- DEBUG
	saveAppStateQueued = false
	local buffer       = {}

	-- App.
	-- @Incomplete: Save window state.
	writeKvPair(buffer, "copyToClipboard_effects", gui:find"copyToClipboard_effects":isToggled())
	writeKvPair(buffer, "copyToClipboard_filters", gui:find"copyToClipboard_filters":isToggled())

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



-- Audio.
--==============================================================

print("getMaxSceneEffects ", love.audio.getMaxSceneEffects()) -- @Robustness: Make sure the system supports (enough) effects.
print("getMaxSourceEffects", love.audio.getMaxSourceEffects())

local DEFAULT_MASTER_VOLUME = .75
love.audio.setVolume(DEFAULT_MASTER_VOLUME^2) -- Note: This just affects output from sources - not output from effects!

local function updateActiveEffects()
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

			love.audio.setEffect(effectInfo.type, settings)
			theSource:setEffect(effectInfo.type, enabledOrFilterSettings)

		else
			theSource:setEffect(effectInfo.type, false)
			love.audio.setEffect(effectInfo.type, false)
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
			io.stderr:write("Error: ", err)
			if love.system.getOS() == "Windows" and path:find"[\128-\255]" then
				err = "Paths with non-ASCII characters are not supported."
				io.stderr:write(" (", err, ")")
			end
			io.stderr:write("\n")
			return false, err
		end
		pathOrFileData = love.filesystem.newFileData(file:read"*a", path)
		file:close()
		print("File size: "..formatBytes(pathOrFileData:getSize()))
	end

	local ok, source = pcall(love.audio.newSource, pathOrFileData, "static")
	if type(pathOrFileData) == "userdata" then
		pathOrFileData:release()
	end
	if not ok then
		io.stderr:write("Error: ", source, "\n")
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

local SPACING           = 8
local LABEL_EXTRA_WIDTH = 5

local fontSmall   = LG.newFont("fonts/NotoSans-Medium.ttf"  , 10)
local fontNormal  = LG.newFont("fonts/NotoSans-Medium.ttf"  , 13)
local fontButtons = LG.newFont("fonts/NotoSans-SemiBold.ttf", 13)
local fontLarge   = LG.newFont("fonts/NotoSans-SemiBold.ttf", 16)
local fontHuge    = LG.newFont("fonts/NotoSans-SemiBold.ttf", 28)

local imageHeart = LG.newImage("gfx/heart.png")
local imageWhale = LG.newImage("gfx/whale.png")

local actionMessage     = ""
local actionMessageTime = -1/0

local function showActionMessage(s)
	actionMessage     = s
	actionMessageTime = love.timer.getTime()
end

-- showTextPrompt( title, label, initialValue, callback )
-- callback( path|nil )
local function showTextPrompt(title, label, v, cb)
	local guiPrompt = gui:getRoot():insert{"container", background="faded", relativeWidth=1, relativeHeight=1, closable=true, captureGuiInput=true, confineNavigation=true,
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
	local vOnClose = nil

	guiPrompt:on("closed", function(guiPrompt, event)
		guiPrompt:remove()
		cb(vOnClose)
	end)

	guiInput:on("submit", function(guiInput, event)
		vOnClose = guiInput:getValue()
		guiPrompt:close()
	end)
	guiPrompt:find"ok":on("press", function(guiButton, event)
		vOnClose = guiInput:getValue()
		guiPrompt:close()
	end)

	guiInput:focus()
	guiInput:getField():selectAll()
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

		local guiMenu = guiSlider:showMenu(items, mx,my, function(choice)
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

		guiMenu[1]:insert({"container", padding=2,
			{"text", text=label, align="left"},
		}, 1)
	end)

	return guiRow
end

local function guiAddRadioParam(guiParent, labelWidth, id, label, values--[[{ {value1,label[,tooltip]}, ... }]], selectedValue, onChange)
	local guiRow = guiParent:insert{"hbar",
		{"text", width=labelWidth, align="left", text=label..":"},
		{"hbar", id=id, weight=1},
	}

	for _, valueInfo in ipairs(values) do
		local guiButton = guiRow:findType"hbar":insert{"button", style="button", data={value=valueInfo[1]}, weight=1, radio=id, canToggle=true, toggled=(valueInfo[1]==selectedValue), text=valueInfo[2], tooltip=valueInfo[3]}
		guiButton:on("toggleon", function(guiButton, event)
			if onChange then  onChange(guiButton)  end
		end)
	end

	return guiRow
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
	love.audio.setVolume(guiSlider:getValue()^2)
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
	local values = {{"sounds/fight.ogg","Fight"},{"sounds/guitar.wav","Guitar"},{"sounds/speech.ogg","Speech"},{"","Custom"}}
	local v      = readAppState(appState, "sourceSound", "sounds/guitar.wav", values)
	guiAddRadioParam(guiSource, labelWidth, "sourceSound", "sound", values, v, function(guiButton)
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
		if path == "" then  return  end

		local ok, err = loadSound(false, path)
		if not ok then
			local textW = guiInput:getLayoutWidth() - 4
			guiSource:find"sourceCustomSoundError":show()
			guiSource:find"sourceCustomSoundError":find"_text":setText("Error: "..err)
			guiSource:find"sourceCustomSoundError":find"_text"._textWrapLimit = textW -- @Hack: No fitting library method!
			gui:scheduleLayoutUpdate()
			return
		end

		guiSource:find"sourceSound":setToggledChild(#guiSource:find"sourceSound")
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

	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_volume", "volume", 0,1, 1,readAppState(appState, "filterParam_volume", 1), 2, "%.2f", updateActiveEffects)

	local values = {{"lowpass","LP","Lowpass"},{"highpass","HP","Highpass"},{"bandpass","BP","Bandpass"}}
	local v      = readAppState(appState, "filterParam_type", "lowpass", values)
	guiAddRadioParam(guiFilterRows, labelWidth, "filterParam_type", "type", values, v, function(guiButton)
		guiFilterRows:find"filterParam_lowgain" :setActive(guiButton.data.value ~= "lowpass" )
		guiFilterRows:find"filterParam_highgain":setActive(guiButton.data.value ~= "highpass")
		updateActiveEffects()
	end)

	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_lowgain" , "lowgain" , 0,1, 1,readAppState(appState, "filterParam_lowgain" , 1), 2, "%.2f", updateActiveEffects):findType"slider":setActive(v ~= "lowpass" )
	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_highgain", "highgain", 0,1, 1,readAppState(appState, "filterParam_highgain", 1), 2, "%.2f", updateActiveEffects):findType"slider":setActive(v ~= "highpass")
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

			for _, param in ipairs(effectInfo) do
				if param.type ~= "constant" then
					local v = preset and preset.params[param.name]
					if v == nil then  v = param.default  end

					local paramId = "param_"..effectInfo.type.."_"..param.name
					local guiEl   = gui:find(paramId)

					if     param.type == "boolean" then  guiEl:setToggled(v)
					elseif param.type == "number"  then  setSliderValue(guiEl, param.min,param.max, param.exp, v) ; guiEl:trigger("valuechange")
					elseif param.type == "enum"    then  guiEl:setToggledChild(guiEl:getChildWithData("value", v):getIndex())
					else
						error(param.type)
					end
				end
			end
		end)
	end)

	local guiBody = guiEffect:insert{"vbar", id="body", spacing=SPACING, hidden=not readAppState(appState, "param_"..effectInfo.type.."_active", false)}

	-- Effect parameters.
	for _, param in ipairs(effectInfo) do
		local paramId = "param_"..effectInfo.type.."_"..param.name

		if     param.type == "constant" then  guiAddConstantParam(guiBody, labelWidth,                             param.name, param.value)
		elseif param.type == "boolean"  then  guiAddToggleParam  (guiBody, labelWidth,                    paramId, param.name, readAppState(appState, paramId, param.default), updateActiveEffects)
		elseif param.type == "number"   then  guiAddSliderParam  (guiBody, labelWidth, numberOutputWidth, paramId, param.name, param.min,param.max, param.default,readAppState(appState, paramId, param.default), param.exp, param.format, updateActiveEffects)
		elseif param.type == "enum"     then  guiAddRadioParam   (guiBody, labelWidth,                    paramId, param.name, param.values, readAppState(appState, paramId, param.default, param.values), updateActiveEffects)
		else
			error(param.type)
		end
	end

	-- Filter parameters.
	local guiFilterRows = guiBody:insert{"vbar", id="filterParams", hidden=not readAppState(appState, "filterParam_"..effectInfo.type.."_active", false),
		{"text", style="biglabel", text="Filter"},
	}

	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_"..effectInfo.type.."_volume", "volume", 0,1, 1,readAppState(appState, "filterParam_"..effectInfo.type.."_volume", 1), 2, "%.2f", updateActiveEffects)

	local values = {{"lowpass","LP","Lowpass"},{"highpass","HP","Highpass"},{"bandpass","BP","Bandpass"}}
	local v      = readAppState(appState, "filterParam_"..effectInfo.type.."_type", "lowpass", values)
	guiAddRadioParam(guiFilterRows, labelWidth, "filterParam_"..effectInfo.type.."_type", "type", values, v, function(guiButton)
		guiFilterRows:find("filterParam_"..effectInfo.type.."_lowgain" ):setActive(guiButton.data.value ~= "lowpass" )
		guiFilterRows:find("filterParam_"..effectInfo.type.."_highgain"):setActive(guiButton.data.value ~= "highpass")
		updateActiveEffects()
	end)

	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_"..effectInfo.type.."_lowgain" , "lowgain" , 0,1, 1,readAppState(appState, "filterParam_"..effectInfo.type.."_lowgain" , 1), 2, "%.2f", updateActiveEffects):findType"slider":setActive(v ~= "lowpass" )
	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_"..effectInfo.type.."_highgain", "highgain", 0,1, 1,readAppState(appState, "filterParam_"..effectInfo.type.."_highgain", 1), 2, "%.2f", updateActiveEffects):findType"slider":setActive(v ~= "highpass")
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

local time = 0.00

function love.keypressed(key, scancode, isRepeat)
	if gui:keypressed(key, scancode, isRepeat) then
		-- void

	elseif key == "escape" then
		love.event.quit()

	elseif key == "space" then
		if isRepeat then  return  end
		gui:find"play":setToggled(not gui:find"play":isToggled())
	end
end
function love.keyreleased(key, scancode)
	gui:keyreleased(key, scancode)
end
function love.textinput(text)
	gui:textinput(text)
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
	gui.canScrollMeansSolid = false -- @Hack
	if
		mbutton == 1
		and ((mx - whale.x) / imageWhale:getWidth()) ^ 2 + ((my - (LG.getHeight()/2 + whale.y)) / imageWhale:getHeight()) ^ 2 < .5^2
		and not gui:getElementAt(mx, my)
	then
		spawnHeart()
	end
	gui.canScrollMeansSolid = true

	gui:mousepressed(mx, my, mbutton, pressCount)
end
function love.mousemoved(mx, my, dx, dy, isTouch)
	gui:mousemoved(mx, my, dx, dy)
end
function love.mousereleased(mx, my, mbutton, isTouch, pressCount)
	gui:mousereleased(mx, my, mbutton, pressCount)
end
function love.wheelmoved(dx, dy)
	gui:wheelmoved(dx, dy)
end

local autoSpawnHeartTime = randomf(20.00, 30.00)

function love.update(dt)
	-- dt = dt * 20 -- DEBUG
	time  = time + dt

	gui:update(dt)

	if saveAppStateQueued and love.timer.getTime() >= saveAppStateTime then
		saveAppStateNow()
	end

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
end

function love.draw()
	LG.clear(Color"b1e3fa")

	-- Lovely stuff.
	LG.push("all")
		LG.translate(0, LG.getHeight()/2)

		LG.setColor(1, 1, 1)
		LG.draw(imageWhale, whale.x,whale.y, 0, 1,1, imageWhale:getWidth()/2,imageWhale:getHeight()/2)

		LG.setColor(Color"da5d86")

		for i, heart in ipairsr(hearts) do
			local dist = 10 * (time - heart.spawnTime)
			local x    = heart.x + dist*math.cos(heart.angle) + 4*math.cos(time*TAU/heart.wiggleInterval)
			local y    = heart.y + dist*math.sin(heart.angle)

			if x < -imageHeart:getWidth() or y < -imageHeart:getHeight()-LG.getHeight()/2 then
				table.remove(hearts, i)
			else
				LG.draw(imageHeart, x,y, 0, 1,1, imageHeart:getWidth()/2,imageHeart:getHeight()/2)
			end
		end
	LG.pop()

	-- GUI.
	gui:draw()

	-- Action message.
	local DURATION  = 2.00
	local FADE_TIME = 1.50
	local a         = math.min(1-(love.timer.getTime()-actionMessageTime-(DURATION-FADE_TIME))/FADE_TIME, 1)

	if a > 0 then
		local w = fontHuge:getWidth(actionMessage)
		local h = fontHuge:getHeight()
		local x = math.floor((LG.getWidth ()-w)/2)
		local y = math.floor((LG.getHeight()-h)/2)
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


