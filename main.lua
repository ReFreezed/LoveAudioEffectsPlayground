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

local gui
local source

--
-- Audio.
--
local EFFECTS = {
	{type="chorus", column=1, title="Chorus",
		{name="type"            , type="constant",                       value="chorus"},
		{name="volume"          , type="number"  , min=0    , max=1    , default=1    , format="%.2f"},
		{name="waveform"        , type="enum"    ,                       default="triangle", values={"sine","triangle"}},
		{name="phase"           , type="number"  , min=-180 , max=180  , default=90   , format="%.0fdeg"},
		{name="rate"            , type="number"  , min=0    , max=10   , default=1.1  , format="%.1fHz"},
		{name="depth"           , type="number"  , min=0    , max=1    , default=0.1  , format="%.2f"},
		{name="feedback"        , type="number"  , min=-1   , max=1    , default=0.25 , format="%.2f"},
		{name="delay"           , type="number"  , min=0    , max=0.016, default=0.016, format="%.3fsec"},
	},
	{type="flanger", column=1, title="Flanger",
		{name="type"            , type="constant",                       value="flanger"},
		{name="volume"          , type="number"  , min=0    , max=1    , default=1    , format="%.2f"},
		{name="waveform"        , type="enum"    ,                       default="triangle", values={"sine","triangle"}},
		{name="phase"           , type="number"  , min=-180 , max=180  , default=0    , format="%.0fdeg"},
		{name="rate"            , type="number"  , min=0    , max=10   , default=0.27 , format="%.2fHz"},
		{name="depth"           , type="number"  , min=0    , max=1    , default=1    , format="%.2f"},
		{name="feedback"        , type="number"  , min=-1   , max=1    , default=-.5  , format="%.2f"},
		{name="delay"           , type="number"  , min=0    , max=0.004, default=0.002, format="%.4fsec"},
	},
	{type="equalizer", column=2, title="Equalizer",
		{name="type"            , type="constant",                       value="equalizer"},
		{name="volume"          , type="number"  , min=0    , max=1    , default=1    , format="%.2f"},
		{name="lowgain"         , type="number"  , min=0.126, max=7.943, default=1    , format="%.3f"},
		{name="lowcut"          , type="number"  , min=50   , max=800  , default=200  , format="%.0fHz"},
		{name="lowmidgain"      , type="number"  , min=0.126, max=7.943, default=1    , format="%.3f"},
		{name="lowmidfrequency" , type="number"  , min=200  , max=3000 , default=500  , format="%.0fHz"},
		{name="lowmidbandwidth" , type="number"  , min=0.01 , max=1    , default=1    , format="%.2f"},
		{name="highmidgain"     , type="number"  , min=0.126, max=7.943, default=1    , format="%.3f"},
		{name="highmidfrequency", type="number"  , min=1000 , max=8000 , default=3000 , format="%.0fHz"},
		{name="highmidbandwidth", type="number"  , min=0.01 , max=1    , default=1    , format="%.2f"},
		{name="highgain"        , type="number"  , min=0.126, max=7.943, default=1    , format="%.3f"},
		{name="highcut"         , type="number"  , min=4000 , max=16000, default=6000 , format="%.0fHz"},
	},
	{type="compressor", column=2, title="Compressor",
		{name="type"            , type="constant",                       value="compressor"},
		{name="volume"          , type="number"  , min=0    , max=1    , default=1    , format="%.2f"},
		{name="enable"          , type="boolean" ,                       default=true },
	},
	{type="reverb", column=3, title="Reverb",
		{name="type"            , type="constant",                       value="reverb"},
		{name="volume"          , type="number"  , min=0    , max=1    , default=1    , format="%.2f"},
		{name="density"         , type="number"  , min=0    , max=1    , default=1    , format="%.2f"},
		{name="diffusion"       , type="number"  , min=0    , max=1    , default=1    , format="%.2f"},
		{name="gain"            , type="number"  , min=0    , max=1    , default=0.32 , format="%.2f"},
		{name="highgain"        , type="number"  , min=0    , max=1    , default=0.89 , format="%.2f"},
		{name="decaytime"       , type="number"  , min=0.1  , max=20   , default=1.49 , format="%.1fsec"},
		{name="decayhighratio"  , type="number"  , min=0.1  , max=2    , default=0.83 , format="%.2f"},
		{name="earlygain"       , type="number"  , min=0    , max=3.16 , default=0.05 , format="%.2f"},
		{name="earlydelay"      , type="number"  , min=0    , max=0.3  , default=0.05 , format="%.2fsec"},
		{name="lategain"        , type="number"  , min=0    , max=10   , default=1.26 , format="%.2f"},
		{name="latedelay"       , type="number"  , min=0    , max=0.1  , default=0.011, format="%.3fsec"},
		{name="airabsorption"   , type="number"  , min=0.892, max=1    , default=0.994, format="%.3f"},
		{name="roomrolloff"     , type="number"  , min=0    , max=10   , default=0    , format="%.1f"},
		{name="highlimit"       , type="boolean" ,                       default=true },
	},
	{type="echo", column=3, title="Echo",
		{name="type"            , type="constant",                       value="echo"},
		{name="volume"          , type="number"  , min=0    , max=1    , default=1    , format="%.2f"},
		{name="delay"           , type="number"  , min=0    , max=0.207, default=0.1  , format="%.3fsec"},
		{name="tapdelay"        , type="number"  , min=0    , max=0.404, default=0.1  , format="%.3fsec"},
		{name="damping"         , type="number"  , min=0    , max=0.99 , default=0.5  , format="%.2f"},
		{name="feedback"        , type="number"  , min=0    , max=1    , default=0.5  , format="%.2f"},
		{name="spread"          , type="number"  , min=-1   , max=1    , default=-1   , format="%.2f"},
	},
	{type="ringmodulator", column=4, title="Ring modulator",
		{name="type"            , type="constant",                       value="ringmodulator"},
		{name="volume"          , type="number"  , min=0    , max=1    , default=1    , format="%.2f"},
		{name="frequency"       , type="number"  , min=0    , max=8000 , default=440  , format="%.0fHz"},
		{name="highcut"         , type="number"  , min=0    , max=24000, default=800  , format="%.0fHz"},
		{name="waveform"        , type="enum"    ,                       default="sine", values={"sine","sawtooth","square"}},
	},
	{type="distortion", column=4, title="Distortion",
		{name="type"            , type="constant",                       value="distortion"},
		{name="volume"          , type="number"  , min=0    , max=1    , default=1    , format="%.2f"},
		{name="edge"            , type="number"  , min=0    , max=1    , default=0.2  , format="%.2f"},
		{name="gain"            , type="number"  , min=0.01 , max=1    , default=0.2  , format="%.2f"},
		{name="lowcut"          , type="number"  , min=80   , max=24000, default=8000 , format="%.0fHz"},
		{name="center"          , type="number"  , min=80   , max=24000, default=3600 , format="%.0fHz"},
		{name="bandwidth"       , type="number"  , min=80   , max=24000, default=3600 , format="%.0fHz"},
	},
}

print("getMaxSceneEffects ", love.audio.getMaxSceneEffects())
print("getMaxSourceEffects", love.audio.getMaxSourceEffects())

local DEFAULT_MASTER_VOLUME = .75
love.audio.setVolume(DEFAULT_MASTER_VOLUME^2)

local function updateActiveEffects()
	-- Effects.
	for _, effectInfo in ipairs(EFFECTS) do
		if gui:find("param_"..effectInfo.type.."_active"):isToggled() then
			local settings = {}

			for _, param in ipairs(effectInfo) do
				local paramId = "param_"..effectInfo.type.."_"..param.name

				if param.type == "constant" then
					settings[param.name] = param.value

				elseif param.type == "boolean" then
					settings[param.name] = gui:find(paramId):isToggled()

				elseif param.type == "number" then
					settings[param.name] = gui:find(paramId):getValue()

				elseif param.type == "enum" then
					settings[param.name] = gui:find(paramId):findToggled().data.value

				else
					error(param.type)
				end
			end

			local enabledOrFilterSettings = true

			if gui:find("filterParam_"..effectInfo.type.."_active"):isToggled() then
				local filterType = gui:find("filterParam_"..effectInfo.type.."_type"):findToggled().data.value
				enabledOrFilterSettings = {
					type     = filterType,
					volume   = gui:find("filterParam_"..effectInfo.type.."_volume"  ):getValue(),
					highgain = (filterType == "bandpass" or filterType == "lowpass" ) and gui:find("filterParam_"..effectInfo.type.."_highgain"):getValue() or nil,
					lowgain  = (filterType == "bandpass" or filterType == "highpass") and gui:find("filterParam_"..effectInfo.type.."_lowgain" ):getValue() or nil,
				}
			end

			love.audio.setEffect(effectInfo.type, settings)
			source:setEffect(effectInfo.type, enabledOrFilterSettings)

		else
			source:setEffect(effectInfo.type, false)
			love.audio.setEffect(effectInfo.type, false)
		end
	end

	-- Filter.
	if gui:find("filterParam_active"):isToggled() then
		local filterType = gui:find("filterParam_type"):findToggled().data.value
		source:setFilter{
			type     = filterType,
			volume   = gui:find("filterParam_volume"  ):getValue(),
			highgain = (filterType == "bandpass" or filterType == "lowpass" ) and gui:find("filterParam_highgain"):getValue() or nil,
			lowgain  = (filterType == "bandpass" or filterType == "highpass") and gui:find("filterParam_lowgain" ):getValue() or nil,
		}
	else
		source:setFilter()
	end
end

local function loadSound(path)
	local isPlaying = false
	local vol       = 1

	if source then
		isPlaying = source:isPlaying()
		vol       = source:getVolume()
		source:stop()
	end

	source = love.audio.newSource(path, "static")
	source:setVolume(vol)
	source:setLooping(true)

	if isPlaying then  source:play()  end
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
	if onToggle then  guiRow:findType"button":on("toggle", onToggle)  end
	return guiRow
end
local function guiAddSliderParam(guiParent, labelWidth, outputWidth, id, label, min,max, v, vFormat, onChange)
	local guiRow = guiParent:insert{"hbar",
		{"text", width=labelWidth, align="left", text=label..":"},
		{"slider", id=id, min=min, max=max, value=v, weight=1},
		{"text", style="output", width=outputWidth, text=string.format(vFormat, v)},
	}
	guiRow:findType"slider":on("valuechange", function(guiSlider)
		guiRow:find"output":setText(string.format(vFormat, guiSlider:getValue()))
		if onChange then  onChange(guiSlider)  end
	end)
	guiRow:findType"slider":on("mousepressed", function(guiSlider, event, mx,my, mbutton, pressCount)
		if mbutton ~= 2 then  return  end
		guiSlider:showMenu({
			":: "..label.." ::",
			"Copy ("..guiSlider:getValue()..")",
			-- "Paste", -- @Incomplete
			"Reset ("..v..")",
		}, mx+2,my+2, function(choice)
			if choice == 2 then
				love.system.setClipboardText(tostring(guiSlider:getValue()))
			elseif choice == 3 then
				guiSlider:setValue(v)
				guiSlider:trigger("valuechange")
			end
		end)
	end)
	return guiRow
end
local function guiAddRadioParam(guiParent, labelWidth, id, label, values, currentValue, onChange)
	local guiRow = guiParent:insert{"hbar",
		{"text", width=labelWidth, align="left", text=label..":"},
		{"hbar", id=id, weight=1},
	}
	for _, v in ipairs(values) do
		local guiButton = guiRow:findType"hbar":insert{"button", data={value=v}, weight=1, radio=id, canToggle=true, toggled=(v==currentValue), text=tostring(v)}
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

gui:load{"root", width=love.graphics.getWidth(), height=love.graphics.getHeight(),
	{"vbar", relativeWidth=1, relativeHeight=1, padding=SPACING, canScrollY=true,
		{"hbar", spacing=SPACING, background="whatever", padding=SPACING,
			{"text", text="LÖVE Audio Effects Playground", spacing=2*SPACING, font=fontLarge},
			{"vbar", spacing=SPACING,
				{"button", id="play", text="Play", tooltip="Shortcut: Space", canToggle=true, weight=1},
				{"canvas", id="position", height=2},
			},
			{"hbar", spacing=SPACING,
				{"text", text="Master:"},
				{"slider", id="masterVolume", min=0, max=1, value=DEFAULT_MASTER_VOLUME, width=100},
			},
			{"hbar", spacing=SPACING,
				{"text", text="Clipboard:"},
				{"button", id="copyEffects", text="Effects", canToggle=true, toggled=true},
				{"button", id="copyFilters", text="Filters", canToggle=true, toggled=true},
				{"button", id="copyToClipboard", text="Copy!"},
			},
		},
		{"hbar", spacing=SPACING,
			{"vbar", id="column1", spacing=SPACING, weight=1},
			{"vbar", id="column2", spacing=SPACING, weight=1},
			{"vbar", id="column3", spacing=SPACING, weight=1},
			{"vbar", id="column4", spacing=SPACING, weight=1},
		},
	},
}

gui:find"play":on("toggle", function(guiSlider)
	if source:isPlaying() then
		source:stop()
	else
		source:play()
	end
end)

gui:find"position":on("draw", function(guiCanvas, event, cw,ch)
	love.graphics.clear(0, 0, 0, 1)
	love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle("fill", 0,0, 1+(cw-1)*source:tell()/source:getDuration(),ch)
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
		fontNormal:getWidth"f_volume:",
		fontNormal:getWidth"f_highgain:",
		fontNormal:getWidth"f_lowgain:"
	)

	local guiSource = gui:find"column1":insert{"vbar", spacing=SPACING, background="whatever", padding=SPACING}

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
	guiAddRadioParam(guiSource, labelWidth, "sourceSound", "sound", {"Fight","Guitar","Speech"}, "Guitar", function(guiButton)
		if guiButton.data.value == "Fight"  then  loadSound("sounds/fight.ogg" )  end
		if guiButton.data.value == "Guitar" then  loadSound("sounds/guitar.wav")  end
		if guiButton.data.value == "Speech" then  loadSound("sounds/speech.ogg")  end
		updateActiveEffects()
	end)

	guiAddSliderParam(guiSource, labelWidth, fontSmall:getWidth"1.00", "sourceVolume", "volume", 0,1, 1, "%.2f", function(guiSlider)
		source:setVolume(guiSlider:getValue()^2)
	end)

	-- Filter parameters.
	local guiFilterRows = guiSource:insert{"vbar", id="filterParams", hidden=true}

	guiAddRadioParam(guiFilterRows, labelWidth, "filterParam_type", "f_type", {"lowpass","highpass","bandpass"}, "lowpass", function(guiButton)
		guiFilterRows:find("filterParam_highgain"):setActive(guiButton.data.value == "bandpass" or guiButton.data.value == "lowpass" )
		guiFilterRows:find("filterParam_lowgain" ):setActive(guiButton.data.value == "bandpass" or guiButton.data.value == "highpass")
		updateActiveEffects()
	end)

	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_volume"  , "f_volume"  , 0,1, 1, "%.2f", updateActiveEffects)
	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_highgain", "f_highgain", 0,1, 1, "%.2f", updateActiveEffects)
	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_lowgain" , "f_lowgain" , 0,1, 1, "%.2f", updateActiveEffects):findType"slider":setActive(false)
end

-- Effects.
for _, effectInfo in ipairs(EFFECTS) do
	local labelWidth = math.max(
		fontNormal:getWidth"f_volume:",
		fontNormal:getWidth"f_highgain:",
		fontNormal:getWidth"f_lowgain:"
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

	local guiColumn = gui:find("column"..effectInfo.column)
	local guiEffect = guiColumn:insert{"vbar", spacing=SPACING, background="whatever", padding=SPACING}

	-- Header.
	guiEffect:insert{"hbar", spacing=SPACING,
		{"text", align="left", text=effectInfo.title, font=fontLarge, weight=1},
		{"button", id="filterParam_"..effectInfo.type.."_active", canToggle=true, text="Filter"},
		{"button", id="param_"..effectInfo.type.."_active", canToggle=true, text="Active"},
	}
	guiEffect:find("param_"..effectInfo.type.."_active"):on("toggle", updateActiveEffects)
	guiEffect:find("filterParam_"..effectInfo.type.."_active"):on("toggle", function(guiButton)
		guiEffect:find"filterParams":setVisible(guiButton:isToggled())
		updateActiveEffects()
	end)

	-- Effect parameters.
	for _, param in ipairs(effectInfo) do
		local paramId = "param_"..effectInfo.type.."_"..param.name

		if     param.type == "constant" then  guiAddConstantParam(guiEffect, labelWidth, param.name, param.value)
		elseif param.type == "boolean"  then  guiAddToggleParam(guiEffect, labelWidth, paramId, param.name, param.default, updateActiveEffects)
		elseif param.type == "number"   then  guiAddSliderParam(guiEffect, labelWidth, numberOutputWidth, paramId, param.name, param.min,param.max, param.default, param.format, updateActiveEffects)
		elseif param.type == "enum"     then  guiAddRadioParam(guiEffect, labelWidth, paramId, param.name, param.values, param.default, updateActiveEffects)
		else
			error(param.type)
		end
	end

	-- Filter parameters.
	local guiFilterRows = guiEffect:insert{"vbar", id="filterParams", hidden=true}

	guiAddRadioParam(guiFilterRows, labelWidth, "filterParam_"..effectInfo.type.."_type", "f_type", {"lowpass","highpass","bandpass"}, "lowpass", function(guiButton)
		guiFilterRows:find("filterParam_"..effectInfo.type.."_highgain"):setActive(guiButton.data.value == "bandpass" or guiButton.data.value == "lowpass" )
		guiFilterRows:find("filterParam_"..effectInfo.type.."_lowgain" ):setActive(guiButton.data.value == "bandpass" or guiButton.data.value == "highpass")
		updateActiveEffects()
	end)

	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_"..effectInfo.type.."_volume"  , "f_volume"  , 0,1, 1, "%.2f", updateActiveEffects)
	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_"..effectInfo.type.."_highgain", "f_highgain", 0,1, 1, "%.2f", updateActiveEffects)
	guiAddSliderParam(guiFilterRows, labelWidth, numberOutputWidth, "filterParam_"..effectInfo.type.."_lowgain" , "f_lowgain" , 0,1, 1, "%.2f", updateActiveEffects):findType"slider":setActive(false)
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
