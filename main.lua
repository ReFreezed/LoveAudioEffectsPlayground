--[[============================================================
--=
--=  LÖVE Audio Effects Playground
--=  by Marcus 'ReFreezed' Thunström
--=
--=  Made for LÖVE 11.4
--=
--============================================================]]

io.stdout:setvbuf("no")
io.stderr:setvbuf("no")

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

print("getMaxSceneEffects ", love.audio.getMaxSceneEffects())
print("getMaxSourceEffects", love.audio.getMaxSourceEffects())

local DEFAULT_MASTER_VOLUME = .75
love.audio.setVolume(DEFAULT_MASTER_VOLUME^2) -- Note: This just affects output from sources - not output from effects!

local function expKeepSign(v, exp)
	return (v < 0) and -(-v)^exp or v^exp
end

local function normalize(v, min,max, exp)
	v   = expKeepSign(v  , 1/exp)
	min = expKeepSign(min, 1/exp)
	max = expKeepSign(max, 1/exp)
	return (v-min) / (max-min)
end
local function denormalize(v01, min,max, exp)
	min = expKeepSign(min, 1/exp)
	max = expKeepSign(max, 1/exp)
	return expKeepSign(min+v01*(max-min), exp)
end

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
					highgain = (filterType == "bandpass" or filterType == "lowpass" ) and gui:find("filterParam_"..effectInfo.type.."_highgain"):getValue()^2 or nil,
					lowgain  = (filterType == "bandpass" or filterType == "highpass") and gui:find("filterParam_"..effectInfo.type.."_lowgain" ):getValue()^2 or nil,
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
	if gui:find("filterParam_active"):isToggled() then
		local filterType = gui:find("filterParam_type"):findToggled().data.value
		theSource:setFilter{
			volume   = gui:find("filterParam_volume"):getValue()^2,
			type     = filterType,
			highgain = (filterType == "bandpass" or filterType == "lowpass" ) and gui:find("filterParam_highgain"):getValue()^2 or nil,
			lowgain  = (filterType == "bandpass" or filterType == "highpass") and gui:find("filterParam_lowgain" ):getValue()^2 or nil,
		}
	else
		theSource:setFilter()
	end
end

local function loadSound(path)
	local isPlaying = false
	local vol       = 1

	if theSource then
		isPlaying = theSource:isPlaying()
		vol       = theSource:getVolume()
		theSource:stop()
		theSource:release()
	end

	theSource = love.audio.newSource(path, "static")
	theSource:setVolume(vol)
	theSource:setLooping(true)

	if isPlaying then  theSource:play()  end
end

loadSound("sounds/guitar.wav")

--
-- GUI.
--
local fontSmall  = love.graphics.newFont(10)
local fontNormal = love.graphics.newFont(12)
local fontLarge  = love.graphics.newFont(16)

local SPACING           = 8
local LABEL_EXTRA_WIDTH = 5

local function guiAddConstantParam(guiParent, labelWidth, label, v)
	local guiRow = guiParent:insert{"hbar",
		{"text", width=labelWidth, align="left", text=label..":"},
		{"text", align="left", text=tostring(v)},
	}
	return guiRow
end

local function guiAddToggleParam(guiParent, labelWidth, id, label, toggled, onToggle)
	local guiRow = guiParent:insert{"hbar",
		{"button", id=id, canToggle=true, toggled=toggled, text=label, weight=1},
	}

	if onToggle then
		guiRow:findType"button":on("toggle", onToggle)
	end

	return guiRow
end

local function guiAddSliderParam(guiParent, labelWidth, outputWidth, id, label, min,max, v, exp, vFormat, onChange)
	local guiRow = guiParent:insert{"hbar",
		{"text", width=labelWidth, align="left", text=label..":"},
		{"slider", id=id, min=0, max=1, value=normalize(v, min,max, exp), weight=1},
		{"text", style="output", width=outputWidth, text=string.format(vFormat, v)},
	}

	guiRow:findType"slider":on("valuechange", function(guiSlider)
		guiRow:find"output":setText(string.format(vFormat, getSliderValue(guiSlider, min,max, exp)))
		if onChange then  onChange(guiSlider)  end
	end)

	guiRow:findType"slider":on("mousepressed", function(guiSlider, event, mx,my, mbutton, pressCount)
		if mbutton ~= 2 then  return  end

		local clipboardN = tonumber(love.system.getClipboardText())
		local items = {
			":: "..label.." ::",
			"Copy ("..getSliderValue(guiSlider, min,max, exp)..")",
			clipboardN and "Paste ("..clipboardN..")" or "Paste",
			"Reset ("..v..")",
		}

		guiSlider:showMenu(items, mx+2,my+2, function(choice)
			if choice == 2 then
				love.system.setClipboardText(tostring(getSliderValue(guiSlider, min,max, exp)))

			elseif choice == 3 then
				if not clipboardN then  return  end
				setSliderValue(guiSlider, min,max, exp, clipboardN)
				guiSlider:trigger("valuechange")

			elseif choice == 4 then
				setSliderValue(guiSlider, min,max, exp, v)
				guiSlider:trigger("valuechange")
			end
		end)
	end)

	return guiRow
end

local function guiAddRadioParam(guiParent, labelWidth, id, label, values--[[{ {value1,label[,tooltip]}, ... }]], v, onChange)
	local guiRow = guiParent:insert{"hbar",
		{"text", width=labelWidth, align="left", text=label..":"},
		{"hbar", id=id, weight=1},
	}

	for _, valueInfo in ipairs(values) do
		local guiButton = guiRow:findType"hbar":insert{"button", data={value=valueInfo[1]}, weight=1, radio=id, canToggle=true, toggled=(valueInfo[1]==v), text=valueInfo[2], tooltip=valueInfo[3]}
		if onChange then  guiButton:on("toggleon", onChange)  end
	end

	return guiRow
end

gui = require"Gui"()
gui:setFont(fontNormal)

gui:defineStyle("_MENU", {
	{background="whatever"},
})
gui:defineStyle("output", {id="output", align="right", font=fontSmall})
gui:defineStyle("biglabel", {font=fontLarge})

gui:load{"root", width=love.graphics.getWidth(), height=love.graphics.getHeight(),
	{"vbar", relativeWidth=1, relativeHeight=1, padding=SPACING, canScrollY=true,
		{"hbar", spacing=SPACING, background="whatever", padding=SPACING,
			{"text", text="LÖVE Audio Effects Playground", spacing=2*SPACING, font=fontLarge},
			{"vbar", spacing=SPACING,
				{"button", id="play", text="Play", tooltip="Shortcut: Space", canToggle=true, weight=1}, -- @Cleanup: Move to Source section.
				{"canvas", id="position", height=2},
			},
			{"hbar", spacing=SPACING, hidden=1==1,
				{"text", text="Master:"},
				{"slider", id="masterVolume", min=0, max=1, value=DEFAULT_MASTER_VOLUME, width=100},
			},
			{"hbar", spacing=SPACING,
				{"text", text="Clipboard:"},
				{"button", id="copyEffects", text="Effects", canToggle=true, toggled=true},
				{"button", id="copyFilters", text="Filters", canToggle=true, toggled=true},
				{"button", id="copyToClipboard", text="Export!"},
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

gui:find"play":on("toggle", function(guiSlider)
	if theSource:isPlaying() then
		theSource:stop()
	else
		theSource:play()
	end
end)

gui:find"position":on("draw", function(guiCanvas, event, cw,ch)
	love.graphics.clear(0, 0, 0, 1)
	love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle("fill", 0,0, 1+(cw-1)*theSource:tell()/theSource:getDuration(),ch)
end)

gui:find"masterVolume":on("valuechange", function(guiSlider)
	love.audio.setVolume(guiSlider:getValue()^2)
end)

gui:find"copyToClipboard":on("press", function(guiButton)
	-- @Incomplete
end)

-- Source.
do
	local labelWidth = math.max(
		fontNormal:getWidth"sound:",
		fontNormal:getWidth"volume:",
		fontNormal:getWidth"volume:",
		fontNormal:getWidth"highgain:",
		fontNormal:getWidth"lowgain:"
	) + LABEL_EXTRA_WIDTH

	local guiSource = gui:find"columns"[1]:insert{"vbar", spacing=SPACING, background="whatever", padding=SPACING}

	-- Header.
	guiSource:insert{"hbar", spacing=SPACING,
		{"text", align="left", text="Source", font=fontLarge, weight=1},
		{"button", id="filterParam_active", canToggle=true, text="Filter"},
	}
	guiSource:find("filterParam_active"):on("toggle", function(guiButton)
		guiSource:find"filterParams":setVisible(guiButton:isToggled())
		updateActiveEffects()
	end)

	-- Source parameters.
	guiAddRadioParam(guiSource, labelWidth, "sourceSound", "sound", {{"sounds/fight.ogg","Fight"},{"sounds/guitar.wav","Guitar"},{"sounds/speech.ogg","Speech"}}, "sounds/guitar.wav", function(guiButton)
		loadSound(guiButton.data.value)
		updateActiveEffects()
	end)

	guiAddSliderParam(guiSource, labelWidth, fontSmall:getWidth"1.00", "sourceVolume", "volume", 0,1, 1, 2, "%.2f", function(guiSlider)
		theSource:setVolume(guiSlider:getValue()^2)
	end)

	-- Filter parameters.
	local guiFilterRows = guiSource:insert{"vbar", id="filterParams", hidden=true,
		{"text", style="biglabel", text="Filter"},
	}

	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_volume", "volume", 0,1, 1, 2, "%.2f", updateActiveEffects)

	guiAddRadioParam(guiFilterRows, labelWidth, "filterParam_type", "type", {{"lowpass","LP","Lowpass"},{"highpass","HP","Highpass"},{"bandpass","BP","Bandpass"}}, "lowpass", function(guiButton)
		guiFilterRows:find("filterParam_highgain"):setActive(guiButton.data.value == "bandpass" or guiButton.data.value == "lowpass" )
		guiFilterRows:find("filterParam_lowgain" ):setActive(guiButton.data.value == "bandpass" or guiButton.data.value == "highpass")
		updateActiveEffects()
	end)

	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_highgain", "highgain", 0,1, 1, 2, "%.2f", updateActiveEffects)
	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_lowgain" , "lowgain" , 0,1, 1, 2, "%.2f", updateActiveEffects):findType"slider":setActive(false)
end

-- Effects.
for _, effectInfo in ipairs(EFFECTS) do
	local labelWidth = math.max(
		fontNormal:getWidth"volume:",
		fontNormal:getWidth"highgain:",
		fontNormal:getWidth"lowgain:"
	)
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
	local guiEffect = guiColumn:insert{"vbar", spacing=SPACING, background="whatever", padding=SPACING}

	-- Header.
	guiEffect:insert{"hbar", spacing=SPACING,
		{"text", align="left", text=effectInfo.title, font=fontLarge, weight=1},
		{"button", id="filterParam_"..effectInfo.type.."_active", canToggle=true, text="Filter"},
		{"button", id="param_"..effectInfo.type.."_active", canToggle=true, text="Active"},
	}

	guiEffect:find("param_"..effectInfo.type.."_active"):on("toggle", function(guiButton)
		guiEffect:find"body":setVisible(guiButton:isToggled())
		updateActiveEffects()
	end)

	guiEffect:find("filterParam_"..effectInfo.type.."_active"):on("toggle", function(guiButton)
		guiEffect:find"filterParams":setVisible(guiButton:isToggled())
		updateActiveEffects()
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
		guiFilterRows:find("filterParam_"..effectInfo.type.."_highgain"):setActive(guiButton.data.value == "bandpass" or guiButton.data.value == "lowpass" )
		guiFilterRows:find("filterParam_"..effectInfo.type.."_lowgain" ):setActive(guiButton.data.value == "bandpass" or guiButton.data.value == "highpass")
		updateActiveEffects()
	end)

	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_"..effectInfo.type.."_highgain", "highgain", 0,1, 1, 2, "%.2f", updateActiveEffects)
	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_"..effectInfo.type.."_lowgain" , "lowgain" , 0,1, 1, 2, "%.2f", updateActiveEffects):findType"slider":setActive(false)
end

--
-- LÖVE callbacks.
--
function love.keypressed(key, scancode, isRepeat)
	if gui:keypressed(key, scancode, isRepeat) then
		-- void

	elseif key == "escape" then
		love.event.quit()

	elseif key == "space" then
		gui:find"play":setToggled(not gui:find"play":isToggled())
	end
end
function love.keyreleased(key, scancode)
	gui:keyreleased(key, scancode)
end
function love.textinput(text)
	gui:textinput(text)
end

function love.mousepressed(mx, my, mbutton, isTouch, pressCount)
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

function love.update(dt)
	gui:update(dt)
end
function love.draw()
	gui:draw()
end

function love.resize(ww, wh)
	gui:getRoot():setDimensions(ww, wh)
end
