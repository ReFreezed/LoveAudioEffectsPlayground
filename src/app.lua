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

if not DEV then
	love.window.maximize()
end

io.stdout:setvbuf("no")
io.stderr:setvbuf("no")

_G.TAU = 2*math.pi
_G.LG  = love.graphics

require"functions"

love.keyboard.setKeyRepeat(true)

local theSource = nil
local gui

--
-- Audio.
--
local EFFECTS = {
	{type="chorus", column=1, title="Chorus",
		{name="type"            , type="constant",                        value="chorus"},
		{name="volume"          , type="number"  , min=0     , max=1    , default=1    , exp=2, format="%.2f"},
		{name="waveform"        , type="enum"    ,                        default="triangle", values={{"sine","sine"},{"triangle","triangle"}}},
		{name="phase"           , type="number"  , min=-180  , max=180  , default=90   , exp=1, format="%.0fdeg"},
		{name="rate"            , type="number"  , min=0     , max=10   , default=1.1  , exp=2, format="%.1fHz"},
		{name="depth"           , type="number"  , min=0     , max=1    , default=0.1  , exp=2, format="%.2f"},
		{name="feedback"        , type="number"  , min=-1    , max=1    , default=0.25 , exp=2, format="%.2f"},
		{name="delay"           , type="number"  , min=0.0005, max=0.016, default=0.016, exp=2, format="%.3fsec"}, -- Min is documented to be 0 but isn't actually.
	},
	{type="flanger", column=1, title="Flanger",
		{name="type"            , type="constant",                        value="flanger"},
		{name="volume"          , type="number"  , min=0     , max=1    , default=1    , exp=2, format="%.2f"},
		{name="waveform"        , type="enum"    ,                        default="triangle", values={{"sine","sine"},{"triangle","triangle"}}},
		{name="phase"           , type="number"  , min=-180  , max=180  , default=0    , exp=1, format="%.0fdeg"},
		{name="rate"            , type="number"  , min=0     , max=10   , default=0.27 , exp=2, format="%.2fHz"},
		{name="depth"           , type="number"  , min=0     , max=1    , default=1    , exp=2, format="%.2f"},
		{name="feedback"        , type="number"  , min=-1    , max=1    , default=-.5  , exp=2, format="%.2f"},
		{name="delay"           , type="number"  , min=0.0004, max=0.004, default=0.002, exp=2, format="%.4fsec"}, -- Min is documented to be 0 but isn't actually.
	},
	{type="equalizer", column=2, title="Equalizer",
		{name="type"            , type="constant",                        value="equalizer"},
		{name="volume"          , type="number"  , min=0     , max=1    , default=1    , exp=2, format="%.2f"},
		{name="lowgain"         , type="number"  , min=0.126 , max=7.943, default=1    , exp=2, format="%.3f"},
		{name="lowcut"          , type="number"  , min=50    , max=800  , default=200  , exp=2, format="%.0fHz"},
		{name="lowmidgain"      , type="number"  , min=0.126 , max=7.943, default=1    , exp=2, format="%.3f"},
		{name="lowmidfrequency" , type="number"  , min=200   , max=3000 , default=500  , exp=2, format="%.0fHz"},
		{name="lowmidbandwidth" , type="number"  , min=0.01  , max=1    , default=1    , exp=2, format="%.2f"},
		{name="highmidgain"     , type="number"  , min=0.126 , max=7.943, default=1    , exp=2, format="%.3f"},
		{name="highmidfrequency", type="number"  , min=1000  , max=8000 , default=3000 , exp=2, format="%.0fHz"},
		{name="highmidbandwidth", type="number"  , min=0.01  , max=1    , default=1    , exp=2, format="%.2f"},
		{name="highgain"        , type="number"  , min=0.126 , max=7.943, default=1    , exp=2, format="%.3f"},
		{name="highcut"         , type="number"  , min=4000  , max=16000, default=6000 , exp=2, format="%.0fHz"},
	},
	{type="compressor", column=2, title="Compressor",
		{name="type"            , type="constant",                        value="compressor"},
		{name="volume"          , type="number"  , min=0     , max=1    , default=1    , exp=2, format="%.2f"},
		{name="enable"          , type="boolean" ,                        default=true },
	},
	{type="reverb", column=3, title="Reverb",
		{name="type"            , type="constant",                        value="reverb"},
		{name="volume"          , type="number"  , min=0     , max=1    , default=1    , exp=2, format="%.2f"},
		{name="density"         , type="number"  , min=0     , max=1    , default=1    , exp=2, format="%.2f"},
		{name="diffusion"       , type="number"  , min=0     , max=1    , default=1    , exp=2, format="%.2f"},
		{name="gain"            , type="number"  , min=0     , max=1    , default=0.32 , exp=2, format="%.2f"},
		{name="highgain"        , type="number"  , min=0     , max=1    , default=0.89 , exp=2, format="%.2f"},
		{name="decaytime"       , type="number"  , min=0.1   , max=20   , default=1.49 , exp=2, format="%.1fsec"},
		{name="decayhighratio"  , type="number"  , min=0.1   , max=2    , default=0.83 , exp=1, format="%.2f"},
		{name="earlygain"       , type="number"  , min=0     , max=3.16 , default=0.05 , exp=2, format="%.2f"},
		{name="earlydelay"      , type="number"  , min=0     , max=0.3  , default=0.05 , exp=2, format="%.2fsec"},
		{name="lategain"        , type="number"  , min=0     , max=10   , default=1.26 , exp=2, format="%.2f"},
		{name="latedelay"       , type="number"  , min=0     , max=0.1  , default=0.011, exp=2, format="%.3fsec"},
		{name="airabsorption"   , type="number"  , min=0.892 , max=1    , default=0.994, exp=1, format="%.3f"},
		{name="roomrolloff"     , type="number"  , min=0     , max=10   , default=0    , exp=1, format="%.1f"},
		{name="highlimit"       , type="boolean" ,                        default=true },
	},
	{type="echo", column=3, title="Echo",
		{name="type"            , type="constant",                        value="echo"},
		{name="volume"          , type="number"  , min=0     , max=1    , default=1    , exp=2, format="%.2f"},
		{name="delay"           , type="number"  , min=0     , max=0.207, default=0.1  , exp=2, format="%.3fsec"},
		{name="tapdelay"        , type="number"  , min=0     , max=0.404, default=0.1  , exp=2, format="%.3fsec"},
		{name="damping"         , type="number"  , min=0     , max=0.99 , default=0.5  , exp=1, format="%.2f"},
		{name="feedback"        , type="number"  , min=0     , max=1    , default=0.5  , exp=2, format="%.2f"},
		{name="spread"          , type="number"  , min=-1    , max=1    , default=-1   , exp=2, format="%.2f"},
	},
	{type="ringmodulator", column=4, title="Ring modulator",
		{name="type"            , type="constant",                        value="ringmodulator"},
		{name="volume"          , type="number"  , min=0     , max=1    , default=1    , exp=2, format="%.2f"},
		{name="frequency"       , type="number"  , min=0     , max=8000 , default=440  , exp=2, format="%.0fHz"},
		{name="highcut"         , type="number"  , min=0     , max=24000, default=800  , exp=2, format="%.0fHz"},
		{name="waveform"        , type="enum"    ,                        default="sine", values={{"sine","sine"},{"sawtooth","sawtooth"},{"square","square"}}},
	},
	{type="distortion", column=4, title="Distortion",
		{name="type"            , type="constant",                        value="distortion"},
		{name="volume"          , type="number"  , min=0     , max=1    , default=1    , exp=2, format="%.2f"},
		{name="edge"            , type="number"  , min=0     , max=1    , default=0.2  , exp=2, format="%.2f"},
		{name="gain"            , type="number"  , min=0.01  , max=1    , default=0.2  , exp=2, format="%.2f"},
		{name="lowcut"          , type="number"  , min=80    , max=24000, default=8000 , exp=2, format="%.0fHz"},
		{name="center"          , type="number"  , min=80    , max=24000, default=3600 , exp=2, format="%.0fHz"},
		{name="bandwidth"       , type="number"  , min=80    , max=24000, default=3600 , exp=2, format="%.0fHz"},
	},
}

local PRESETS = require"presets"

print("getMaxSceneEffects ", love.audio.getMaxSceneEffects()) -- @Robustness: Make sure the system supports (enough) effects.
print("getMaxSourceEffects", love.audio.getMaxSourceEffects())

local DEFAULT_MASTER_VOLUME = .75
love.audio.setVolume(DEFAULT_MASTER_VOLUME^2) -- Note: This just affects output from sources - not output from effects!

local function getSliderValue(guiSlider, min,max, exp)
	return denormalize(guiSlider:getValue(), min,max, exp)
end
local function setSliderValue(guiSlider, min,max, exp, v)
	guiSlider:setValue(normalize(v, min,max, exp))
end

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
					lowgain  = (filterType == "bandpass" or filterType == "highpass") and gui:find("filterParam_"..effectInfo.type.."_lowgain" ):getValue()^2 or nil,
					highgain = (filterType == "bandpass" or filterType == "lowpass" ) and gui:find("filterParam_"..effectInfo.type.."_highgain"):getValue()^2 or nil,
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
			lowgain  = (filterType == "bandpass" or filterType == "highpass") and gui:find"filterParam_lowgain" :getValue()^2 or nil,
			highgain = (filterType == "bandpass" or filterType == "lowpass" ) and gui:find"filterParam_highgain":getValue()^2 or nil,
		}
	else
		theSource:setFilter()
	end
end

local currentSoundPath = ""

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
		io.stderr:write("Error: "..source, "\n")
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

loadSound(true, "sounds/guitar.wav")

--
-- GUI.
--
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

	if onToggle then
		guiRow:findType"button":on("toggle", onToggle)
	end

	return guiRow
end

local function guiAddSliderParam(guiParent, labelWidth, outputWidth, id, label, min,max, defaultValue, exp, vFormat, onChange)
	local guiRow = guiParent:insert{"hbar",
		{"text", width=labelWidth, align="left", text=label..":"},
		{"slider", id=id, min=0, max=1, value=normalize(defaultValue, min,max, exp), weight=1},
		{"text", style="output", width=outputWidth, text=string.format(vFormat, defaultValue)},
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

local function guiAddRadioParam(guiParent, labelWidth, id, label, values--[[{ {value1,label[,tooltip]}, ... }]], v, onChange)
	local guiRow = guiParent:insert{"hbar",
		{"text", width=labelWidth, align="left", text=label..":"},
		{"hbar", id=id, weight=1},
	}

	for _, valueInfo in ipairs(values) do
		local guiButton = guiRow:findType"hbar":insert{"button", style="button", data={value=valueInfo[1]}, weight=1, radio=id, canToggle=true, toggled=(valueInfo[1]==v), text=valueInfo[2], tooltip=valueInfo[3]}
		if onChange then  guiButton:on("toggleon", onChange)  end
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
				{"button", style="button", id="copyToClipboard_effects", text="Include effects", canToggle=true, toggled=true},
				{"button", style="button", id="copyToClipboard_filters", text="Include filters", canToggle=true, toggled=true},
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

	-- Effects and filters.
	if gui:find"copyToClipboard_effects":isToggled() then
		for _, effectInfo in ipairs(EFFECTS) do
			if gui:find("param_"..effectInfo.type.."_active"):isToggled() then
				table.insert(buffer, "love.audio.setEffect(")
				table.insert(buffer, toLua("cool"..effectInfo.type))
				table.insert(buffer, ", {")

				for i, param in ipairs(effectInfo) do
					local paramId = "param_"..effectInfo.type.."_"..param.name

					if i > 1 then  table.insert(buffer, ",")  end
					table.insert(buffer, param.name)
					table.insert(buffer, "=")

					if     param.type == "constant" then  table.insert(buffer, toLua(param.value))
					elseif param.type == "boolean"  then  table.insert(buffer, toLua(gui:find(paramId):isToggled()))
					elseif param.type == "number"   then  table.insert(buffer, toLua(getSliderValue(gui:find(paramId), param.min,param.max, param.exp)))
					elseif param.type == "enum"     then  table.insert(buffer, toLua(gui:find(paramId):findToggled().data.value))
					else
						error(param.type)
					end
				end

				table.insert(buffer, "})\n")
			end
		end

		for _, effectInfo in ipairs(EFFECTS) do
			if gui:find("param_"..effectInfo.type.."_active"):isToggled() then
				table.insert(buffer, "mySource:setEffect(")
				table.insert(buffer, toLua("cool"..effectInfo.type))

				if gui:find"copyToClipboard_filters":isToggled() and gui:find("filterParam_"..effectInfo.type.."_active"):isToggled() then
					local filterType = gui:find("filterParam_"..effectInfo.type.."_type"):findToggled().data.value
					table.insert(buffer, ", {")

					table.insert(buffer, "volume=")
					table.insert(buffer, toLua(gui:find("filterParam_"..effectInfo.type.."_volume"  ):getValue()^2))

					table.insert(buffer, ",type=")
					table.insert(buffer, toLua(filterType))

					if filterType == "bandpass" or filterType == "highpass" then
						table.insert(buffer, ",lowgain=")
						table.insert(buffer, toLua(gui:find("filterParam_"..effectInfo.type.."_lowgain" ):getValue()^2))
					end

					if filterType == "bandpass" or filterType == "lowpass"  then
						table.insert(buffer, ",highgain=")
						table.insert(buffer, toLua(gui:find("filterParam_"..effectInfo.type.."_highgain"):getValue()^2))
					end

					table.insert(buffer, "}")
				end

				table.insert(buffer, ")\n")
			end
		end
	end

	-- Filter.
	if gui:find"copyToClipboard_filters":isToggled() and gui:find"filterParam_active":isToggled() then
		local filterType = gui:find"filterParam_type":findToggled().data.value

		table.insert(buffer, "mySource:setFilter{")

		table.insert(buffer, "volume=")
		table.insert(buffer, toLua(gui:find"filterParam_volume":getValue()^2))

		table.insert(buffer, ",type=")
		table.insert(buffer, toLua(filterType))

		if filterType == "bandpass" or filterType == "highpass" then
			table.insert(buffer, ",lowgain=")
			table.insert(buffer, toLua(gui:find"filterParam_lowgain" :getValue()^2))
		end

		if filterType == "bandpass" or filterType == "lowpass"  then
			table.insert(buffer, ",highgain=")
			table.insert(buffer, toLua(gui:find"filterParam_highgain":getValue()^2))
		end

		table.insert(buffer, "}\n")
	end

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
		{"button", style="button", id="filterParam_active", canToggle=true, text="Filter"},
	}
	guiSource:find"filterParam_active":on("toggle", function(guiButton)
		guiSource:find"filterParams":setVisible(guiButton:isToggled())
		updateActiveEffects()
	end)

	-- Source parameters.
	guiAddRadioParam(guiSource, labelWidth, "sourceSound", "sound", {{"sounds/fight.ogg","Fight"},{"sounds/guitar.wav","Guitar"},{"sounds/speech.ogg","Speech"},{"","Custom"}}, "sounds/guitar.wav", function(guiButton)
		if guiButton.data.value == "" then
			guiSource:find"customSoundPath":trigger("submit")
		else
			loadSound(true, guiButton.data.value)
			guiSource:find"customSoundError":hide()
			updateActiveEffects()
		end
	end)

	guiSource:insert{"hbar",
		{"text", width=labelWidth, align="left", text="custom:"},
		{"input", id="customSoundPath", placeholder="C:/path/to/sound", weight=1, tooltip="You can drag files into the window too!"},
	}
	guiSource:find"customSoundPath":on("submit", function(guiInput)
		local path = guiInput:getValue()
		if path == "" then  return  end

		local ok, err = loadSound(false, path)
		if not ok then
			local textW = guiInput:getLayoutWidth() - 4
			guiSource:find"customSoundError":show()
			guiSource:find"customSoundError":find"_text":setText("Error: "..err)
			guiSource:find"customSoundError":find"_text"._textWrapLimit = textW -- @Hack: No fitting library method!
			gui:scheduleLayoutUpdate()
			return
		end

		guiSource:find"sourceSound":setToggledChild(#guiSource:find"sourceSound")
		guiSource:find"customSoundError":hide()
		updateActiveEffects()
	end)

	guiSource:insert{"hbar", id="customSoundError", hidden=true,
		{"text", width=labelWidth},
		{"text", id="_text", wrapText=true, align="left", textColor={.9,.1,.1}},
	}

	guiAddSliderParam(guiSource, labelWidth, fontSmall:getWidth"1.00", "sourceVolume", "volume", 0,1, 1, 2, "%.2f", function(guiSlider)
		theSource:setVolume(guiSlider:getValue()^2)
	end)

	-- Filter parameters.
	local guiFilterRows = guiSource:insert{"vbar", id="filterParams", hidden=true,
		{"text", style="biglabel", text="Filter"},
	}

	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_volume", "volume", 0,1, 1, 2, "%.2f", updateActiveEffects)

	guiAddRadioParam(guiFilterRows, labelWidth, "filterParam_type", "type", {{"lowpass","LP","Lowpass"},{"highpass","HP","Highpass"},{"bandpass","BP","Bandpass"}}, "lowpass", function(guiButton)
		guiFilterRows:find"filterParam_lowgain" :setActive(guiButton.data.value == "bandpass" or guiButton.data.value == "highpass")
		guiFilterRows:find"filterParam_highgain":setActive(guiButton.data.value == "bandpass" or guiButton.data.value == "lowpass" )
		updateActiveEffects()
	end)

	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_lowgain" , "lowgain" , 0,1, 1, 2, "%.2f", updateActiveEffects):findType"slider":setActive(false)
	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_highgain", "highgain", 0,1, 1, 2, "%.2f", updateActiveEffects)
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
		{"button", style="button", id="filterParam_"..effectInfo.type.."_active", text="Filter", canToggle=true},
		{"button", style="button", id="param_"      ..effectInfo.type.."_active", text="Active", canToggle=true},
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

	local guiBody = guiEffect:insert{"vbar", id="body", spacing=SPACING, hidden=true}

	-- Effect parameters.
	for _, param in ipairs(effectInfo) do
		local paramId = "param_"..effectInfo.type.."_"..param.name

		if     param.type == "constant" then  guiAddConstantParam(guiBody, labelWidth, param.name, param.value)
		elseif param.type == "boolean"  then  guiAddToggleParam(guiBody, labelWidth, paramId, param.name, param.default, updateActiveEffects)
		elseif param.type == "number"   then  guiAddSliderParam(guiBody, labelWidth, numberOutputWidth, paramId, param.name, param.min,param.max, param.default, param.exp, param.format, updateActiveEffects)
		elseif param.type == "enum"     then  guiAddRadioParam(guiBody, labelWidth, paramId, param.name, param.values, param.default, updateActiveEffects)
		else
			error(param.type)
		end
	end

	-- Filter parameters.
	local guiFilterRows = guiBody:insert{"vbar", id="filterParams", hidden=true,
		{"text", style="biglabel", text="Filter"},
	}

	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_"..effectInfo.type.."_volume", "volume", 0,1, 1, 2, "%.2f", updateActiveEffects)

	guiAddRadioParam(guiFilterRows, labelWidth, "filterParam_"..effectInfo.type.."_type", "type", {{"lowpass","LP","Lowpass"},{"highpass","HP","Highpass"},{"bandpass","BP","Bandpass"}}, "lowpass", function(guiButton)
		guiFilterRows:find("filterParam_"..effectInfo.type.."_lowgain" ):setActive(guiButton.data.value == "bandpass" or guiButton.data.value == "highpass")
		guiFilterRows:find("filterParam_"..effectInfo.type.."_highgain"):setActive(guiButton.data.value == "bandpass" or guiButton.data.value == "lowpass" )
		updateActiveEffects()
	end)

	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_"..effectInfo.type.."_lowgain" , "lowgain" , 0,1, 1, 2, "%.2f", updateActiveEffects):findType"slider":setActive(false)
	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_"..effectInfo.type.."_highgain", "highgain", 0,1, 1, 2, "%.2f", updateActiveEffects)
end

--
-- LÖVE callbacks.
--
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
	local guiInput = gui:find"source":find"customSoundPath"
	guiInput:setValue(file:getFilename())
	guiInput:trigger("submit")
end
