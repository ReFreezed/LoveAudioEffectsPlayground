--[[============================================================
--=
--=  GuiLove v0.2 beta for LÖVE 0.10.2+
--=  - Written by Marcus 'ReFreezed' Thunström
--=  - MIT License (See the bottom of this file)
--=
--=  This file is generated from the source at:
--=  https://github.com/ReFreezed/GuiLove
--=
--==============================================================



	Basic usage
	----------------------------------------------------------------

	function love.load()
		local Gui = require("Gui")
		gui       = Gui()

		local tree = {"root", width=love.graphics.getWidth(), height=love.graphics.getHeight(),
			{"vbar", id="myContainer", width=200,
				{"text", text="I'm just a text."},
				{"input", value="foo bar"},
				{"button", id="myButton", text="Press Me!"},
			},
		}
		gui:load(tree)

		local myButton   = gui:find("myButton")
		local pressCount = 0

		myButton:on("press", function(myButton, event)
			pressCount = pressCount + 1

			local myContainer = gui:find("myContainer")
			local text        = "Pressed button " .. pressCount .. " " .. (pressCount == 1 and "time" or "times") .. "!"
			myContainer:insert{ "text", text=text }
		end)
	end

	function love.keypressed(key, scancode, isRepeat)
		gui:keypressed(key, scancode, isRepeat)
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



	Gui methods
	----------------------------------------------------------------

	keypressed, keyreleased, textinput
	mousepressed, mousemoved, mousereleased, wheelmoved
	update
	draw

	areStandardKeysActive, setStandardKeysActive
	blur
	defineStyle
	find, findAll, findActive, findToggled, match, matchAll
	getDefaultSound, setDefaultSound
	getElementAt
	getFont, setFont, getTooltipFont, setTooltipFont
	getHoveredElement
	getNavigationTarget, navigateTo, navigateToNext, navigateToPrevious, navigateToFirst, navigate, canNavigateTo
	getRoot
	getScissorCoordsConverter, setScissorCoordsConverter
	getScrollSmoothness, setScrollSmoothness
	getScrollSpeed, setScrollSpeed
	getSoundPlayer, setSoundPlayer
	getSpriteLoader, setSpriteLoader
	getTarget, getTargetCallback, setTargetCallback
	getTextPreprocessor, setTextPreprocessor, reprocessTexts
	getTheme, setTheme
	getTime, getTimeSinceNavigation
	getTooltipDelay, setTooltipDelay, getTooltipDuration, setTooltipDuration
	isBusy, isKeyboardBusy, isMouseBusy
	isCullingActive, setCullingActive
	isIgnoringKeyboardInput
	isInputCaptured, getInputCapturingElement
	isInteractionLocked
	isMouseGrabbed, setMouseIsGrabbed
	isTriggeringOnMousepressed, setTriggerOnMousepressed
	load
	ok, back
	scheduleLayoutUpdate, updateLayoutNow, getLayoutUpdateTime



	Element types, methods and events
	----------------------------------------------------------------

	(element)
	- animate
	- close, canClose
	- drawTooltip
	- exists
	- getAnchor, setAnchor, getAnchorX, setAnchorX, getAnchorY, setAnchorY
	- getCallback, setCallback, on, off, trigger, triggerBubbling
	- getClosest
	- getClosestInDirection, getNext, getPrevious
	- getData, setData, swapData
	- getDimensions, setDimensions, getWidth, setWidth, getHeight, setHeight
	- getGui
	- getGuiTime
	- getId, setId, hasId
	- getIndex, getDepth
	- getLayout
	- getLayoutDimensions, getLayoutWidth, getLayoutHeight
	- getLayoutPosition, getLayoutX, getLayoutY, getLayoutCenterPosition
	- getMaxDimensions, setMaxDimensions, getMaxWidth, setMaxWidth, getMaxHeight, setMaxHeight
	- getMinDimensions, setMinDimensions, getMinWidth, setMinWidth, getMinHeight, setMinHeight
	- getMouseCursor, getResultingMouseCursor, setMouseCursor
	- getMousePosition, getMouseX, getMouseY
	- getOrigin, setOrigin, getOriginX, setOriginX, getOriginY, setOriginY
	- getParent, getAllParents, hasParent, getParentWithId, hasParentWithId, parents, parentsr, lineageUp
	- getPathDescription
	- getPosition, setPosition, getX, setX, getY, setY
	- getPositionOnScreen, getXOnScreen, getYOnScreen, getLayoutOnScreen, getCenterPositionOnScreen
	- getRelativeDimensions, getRelativeWidth, getRelativeHeight, setRelativeDimensions, setRelativeWidth, setRelativeHeight
	- getResultingTooltipFont, useTooltipFont
	- getRoot, getNavigationRoot
	- getSibling
	- getSound, getResultingSound, setSound
	- getSpacing, getSpacingLeft, getSpacingRight, getSpacingTop, getSpacingBottom, setSpacing
	- getStyle
	- getTimeSinceBecomingVisible
	- getTooltip, setTooltip
	- getWeight, setWeight
	- hasFixedWidth, hasFixedHeight, hasDynamicWidth, hasDynamicHeight, hasRelativeWidth, hasRelativeHeight
	- hasTag, addTag, removeTag, removeAllTags, setTag
	- isAt
	- isDisplayed, getClosestHiddenElement, getFarthestHiddenElement
	- isFirst, isLast
	- isHidden, isVisible, setHidden, setVisible, show, hide, toggleHidden
	- isHovered
	- isMouseFocus, isKeyboardFocus
	- isNavigationTarget
	- isSolid
	- isType
	- playSound
	- refresh
	- remove
	- reprocessTexts
	- scrollIntoView
	- setScissor, unsetScissor
	- showMenu
	- updateLayoutNow
	- Event: beforedraw, afterdraw
	- Event: close, closed
	- Event: focused, blurred
	- Event: init
	- Event: keypressed
	- Event: layout
	- Event: mousepressed, mousemoved, mousereleased
	- Event: navigated
	- Event: pressed
	- Event: refresh
	- Event: show, hide
	- Event: textinput
	- Event: update
	- Event: wheelmoved

	container
	- canScrollAny, canScrollX, canScrollY
	- find, findAll, findType, findActive, findToggled, match, matchAll
	- get, children
	- getChildAreaDimensions, getChildAreaWidth, getChildAreaHeight
	- getChildWithData
	- getElementAt
	- getInnerSpace, getInnerSpaceX, getInnerSpaceY
	- getPadding, getPaddingLeft, getPaddingRight, getPaddingTop, getPaddingBottom, setPadding
	- getScroll, getScrollX, getScrollY, setScroll, setScrollX, setScrollY, scroll
	- getScrollHandleX, getScrollHandleY
	- getScrollLimit, getScrollLimitX, getScrollLimitY
	- getToggledChild, setToggledChild
	- getVisibleChild, getVisibleChildNumber, getVisibleChildCount, setVisibleChild
	- getVisualScroll, getVisualScrollX, getVisualScrollY
	- indexOf
	- insert, removeAt, empty
	- isScrollbarXHovered, isScrollbarYHovered, isScrollbarXHandleHovered, isScrollbarYHandleHovered
	- isScrollingX, isScrollingY
	- setChildrenActive
	- setChildrenHidden
	- sort
	- traverse, traverseType, traverseVisible

		(bar)

			hbar

			vbar

		root
		- setDimensions

	(leaf)
	- drawText, drawAlignedText
	- getAlign, setAlign
	- getFont, getResultingFont, setFont, useFont
	- getMnemonicOffset
	- getText, getUnprocessedText, setText
	- getTextColor, setTextColor, hasTextColor, useTextColor

		canvas
		- getCanvasBackgroundColor, setCanvasBackgroundColor
		- Event: draw

		image
		- Includes: imageInclude

		text

		(widget)
		- getPriority, setPriority
		- isActive, setActive
		- Event: navigate
		- Event: navupdate

			button
			- Includes: imageInclude
			- drawText2, drawAlignedText2
			- getText2, getUnprocessedText2, setText2
			- isPressable, setPressable
			- isRadio, getRadio, setRadio
			- isToggled, setToggled
			- press, isPressed
			- Event: press
			- Event: toggle, toggleon, toggleoff

			input
			- drawValue, drawPlaceholder, drawValueOrPlaceholder, drawSelections
			- focus, blur, isFocused
			- getBlinkPhase
			- getField
			- getFieldType, setFieldType
			- getValue, setValue, getVisibleValue
			- getValueLayout, getCursorLayout
			- Event: change
			- Event: submit
			- Event: valuechange

			slider
			- drawValue
			- getMin, setMin, getMax, setMax
			- getValue, getNormalizedValue, setValue, increase, decrease
			- getValueFormat, getResultingValueFormat, setValueFormat
			- getValueText
			- isContinuous, setContinuous
			- isVertical, setVertical
			- Event: change
			- Event: valuechange



	Includes
	----------------------------------------------------------------

	imageInclude
	- drawImage
	- getImageBackgroundColor, setImageBackgroundColor, hasImageBackgroundColor, useImageBackgroundColor
	- getImageColor, setImageColor, hasImageColor, useImageColor
	- getImageDimensions, setImageSize, maximizeImageSize
	- getImageScale, getImageScaleX, getImageScaleY, setImageScale, setImageScaleX, setImageScaleY
	- getSprite, setSprite, hasSprite



	Utilities
	----------------------------------------------------------------

	clamp, clamp01, clamp11
	create9SliceQuads
	draw9SliceScaled, draw9SliceRepeated
	getDefaultFont
	lerp, lerpColor, damp, remap
	newMonochromeImage, newImageUsingPalette
	parseTargetAndEvent
	round
	setColor



--============================================================]]



local setColor = love.graphics.setColor

if love.getVersion() < 11 then
	local _setColor = setColor
	function setColor(r, g, b, a)
		_setColor(r*255, g*255, b*255, (a and a*255))
	end
end

local newClass   = (function()
	--[[============================================================
	--=
	--=  BarelyOOP - simple, bare bones, optimized class library
	--=  - Written by Marcus 'ReFreezed' Thunström
	--=  - CC0 License (https://creativecommons.org/publicdomain/zero/1.0/)
	--=
	--==============================================================

		classLib = require("class")

		myClass  = classLib( className, [ includes, ] baseTable ) -- Create a new class.
		subclass = myClass:extend( className, [ includes, ] baseTable ) -- Create a subclass.

		subclass.super -- Access the parent class.

		instance = myClass(...) -- Create a new instance (which calls myClass.init(instance, ...)).
		bool     = instance:is( class ) -- Check if the instance inherits a class.

		instance.class -- Access the instance's class.

		string = tostring( class|instance )

		Notes:
		- Subclasses are completely detached from their parent (members are copied over when extending).
		- Because of the above, static class members ought to be constant as changes are not propagated to derived classes.
		- Subclasses have to manually call the parent's init function, if that's desired.

	----------------------------------------------------------------

		--
		-- Example #1: Base and derived button class.
		--
		local Button = classLib("Button", {
			text     = "Default text.",
			position = nil,
		})
		function Button:init()
			self.position = {x=0, y=0}
		end
		function Button:printText()
			print(self.text)
		end

		local CoolButton = Button:extend("CoolButton", {
			coolness = 0,
		})
		function CoolButton:init(coolness)
			CoolButton.super.init(self)
			self.position.y = 300
			self.coolness   = coolness
		end

		local button1 = Button()
		button1.text  = "Foo!"

		local button2      = Button()
		button2.text       = "Bar?"
		button2.position.x = 80

		local button3 = CoolButton(9001)
		button3:printText()

		--
		-- Example #2: Includes.
		--
		local Text = classLib("Text", {
			text = "",
		})
		function Text:setText(text)
			self.text = text
		end

		local Image = classLib("Image", {
			filePath = "",
		})

		local TextAndImage = classLib("TextAndImage", {Text,Image}, {
			spacing = 5,
		})

		local header = TextAndImage()
		header:setText("Foo!")

	--============================================================]]

	local setmetatable = setmetatable
	local format       = string.format
	local dummyTable   = {}
	local zeroX        = tostring(dummyTable):match"0x" or "" -- For __tostring(). LuaJIT uses 0x address prefix, PUC-Lua does not.

	local classMt = {
		__call = function(class, ...)
			local instance = {--[[ class=class, __id="" ]]} -- The ID is generated when needed in __tostring().
			setmetatable(instance, class)
			instance:init(...)
			return instance
		end,

		__tostring = function(class)
			return format("class(%s): %s%s", class.__name, zeroX, class.__classid)
		end,
	}

	local function getId(t)
		local id = tostring(t)
		return (zeroX ~= "") and id:match"0x(%x+)" or id:gsub("^table: ", "")
	end

	local function copyMissingMembers(class, members)
		for k, v in pairs(members) do
			if class[k] == nil then  class[k] = v  end
		end
	end

	local function newClass(parentClass, name, includes, class)
		if not class then
			includes, class = nil, includes
		end

		class.__index   = class        -- Instances use their class as metatable.
		class.__name    = name         -- For __tostring().
		class.__classid = getId(class) -- For __tostring().
		class.class     = class        -- So instance.class works.
		class.super     = parentClass

		if parentClass then
			copyMissingMembers(class, parentClass) -- Subclasses do NOT use parent classes as metatables - we just copy everything over.
		end
		for _, t in ipairs(includes or dummyTable) do
			copyMissingMembers(class, t)
		end

		return setmetatable(class, classMt)
	end

	local BaseClass = newClass(nil, "Class", {
		init   = function()end, -- It's safe for any class to call the parent's init().
		extend = newClass,

		is = function(instance, class)
			local currentClass = instance.class

			while currentClass do
				if currentClass == class then  return true  end
				currentClass = currentClass.super
			end

			return false
		end,

		__tostring = function(instance)
			if not instance.__id then
				local setMt = debug and debug.setmetatable or setmetatable
				local class = instance.class
				setMt(instance, nil) -- We prefer debug.setmetatable() over setmetatable() in case class.__metatable is set.
				instance.__id = getId(instance)
				setMt(instance, class)
			end
			return format("%s: %s%s", instance.__name, zeroX, instance.__id)
		end,
	})

	return setmetatable({_VERSION="0.1.0", base=BaseClass}, {
		__call = function(_M, name, includes, subclass)
			return BaseClass:extend(name, includes, subclass)
		end,
	})

       end)()
local InputField = (function()
	--[[============================================================
	--=
	--=  InputField v3.3-dev - text input handling library for LÖVE (0.10.2+)
	--=  - Written by Marcus 'ReFreezed' Thunström
	--=  - MIT License (See the bottom of this file)
	--=  - https://github.com/ReFreezed/InputField
	--=
	--==============================================================

		1. Functions
		2. Enums
		3. Basic usage



		1. Functions
		----------------------------------------------------------------

		-- Search through the file for more info about each individual function.

		-- Settings:
		getAlignment, setAlignment
		getDimensions, getWidth, getHeight, setDimensions, setWidth, setHeight
		getDoubleClickMaxDelay, setDoubleClickMaxDelay
		getFilter, setFilter
		getFont, setFont
		getMaxHistory, setMaxHistory
		getMouseScrollSpeed, getMouseScrollSpeedX, getMouseScrollSpeedY, setMouseScrollSpeed, setMouseScrollSpeedX, setMouseScrollSpeedY
		getType, setType, isPassword, isMultiline
		getWheelScrollSpeed, getWheelScrollSpeedX, getWheelScrollSpeedY, setWheelScrollSpeed, setWheelScrollSpeedX, setWheelScrollSpeedY
		isEditable, setEditable
		isFontFilteringActive, setFontFilteringActive

		-- Events:
		update
		mousepressed, mousemoved, mousereleased, wheelmoved
		keypressed, textinput

		-- Other:
		canScroll, canScrollHorizontally, canScrollVertically
		clearHistory
		eachVisibleLine, eachSelection, eachSelectionOptimized
		getBlinkPhase, resetBlinking
		getCursor, setCursor, moveCursor, getCursorSelectionSide, getAnchorSelectionSide
		getCursorLayout
		getInfoAtCoords, getInfoAtCursor, getInfoAtCharacter
		getScroll, getScrollX, getScrollY, setScroll, setScrollX, setScrollY, scroll, scrollToCursor
		getScrollHandles, getScrollHandleHorizontal, getScrollHandleVertical
		getScrollLimits
		getSelection, setSelection, selectAll, getSelectedText, getSelectedVisibleText
		getText, setText, getVisibleText, insert
		getTextDimensions, getTextWidth, getTextHeight
		getTextLength
		getTextOffset
		getVisibleLine, getVisibleLineCount
		isBusy
		releaseMouse
		reset



		2. Enums
		----------------------------------------------------------------

		InputFieldType
			"normal"      -- Simple single-line input.
			"password"    -- Single-line input where all characters are obscured.
			"multiwrap"   -- Multi-line input where text wraps by the width of the field.
			"multinowrap" -- Multi-line input with no wrapping.

		SelectionSide
			"start" -- The start (left side) of the text selection.
			"end"   -- The end (right side) of the text selection.

		TextCursorAlignment
			"left"  -- Align cursor to the left.
			"right" -- Align cursor to the right.

		TextAlignment
			"left"   -- Align text to the left.
			"right"  -- Align text to the right.
			"center" -- Align text to the center.



		3. Basic usage
		----------------------------------------------------------------

		local InputField = require("InputField")
		local field      = InputField("Initial text.")

		local fieldX = 80
		local fieldY = 50

		love.keyboard.setKeyRepeat(true)

		function love.keypressed(key, scancode, isRepeat)
			field:keypressed(key, isRepeat)
		end
		function love.textinput(text)
			field:textinput(text)
		end

		function love.mousepressed(mx, my, mbutton, pressCount)
			field:mousepressed(mx-fieldX, my-fieldY, mbutton, pressCount)
		end
		function love.mousemoved(mx, my)
			field:mousemoved(mx-fieldX, my-fieldY)
		end
		function love.mousereleased(mx, my, mbutton)
			field:mousereleased(mx-fieldX, my-fieldY, mbutton)
		end
		function love.wheelmoved(dx, dy)
			field:wheelmoved(dx, dy)
		end

		function love.draw()
			love.graphics.setColor(0, 0, 1)
			for _, x, y, w, h in field:eachSelection() do
				love.graphics.rectangle("fill", fieldX+x, fieldY+y, w, h)
			end

			love.graphics.setColor(1, 1, 1)
			for _, text, x, y in field:eachVisibleLine() do
				love.graphics.print(text, fieldX+x, fieldY+y)
			end

			local x, y, h = field:getCursorLayout()
			love.graphics.rectangle("fill", fieldX+x, fieldY+y, 1, h)
		end



	--============================================================]]

	local InputField = {
		_VERSION = "InputField 3.3.0-dev",
	}



	local LK   = require"love.keyboard"
	local LS   = require"love.system"
	local LT   = require"love.timer"
	local utf8 = require"utf8"

	local isMac = (LS.getOS() == "OS X")

	local InputField   = {}
	InputField.__index = InputField



	--[[ @Debug macOS on Windows.
	isMac         = true
	local _isDown = LK.isDown

	function LK.isDown(...)
		for i = 1, select("#", ...) do
			local key = select(i, ...)

			if     key == "lgui"  then  key = "lctrl"
			elseif key == "rgui"  then  key = "rctrl"
			elseif key == "lctrl" then  key = "application"
			elseif key == "rctrl" then  key = "application"
			end

			if _isDown(key) then  return true  end
		end

		return false
	end
	--]]



	--==============================================================
	--= Internal functions =========================================
	--==============================================================



	local function noop() end



	local function clamp(n, min, max)
		return math.max(math.min(n, max), min)
	end



	local function nextCodepoint(s, i)
		if i > 0 then
			local b = s:byte(i)
			if not b then
				return
			elseif b >= 240 then
				i = i + 4
			elseif b >= 224 then
				i = i + 3
			elseif b >= 192 then
				i = i + 2
			else
				i = i + 1
			end
		elseif i == 0 then
			i = 1
		elseif i < 0 then
			return
		end
		if i > #s then  return  end

		return i, utf8.codepoint(s, i)
	end

	local function utf8Codes(s) -- We don't use utf8.codes() as it creates garbage!
		return nextCodepoint, s, 0
	end

	local function utf8GetEndOffset(line, pos)
		return (utf8.offset(line, pos+1) or #line+1) - 1
	end



	local function cleanString(field, s)
		local isMultiline = field:isMultiline()
		s                 = s:gsub((isMultiline and "[%z\1-\9\11-\31]+" or "[%z\1-\31]+"), "") -- Should we allow horizontal tab?

		if field.fontFilteringIsActive then
			local font      = field.font
			local hasGlyphs = font.hasGlyphs

			s = s:gsub(utf8.charpattern, function(c)
				if not (hasGlyphs(font, c) or (c == "\n" and isMultiline)) then
					return ""
				end
			end)
		end

		return s
	end



	--
	-- boundPosition = getNextWordBound    ( string, startPosition, direction )
	-- boundPosition = getNextHardLineBound( string, startPosition, direction )
	-- direction     = -1 | 1
	--
	-- Cursor behavior examples when navigating by word:
	--   a|a bb  ->  aa| bb
	--   aa| bb  ->  aa bb|
	--   aa |bb  ->  aa bb|
	--   cc| = dd+ee  ->  cc =| dd+ee
	--   cc =| dd+ee  ->  cc = dd|+ee
	--   cc = dd|+ee  ->  cc = dd+|ee
	--   f|f(-88  ->  ff|(-88
	--   ff|(-88  ->  ff(-|88
	--   ff(|-88  ->  ff(-|88
	--
	local getNextWordBound, getNextHardLineBound
	do
		local function newSet(values)
			local set = {}
			for _, v in ipairs(values) do
				set[v] = true
			end
			return set
		end

		local ASCII_PUNCTUATION = "!\"#$%&'()*+,-./:;<=>?@[\\]^`{|}~"; ASCII_PUNCTUATION = newSet{ ASCII_PUNCTUATION:byte(1, #ASCII_PUNCTUATION) }
		local ASCII_WHITESPACE  = newSet{ 9--[[,10]],11,12,13,32 } -- Horizontal tab, line feed, vertical tab, form feed, carriage return, space.

		-- Generated by tools/generateUnicodeInfo.lua:

		-- PUNCTUATION (8330, 97+230)
		local UNICODE_PUNCTUATION = newSet{180,187,191,215,247,749,885,894,903,1014,1154,1470,1472,1475,1478,1563,1748,1758,1769,2142,2416,2557,2678,2928,3191,3199,3204,3407,3449,
			3572,3647,3663,3892,3894,3896,3973,4347,5120,6464,7379,8125,8468,8485,8487,8489,8494,8527,11632,12336,12448,12539,12880,42611,42622,43260,43359,43867,44011,64297,
			65952,66463,66512,66927,67671,67871,67903,68223,68296,69293,70093,70107,70313,70749,70854,71739,72162,73727,92917,94178,113820,113823,119365,120513,120539,120571,120597,120629,120655,120687,
			120713,120745,120771,123215,123647,126124,126128,126254}
		local ranges = {161,169,171,172,174,177,182,184,706,709,722,735,741,747,751,767,900,901,1370,1375,1417,1418,
			1421,1423,1523,1524,1542,1551,1566,1567,1642,1645,1789,1790,1792,1805,2038,2041,2046,2047,2096,2110,2404,2405,2546,2547,
			2554,2555,2800,2801,3059,3066,3674,3675,3841,3863,3866,3871,3898,3901,4030,4037,4039,4044,4046,4058,4170,4175,4254,4255,
			4960,4968,5008,5017,5741,5742,5787,5788,5867,5869,5941,5942,6100,6102,6104,6107,6144,6154,6468,6469,6622,6655,6686,6687,
			6816,6822,6824,6829,7002,7018,7028,7036,7164,7167,7227,7231,7294,7295,7360,7367,8127,8129,8141,8143,8157,8159,8173,8175,
			8189,8190,8208,8231,8240,8286,8314,8318,8330,8334,8352,8383,8448,8449,8451,8454,8456,8457,8470,8472,8478,8483,8506,8507,
			8512,8516,8522,8525,8586,8587,8592,9254,9280,9290,9372,9449,9472,10101,10132,11123,11126,11157,11159,11263,11493,11498,11513,11516,
			11518,11519,11776,11822,11824,11858,11904,11929,11931,12019,12032,12245,12272,12283,12289,12292,12296,12320,12342,12343,12349,12351,12443,12444,
			12688,12689,12694,12703,12736,12771,12800,12830,12842,12871,12896,12927,12938,12976,12992,13311,19904,19967,42128,42182,42238,42239,42509,42511,
			42738,42743,42752,42774,42784,42785,42889,42890,43048,43051,43062,43065,43124,43127,43214,43215,43256,43258,43310,43311,43457,43469,43486,43487,
			43612,43615,43639,43641,43742,43743,43760,43761,43882,43883,64434,64449,64830,64831,65020,65021,65040,65049,65072,65106,65108,65126,65128,65131,
			65281,65295,65306,65312,65339,65344,65371,65381,65504,65510,65512,65518,65532,65533,65792,65794,65847,65855,65913,65929,65932,65934,65936,65948,
			66000,66044,67703,67704,68176,68184,68336,68342,68409,68415,68505,68508,69461,69465,69703,69709,69819,69820,69822,69825,69952,69955,70004,70005,
			70085,70088,70109,70111,70200,70205,70731,70735,70746,70747,71105,71127,71233,71235,71264,71276,71484,71487,72004,72006,72255,72262,72346,72348,
			72350,72354,72769,72773,72816,72817,73463,73464,73685,73713,74864,74868,92782,92783,92983,92991,92996,92997,93847,93850,118784,119029,119040,119078,
			119081,119140,119146,119148,119171,119172,119180,119209,119214,119272,119296,119361,119552,119638,120832,121343,121399,121402,121453,121460,121462,121475,121477,121483,
			125278,125279,126704,126705,126976,127019,127024,127123,127136,127150,127153,127167,127169,127183,127185,127221,127245,127405,127462,127490,127504,127547,127552,127560,
			127568,127569,127584,127589,127744,128727,128736,128748,128752,128764,128768,128883,128896,128984,128992,129003,129024,129035,129040,129095,129104,129113,129120,129159,
			129168,129197,129200,129201,129280,129400,129402,129483,129485,129619,129632,129645,129648,129652,129656,129658,129664,129670,129680,129704,129712,129718,129728,129730,
			129744,129750,129792,129938,129940,129994}
		for i = 1, #ranges, 2 do  for cp = ranges[i], ranges[i+1] do UNICODE_PUNCTUATION[cp] = true end  end

		-- WHITESPACE (18, 5+2)
		local UNICODE_WHITESPACE = newSet{160,5760,8239,8287,12288}
		local ranges = {8192,8202,8232,8233}
		for i = 1, #ranges, 2 do  for cp = ranges[i], ranges[i+1] do UNICODE_WHITESPACE[cp] = true end  end



		local function getCodepointCharType(cp)
			return ASCII_PUNCTUATION[cp]   and "punctuation"
			    or cp == 10                and "newline"
			    or ASCII_WHITESPACE[cp]    and "whitespace"
			    or cp <= 127               and "word"
			    or UNICODE_PUNCTUATION[cp] and "punctuation"
			    or UNICODE_WHITESPACE[cp]  and "whitespace"
			    or                             "word"
		end

		local codepoints = {}

		function getNextWordBound(s, pos, direction)
			local len = 0

			for _, cp in utf8Codes(s) do
				len             = len + 1
				codepoints[len] = cp
			end
			for i = len+1, #codepoints do
				codepoints[i] = nil
			end

			pos = clamp(pos, 0, len)
			if direction < 0 then  pos = pos+1  end

			while true do
				pos = pos + direction

				-- Check for end of string.
				local prevCp = codepoints[pos]
				local nextCp = codepoints[pos+direction]

				if not (prevCp and nextCp) then
					pos = pos + direction
					break
				end

				-- Check for word bound.
				local prevType = getCodepointCharType(prevCp)
				local nextType = getCodepointCharType(nextCp)

				if (nextType ~= prevType and not (nextType ~= "whitespace" and prevType == "whitespace")) or nextType == "newline" then
					if direction < 0 then  pos = pos-1  end
					break
				end
			end

			return clamp(pos, 0, len)
		end

		function getNextHardLineBound(s, pos, direction)
			local len = 0

			for _, cp in utf8Codes(s) do
				len             = len + 1
				codepoints[len] = cp
			end
			for i = len+1, #codepoints do
				codepoints[i] = nil
			end

			while codepoints[pos] or codepoints[pos+direction] do
				pos = pos + direction

				if (codepoints[pos] or 10) == 10 then
					if direction > 0 then  pos = pos-1  end
					break
				end
			end

			return clamp(pos, 0, len)
		end
	end



	local function updateWrap(field)
		local text = field:getVisibleText()
		if field.lastWrappedText == text then  return  end

		field.lastWrappedText = text

		if field:isMultiline() then
			field.wrappedWidth = 0

			local wrapWidth = (field.type == "multiwrap") and field.width or 1/0
			local lineCount = 0
			local processed = 0

			for line, i in text:gmatch"([^\n]*)()" do
				if i > processed then
					processed = i

					if line == "" then
						lineCount                    = lineCount + 1
						field.wrappedText[lineCount] = ""
						field.softBreak[lineCount]   = false

					else
						local w, subLines  = field.font:getWrap(line, wrapWidth)
						local subLineCount = #subLines

						for subLineI, subLine in ipairs(subLines) do
							lineCount                    = lineCount + 1
							field.wrappedText[lineCount] = subLine
							field.softBreak[lineCount]   = subLineI < subLineCount
						end

						field.wrappedWidth = math.max(field.wrappedWidth, w)
					end
				end
			end

			for lineI = lineCount+1, #field.wrappedText do
				field.wrappedText[lineI] = nil
				field.softBreak[lineI]   = nil
			end

		else
			field.wrappedText[1] = text
			field.softBreak[1]   = false
			field.wrappedWidth   = field.font:getWidth(text)

			for lineI = 2, #field.wrappedText do
				field.wrappedText[lineI] = nil
				field.softBreak[lineI]   = nil
			end
		end

		--[[ @Debug
		print("--------------------------------")
		for i = 1, #field.wrappedText do
			print(i, field.softBreak[i], field.wrappedText[i])
		end
		--]]
	end



	local function getLineAlignmentOffset(field, line)
		if     field.alignment == "left"        then  return 0
		elseif field.width     == 1/0           then  return 0
		elseif field.type      == "multinowrap" then  return 0
		elseif field.alignment == "right"       then  return math.max(field.width-field.font:getWidth(line), 0)
		elseif field.alignment == "center"      then  return math.floor(.5 * math.max(field.width-field.font:getWidth(line), 0))
		else
			error(field.alignment)
		end
	end

	local function alignOnLine(field, line, x)
		return x + getLineAlignmentOffset(field, line)
	end

	local function unalignOnLine(field, line, x)
		return x - getLineAlignmentOffset(field, line)
	end

	-- cursorPosition, side = getCursorPositionAtX(field, line, x)
	-- side                 = -1 | 1
	local function getCursorPositionAtX(field, line, x)
		x = unalignOnLine(field, line, x)

		if line == "" or x <= 0 then
			return 0
		elseif x <= field.font:getWidth(line:sub(1, utf8GetEndOffset(line, 1)))/2 then
			return 0
		end

		local lineW = field.font:getWidth(line)
		if x >= lineW then
			return utf8.len(line)
		end

		-- Binary search.
		local posL = 1
		local posR = utf8.len(line)

		local closestDist = math.abs(x - lineW)
		local closestPos  = posR

		while posL < posR do
			local pos      = math.floor((posL+posR)/2)
			local linePart = line:sub(1, utf8GetEndOffset(line, pos)) -- @Memory (We could maybe use font:getKerning() in LÖVE 11.4+ to traverse one character at a time. Might be slower though.)

			local dx = x - field.font:getWidth(linePart)
			if dx == 0 then  return pos  end -- x is exactly at the cursor's position.

			local dist = math.abs(dx)

			if dist < closestDist then
				closestDist = dist
				closestPos  = pos
			end

			if dx < 0 then
				posR = pos
			else
				posL = pos
				if posL == posR-1 then  break  end -- Because pos is rounded down we'd get stuck without this (as pos would be posL again and again).
			end
		end

		return closestPos
	end

	local function getLineStartPosition(field, targetLineI)
		local linePos1 = 1

		for lineI = 1, targetLineI-1 do
			linePos1 = linePos1 + utf8.len(field.wrappedText[lineI])

			if not field.softBreak[lineI] then
				linePos1 = linePos1 + 1
			end
		end

		return linePos1
	end

	-- cursorPosition, visualLineIndex, visualLineIndexUnclamped = getCursorPositionAtCoordinates( field, x, y )
	local function getCursorPositionAtCoordinates(field, x, y)
		updateWrap(field)

		if not field:isMultiline() then
			return getCursorPositionAtX(field, field.wrappedText[1], x), 1, 1
		end

		local fontH          = field.font:getHeight()
		local lineDist       = math.ceil(fontH*field.font:getLineHeight())
		local lineSpace      = lineDist - fontH
		local lineIUnclamped = math.floor(1 + (y+lineSpace/2) / lineDist)
		local lineI          = clamp(lineIUnclamped, 1, #field.wrappedText)
		local line           = field.wrappedText[lineI]

		if not line then  return 0, 0, lineIUnclamped  end

		local linePos1  = getLineStartPosition(field, lineI)
		local posOnLine = getCursorPositionAtX(field, line, x)

		return linePos1+posOnLine-1, lineI, lineIUnclamped
	end

	-- line, positionOnLine, lineIndex, linePosition1, linePosition2 = getLineInfoAtPosition( field, position )
	local function getLineInfoAtPosition(field, pos)
		updateWrap(field)

		pos            = math.min(pos, utf8.len(field.text))
		local linePos1 = 1

		for lineI, line in ipairs(field.wrappedText) do
			local linePos2  = linePos1 + utf8.len(line) - 1
			local softBreak = field.softBreak[lineI]

			if pos <= (softBreak and linePos2-1 or linePos2) then -- Any trailing newline counts as being on the next line.
				return line, pos-linePos1+1, lineI, linePos1, linePos2
			end

			linePos1 = linePos2 + (softBreak and 1 or 2) -- Jump over any newline.
		end

		-- We should never get here!
		return getLineInfoAtPosition(field, 0)
	end



	local LCTRL = isMac and "lgui" or "lctrl"
	local RCTRL = isMac and "rgui" or "rctrl"

	-- modKeys = getModKeys( )
	-- modKeys = "cas" | "ca" | "cs" | "as" | "c" | "a" | "s" | "" | "^cas" | "^ca" | "^cs" | "^as" | "^c" | "^a" | "^s" | "^"
	local function getModKeys()
		local c = LK.isDown(LCTRL,    RCTRL   )
		local a = LK.isDown("lalt",   "ralt"  )
		local s = LK.isDown("lshift", "rshift")

		if isMac and LK.isDown("lctrl", "rctrl") then
			if     c and a and s then  return "^cas"
			elseif c and a       then  return "^ca"
			elseif c and s       then  return "^cs"
			elseif a and s       then  return "^as"
			elseif c             then  return "^c"
			elseif a             then  return "^a"
			elseif s             then  return "^s"
			else                       return "^"  end
		end

		if     c and a and s then  return "cas"
		elseif c and a       then  return "ca"
		elseif c and s       then  return "cs"
		elseif a and s       then  return "as"
		elseif c             then  return "c"
		elseif a             then  return "a"
		elseif s             then  return "s"
		else                       return ""  end
	end



	local function limitScroll(field)
		local limitX, limitY = field:getScrollLimits()
		field.scrollX        = clamp(field.scrollX, 0, limitX)
		field.scrollY        = clamp(field.scrollY, 0, limitY)
	end



	local function applyFilter(field, s)
		local filterFunc = field.filterFunction
		if not filterFunc then  return s  end

		s = s:gsub(utf8.charpattern, function(c)
			if filterFunc(c) then  return ""  end
		end)

		return s
	end



	-- pushHistory( field, group|nil )
	local function pushHistory(field, group)
		local history = field.editHistory
		local i, state

		-- Never save history for password fields.
		if field.type == "password" then
			i     = 1
			state = history[1]

		-- Update last entry if group matches.
		elseif group and group == field.editHistoryGroup then
			i     = field.editHistoryIndex
			state = history[i]

		-- History limit reached.
		elseif field.editHistoryIndex >= field.editHistoryMax then
			i          = field.editHistoryIndex
			state      = table.remove(history, 1)
			history[i] = state

		-- Expand history.
		else
			i          = field.editHistoryIndex + 1
			state      = {}
			history[i] = state
		end

		for i = i+1, #history do
			history[i] = nil
		end

		state.text           = field.text
		state.cursorPosition = field.cursorPosition
		state.selectionStart = field.selectionStart
		state.selectionEnd   = field.selectionEnd

		field.editHistoryIndex = i
		field.editHistoryGroup = group

		field.navigationTargetX = nil
	end



	local function finilizeHistoryGroup(field)
		field.editHistoryGroup = nil
	end



	local function applyHistoryState(field, offset)
		field.editHistoryIndex = field.editHistoryIndex + offset

		local state = field.editHistory[field.editHistoryIndex] or assert(false)

		field.text           = state.text
		field.cursorPosition = state.cursorPosition
		field.selectionStart = state.selectionStart
		field.selectionEnd   = state.selectionEnd

		field.navigationTargetX = nil
	end

	-- @UX: Improve how the cursor and selection are restored on undo.
	local function undoEdit(field)
		if field.editHistoryIndex == 1 then  return false  end

		finilizeHistoryGroup(field)
		applyHistoryState(field, -1)

		field:resetBlinking()
		field:scrollToCursor()

		return true
	end

	local function redoEdit(field)
		if field.editHistoryIndex == #field.editHistory then  return false  end

		finilizeHistoryGroup(field)
		applyHistoryState(field, 1)

		field:resetBlinking()
		field:scrollToCursor()

		return true
	end



	--==============================================================
	--= Exported functions =========================================
	--==============================================================



	-- InputField( [ initialText="", type:InputFieldType="normal" ] )
	local function newInputField(text, fieldType)
		if not (fieldType == nil or fieldType == "normal" or fieldType == "password" or fieldType == "multiwrap" or fieldType == "multinowrap") then
			error("[InputField] Invalid field type '"..tostring(fieldType).."'.", 2)
		end
		fieldType = fieldType or "normal"

		local field = setmetatable({
			type = fieldType,

			blinkTimer = LT.getTime(),

			cursorPosition = 0,
			selectionStart = 0,
			selectionEnd   = 0,

			clickCount               = 1, -- This and multiClickMaxDelay are only used if the 'pressCount' argument isn't supplied to mousepressed().
			multiClickMaxDelay       = 0.40,
			multiClickExpirationTime = 0.00,
			multiClickLastX          = 0.0,
			multiClickLastY          = 0.0,

			editHistoryMax   = 100,
			editHistory      = {},
			editHistoryIndex = 1,
			editHistoryGroup = nil, -- nil | "insert" | "remove"

			font                  = require"love.graphics".getFont(),
			fontFilteringIsActive = false,

			filterFunction = nil,

			mouseScrollSpeedX = 6.0, -- Per pixel per second.
			mouseScrollSpeedY = 8.0,

			wheelScrollSpeedX = 1.0, -- Per second. Relative to the font size.
			wheelScrollSpeedY = 1.0,

			dragMode           = "", -- "" | "character" | "word" | "line"
			dragStartPosition1 = 0,
			dragStartPosition2 = 0,
			dragLastX          = 0,
			dragLastY          = 0,

			editingEnabled = true,

			scrollX = 0.0,
			scrollY = 0.0,

			text = "",

			width  = 1/0,
			height = 1/0,

			alignment = "left",

			navigationTargetX = nil, -- Used when navigating vertically. Nil means need recalculation.

			-- These are updated by updateWrap():
			lastWrappedText = "",
			wrappedText     = {""}, -- []line
			softBreak       = {false}, -- []bool
			wrappedWidth    = 0,
		}, InputField)

		text       = cleanString(field, tostring(text == nil and "" or text))
		field.text = text
		local len  = utf8.len(text)

		field.editHistory[1] = {
			text           = text,
			cursorPosition = len,
			selectionStart = 0,
			selectionEnd   = len,
		}

		return field
	end



	-- phase = field:getBlinkPhase( )
	-- Get current phase for an animated cursor.
	-- The value is the time since the last blink reset.
	function InputField.getBlinkPhase(field)
		return LT.getTime() - field.blinkTimer
	end

	-- field:resetBlinking( )
	function InputField.resetBlinking(field)
		field.blinkTimer = LT.getTime()
	end



	-- position = field:getCursor( )
	-- Position 0 is before first character, position 1 is between first and second etc.
	function InputField.getCursor(field)
		return field.cursorPosition
	end

	-- field:setCursor( position [, selectionSideToAnchor:SelectionSide=none ] )
	-- Position 0 is before first character, position 1 is between first and second etc.
	function InputField.setCursor(field, pos, selSideAnchor)
		finilizeHistoryGroup(field)

		pos                  = clamp(pos, 0, field:getTextLength())
		field.cursorPosition = pos

		local selStart       = (selSideAnchor == "start" and field.selectionStart or pos)
		local selEnd         = (selSideAnchor == "end"   and field.selectionEnd   or pos)
		field.selectionStart = math.min(selStart, selEnd)
		field.selectionEnd   = math.max(selStart, selEnd)

		field:resetBlinking()
		field:scrollToCursor()
	end

	local function setCursorPosition(field, pos, selSideAnchor, eraseNavTargetX)
		field:setCursor(pos, selSideAnchor)
		if eraseNavTargetX then
			field.navigationTargetX = nil
		end
	end

	-- field:moveCursor( steps [, selectionSideToAnchor:SelectionSide=none ] )
	-- 'steps' may be positive or negative.
	function InputField.moveCursor(field, steps, selSideAnchor)
		setCursorPosition(field, field.cursorPosition+steps, selSideAnchor, true)
	end

	-- side:SelectionSide = field:getCursorSelectionSide( )
	function InputField.getCursorSelectionSide(field)
		return (field.cursorPosition < field.selectionEnd and "start" or "end")
	end

	-- side:SelectionSide = field:getAnchorSelectionSide( )
	function InputField.getAnchorSelectionSide(field)
		return (field.cursorPosition < field.selectionEnd and "end" or "start")
	end



	-- font = field:getFont( )
	function InputField.getFont(field)
		return field.font
	end

	-- field:setFont( font )
	-- The font is used for text measurements.
	function InputField.setFont(field, font)
		if field.font == font then  return  end

		if not font then  error("Missing font argument.", 2)  end

		field.font            = font
		field.lastWrappedText = "\0" -- Make sure wrappedText updates.

		limitScroll(field)
	end



	-- scrollX, scrollY = field:getScroll( )
	-- scrollX = field:getScrollX( )
	-- scrollY = field:getScrollY( )
	function InputField.getScroll(field)
		return field.scrollX, field.scrollY
	end
	function InputField.getScrollX(field)
		return field.scrollX
	end
	function InputField.getScrollY(field)
		return field.scrollY
	end

	-- field:setScroll( scrollX, scrollY )
	-- field:setScrollX( scrollX )
	-- field:setScrollY( scrollY )
	function InputField.setScroll(field, scrollX, scrollY)
		field.scrollX = scrollX
		field.scrollY = scrollY
		limitScroll(field)
	end
	function InputField.setScrollX(field, scrollX)
		field.scrollX = scrollX
		limitScroll(field)
	end
	function InputField.setScrollY(field, scrollY)
		field.scrollY = scrollY
		limitScroll(field)
	end

	-- scrolledX, scrolledY = field:scroll( deltaX, deltaY )
	-- Returned values are how much was actually scrolled.
	function InputField.scroll(field, dx, dy)
		local oldScrollX = field.scrollX
		local oldScrollY = field.scrollY
		field.scrollX    = oldScrollX + dx
		field.scrollY    = oldScrollY + dy

		limitScroll(field)

		return field.scrollX - oldScrollX,
		       field.scrollY - oldScrollY
	end

	-- field:scrollToCursor( )
	function InputField.scrollToCursor(field)
		local line, posOnLine, lineI = getLineInfoAtPosition(field, field.cursorPosition)

		do
			local fontH    = field.font:getHeight()
			local lineDist = math.ceil(fontH*field.font:getLineHeight())
			local y        = (lineI - 1) * lineDist
			field.scrollY  = clamp(field.scrollY, y-field.height+fontH, y)
		end

		if not field:isMultiline() then
			local visibleText = field:getVisibleText()
			local preText     = visibleText:sub(1, utf8GetEndOffset(visibleText, field.cursorPosition))
			local x           = field.font:getWidth(preText)
			field.scrollX     = clamp(field.scrollX, x-field.width, x)

		elseif field.type == "multinowrap" then
			local preText = line:sub(1, utf8GetEndOffset(line, posOnLine))
			local x       = field.font:getWidth(preText)
			field.scrollX = clamp(field.scrollX, x-field.width, x)
		end

		limitScroll(field)
	end



	-- limitX, limitY = field:getScrollLimits( )
	function InputField.getScrollLimits(field)
		updateWrap(field)

		local fontH    = field.font:getHeight()
		local lineDist = math.ceil(fontH*field.font:getLineHeight())

		return (field.type == "multiwrap") and 0 or math.max((field.wrappedWidth                   ) - field.width,  0),
		       (not field:isMultiline()  ) and 0 or math.max(((#field.wrappedText-1)*lineDist+fontH) - field.height, 0)
	end



	-- speedX, speedY = field:getMouseScrollSpeed( )
	-- speedX = field:getMouseScrollSpeedX( )
	-- speedY = field:getMouseScrollSpeedY( )
	function InputField.getMouseScrollSpeed(field)
		return field.mouseScrollSpeedX, field.mouseScrollSpeedY
	end
	function InputField.getMouseScrollSpeedX(field)
		return field.mouseScrollSpeedX
	end
	function InputField.getMouseScrollSpeedY(field)
		return field.mouseScrollSpeedY
	end

	--
	-- field:setMouseScrollSpeed( speedX [, speedY=speedX ] )
	-- field:setMouseScrollSpeedX( speedX )
	-- field:setMouseScrollSpeedY( speedY )
	--
	-- Also see setWheelScrollSpeed().
	--
	function InputField.setMouseScrollSpeed(field, speedX, speedY)
		speedY                  = speedY or speedX
		field.mouseScrollSpeedX = math.max(speedX, 0)
		field.mouseScrollSpeedY = math.max(speedY, 0)
	end
	function InputField.setMouseScrollSpeedX(field, speedX)
		field.mouseScrollSpeedX = math.max(speedX, 0)
	end
	function InputField.setMouseScrollSpeedY(field, speedY)
		field.mouseScrollSpeedY = math.max(speedY, 0)
	end



	-- speedX, speedY = field:getWheelScrollSpeed( )
	-- speedX = field:getWheelScrollSpeedX( )
	-- speedY = field:getWheelScrollSpeedY( )
	function InputField.getWheelScrollSpeed(field)
		return field.wheelScrollSpeedX, field.wheelScrollSpeedY
	end
	function InputField.getWheelScrollSpeedX(field)
		return field.wheelScrollSpeedX
	end
	function InputField.getWheelScrollSpeedY(field)
		return field.wheelScrollSpeedY
	end

	-- field:setWheelScrollSpeed( speedX [, speedY=speedX ] )
	-- field:setWheelScrollSpeedX( speedX )
	-- field:setWheelScrollSpeedY( speedY )
	function InputField.setWheelScrollSpeed(field, speedX, speedY)
		speedY                  = speedY or speedX
		field.wheelScrollSpeedX = math.max(speedX, 0)
		field.wheelScrollSpeedY = math.max(speedY, 0)
	end
	function InputField.setWheelScrollSpeedX(field, speedX)
		field.wheelScrollSpeedX = math.max(speedX, 0)
	end
	function InputField.setWheelScrollSpeedY(field, speedY)
		field.wheelScrollSpeedY = math.max(speedY, 0)
	end



	-- delay = field:getDoubleClickMaxDelay( )
	function InputField.getDoubleClickMaxDelay(field)
		return field.multiClickMaxDelay
	end

	-- field:setDoubleClickMaxDelay( delay )
	-- Note: This value is only used if the 'pressCount' argument isn't supplied to mousepressed().
	function InputField.setDoubleClickMaxDelay(field, delay)
		field.multiClickMaxDelay = math.max(delay, 0)
	end



	-- fromPosition, toPosition = field:getSelection( )
	-- Position 0 is before first character, position 1 is between first and second etc.
	function InputField.getSelection(field)
		return field.selectionStart, field.selectionEnd
	end

	-- field:setSelection( fromPosition, toPosition [, cursorAlign:TextCursorAlignment="right" ] )
	-- Position 0 is before first character, position 1 is between first and second etc.
	function InputField.setSelection(field, from, to, cursorAlign)
		finilizeHistoryGroup(field)

		local len = field:getTextLength()
		from = clamp(from, 0, len)
		to   = clamp(to,   0, len)

		from, to = math.min(from, to), math.max(from, to)

		field.selectionStart = from
		field.selectionEnd   = to
		field.cursorPosition = (cursorAlign == "left") and from or to

		field:resetBlinking()
		field:scrollToCursor()
	end

	-- field:selectAll( )
	function InputField.selectAll(field)
		field:setSelection(0, field:getTextLength())
	end

	-- text = field:getSelectedText( )
	function InputField.getSelectedText(field)
		local text = field.text
		return text:sub(
			utf8.offset(text, field.selectionStart+1),
			utf8GetEndOffset(text, field.selectionEnd)
		)
	end

	-- text = field:getSelectedVisibleText( )
	function InputField.getSelectedVisibleText(field)
		return (field.type == "password") and ("*"):rep(field.selectionEnd-field.selectionStart) or field:getSelectedText()
	end



	-- text = field:getText( )
	-- The text is the value of the field.
	-- Also see field:getVisibleText().
	function InputField.getText(field)
		return field.text
	end

	-- text = field:getVisibleText( )
	-- Returns asterisks for password fields instead of the actual text value.
	-- Also see field:getText().
	function InputField.getVisibleText(field)
		return (field.type == "password") and ("*"):rep(field:getTextLength()) or field.text -- @Speed: Maybe cache the repeated text.
	end

	-- field:setText( text )
	function InputField.setText(field, text)
		text = cleanString(field, tostring(text))
		if field.text == text then  return  end

		local len = utf8.len(text)

		field.text           = text
		field.cursorPosition = math.min(len, field.cursorPosition)
		field.selectionStart = math.min(len, field.selectionStart)
		field.selectionEnd   = math.min(len, field.selectionEnd)

		pushHistory(field, nil)
	end



	-- length = field:getTextLength( )
	-- Returns the number of characters in the UTF-8 text string.
	function InputField.getTextLength(field)
		return utf8.len(field.text)
	end



	-- offsetX, offsetY = field:getTextOffset( )
	-- Note: The coordinates are relative to the field's position.
	function InputField.getTextOffset(field)
		return -math.floor(field.scrollX),
		       -math.floor(field.scrollY)
	end



	-- x, y, height = field:getCursorLayout( )
	-- Note: The coordinates are relative to the field's position.
	function InputField.getCursorLayout(field)
		local line, posOnLine, lineI = getLineInfoAtPosition(field, field.cursorPosition)

		local preText  = line:sub(1, utf8GetEndOffset(line, posOnLine))
		local fontH    = field.font:getHeight()
		local lineDist = math.ceil(fontH*field.font:getLineHeight())

		return alignOnLine(field, line, field.font:getWidth(preText)) - math.floor(field.scrollX),
		       (lineI-1)*lineDist                                     - math.floor(field.scrollY),
		       fontH
	end



	-- width, height = field:getDimensions( )
	-- width  = field:getWidth( )
	-- height = field:getHeight( )
	function InputField.getDimensions(field)
		return field.width, field.height
	end
	function InputField.getWidth(field)
		return field.width
	end
	function InputField.getHeight(field)
		return field.height
	end

	-- field:setDimensions( width, height )
	-- field:setDimensions( nil, nil ) -- Disable scrolling on both axes.
	-- Enable/disable horizontal/vertical scrolling.
	function InputField.setDimensions(field, w, h)
		w = math.max((w or 1/0), 0)
		h = math.max((h or 1/0), 0)
		if field.width == w and field.height == h then  return  end

		field.width           = w
		field.height          = h
		field.lastWrappedText = "\0" -- Make sure wrappedText updates.

		limitScroll(field)
	end

	-- field:setWidth( width )
	-- field:setWidth( nil ) -- Disable scrolling on the x axis.
	-- Enable/disable horizontal scrolling.
	function InputField.setWidth(field, w)
		w = math.max((w or 1/0), 0)
		if field.width == w then  return  end

		field.width           = w
		field.lastWrappedText = "\0" -- Make sure wrappedText updates.

		limitScroll(field)
	end

	-- field:setHeight( height )
	-- field:setHeight( nil ) -- Disable scrolling on the y axis.
	-- Enable/disable vertical scrolling.
	function InputField.setHeight(field, h)
		h = math.max((h or 1/0), 0)
		if field.height == h then  return  end

		field.height = h -- Note: wrappedText does not need to update because of this change.

		limitScroll(field)
	end



	-- width, height = field:getTextDimensions( )
	function InputField.getTextDimensions(field)
		updateWrap(field)

		local fontH    = field.font:getHeight()
		local lineDist = math.ceil(fontH*field.font:getLineHeight())

		return field.wrappedWidth, (#field.wrappedText-1)*lineDist+fontH
	end

	-- width = field:getTextWidth( )
	function InputField.getTextWidth(field)
		updateWrap(field)
		return field.wrappedWidth
	end

	-- height = field:getTextHeight( )
	function InputField.getTextHeight(field)
		updateWrap(field)

		local fontH    = field.font:getHeight()
		local lineDist = math.ceil(fontH*field.font:getLineHeight())

		return (#field.wrappedText - 1) * lineDist + fontH
	end



	-- field:insert( text )
	-- Insert text at cursor, or replace selected text.
	function InputField.insert(field, newText)
		newText = cleanString(field, tostring(newText))

		local text     = field.text
		local selStart = field.selectionStart
		local iLeft    = utf8GetEndOffset(text, selStart)
		local iRight   = utf8.offset(text, field.selectionEnd+1)

		if newText == "" then
			field.text           = text:sub(1, iLeft) .. text:sub(iRight)
			field.cursorPosition = selStart
			field.selectionEnd   = selStart

			pushHistory(field, "remove")

		else
			field.text           = text:sub(1, iLeft) .. newText .. text:sub(iRight)
			field.cursorPosition = selStart + utf8.len(newText)
			field.selectionStart = field.cursorPosition
			field.selectionEnd   = field.cursorPosition

			pushHistory(field, "insert")
		end

		field:resetBlinking()
		field:scrollToCursor()
	end



	-- field:reset( [ initialText="" ] )
	function InputField.reset(field, text)
		field:releaseMouse()

		field.cursorPosition = 0
		field.selectionStart = 0
		field.selectionEnd   = 0

		field.clickCount               = 1
		field.multiClickExpirationTime = 0

		field.navigationTargetX = nil

		field:setText(text == nil and "" or text)
		field:clearHistory()
	end



	--
	-- bool = field:isFontFilteringActive( )
	-- field:setFontFilteringActive( bool )
	--
	-- Filter out characters that the font doesn't have glyphs for.
	--
	function InputField.isFontFilteringActive(field)          return field.fontFilteringIsActive   end
	function InputField.setFontFilteringActive(field, state)  field.fontFilteringIsActive = state  end

	-- bool = field:isEditable( )
	-- field:setEditable( bool )
	-- Enable/disable read-only mode.
	function InputField.isEditable(field)          return field.editingEnabled   end
	function InputField.setEditable(field, state)  field.editingEnabled = state  end



	-- type:InputFieldType = field:getType( )
	function InputField.getType(field)
		return field.type
	end

	-- field:setType( type:InputFieldType )
	function InputField.setType(field, fieldType)
		if field.type == fieldType then  return  end

		if not (fieldType == "normal" or fieldType == "password" or fieldType == "multiwrap" or fieldType == "multinowrap") then
			error("[InputField] Invalid field type '"..tostring(fieldType).."'.", 2)
		end

		local wasMultiline = field:isMultiline()

		field.type            = fieldType
		field.lastWrappedText = "\0" -- Make sure wrappedText updates.

		if wasMultiline and not field:isMultiline() then
			field:reset(cleanString(field, field.text)) -- Removes newlines (including from history).
		end
	end

	-- bool = field:isPassword( )
	-- bool = field:isMultiline( )
	function InputField.isPassword(field)   return field.type == "password"  end
	function InputField.isMultiline(field)  return field.type == "multiwrap" or field.type == "multinowrap"  end



	-- filterFunction = field:getFilter( )
	function InputField.getFilter(field)
		return field.filterFunction
	end

	--
	-- setFilter( filterFunction )
	-- setFilter( nil ) -- Remove filter.
	-- removeCharacter:bool = filterFunction( utf8Character )
	--
	-- Filter out entered characters.
	--
	-- Note: The filter is only applied in text input events, like textinput().
	-- Functions like setText() are unaffected (unlike with font filtering).
	--
	function InputField.setFilter(field, filterFunc)
		field.filterFunction = filterFunc
	end



	-- field:clearHistory( )
	function InputField.clearHistory(field)
		local history = field.editHistory

		history[1] = history[#history]
		for i = 2, #history do  history[i] = nil  end

		field.editHistoryGroup = nil
		field.editHistoryIndex = 1
	end



	-- maxHistory = field:getMaxHistory( )
	function InputField.getMaxHistory(field)
		return field.editHistoryMax
	end

	-- field:setMaxHistory( maxHistory )
	-- Limit entry count for the undo/redo history.
	function InputField.setMaxHistory(field, maxHistory)
		maxHistory = math.max(maxHistory, 1)
		if maxHistory == field.editHistoryMax then  return  end

		field:clearHistory()
		field.editHistoryMax = maxHistory
	end



	-- horizontally, vertically = field:canScroll( )
	-- Note: Scrolling is enabled/disabled by setDimensions() and company.
	function InputField.canScroll(field)
		return field:canScrollHorizontally(), field:canScrollVertically()
	end

	-- horizontally = field:canScrollHorizontally( )
	-- Note: Scrolling is enabled/disabled by setDimensions() or setWidth().
	function InputField.canScrollHorizontally(field)
		return field.type ~= "multiwrap"
	end

	-- vertically = field:canScrollVertically( )
	-- Note: Scrolling is enabled/disabled by setDimensions() or setHeight().
	function InputField.canScrollVertically(field)
		return field.type == "multiwrap" or field.type == "multinowrap"
	end



	-- horizontalOffset, horizontalCoverage, verticalOffset, verticalCoverage = field:getScrollHandles( )
	-- Values are between 0 and 1.
	function InputField.getScrollHandles(field)
		local textW,      textH      = field:getTextDimensions()
		local scrollX,    scrollY    = field:getScroll()
		local maxScrollX, maxScrollY = field:getScrollLimits()

		local hCoverage = math.min(field.width  / textW, 1)
		local vCoverage = math.min(field.height / textH, 1)
		local hOffset   = (maxScrollX == 0) and 0 or (scrollX / maxScrollX) * (1 - hCoverage)
		local vOffset   = (maxScrollY == 0) and 0 or (scrollY / maxScrollY) * (1 - vCoverage)

		return hOffset, hCoverage, vOffset, vCoverage
	end

	-- offset, coverage = field:getScrollHandleHorizontal( )
	-- The values (and their sum) are between 0 and 1.
	function InputField.getScrollHandleHorizontal(field)
		local hOffset, hCoverage, vOffset, vCoverage = field:getScrollHandles()
		return hOffset, hCoverage
	end

	-- offset, coverage = field:getScrollHandleVertical( )
	-- The values (and their sum) are between 0 and 1.
	function InputField.getScrollHandleVertical(field)
		local hOffset, hCoverage, vOffset, vCoverage = field:getScrollHandles()
		return vOffset, vCoverage
	end



	-- alignment:TextAlignment = field:getAlignment( )
	function InputField.getAlignment(field)
		return field.alignment
	end

	-- field:setAlignment( alignment:TextAlignment )
	-- Note: The field's width must be set for alignment to work. (See field:setDimensions() or field:setWidth().)
	-- Note: Alignment doesn't work for fields of type "multinowrap".
	function InputField.setAlignment(field, alignment)
		field.alignment = alignment
	end



	-- line = field:getVisibleLine( lineIndex )
	-- Returns nil if lineIndex is invalid.
	function InputField.getVisibleLine(field, lineI)
		updateWrap(field)
		return field.wrappedText[lineI]
	end

	-- count = field:getVisibleLineCount( )
	function InputField.getVisibleLineCount(field)
		updateWrap(field)
		return #field.wrappedText
	end



	--
	-- info = field:getInfoAtCoords( x, y [, info={} ] )
	--
	-- Info table fields:
	--   cursorPosition    -- integer  Cursor position.
	--   characterPosition -- integer  Character position. (Is set even if hasText is false.)
	--   hasText           -- boolean  Whether there's text directly at the coordinates.
	--   lineIndex         -- integer  Visible line index.
	--   linePosition      -- integer  Visible line start position.
	--
	-- Note: The coordinates must be relative to the field's position on the screen.
	--
	function InputField.getInfoAtCoords(field, x, y, info)
		updateWrap(field)

		info = info or {}

		if field.text == "" then
			info.cursorPosition    = 0
			info.characterPosition = 1
			info.hasText           = false
			info.lineIndex         = 1
			info.linePosition      = 1

		else
			local curPos, visualLineI, visualLineIUnclamped = getCursorPositionAtCoordinates(field, x+field.scrollX, y+field.scrollY)

			local line, curPosOnLine, lineI, linePos1, linePos2 = getLineInfoAtPosition(field, curPos)

			local preText              = line:sub(1, utf8GetEndOffset(line, curPosOnLine)) -- @Speed @Memory
			local preTextW             = field.font:getWidth(preText)
			local charStartIsLeftOfCur = (alignOnLine(field, line, preTextW-field.scrollX) <= x)
			local charPosOnLine        = clamp(curPosOnLine+(charStartIsLeftOfCur and 1 or 0), 1, linePos2-linePos1+1)

			if lineI > visualLineI then
				-- We're right before a soft wrap.
				line, posOnLine, lineI, linePos1, linePos2 = getLineInfoAtPosition(field, curPos-1)
				charPosOnLine                              = linePos2 - linePos1 + 1
			end

			local xInText = unalignOnLine(field, line, x+field.scrollX)

			info.cursorPosition    = curPos
			info.characterPosition = math.min(linePos1+charPosOnLine-1, utf8.len(field.text))
			info.hasText           = field.wrappedText[visualLineIUnclamped] ~= nil and xInText >= 0 and xInText < field.font:getWidth(line)
			info.lineIndex         = lineI
			info.linePosition      = linePos1
		end

		return info
	end

	--
	-- info = field:getInfoAtCursor( cursorPosition [, info={} ] )
	--
	-- Info table fields:
	--   x            -- integer  X position.
	--   y            -- integer  Y/top position.
	--   height       -- integer  Line height.
	--   lineIndex    -- integer  Visible line index.
	--   linePosition -- integer  Visible line start position.
	--
	-- Note: The coordinates are relative to the field's position.
	--
	function InputField.getInfoAtCursor(field, pos, info)
		updateWrap(field)

		info = info or {}

		if field.text == "" then
			info.x            = alignOnLine(field, "", 0)
			info.y            = 0
			info.height       = field.font:getHeight()
			info.lineIndex    = 1
			info.linePosition = 1

		else
			pos = clamp(pos, 0, utf8.len(field.text))

			local line, curPosOnLine, lineI, linePos1, linePos2 = getLineInfoAtPosition(field, pos)

			local savedCursorPosition = field.cursorPosition
			field.cursorPosition      = pos
			local x, y, h             = field:getCursorLayout()
			field.cursorPosition      = savedCursorPosition

			info.x            = x
			info.y            = y
			info.height       = h
			info.lineIndex    = lineI
			info.linePosition = linePos1
		end

		return info
	end

	--
	-- info = field:getInfoAtCharacter( characterPosition [, info={} ] )
	--
	-- Info table fields:
	--   character    -- string   The character (unobfuscated if field type is "password").
	--   x            -- integer  Character x/left position.
	--   y            -- integer  Character y/top position.
	--   width        -- integer  Character width.
	--   height       -- integer  Character/line height.
	--   lineIndex    -- integer  Visible line index.
	--   linePosition -- integer  Visible line start position.
	--
	-- Returns nil if characterPosition is invalid or points at a newline.
	-- Note: The coordinates are relative to the field's position.
	--
	function InputField.getInfoAtCharacter(field, pos, info)
		updateWrap(field)

		local text = field.text

		if
			text == "" or pos < 1 or pos > utf8.len(text) -- Error: Out-of-range!
			or utf8.codepoint(text, utf8.offset(text, pos)) == 10 -- Don't return info about newlines.
		then
			return nil
		end

		local line, curPosOnLine, lineI, linePos1, linePos2 = getLineInfoAtPosition(field, pos-1)

		local i1          = utf8.offset(line, curPosOnLine+1)
		local i2          = utf8GetEndOffset(line, curPosOnLine+1)
		local visibleChar = line:sub(i1, i2)

		local preText = line:sub(1, i1-1) -- @Speed @Memory
		local x       = alignOnLine(field, line, field.font:getWidth(preText))

		local fontH    = field.font:getHeight()
		local lineDist = math.ceil(fontH*field.font:getLineHeight())
		local y        = (lineI-1) * lineDist

		info              = info or {}
		info.character    = (field.type == "password") and text:sub(utf8.offset(text, pos), utf8GetEndOffset(text, pos)) or visibleChar
		info.x            = x
		info.y            = y
		info.width        = field.font:getWidth(visibleChar)
		info.height       = fontH
		info.lineIndex    = lineI
		info.linePosition = linePos1

		return info
	end



	----------------------------------------------------------------



	-- field:update( deltaTime )
	function InputField.update(field, dt)
		if field.dragMode ~= "" then
			local mx         = field.dragLastX
			local my         = field.dragLastY
			local oldScrollX = field.scrollX
			local oldScrollY = field.scrollY
			local scrollX    = oldScrollX
			local scrollY    = oldScrollY
			local w          = field.width
			local h          = field.height

			field.scrollX = (mx < 0 and scrollX+field.mouseScrollSpeedX*mx*dt) or (mx > w and scrollX+field.mouseScrollSpeedX*(mx-w)*dt) or (scrollX)
			field.scrollY = (my < 0 and scrollY+field.mouseScrollSpeedY*my*dt) or (my > h and scrollY+field.mouseScrollSpeedY*(my-h)*dt) or (scrollY)
			limitScroll(field)

			if not (field.scrollX == oldScrollX and field.scrollY == oldScrollY) then
				field:mousemoved(mx, my) -- This should only update selection stuff.
			end
		end
	end



	-- eventWasHandled = field:mousepressed( mouseX, mouseY, mouseButton [, pressCount=auto ] )
	-- Note: The coordinates must be relative to the field's position on the screen.
	function InputField.mousepressed(field, mx, my, mbutton, pressCount)
		if mbutton ~= 1 then  return false  end

		-- Check if double click.
		if mbutton == 1 then
			local time = LT.getTime()

			if pressCount then
				-- void
			elseif
				time < field.multiClickExpirationTime
				and math.abs(field.multiClickLastX-mx) <= 1 -- @Incomplete: Make max distance into a setting? Also, shoud we use max distance even if pressCount is supplied?
				and math.abs(field.multiClickLastY-my) <= 1
			then
				pressCount = field.clickCount + 1
			else
				pressCount = 1
			end

			field.clickCount               = (pressCount == 1) and 1 or 2+(pressCount%2)
			field.multiClickExpirationTime = time + field.multiClickMaxDelay
			field.multiClickLastX          = mx
			field.multiClickLastY          = my

		else
			field.clickCount               = 1
			field.multiClickExpirationTime = 0
		end

		-- Handle mouse press.
		local pos = getCursorPositionAtCoordinates(field, mx+field.scrollX, my+field.scrollY)

		if field.clickCount == 3 then
			local pos1 = getNextHardLineBound(field.text, pos+1, -1)
			local pos2 = getNextHardLineBound(field.text, pos1,   1)

			field:setSelection(pos1, pos2)

			field.dragMode           = "line"
			field.dragStartPosition1 = pos1
			field.dragStartPosition2 = pos2
			field.dragLastX          = mx
			field.dragLastY          = my

		elseif field.clickCount == 2 then
			local visibleText = field:getVisibleText()
			local pos1        = getNextWordBound(visibleText, pos+1, -1)
			local pos2        = getNextWordBound(visibleText, pos1,   1)

			field:setSelection(pos1, pos2)

			field.dragMode           = "word"
			field.dragStartPosition1 = pos1
			field.dragStartPosition2 = pos2
			field.dragLastX          = mx
			field.dragLastY          = my

		elseif LK.isDown("lshift","rshift") then
			local anchorPos = (field:getAnchorSelectionSide() == "start" and field.selectionStart or field.selectionEnd)

			field:setSelection(pos, anchorPos, (pos < anchorPos and "left" or "right"))

			field.dragMode           = "character"
			field.dragStartPosition1 = anchorPos
			field.dragLastX          = mx
			field.dragLastY          = my

		else
			setCursorPosition(field, pos, nil, true)

			field.dragMode           = "character"
			field.dragStartPosition1 = pos
			field.dragLastX          = mx
			field.dragLastY          = my
		end

		return true
	end

	-- eventWasHandled = field:mousemoved( mouseX, mouseY )
	-- Note: The coordinates must be relative to the field's position on the screen.
	function InputField.mousemoved(field, mx, my)
		if field.dragMode == "" then  return false  end

		local scrollX = field.scrollX
		local scrollY = field.scrollY
		local pos     = getCursorPositionAtCoordinates(field, mx+field.scrollX, my+field.scrollY)

		if field.dragMode == "line" then
			-- Note: Visibility doesn't matter when selecting lines.
			local pos1 = getNextHardLineBound(field.text, pos+1, -1)
			local pos2 = getNextHardLineBound(field.text, pos1,   1)

			if pos1 < field.dragStartPosition1 then
				field:setSelection(pos1, field.dragStartPosition2, "left")
			else
				field:setSelection(field.dragStartPosition1, pos2, "right")
			end

		elseif field.dragMode == "word" then
			local visibleText = field:getVisibleText()
			local pos1        = getNextWordBound(visibleText, pos+1, -1)
			local pos2        = getNextWordBound(visibleText, pos1,   1)

			if pos1 < field.dragStartPosition1 then
				field:setSelection(pos1, field.dragStartPosition2, "left")
			else
				field:setSelection(field.dragStartPosition1, pos2, "right")
			end

		else
			field:setSelection(field.dragStartPosition1, pos, (pos < field.dragStartPosition1 and "left" or "right"))
		end

		field.scrollX = scrollX -- Prevent scrolling to cursor while dragging.
		field.scrollY = scrollY

		field.dragLastX = mx
		field.dragLastY = my
		return true
	end

	-- eventWasHandled = field:mousereleased( mouseX, mouseY, mouseButton )
	-- Note: The coordinates must be relative to the field's position on the screen.
	function InputField.mousereleased(field, mx, my, mbutton)
		if mbutton ~= 1         then  return false  end
		if field.dragMode == "" then  return false  end

		field.dragMode = ""

		field:scrollToCursor()
		return true
	end

	-- eventWasHandled = field:wheelmoved( deltaX, deltaY )
	function InputField.wheelmoved(field, dx, dy)
		if LK.isDown("lshift","rshift") then
			dx, dy = dy, dx
		end

		if not ((dx ~= 0 and field:canScrollHorizontally()) or (dy ~= 0 and field:canScrollVertically())) then
			return false
		end

		local fontH = field.font:getHeight()
		local scrolledX, scrolledY = field:scroll(
			-dx * field.wheelScrollSpeedX*fontH,
			-dy * field.wheelScrollSpeedY*fontH
		)

		return scrolledX ~= 0 or scrolledY ~= 0
	end



	-- field:releaseMouse( )
	-- Release mouse buttons that are held down (i.e. stop drag-selecting).
	function InputField.releaseMouse(field)
		field.dragMode = ""
	end



	-- bool = field:isBusy( )
	-- Returns true if the user is currently drag-selecting.
	function InputField.isBusy(field)
		return field.dragMode ~= ""
	end



	local function action_moveCursorCharacterLeft(field, isRepeat)
		if field.selectionStart ~= field.selectionEnd then
			setCursorPosition(field, field.selectionStart, nil, true)
		else
			field:moveCursor(-1)
		end
		return true, false
	end
	local function action_moveCursorCharacterLeftAnchored(field, isRepeat)
		field:moveCursor(-1, field:getAnchorSelectionSide())
		return true, false
	end
	local function action_moveCursorWordLeft(field, isRepeat)
		setCursorPosition(field, getNextWordBound(field:getVisibleText(), field.cursorPosition, -1), nil, true)
		return true, false
	end
	local function action_moveCursorWordLeftAnchored(field, isRepeat)
		setCursorPosition(field, getNextWordBound(field:getVisibleText(), field.cursorPosition, -1), field:getAnchorSelectionSide(), true)
		return true, false
	end

	local function action_moveCursorCharacterRight(field, isRepeat)
		if field.selectionStart ~= field.selectionEnd then
			setCursorPosition(field, field.selectionEnd, nil, true)
		else
			field:moveCursor(1)
		end
		return true, false
	end
	local function action_moveCursorCharacterRightAnchored(field, isRepeat)
		field:moveCursor(1, field:getAnchorSelectionSide())
		return true, false
	end
	local function action_moveCursorWordRight(field, isRepeat)
		setCursorPosition(field, getNextWordBound(field:getVisibleText(), field.cursorPosition, 1), nil, true)
		return true, false
	end
	local function action_moveCursorWordRightAnchored(field, isRepeat)
		setCursorPosition(field, getNextWordBound(field:getVisibleText(), field.cursorPosition, 1), field:getAnchorSelectionSide(), true)
		return true, false
	end

	local function action_moveCursorLineStart(field, isRepeat)
		local line, posOnLine, lineI, linePos1, linePos2 = getLineInfoAtPosition(field, field.cursorPosition)
		if field.cursorPosition == linePos1-1 and field.softBreak[lineI-1] then
			line, posOnLine, lineI, linePos1, linePos2 = getLineInfoAtPosition(field, field.cursorPosition-1)
		end
		setCursorPosition(field, linePos1-1, nil, true)
		return true, false
	end
	local function action_moveCursorLineStartAnchored(field, isRepeat)
		local line, posOnLine, lineI, linePos1, linePos2 = getLineInfoAtPosition(field, field.cursorPosition)
		if field.cursorPosition == linePos1-1 and field.softBreak[lineI-1] then
			line, posOnLine, lineI, linePos1, linePos2 = getLineInfoAtPosition(field, field.cursorPosition-1)
		end
		setCursorPosition(field, linePos1-1, field:getAnchorSelectionSide(), true)
		return true, false
	end
	local function action_moveCursorDocumentStart(field, isRepeat)
		setCursorPosition(field, 0, nil, true)
		return true, false
	end
	local function action_moveCursorDocumentStartAnchored(field, isRepeat)
		setCursorPosition(field, 0, field:getAnchorSelectionSide(), true)
		return true, false
	end

	local function action_moveCursorLineEnd(field, isRepeat)
		local line, posOnLine, lineI, linePos1, linePos2 = getLineInfoAtPosition(field, field.cursorPosition)
		setCursorPosition(field, linePos2, nil, true)
		return true, false
	end
	local function action_moveCursorLineEndAnchored(field, isRepeat)
		local line, posOnLine, lineI, linePos1, linePos2 = getLineInfoAtPosition(field, field.cursorPosition)
		setCursorPosition(field, linePos2, field:getAnchorSelectionSide(), true)
		return true, false
	end
	local function action_moveCursorDocumentEnd(field, isRepeat)
		setCursorPosition(field, field:getTextLength(), nil, true)
		return true, false
	end
	local function action_moveCursorDocumentEndAnchored(field, isRepeat)
		setCursorPosition(field, field:getTextLength(), field:getAnchorSelectionSide(), true)
		return true, false
	end

	local function navigateByLine(field, dirY, doAnchor)
		if not field:isMultiline() then  return false  end

		local anchorSide = (doAnchor and field:getAnchorSelectionSide() or nil)

		-- Get info about the current line.
		local oldLine, oldPosOnLine, oldLineI, oldLinePos1, oldLinePos2 = getLineInfoAtPosition(field, field.cursorPosition)

		if dirY < 0 and oldLineI == 1 then
			-- setCursorPosition(field, 0, anchorSide, false) -- Eh, not sure it's good to navigate horizontally during vertical navigation.
			return true
		elseif dirY > 0 and oldLineI >= #field.wrappedText then
			-- setCursorPosition(field, utf8.len(field.text), anchorSide, false)
			return true
		end

		if not field.navigationTargetX then
			local linePart          = oldLine:sub(1, utf8GetEndOffset(oldLine, oldPosOnLine))
			field.navigationTargetX = alignOnLine(field, oldLine, field.font:getWidth(linePart))
		end

		-- Get info about the target line.
		local newLine, newPosOnLine, newLineI, newLinePos1, newLinePos2
		if dirY < 0 then
			newLine, newPosOnLine, newLineI, newLinePos1, newLinePos2 = getLineInfoAtPosition(field, oldLinePos1-2)
		else
			newLine, newPosOnLine, newLineI, newLinePos1, newLinePos2 = getLineInfoAtPosition(field, oldLinePos2+1)
		end

		local posOnLine = getCursorPositionAtX(field, newLine, field.navigationTargetX)

		-- Going from the end of a long line to the end of a short soft-wrapped line would put
		-- the cursor at the start of the previous long line or two lines down. No good!
		if field.softBreak[newLineI] and posOnLine == utf8.len(newLine) then
			posOnLine = posOnLine - 1
		end

		setCursorPosition(field, newLinePos1+posOnLine-1, anchorSide, false)
		return true
	end

	local function navigateByPage(field, dirY, doAnchor)
		local fontH      = field.font:getHeight()
		local lineDist   = math.ceil(fontH*field.font:getLineHeight())
		local walkCount  = math.max(math.floor(field.height/lineDist), 1)
		local anyHandled = false

		for i = 1, walkCount do
			local handled, _targetX = navigateByLine(field, dirY, doAnchor) -- @Speed @Memory
			if not handled then  break  end
			anyHandled = true
		end

		return anyHandled
	end

	local function action_moveCursorLineUp          (field, isRepeat)  return navigateByLine(field, -1, false), false  end
	local function action_moveCursorLineDown        (field, isRepeat)  return navigateByLine(field,  1, false), false  end
	local function action_moveCursorLineUpAnchored  (field, isRepeat)  return navigateByLine(field, -1, true ), false  end
	local function action_moveCursorLineDownAnchored(field, isRepeat)  return navigateByLine(field,  1, true ), false  end

	local function action_moveCursorPageUp          (field, isRepeat)  return navigateByPage(field, -1, false), false  end
	local function action_moveCursorPageDown        (field, isRepeat)  return navigateByPage(field,  1, false), false  end
	local function action_moveCursorPageUpAnchored  (field, isRepeat)  return navigateByPage(field, -1, true ), false  end
	local function action_moveCursorPageDownAnchored(field, isRepeat)  return navigateByPage(field,  1, true ), false  end

	local function action_insertNewline(field, isRepeat)
		if not field.editingEnabled then  return false, false  end
		if not field:isMultiline()  then  return false, false  end

		field:insert("\n")
		return true, true
	end

	local function action_deleteCharacterLeft(field, isRepeat)
		if not field.editingEnabled then
			return false, false

		elseif field.selectionStart ~= field.selectionEnd then
			-- void

		elseif field.cursorPosition == 0 then
			field:resetBlinking()
			field:scrollToCursor()
			return true, false

		else
			field.selectionStart = field.cursorPosition - 1
			field.selectionEnd   = field.cursorPosition
		end

		field:insert("")
		return true, true
	end
	local function action_deleteWordLeft(field, isRepeat)
		if not field.editingEnabled then
			return false, false
		elseif field.selectionStart ~= field.selectionEnd then
			-- void
		else
			field.cursorPosition = getNextWordBound(field:getVisibleText(), field.cursorPosition, -1)
			field.selectionStart = field.cursorPosition
		end
		field:insert("")
		return true, true
	end

	local function action_deleteCharacterRight(field, isRepeat)
		if not field.editingEnabled then
			return false, false

		elseif field.selectionStart ~= field.selectionEnd then
			-- void

		elseif field.cursorPosition == field:getTextLength() then
			field:resetBlinking()
			field:scrollToCursor()
			return true, false

		else
			field.selectionStart = field.cursorPosition
			field.selectionEnd   = field.cursorPosition + 1
		end

		field:insert("")
		return true, true
	end
	local function action_deleteWordRight(field, isRepeat)
		if not field.editingEnabled then
			return false, false
		elseif field.selectionStart ~= field.selectionEnd then
			-- void
		else
			field.cursorPosition = getNextWordBound(field:getVisibleText(), field.cursorPosition, 1)
			field.selectionEnd   = field.cursorPosition
		end
		field:insert("")
		return true, true
	end

	local function action_selectAll(field, isRepeat)
		field:selectAll()
		return true, false
	end

	local function action_copy(field, isRepeat)
		local text = field:getSelectedVisibleText()

		if text ~= "" then
			LS.setClipboardText(text)
			field:resetBlinking()
		end

		return true, false
	end

	local function action_cut(field, isRepeat)
		local text = field:getSelectedVisibleText()
		if text == "" then  return true, false  end

		LS.setClipboardText(text)

		if field.editingEnabled then
			field:insert("")
			return true, true
		else
			field:resetBlinking()
			return true, false
		end
	end

	local function action_paste(field, isRepeat)
		if not field.editingEnabled then  return false, false  end

		local text = cleanString(field, LS.getClipboardText())
		if text ~= "" then
			field:insert(applyFilter(field, text))
		end

		field:resetBlinking()
		return true, true
	end

	local function action_undo(field, isRepeat)
		if not field.editingEnabled then  return false, false  end

		-- @Robustness: Filter and/or font filter could have changed after the last edit.
		return true, (field.type ~= "password" and undoEdit(field))
	end
	local function action_redo(field, isRepeat)
		if not field.editingEnabled then  return false, false  end

		-- @Robustness: Filter and/or font filter could have changed after the last edit.
		return true, (field.type ~= "password" and redoEdit(field))
	end



	local keyHandlers = {
		[ "cas"]={}, [ "ca"]={}, [ "cs"]={}, [ "as"]={}, [ "c"]={}, [ "a"]={}, [ "s"]={}, [ ""]={},
		["^cas"]={}, ["^ca"]={}, ["^cs"]={}, ["^as"]={}, ["^c"]={}, ["^a"]={}, ["^s"]={}, ["^"]={}, -- macOS only.
	}

	local function bind(system, modKeys, key, action)
		if system == "all" or (system == "macos") == isMac then
			keyHandlers[modKeys][key] = action
		end
	end

	-- (Ctrl means Cmd and Alt means Option in macOS.)

	bind("all"    , ""   , "left"     , action_moveCursorCharacterLeft)
	bind("all"    , "s"  , "left"     , action_moveCursorCharacterLeftAnchored)
	bind("all"    , ""   , "right"    , action_moveCursorCharacterRight)
	bind("all"    , "s"  , "right"    , action_moveCursorCharacterRightAnchored)
	bind("macos"  , "^"  , "b"        , action_moveCursorCharacterLeft)
	bind("macos"  , "^"  , "f"        , action_moveCursorCharacterRight)

	bind("windows", "c"  , "left"     , action_moveCursorWordLeft)
	bind("windows", "cs" , "left"     , action_moveCursorWordLeftAnchored)
	bind("windows", "c"  , "right"    , action_moveCursorWordRight)
	bind("windows", "cs" , "right"    , action_moveCursorWordRightAnchored)
	bind("macos"  , "a"  , "left"     , action_moveCursorWordLeft)
	bind("macos"  , "as" , "left"     , action_moveCursorWordLeftAnchored)
	bind("macos"  , "a"  , "right"    , action_moveCursorWordRight)
	bind("macos"  , "as" , "right"    , action_moveCursorWordRightAnchored)

	bind("all"    , ""   , "home"     , action_moveCursorLineStart)
	bind("all"    , "s"  , "home"     , action_moveCursorLineStartAnchored)
	bind("all"    , ""   , "end"      , action_moveCursorLineEnd)
	bind("all"    , "s"  , "end"      , action_moveCursorLineEndAnchored)
	bind("macos"  , "c"  , "left"     , action_moveCursorLineStart)
	bind("macos"  , "cs" , "left"     , action_moveCursorLineStartAnchored)
	bind("macos"  , "c"  , "right"    , action_moveCursorLineEnd)
	bind("macos"  , "cs" , "right"    , action_moveCursorLineEndAnchored)

	bind("all"    , "c"  , "home"     , action_moveCursorDocumentStart)
	bind("all"    , "cs" , "home"     , action_moveCursorDocumentStartAnchored)
	bind("all"    , "c"  , "end"      , action_moveCursorDocumentEnd)
	bind("all"    , "cs" , "end"      , action_moveCursorDocumentEndAnchored)
	bind("macos"  , "c"  , "up"       , action_moveCursorDocumentStart)
	bind("macos"  , "cs" , "up"       , action_moveCursorDocumentStartAnchored)
	bind("macos"  , "c"  , "down"     , action_moveCursorDocumentEnd)
	bind("macos"  , "cs" , "down"     , action_moveCursorDocumentEndAnchored)

	bind("all"    , ""   , "up"       , action_moveCursorLineUp)
	bind("all"    , "s"  , "up"       , action_moveCursorLineUpAnchored)
	bind("all"    , ""   , "down"     , action_moveCursorLineDown)
	bind("all"    , "s"  , "down"     , action_moveCursorLineDownAnchored)

	bind("all"    , ""   , "pageup"   , action_moveCursorPageUp)
	bind("all"    , "s"  , "pageup"   , action_moveCursorPageUpAnchored)
	bind("all"    , ""   , "pagedown" , action_moveCursorPageDown)
	bind("all"    , "s"  , "pagedown" , action_moveCursorPageDownAnchored)

	bind("all"    , ""   , "return"   , action_insertNewline)
	bind("all"    , ""   , "kpenter"  , action_insertNewline)
	bind("macos"  , "^"  , "o"        , action_insertNewline)

	bind("all"    , ""   , "backspace", action_deleteCharacterLeft)
	bind("all"    , ""   , "delete"   , action_deleteCharacterRight)
	bind("macos"  , "^"  , "h"        , action_deleteCharacterLeft)
	bind("macos"  , "^"  , "d"        , action_deleteCharacterRight)

	bind("windows", "c"  , "backspace", action_deleteWordLeft)
	bind("windows", "c"  , "delete"   , action_deleteWordRight)
	bind("macos"  , "a"  , "backspace", action_deleteWordLeft)
	bind("macos"  , "a"  , "delete"   , action_deleteWordRight) -- Guessed macOS equivalent.  @Incomplete: Handle keyboards with no 'right-delete' key.

	bind("all"    , "c"  , "a"        , action_selectAll)

	bind("all"    , "c"  , "c"        , action_copy)
	bind("windows", "c"  , "insert"   , action_copy)

	bind("all"    , "c"  , "x"        , action_cut)
	bind("windows", "s"  , "delete"   , action_cut)

	bind("all"    , "c"  , "v"        , action_paste)
	bind("windows", "s"  , "insert"   , action_paste)
	bind("macos"  , "cas", "v"        , action_paste)

	bind("all"    , "c"  , "z"        , action_undo)
	bind("all"    , "cs" , "z"        , action_redo)
	bind("windows", "c"  , "y"        , action_redo)

	-- @Incomplete: Bind 'delete from line start'. windows=ctrl+shift+backspace
	-- @Incomplete: Bind 'delete to line end'. windows=ctrl+shift+delete



	-- eventWasHandled, textWasEdited = field:keypressed( key, isRepeat )
	function InputField.keypressed(field, key, isRepeat)
		if field.dragMode ~= "" then
			-- Escape while dragging: Stop dragging.
			if key == "escape" then  field:releaseMouse()  end

			return true, false
		end

		local keyHandler = keyHandlers[getModKeys()][key]

		if keyHandler then
			return keyHandler(field, isRepeat)
		else
			return false, false
		end
	end

	-- eventWasHandled, textWasEdited = field:textinput( text )
	function InputField.textinput(field, text)
		if field.dragMode ~= ""     then  return true, false  end
		if not field.editingEnabled then  return true, false  end
		field:insert(applyFilter(field, text))
		return true, true
	end



	local function nextLine(field, lineI)
		lineI      = lineI + 1
		local line = field.wrappedText[lineI]

		if not line then  return nil  end

		local fontH    = field.font:getHeight()
		local lineDist = math.ceil(fontH*field.font:getLineHeight())

		return lineI,
			line,
			alignOnLine(field, line, 0) - math.floor(field.scrollX),
			(lineI - 1) * lineDist      - math.floor(field.scrollY),
			field.font:getWidth(line),
			fontH
	end

	-- for index, line, lineX, lineY, lineWidth, lineHeight in field:eachVisibleLine( )
	-- Note: The coordinates are relative to the field's position.
	function InputField.eachVisibleLine(field)
		updateWrap(field)
		return nextLine, field, 0
	end



	local versionMajor, versionMinor = love.getVersion()
	local hasGetKerningMethod        = false--(versionMajor > 11) or (versionMajor == 11 and versionMinor >= 4)
	local cache                      = {}

	local getSelectionLayoutOnLine = (
		hasGetKerningMethod and function(font, line, posOnLine1, posOnLine2) -- Currently worse than the fallback!
			local pos    = 0
			local x      = 0
			local x1     = 0
			local lastCp = 0

			for _, cp in utf8Codes(line) do
				pos = pos + 1

				if lastCp > 0 then
					x = x + font:getKerning(lastCp, cp)
				end
				cache[cp] = cache[cp] or utf8.char(cp) ; x = x + font:getWidth(cache[cp]) -- Not sure if the cache is doing anything...
				-- x = x + font:getWidth(utf8.char(cp))

				if pos == posOnLine1-1 then
					x1 = x
				end
				if pos == posOnLine2 then
					return x1, x -- @Polish: Handle kerning on the right end of the selection.
				end

				lastCp = cp
			end

			return x, x
		end

		or function(font, line, posOnLine1, posOnLine2)
			local preText       = line:sub(1, utf8.offset     (line, posOnLine1)-1) -- @Speed @Memory
			local preAndMidText = line:sub(1, utf8GetEndOffset(line, posOnLine2)  ) -- @Speed @Memory
			local x1            = font:getWidth(preText)
			local x2            = font:getWidth(preAndMidText) -- @Polish: Handle kerning on the right end of the selection.
			return x1, x2
		end
	)

	local function nextSelection(selections, i)
		i          = i + 1
		local line = selections[3*i-2]

		if not line then  return nil  end

		local field = selections.field
		local font  = field.font

		local posOnLine1 = selections[3*i-1]
		local posOnLine2 = selections[3*i  ]
		local x1, x2     = getSelectionLayoutOnLine(font, line, posOnLine1, posOnLine2)

		local fontH    = font:getHeight()
		local lineDist = math.ceil(fontH*font:getLineHeight())

		if selections[3*(i+1)] then
			x2 = x2 + font:getWidth(" ")
			-- x2 = math.min(x2, field.width) -- Eh, this is a bad idea. Any scissoring should be done by the user.
		end

		return i,
			alignOnLine(field, line, x1)           - math.floor(field.scrollX),
			(selections.lineOffset + i) * lineDist - math.floor(field.scrollY),
			x2 - x1,
			fontH
	end

	local selectionsReused = {field=nil, lineOffset=0, --[[ line1, startPositionOnLine1, endPositionOnLine1, ... ]]}

	local function _eachSelection(field, selections)
		-- updateWrap(field) -- getLineInfoAtPosition() calls this.

		local startLine, startPosOnLine, startLineI, startLinePos1, startLinePos2 = getLineInfoAtPosition(field, field.selectionStart)
		local   endLine,   endPosOnLine,   endLineI,   endLinePos1,   endLinePos2 = getLineInfoAtPosition(field, field.selectionEnd)

		-- Note: We include selections that are empty.
		selections.field      = field
		selections.lineOffset = startLineI - 2

		if startLineI == endLineI then
			selections[1] = startLine
			selections[2] = startPosOnLine + 1
			selections[3] = endPosOnLine

		else
			selections[1] = startLine
			selections[2] = startPosOnLine + 1
			selections[3] = startLinePos2 - startLinePos1 + 1

			for lineI = startLineI+1, endLineI-1 do
				local line = field.wrappedText[lineI]
				table.insert(selections, line)
				table.insert(selections, 1)
				table.insert(selections, utf8.len(line))
			end

			table.insert(selections, endLine)
			table.insert(selections, 1)
			table.insert(selections, endPosOnLine)
		end

		return nextSelection, selections, 0
	end



	--
	-- for index, selectionX, selectionY, selectionWidth, selectionHeight in field:eachSelection( )
	-- for index, selectionX, selectionY, selectionWidth, selectionHeight in field:eachSelectionOptimized( )
	--
	-- Note: The coordinates are relative to the field's position.
	--
	-- Note: It's possible for the right side of selections to extend slightly
	-- past the specified width of the field in multi-line fields.
	--
	-- Warning: field:eachSelection() may chew through lots of memory if many
	-- lines are selected! Consider using field:eachSelectionOptimized() instead.
	--
	-- Warning: field:eachSelectionOptimized() must not be called recursively!
	--

	function InputField.eachSelection(field)
		if field.selectionStart == field.selectionEnd then  return noop  end

		return _eachSelection(field, {}) -- @Speed @Memory: Don't create a new table every call!
	end

	function InputField.eachSelectionOptimized(field)
		if field.selectionStart == field.selectionEnd then  return noop  end

		for i = 4, #selectionsReused do -- selectionsReused will always have at least 3 items, so just ignore them here.
			selectionsReused[i] = nil
		end

		return _eachSelection(field, selectionsReused)
	end



	--==============================================================
	--==============================================================
	--==============================================================

	return setmetatable(InputField, {

		-- InputField( [ initialText="", type:InputFieldType="normal" ] )
		__call = function(InputField, text, fieldType)
			return newInputField(text, fieldType)
		end,

	})

	--==============================================================
	--=
	--=  MIT License
	--=
	--=  Copyright © 2017-2022 Marcus 'ReFreezed' Thunström
	--=
	--=  Permission is hereby granted, free of charge, to any person obtaining a copy
	--=  of this software and associated documentation files (the "Software"), to deal
	--=  in the Software without restriction, including without limitation the rights
	--=  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	--=  copies of the Software, and to permit persons to whom the Software is
	--=  furnished to do so, subject to the following conditions:
	--=
	--=  The above copyright notice and this permission notice shall be included in all
	--=  copies or substantial portions of the Software.
	--=
	--=  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	--=  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	--=  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	--=  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	--=  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	--=  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	--=  SOFTWARE.
	--=
	--==============================================================

  end)()



local COLOR_WHITE             = {1,1,1,1}
local COLOR_TRANSPARENT_WHITE = {1,1,1,0}
local COLOR_TEXT              = {0x1b/255, 0x4d/255, 0x68/255} -- @Edit

local LCTRL = (love.system.getOS() == "OS X") and "lgui" or "lctrl"
local RCTRL = (love.system.getOS() == "OS X") and "rgui" or "rctrl"

local _M = { -- The module.
	_VERSION = "0.2.0",
}

local Gui = newClass("Gui", {
	VALUE_MASK_INT    =  "^%-?%d+$",       -- Integer.  @Revise these masks.
	VALUE_MASK_UINT   =  "^%d+$",          -- Unsigned integer.
	VALUE_MASK_FLOAT  =  "^%-?%d+%.?%d*$", -- Floating point number.
	VALUE_MASK_UFLOAT =  "^%d+%.?%d*$",    -- Unsigned floating point number.

	_allAnimations      = nil,
	_animationLockCount = 0,

	_font        = nil, -- May be overridden by individual leaves.
	_fontTooltip = nil,

	_defaultSounds = nil,
	_soundPlayer   = nil, -- soundPlayer = function( sound )

	_navigateSoundSuppressionLevel = 0,

	_scissorCoordsConverter = nil,
	_elementScissorIsSet    = false,

	_mouseX                 =  -999999,
	_mouseY                 =  -999999,
	_mouseFocus             = nil,
	_mouseFocusButtonStates = nil,
	_mouseIsGrabbed         = false,
	_currentMouseCursor     = nil,

	_keyboardFocus                = nil,
	_ignoreKeyboardInputThisFrame = false,

	_standardKeysAreActive        = false,
	_standardKeysAreActiveInMenus = true,

	_navigationTarget    = nil,
	_timeSinceNavigation = 0.0,
	_lockNavigation      = false, -- True when an input has keyboard focus.

	_scrollSpeedX     = 3.5,
	_scrollSpeedY     = 3.5,
	_scrollSmoothness = 60,

	_time           = 0.0,
	_tooltipTimer   = 0.0,
	_tooltipElement = nil,

	_tooltipDelay    = 0.15,
	_tooltipDuration = 10,

	_theme  = nil,
	_styles = nil,

	_root           = nil,
	_hoveredElement = nil,

	_lastAutomaticId = 0,

	_layoutNeedsUpdate = false,
	_isUpdatingLayout  = false,
	_layoutUpdateTime  = 0.00,

	_textPreprocessor = nil, -- newText       = function( text, element, mnemonicsAreEnabled )
	_spriteLoader     = nil, -- image, frames = function( spriteName )

	_culling = true, -- Affects scrollables and root.

	_triggerOnMousepressed = false,

	_heres = nil,

	debug = false,

	canScrollMeansSolid = true, -- @Edit
})

local Cs = {} -- gui element Classes.
local Is = {} -- gui element Includes.

local VALID_SOUND_KEYS = {
	-- Generic.
	["close"   ] = true, -- Usually containers, but any element can be a closable.
	["focus"   ] = true, -- Only used by Inputs so far.
	["type"    ] = true, -- Inputs (when entering text).
	["press"   ] = true, -- Buttons.
	["toggle"  ] = true, -- Buttons. Overrides/falls back to "press".
	["navigate"] = true, -- Widgets.
	["scroll"  ] = true, -- Containers.

	-- Element specific.
	["buttondown" ] = true,
	["inputsubmit"] = true,
	["inputrevert"] = true,
	["slidermove" ] = true,
}

local defaultTheme

local __LAMBDA1 = (function() local triggerIncludingAnimations ; local __func = function(innerEl)
	triggerIncludingAnimations(innerEl, "layout")
end ; return function(__triggerIncludingAnimations) triggerIncludingAnimations = __triggerIncludingAnimations ; return __func end end)()
local __LAMBDA2 = (function() local trigger, dt ; local __func = function(el)
	trigger(el, "update", dt)
end ; return function(__trigger, __dt) trigger, dt = __trigger, __dt ; return __func end end)()
local __STATIC1 = {}
local __STATIC2 = {}
local __STATIC3 = {}
local __STATIC4 = {}
local __STATIC5 = {}
local __STATIC6 = {}
local __STATIC7 = {}
local __STATIC8 = {}
local __STATIC9 = {}
local __STATIC10 = {}
local __STATIC11 = {}
local __LAMBDA3 = (function() local time ; local __func = function(el)
	el._timeBecomingVisible = time
end ; return function(__time) time = __time ; return __func end end)()
local __STATIC12 = {}
local __STATIC13 = {}
local __STATIC14 = {}
local __STATIC15 = {}
local __STATIC16 = {}
local __STATIC17 = {}
local __STATIC18 = {}



--==============================================================
--= Local functions ============================================
--==============================================================

local F = string.format



-- printf( formatString, ... )
local function printf(s, ...)
	print(F(s, ...))
end

-- printerr( depth, formatString, ... )
-- warn( depth, formatString, ... )
local function printerr(depth, s, ...)
	local time    = require"socket".gettime()
	local timeStr = os.date("%H:%M:%S", time)
	local msStr   = F("%.3f", time%1):sub(2)
	io.stderr:write(debug.traceback(F("[%s%s] Error: "..s, timeStr, msStr, ...), 1+depth), "\n")
end
local function warn(depth, s, ...)
	local time    = require"socket".gettime()
	local timeStr = os.date("%H:%M:%S", time)
	local msStr   = F("%.3f", time%1):sub(2)
	io.stderr:write(debug.traceback(F("[%s%s] Warning: "..s, timeStr, msStr, ...), 1+depth), "\n")
end



-- errorf( [ level=1, ] formatString, ... )
local function errorf(i, s, ...)
	if type(i) == "number" then
		error(F(s, ...), 1+i)
	else
		error(F(i, s, ...), 2)
	end
end

local function argerror(errLevel, argN, argName, v, ...)
	errorf(
		1+errLevel,
		"Bad argument #%d (%s) to '%s'. (Expected %s, got %s)",
		argN,
		argName,
		debug.getinfo(errLevel, "n").name or "?",
		table.concat({...}, " or "),
		type(v)
	)
end



-- class = newElementClass( abstract, className, parentClass|nil, includes, classTable, events )
local function newElementClass(abstract, className, parentClass, includes, classTable, events)
	classTable._abstract = abstract
	local class          = parentClass and parentClass:extend(className, classTable) or newClass(className, classTable)

	-- Include includes.
	for _, includeName in ipairs(includes) do
		for k, v in pairs(Is[includeName]) do
			if not (class[k] == nil) then  error((k))  end -- An include should only add new stuff to classes, not override anything.
			class[k] = v
		end
	end

	-- Register events.
	for i, event in ipairs(class._events) do
		table.insert(events, i, event)
	end
	for i, event in ipairs(events) do
		events[event] = true
	end
	class._events = events

	return class
end



local function applyStyle(elData, styleData)
	for i, childStyleData in ipairs(styleData) do
		if elData[i] == nil then
			error("Cannot apply style. (Missing children.)")
		end
		applyStyle(elData[i], childStyleData)
	end
	for k, v in pairs(styleData) do
		if elData[k] == nil then  elData[k] = v  end
	end
end



local function checkValidSoundKey(soundK, errLevel)
	if soundK == nil or VALID_SOUND_KEYS[soundK] then  return  end

	local keys = {}
	for soundK in pairs(VALID_SOUND_KEYS) do
		table.insert(keys, soundK)
	end
	table.sort(keys)

	errorf(1+errLevel, "Bad sound key '%s'. (Must be any of '%s'.)", soundK, table.concat(keys, "', '"))
end



-- @Memory: Don't use this, yo!
-- iterator, coroutine = newIteratorCoroutine( callback, argument1, ... )
local newIteratorCoroutine
do
	-- ... = coroutineIterator( coroutine )
	local function coroutineIterator(co)
		return select(2, assert(coroutine.resume(co)))
	end
	local function initiator(cb, ...)
		coroutine.yield()
		return cb(...)
	end
	function newIteratorCoroutine(cb, ...)
		local co = coroutine.create(initiator)
		coroutine.resume(co, cb, ...)
		return coroutineIterator, co
	end
end



-- x, y, width, height = xywhOnScreen( element ) -- @Cleanup: Use getLayoutOnScreen().
local function xywhOnScreen(el)
	local x, y = el:getPositionOnScreen()
	return x, y, el._layoutWidth, el._layoutHeight
end



-- drawImageScaled( image,quad , x,y, scaleX,scaleY )
-- drawImageScaled( image,nil  , x,y, scaleX,scaleY )
-- drawImageScaled( nil  ,image, x,y, scaleX,scaleY )
local function drawImageScaled(image,quadOrImage, x,y, sx,sy)
	if image and quadOrImage then
		love.graphics.draw(image,quadOrImage, x,y, 0, sx,sy)
	else
		love.graphics.draw((image or quadOrImage), x,y, 0, sx,sy)
	end
end

local tempQuad = love.graphics.newQuad(0,0, 1,1, 1,1)

-- drawImageLimited( image,quad , x,y, width,height, maxX,maxY )
-- drawImageLimited( image,nil  , x,y, width,height, maxX,maxY )
-- drawImageLimited( nil  ,image, x,y, width,height, maxX,maxY )
local function drawImageLimited(image,quadOrImage, x,y, w,h, maxX,maxY)
	if x+w < maxX and y+h < maxY then
		if image and quadOrImage then
			love.graphics.draw(image,quadOrImage, x,y)
		else
			love.graphics.draw((image or quadOrImage), x,y)
		end

	else
		local qx,qy, qw,qh, iw,ih

		if image and quadOrImage then
			iw, ih       = image:getDimensions()
			qx,qy, qw,qh = quadOrImage:getViewport()
		else
			image        = image or quadOrImage
			iw, ih       = image:getDimensions()
			qx,qy, qw,qh = 0,0, iw,ih
		end

		qw = math.min(qw, maxX-x)
		qh = math.min(qh, maxY-y)

		tempQuad:setViewport(qx,qy, qw,qh, iw,ih)
		love.graphics.draw(image,tempQuad, x,y)
	end
end



-- width, height = getTextDimensions( font, text, wrapLimit )
local function getTextDimensions(font, text, wrapLimit)
	local w, lines = font:getWrap(text, wrapLimit)
	local h        = font:getHeight()
	return w, h + math.floor(h*font:getLineHeight()) * (math.max(#lines, 1)-1)
end



-- elementType = getTypeFromElementData( elementData )
local function getTypeFromElementData(elData)
	if not elData.type and type(elData[1]) == "string" then
		elData.type = table.remove(elData, 1)
	end
	return elData.type
end



-- index|nil = indexOf( array, value )
-- index|nil = indexOf( container, element )
local function indexOf(arr, v)
	for i = 1, #arr do
		if arr[i] == v then  return i  end
	end
	return nil
end

-- index|nil = lastIndexOf( array, value )
local function lastIndexOf(arr, v)
	for i = #arr, 1, -1 do
		if arr[i] == v then  return i  end
	end
	return nil
end



-- for index, item in ipairsr( table )
local ipairsr
do
	local function iprev(arr, i)
		i       = i - 1
		local v = arr[i]
		if v ~= nil then  return i, v  end
	end
	function ipairsr(arr)
		return iprev, arr, #arr+1
	end
end



local function lerp(v1, v2, t)
	return v1 + (v2-v1) * t
end

local function damp(current, target, lambda, dt)
	-- http://www.rorydriscoll.com/2016/03/07/frame-rate-independent-damping-using-lerp/
	return lerp(current, target, 1-math.exp(-lambda*dt))
end



-- matches = matchAll( string, pattern )
local function matchAll(s, pat)
	local matches, i = {}, 0
	for match in s:gmatch(pat) do
		i = i+1
		matches[i] = match
	end
	return matches
end



-- sprite = newSprite( image, quad|frames|nil, errorLevel )
-- frames = { frame1, ... }
-- frame  = { duration=duration, quad=quad }
local function newSprite(image, framesOrQuad, errLevel)
	if not(type(image)=='userdata'and(image):typeOf"Image") then argerror(1+errLevel,1,"image",image,"Image") end
	if not((type(framesOrQuad)=='userdata'and(framesOrQuad):typeOf"Quad") or type(framesOrQuad)=="table" or framesOrQuad==nil) then argerror(1+errLevel,2,"framesOrQuad",framesOrQuad,"Quad","table","nil") end
	local frames

	if not framesOrQuad then
		local iw, ih = image:getDimensions()
		frames = {{duration=1/0, quad=love.graphics.newQuad(0, 0, iw, ih, iw, ih)}}

	elseif type(framesOrQuad) == "userdata" then
		frames = {{duration=1/0, quad=framesOrQuad}}

	else
		frames = framesOrQuad
		if not frames[1] then
			error("The frames table is empty. We need at least one frame!", 1+errLevel)
		end
		for i, frame in ipairs(frames) do
			if not frame.duration then  errorf(1+errLevel, "Frame %d is missing a duration.", i)  end
			if not frame.quad     then  errorf(1+errLevel, "Frame %d is missing a quad."    , i)  end
		end
	end

	local duration = 0
	for _, frame in ipairs(frames) do
		duration = duration + frame.duration
	end

	local _, _, iw, ih = frames[1].quad:getViewport()

	local sprite = {
		image        = image,

		frames       = frames,

		width        = iw,
		height       = ih,

		length       = #frames,
		duration     = duration,

		currentFrame = 1,
		currentTime  = 0.0,
	}

	return sprite
end

-- -- clone = cloneSprite( sprite, errorLevel )
-- local function cloneSprite(sprite, errLevel)
-- 	return (newSprite(sprite.image, sprite.frames, 1+errLevel))
-- end

-- image, quad, width, height = getCurrentViewOfSprite( sprite )
local function getCurrentViewOfSprite(sprite)
	local quad = sprite.frames[sprite.currentFrame].quad
	local _, _, w, h = quad:getViewport()
	return sprite.image, quad, w, h
end

-- updateSprite( sprite, deltaTime )
local function updateSprite(sprite, dt)
	if sprite.length == 1 then  return  end

	local frames = sprite.frames

	local i      = sprite.currentFrame
	local time   = sprite.currentTime + dt

	while time >= frames[i].duration do
		time = time - frames[i].duration
		i    = i % sprite.length + 1
	end

	sprite.currentFrame = i
	sprite.currentTime  = time
end



-- selectorPath = parseSelector( selector )
-- selector     = "elementType #id .tag" -- Sequence of space-separated element types, IDs and tags.
-- Returns nil if the selector is empty or invalid.
local parseSelector
do
	local selPathCache = {}

	function parseSelector(selector)
		local selPath = selPathCache[selector]
		if selPath then  return selPath  end

		selPath = {}

		for section in selector:gmatch"[^ ]+" do
			local selPathSection = {}
			local i = 1
			while true do

				local c = section:sub(i, i)
				if c == "" then
					break
				end

				local selPathSegment

				-- ID
				if c == "#" then
					local id
					id, i = section:match("^([^#.]+)()", i+1)
					if not id then
						printerr(1, "Bad format in selector at '%s'.", section:sub(i))
						return nil
					end
					selPathSegment = {type="id", value=id}

				-- Tag
				elseif c == "." then
					local tag
					tag, i = section:match("^([^#.]+)()", i+1)
					if not tag then
						printerr(1, "Bad format in selector at '%s'.", section:sub(i))
						return nil
					end
					selPathSegment = {type="tag", value=tag}

				-- Element type
				else
					local elType
					elType, i = section:match("^([^#.]+)()", i)
					if not elType then
						printerr(1, "Bad format in selector at '%s'.", section:sub(i))
						return nil
					elseif not Cs[elType] then
						printerr(1, "Unknown element type '%s' in selector.", elType)
						return nil
					end
					selPathSegment = {type="type", value=elType}

				end
				table.insert(selPathSection, selPathSegment)
			end
			table.insert(selPath, selPathSection)
		end

		if not selPath[1] then
			return nil -- The selector was either empty or filled with just spaces.
		end

		selPathCache[selector] = selPath

		return selPath
	end
end

-- result = isElementMatchingSelectorPath( element, selectorPath [, breakElement ] )
-- The path match checking loop breaks before reaching 'breakElement'.
local isElementMatchingSelectorPath
do
	local function isMatchingSection(el, selPathSection)
		for _, selPathSegment in ipairs(selPathSection) do
			-- ID
			if selPathSegment.type == "id" then
				if el._id ~= selPathSegment.value then  return false  end

			-- Tag
			elseif selPathSegment.type == "tag" then
				if not el:hasTag(selPathSegment.value) then  return false  end

			-- Element type
			else--if selPathSegment.type == "type" then
				if not el:isType(selPathSegment.value) then  return false  end
			end
		end

		return true
	end

	function isElementMatchingSelectorPath(el, selPath, breakElement)
		local i = #selPath

		local selPathSection = selPath[i]
		if not selPathSection then
			return false -- An empty path means nothing can match!
		end

		if el == breakElement then
			return false -- We got to the break point before matching the whole path.
		end
		if isMatchingSection(el, selPathSection) then
			i = i-1
			selPathSection = selPath[i]
			if not selPathSection then
				return true -- The whole path (with only one section) matched.
			end
		else
			return false -- The last section must match the specified element, but didn't.
		end

		for _, parent in el:parents() do
			if parent == breakElement then
				return false -- We got to the break point before matching the whole path.
			end
			if isMatchingSection(parent, selPathSection) then
				i = i-1
				selPathSection = selPath[i]
				if not selPathSection then
					return true -- The whole path matched.
				end
			end
		end

		return false -- We went through all parents without matching the whole path.
	end
end



--
-- playSoundFunction = prepareSound( element, soundKey )
--
-- Prepare a sound for being played. Useful if it's possible the element will
-- be removed in an event. Returns nil if no sound will be played.
--
local function prepareSound(el, soundK)
	local gui         = el._gui
	local soundPlayer = gui and gui._soundPlayer
	local sound       = soundPlayer and el:getResultingSound(soundK)

	return (sound ~= nil) and function()soundPlayer(sound)end or nil
end



-- text = preprocessText( gui, text, el, hasMnemonics )
local function preprocessText(gui, unprocessedText, el, hasMnemonics)
	if unprocessedText == "" then  return ""  end

	local preprocessor = gui._textPreprocessor
	if not preprocessor then  return unprocessedText  end

	local text = preprocessor(unprocessedText, el, hasMnemonics)
	if text == nil then  return unprocessedText  end

	return tostring(text)
end



local function printHere(el0)
	local ids = {}
	local el  = el0

	repeat
		if not el._automaticId then  table.insert(ids, 1, el._id)  end
		el = el._parent
	until not el

	ids[1] = ids[1] or el0:getPathDescription()
	print("[Gui] HERE:  "..table.concat(ids, "."))
	-- ids[1] = ids[1] or "~"
	-- printf("[Gui] HERE:  %s  (%s)", table.concat(ids, "."), el0:getPathDescription())
end

local function printHeres(gui)
	local heres = gui._heres
	for i, el in ipairs(heres) do
		printHere(el)
		heres[i] = nil
	end
end



-- class = requireElementClass( elementType, errorLevel )
local function requireElementClass(elType, level)
	return Cs[elType] or errorf(1+level, "Bad element type '%s'.", elType)
end



local function reverseArray(arr)
	local lenPlusOne = #arr + 1

	for i1 = 1, #arr/2 do
		local i2         = lenPlusOne - i1
		arr[i1], arr[i2] = arr[i2], arr[i1]
	end
end



-- integer = round( number )
local function round(n)
	return math.floor(n+0.5)
end



local function setMouseFocus(gui, mbutton, el)
	if gui._mouseFocus and el ~= gui._mouseFocus then
		printerr(1, "Changing mouse focus without blurring the old focus first.")
		gui._mouseFocusButtonStates[1] = false
		gui._mouseFocusButtonStates[2] = false
		gui._mouseFocusButtonStates[3] = false
	end

	gui._mouseFocus                      = el
	gui._mouseFocusButtonStates[mbutton] = true
	love.mouse.setGrabbed(true)
end

-- blurMouseFocus( gui, mbutton=all )
local function blurMouseFocus(gui, mbutton)
	if mbutton then
		gui._mouseFocusButtonStates[mbutton] = false
	else
		gui._mouseFocusButtonStates[1] = false
		gui._mouseFocusButtonStates[2] = false
		gui._mouseFocusButtonStates[3] = false
	end

	if not (gui._mouseFocusButtonStates[1] or gui._mouseFocusButtonStates[2] or gui._mouseFocusButtonStates[3]) then
		gui._mouseFocus = nil
		love.mouse.setGrabbed(gui._mouseIsGrabbed)
	end
end



local function setKeyboardFocus(gui, el)
	gui._keyboardFocus = el
end

local function blurKeyboardFocus(gui)
	gui._keyboardFocus = nil
end



-- setScissor( gui, x, y, width, height ) -- Push scissor.
-- setScissor( gui, nil ) -- Pop scissor.
-- Must be called twice - first with arguments, then without!
local function setScissor(gui, x, y, w, h)
	if not x then
		love.graphics.pop()
		return
	end

	local convert = gui._scissorCoordsConverter
	if convert then
		x, y, w, h = convert(x, y, w, h)
	end

	love.graphics.push("all")
	love.graphics.intersectScissor(x, y, math.max(w, 0), math.max(h, 0))
end

-- Note: Does not push or pop state like setScissor()!
local function intersectScissor(gui, x, y, w, h)
	local convert = gui._scissorCoordsConverter
	if convert then
		x, y, w, h = convert(x, y, w, h)
	end
	love.graphics.intersectScissor(x, y, w, h)
end



-- value1, ... = themeCallBack( gui, sectionKey, what, argument1, ... )
local function themeCallBack(gui, k, what, ...)
	local section = gui._theme and gui._theme[k]
	local cb      = (section and section[what] or defaultTheme[k][what]) or errorf(2, "Missing default theme callback for '%s.%s'.", k, what)
	return cb(...)
end

-- value = themeGet( gui, key )
local function themeGet(gui, k)
	local v = gui._theme and gui._theme[k]
	if v == nil then
		return defaultTheme[k]
	end
	return v
end

-- themeRenderOnScreen( element, what, x, y, w, h, extraArgument1, ... )
local function themeRenderOnScreen(el, what, x, y, w, h, ...)
	if w <= 0 or h <= 0 then  return  end

	love.graphics.push("all")
	love.graphics.translate(x, y)

	themeCallBack(el._gui, "draw", what, el, w, h, ...)
	el:unsetScissor() -- In case the theme set one but didn't unset it.

	love.graphics.pop()
end

-- themeRenderArea( element, what, areaX, areaY, areaWidth, areaHeight, extraArgument1, ... )
local function themeRenderArea(el, what, areaX, areaY, areaW, areaH, ...)
	local x = round(el:getXOnScreen()+areaX)
	local y = round(el:getYOnScreen()+areaY)
	return themeRenderOnScreen(el, what, x, y, areaW, areaH, ...)
end

-- themeRender( element, what, extraArgument1, ... )
local function themeRender(el, what, ...)
	return themeRenderArea(el, what, 0, 0, el._layoutWidth, el._layoutHeight, ...)
end

-- width, height = themeGetSize( element, what, extraArgument1, ... )
local function themeGetSize(el, what, ...)
	local w, h = themeCallBack(el._gui, "size", what, el, ...)
	if not (type(w) == "number" and type(h) == "number") then
		errorf(2, "Theme (or default theme) did not return width and height for '%s', instead we got: %s, %s", what, tostring(w), tostring(h))
	end
	return w, h
end



local function drawLayoutBackground(el)
	if el._background == "" then  return  end

	if el._gui.debug then
		setColor(.27, .27, .27, .86)
		love.graphics.rectangle("fill", xywhOnScreen(el))
	else
		themeRender(el, "background", el._background)
	end
end



-- value = trigger( element, event, value1, ... )
local function trigger(el, event, ...)
	local cb = el._callbacks and el._callbacks[event]
	if not cb then  return nil  end

	return (cb(el, event, ...))
end

-- value = triggerIncludingAnimations( element, event, value, ... )
local function triggerIncludingAnimations(el, event, ...)
	if el._animations then
		local time = el._gui._time

		for _, anim in ipairs(el._animations) do
			local cb = anim.callbacks[event]
			if cb then  cb(el, event, (time-anim.startTime)/anim.duration, ...)  end
		end
	end

	return (trigger(el, event, ...))
end



local function updateTooltip(gui, el)
	if el and el._tooltip == "" then
		el = nil
	end

	if el ~= gui._tooltipElement then
		if not (el and gui._tooltipElement and gui._tooltipTimer >= gui._tooltipDelay) then
			-- @UX: Don't reset tooltip time instantly - add a delay.
			gui._tooltipTimer = 0
		end
		gui._tooltipElement = el
	end
end

local function updateHoveredElement(gui)
	gui._hoveredElement = (gui._mouseX ~=  -999999) and gui:getElementAt(gui._mouseX, gui._mouseY, false) or nil
	updateTooltip(gui, gui._hoveredElement)
end

-- Removes current navigation target if it isn't a valid target anymore. Same with the tooltip element.
local function validateVariousCurrentElements(gui)
	if gui._navigationTarget and not gui:canNavigateTo(gui._navigationTarget) then
		gui:navigateTo(nil)
	end
	if gui._tooltipElement and not gui._tooltipElement:exists() then -- @Speed: We may be able to skip this if gui:navigateTo() is called here above because it probably calls updateTooltip().
		updateTooltip(gui, nil)
	end
end



local getTimerTime = nil

-- didUpdate = updateLayout( element )
local function updateLayout(el)
	-- Guard against accidental recursion (specifically the 'layout' event
	-- callback triggering an update... though maybe the 'layout' event is a
	-- bad idea to begin with... need to mention this in the docs).
	local gui = el._gui
	if gui._isUpdatingLayout then  return false  end -- The returned value is confusing here as we didn't update, but someone else is in the middle of it!

	local root = el:getRoot() -- @Temp
	-- local container = el -- @Incomplete @Speed: Maybe make any element able to update it's layout. (See comment below.)
	if root._hidden then
		gui._layoutNeedsUpdate = false
		return false
	end

	if gui.debug then
		print("Gui: Updating layout.")
	end
	gui._isUpdatingLayout = true

	getTimerTime = getTimerTime or (love.timer and love.timer.getTime) or (pcall(require, "socket") and require"socket".gettime) or os.clock
	local time   = getTimerTime()

	root:_calculateNaturalSize()

	--
	-- Note: This currently, most likely only works correctly if 'container'
	-- is the root. (I think we need to save the last values we use and know
	-- if the parent would change size if we changed size. All the extra work
	-- may be expensive and not worth it in the end. 2022-03-28)
	--
	root._layoutWidth  = root._width
	root._layoutHeight = root._height
	root:_expandAndPositionChildren()

	gui._layoutUpdateTime  = getTimerTime() - time -- We don't include the time the layout event takes.
	gui._layoutNeedsUpdate = false

	root:visitVisible(__LAMBDA1(triggerIncludingAnimations))

	updateHoveredElement(gui)

	gui._isUpdatingLayout = false
	if gui.debug then
		print("Gui: Finished updating layout.")
	end
	return true
end

-- didUpdate = updateLayoutIfNeeded( gui )
local function updateLayoutIfNeeded(gui)
	if not gui._layoutNeedsUpdate then  return false  end
	if gui._isUpdatingLayout      then  return false  end
	gui._layoutNeedsUpdate = false

	local root = gui._root
	if not root then  return false  end

	return (updateLayout(root))
end

local function scheduleLayoutUpdateIfDisplayed(el)
	local gui = el._gui
	if gui._layoutNeedsUpdate then  return  end
	if gui._isUpdatingLayout  then  return  end

	gui._layoutNeedsUpdate = el:isDisplayed()
	if gui.debug and gui._layoutNeedsUpdate then
		print("Gui: Scheduling layout update.")
	end
end



local function setVisualScroll(container, scrollX, scrollY)
	local dx = scrollX - container._visualScrollX
	local dy = scrollY - container._visualScrollY

	local didScroll = false

	if dx ~= 0 then
		container._visualScrollX = container._visualScrollX + dx
		didScroll                = true
	end

	if dy ~= 0 then
		container._visualScrollY = container._visualScrollY + dy
		didScroll                = true
	end

	if not didScroll then  return  end

	for el in container:traverse() do
		el._layoutOffsetX = el._layoutOffsetX + dx
		el._layoutOffsetY = el._layoutOffsetY + dy
	end

	updateHoveredElement(container._gui)
end



-- useColor( color [, alphaMultiplier=1 ] )
local function useColor(color, opacity)
	local r, g, b, a = unpack(color)
	if opacity then
		a = (a or 1) * opacity
	end
	setColor(r, g, b, a)
end



local function clamp(v, vMin, vMax)
	return math.max(math.min(v, vMax), vMin)
end

local function clamp01(v)
	return math.max(math.min(v, 1), 0)
end

local function clamp11(v)
	return math.max(math.min(v, 1), -1)
end



----------------------------------------------------------------
-- Layout functions.
----------------------------------------------------------------



local function calculateContainerChildNaturalSizes(container)
	for _, child in ipairs(container) do
		if not child._hidden then
			child:_calculateNaturalSize()
		end
	end
end



-- <see_return_statement> = barGetNaturalSizeValues( bar )
local function barGetNaturalSizeValues(bar)
	--[[ Examples how homogeneous+weight affect sizes:
	--------------------------------

	input  [A][B][CCCC]
	weight 1  1  2

	minw=3
	maxw=6

	output [A][B][CCCC]

	minw=3
	maxw=6

	A=1*minw
	B=1*minw
	C=2*minw

	--------------------------------

	input  [A][B][CCCC]
	weight 2  1  1

	minw=3
	maxw=6

	output [A~~~~~~~~~][B~~~][CCCC]

	minw=6
	maxw=12

	A=2*minw
	B=1*minw
	C=1*minw

	------------------------------]]

	local staticW, dynamicW, highestW, highestDynamicW = 0, 0, 0, 0 -- Note: highestDynamic* is weighted.
	local staticH, dynamicH, highestH, highestDynamicH = 0, 0, 0, 0

	local currentSpaceX = 0
	local currentSpaceY = 0
	local sumSpaceX     = 0
	local sumSpaceY     = 0
	local first         = true

	local totalWeight = 0

	local homogeneous = bar._homogeneous
	local max         = math.max

	for _, child in ipairs(bar) do
		if not (child._hidden or child._floating) then
			-- Dimensions.
			highestW = max(highestW, child._layoutWidth)
			highestH = max(highestH, child._layoutHeight)

			if child._weight == 0 then
				staticW = staticW + child._layoutWidth
				staticH = staticH + child._layoutHeight
			else
				if child:hasFixedWidth() and not homogeneous then
					staticW = staticW + child._width
				else
					dynamicW        = dynamicW + child._layoutWidth -- Includes relative size.
					highestDynamicW = max(highestDynamicW, child._layoutWidth/child._weight)
				end
				if child:hasFixedHeight() and not homogeneous then
					staticH = staticH + child._height
				else
					dynamicH        = dynamicH + child._layoutHeight -- Includes relative size.
					highestDynamicH = max(highestDynamicH, child._layoutHeight/child._weight)
				end
			end

			-- Spacing.
			if not first then
				currentSpaceX = max(currentSpaceX, child._spacingLeft)
				currentSpaceY = max(currentSpaceY, child._spacingTop )
			end
			sumSpaceX     = sumSpaceX + currentSpaceX
			sumSpaceY     = sumSpaceY + currentSpaceY
			currentSpaceX = child._spacingRight
			currentSpaceY = child._spacingBottom
			first         = false

			-- Weight.
			totalWeight = totalWeight + child._weight
		end
	end

	return staticW, dynamicW, highestW, highestDynamicW, sumSpaceX,
	       staticH, dynamicH, highestH, highestDynamicH, sumSpaceY,
	       totalWeight
end



local function updateContainerNaturalSize(container, contentW, contentH)
	container._contentWidth  = contentW
	container._contentHeight = contentH

	local w = container:hasFixedWidth () and container._width  or contentW+container:getInnerSpaceX()
	local h = container:hasFixedHeight() and container._height or contentH+container:getInnerSpaceY()

	w = math.max(w, container._minWidth )
	h = math.max(h, container._minHeight)

	if container._maxWidth  >= 0 then  w = math.min(w, container._maxWidth )  end
	if container._maxHeight >= 0 then  h = math.min(h, container._maxHeight)  end

	container._layoutWidth  = w
	container._layoutHeight = h
end

local function applySizeLimits(el, w, h)
	w = math.max(w, el._minWidth )
	h = math.max(h, el._minHeight)

	if el._maxWidth  >= 0 then  w = math.min(w, el._maxWidth )  end
	if el._maxHeight >= 0 then  h = math.min(h, el._maxHeight)  end

	return w, h
end

local function expandAndPositionFloatingElement(el, expansionW, expansionH)
	el._layoutWidth, el._layoutHeight = applySizeLimits(el
		, el:hasRelativeWidth()  and expansionW*el._relativeWidth  or el._layoutWidth
		, el:hasRelativeHeight() and expansionH*el._relativeHeight or el._layoutHeight
	)

	local parent = el._parent

	if parent then
		el._layoutX = round(0
			+ parent._layoutX
			+ parent._paddingLeft
			+ el._originX * (parent._layoutWidth - parent:getInnerSpaceX())
			+ el._x
			- el._anchorX * el._layoutWidth
		)
		el._layoutY = round(0
			+ parent._layoutY
			+ parent._paddingTop
			+ el._originY * (parent._layoutHeight - parent:getInnerSpaceY())
			+ el._y
			- el._anchorY * el._layoutHeight
		)
	end

	el:_expandAndPositionChildren()
end



--==============================================================
--= Library functions ==========================================
--==============================================================



-- quads = Gui.create9SliceQuads( image, leftColumnSize, topRowSize [, rightColumnSize=leftColumnSize, bottomRowSize=topRowSize ] )
-- quads = {
--     topLeftQuad,    topCenterQuad,    topRightQuad,
--     middleLeftQuad, middleCenterQuad, middleRightQuad,
--     bottomLeftQuad, bottomCenterQuad, bottomRightQuad,
-- }
function _M.create9SliceQuads(image, l, t, r, b)
	r = r or l
	b = b or t
	local iw, ih = image:getDimensions()
	return {
		love.graphics.newQuad(   0,    0,      l,      t, iw, ih),
		love.graphics.newQuad(   l,    0, iw-l-r,      t, iw, ih),
		love.graphics.newQuad(iw-r,    0,      r,      t, iw, ih),
		love.graphics.newQuad(   0,    t,      l, ih-t-b, iw, ih),
		love.graphics.newQuad(   l,    t, iw-l-r, ih-t-b, iw, ih),
		love.graphics.newQuad(iw-r,    t,      r, ih-t-b, iw, ih),
		love.graphics.newQuad(   0, ih-b,      l,      b, iw, ih),
		love.graphics.newQuad(   l, ih-b, iw-l-r,      b, iw, ih),
		love.graphics.newQuad(iw-r, ih-b,      r,      b, iw, ih),
	}
end



-- Gui.draw9SliceScaled(
--     x, y, width, height,
--     topLeftImage,    topCenterImage,    topRightImage,
--     middleLeftImage, middleCenterImage, middleRightImage,
--     bottomLeftImage, bottomCenterImage, bottomRightImage
-- )
-- Gui.draw9SliceScaled(
--     x, y, width, height, image,
--     topLeftQuad,    topCenterQuad,    topRightQuad,
--     middleLeftQuad, middleCenterQuad, middleRightQuad,
--     bottomLeftQuad, bottomCenterQuad, bottomRightQuad
-- )
function _M.draw9SliceScaled(x, y, w, h, image, obj11, obj12, obj13, obj21, obj22, obj23, obj31, obj32, obj33)
	if not obj33 then
		image, obj11, obj12, obj13, obj21, obj22, obj23, obj31, obj32, obj33 = nil,
		image, obj11, obj12, obj13, obj21, obj22, obj23, obj31, obj32
	end

	local t, l, r, b, sx, sy
	if image then
		local _, objW, objH
		_, _, l, objH = obj21:getViewport()
		_, _, r       = obj23:getViewport()
		_, _, objW, t = obj12:getViewport()
		_, _, _,    b = obj32:getViewport()
		sx = (w-l-r) / objW
		sy = (h-t-b) / objH
	else
		l  = obj21:getWidth()
		r  = obj23:getWidth()
		t  = obj12:getHeight()
		b  = obj32:getHeight()
		sx = (w-l-r) / obj12:getWidth()
		sy = (h-t-b) / obj21:getHeight()
	end

	love.graphics.push()
	love.graphics.translate(x, y)

	-- Fill.
	drawImageScaled(image, obj22, l, t, sx, sy)

	-- Sides.
	drawImageScaled(image, obj12,   l,   0, sx,  1)
	drawImageScaled(image, obj23, w-r,   t,  1, sy)
	drawImageScaled(image, obj32,   l, h-b, sx,  1)
	drawImageScaled(image, obj21,   0,   t,  1, sy)

	-- Corners.
	drawImageScaled(image, obj11,   0,   0,  1,  1)
	drawImageScaled(image, obj13, w-r,   0,  1,  1)
	drawImageScaled(image, obj31,   0, h-b,  1,  1)
	drawImageScaled(image, obj33, w-r, h-b,  1,  1)

	love.graphics.pop()
end

-- Gui.draw9SliceRepeated(
--     x, y, width, height,
--     topLeftImage,    topCenterImage,    topRightImage,
--     middleLeftImage, middleCenterImage, middleRightImage,
--     bottomLeftImage, bottomCenterImage, bottomRightImage
-- )
-- Gui.draw9SliceRepeated(
--     x, y, width, height, image,
--     topLeftQuad,    topCenterQuad,    topRightQuad,
--     middleLeftQuad, middleCenterQuad, middleRightQuad,
--     bottomLeftQuad, bottomCenterQuad, bottomRightQuad
-- )
function _M.draw9SliceRepeated(x, y, w, h, image, obj11, obj12, obj13, obj21, obj22, obj23, obj31, obj32, obj33)
	if not obj33 then
		image, obj11, obj12, obj13, obj21, obj22, obj23, obj31, obj32, obj33 = nil,
		image, obj11, obj12, obj13, obj21, obj22, obj23, obj31, obj32
	end

	local t, l, r, b, segW, segH
	if image then
		local _
		_, _, l   , t    = obj11:getViewport()
		_, _, r   , b    = obj33:getViewport()
		_, _, segW, segH = obj22:getViewport()
	else
		l   , t    = obj11:getDimensions()
		r   , b    = obj33:getDimensions()
		segW, segH = obj22:getDimensions()
	end

	love.graphics.push()
	love.graphics.translate(x, y)

	-- Fill.
	local maxX = w - r
	local maxY = h - b

	local segY = t
	while segY < maxY do
		local segX = l
		while segX < maxX do
			drawImageLimited(image,obj22, segX,segY, segW,segH, maxX,maxY)
			segX = segX + segW
		end
		segY = segY + segH
	end

	-- Sides: top and bottom.
	local segX = l
	while segX < maxX do
		drawImageLimited(image,obj12, segX,0  , segW,0, maxX,1/0)
		drawImageLimited(image,obj32, segX,h-t, segW,0, maxX,1/0)
		segX = segX + segW
	end

	-- Sides: left and right.
	local segY = t
	while segY < maxX do
		drawImageLimited(image,obj21, 0  ,segY, 0,segH, 1/0,maxY)
		drawImageLimited(image,obj23, w-l,segY, 0,segH, 1/0,maxY)
		segY = segY + segH
	end

	-- Corners.
	drawImageScaled(image, obj11,   0,   0, 1, 1)
	drawImageScaled(image, obj13, w-r,   0, 1, 1)
	drawImageScaled(image, obj31,   0, h-b, 1, 1)
	drawImageScaled(image, obj33, w-r, h-b, 1, 1)

	love.graphics.pop()
end



--
-- image     = Gui.newMonochromeImage( pixelRows [, red=1, green=1, blue=1 ] )
-- pixelRows = { pixelRow1, ... }
-- pixelRow: String with single-digit hexadecimal numbers representing alpha values. Invalid characters count as 0 (transparent).
--
-- Example:
--     blurryDiagonalLine = Gui.newMonochromeImage{
--         " 5F",
--         "5F5",
--         "F5 ",
--     }
--
function _M.newMonochromeImage(pixelRows, r, g, b)
	r = r or 1
	g = g or 1
	b = b or 1

	local imageData = love.image.newImageData(#pixelRows[1], #pixelRows)

	for row, pixelRow in ipairs(pixelRows) do
		for col = 1, #pixelRow do
			local pixel = tonumber(pixelRow:sub(col, col), 16) or 0
			imageData:setPixel(col-1, row-1, r, g, b, pixel/15) -- @Speed
		end
	end

	return love.graphics.newImage(imageData)
end

--
-- image     = Gui.newImageUsingPalette( pixelRows, palette )
-- pixelRows = { pixelRow1, ... }
-- pixelRow: String with single-character palette indices. Invalid indices count as transparent white pixels.
-- palette   = { ["index"]=color, ... }
-- color     = { red, green, blue [, alpha=1 ] }
--
-- Example:
--     doubleWideRainbow = Gui.newImageUsingPalette(
--         {
--             "rygcbp",
--             "rygcbp",
--         },
--         {
--             ["r"] = {1,0,0}, -- red
--             ["y"] = {1,1,0}, -- yellow
--             ["g"] = {0,1,0}, -- green
--             ["c"] = {0,1,1}, -- cyan
--             ["b"] = {0,0,1}, -- blue
--             ["p"] = {1,0,1}, -- purple
--         }
--     )
--
function _M.newImageUsingPalette(pixelRows, palette)
	local imageData = love.image.newImageData(#pixelRows[1], #pixelRows)

	for row, pixelRow in ipairs(pixelRows) do
		for col = 1, #pixelRow do
			local pixel      = (palette[pixelRow:sub(col, col)] or COLOR_TRANSPARENT_WHITE)
			local r, g, b, a = unpack(pixel)
			imageData:setPixel(col-1, row-1, r, g, b, (a or 1)) -- @Speed
		end
	end

	return love.graphics.newImage(imageData)
end



-- target, event  = Gui.parseTargetAndEvent( targetAndEvent )
-- targetAndEvent = "ID.subID.anotherSubID.event" -- Sequence of dot-separated IDs followed by a dot and an event name.
-- Returns nil and a message on error.
function _M.parseTargetAndEvent(targetAndEvent)
	local target, event = targetAndEvent:match"^(.-)%.?([^.]+)$" -- @Revise
	if not target then
		return nil, F("Bad targetAndEvent format '%s'.", targetAndEvent)
	end
	return target, event
end



-- value = Gui.lerp( value1, value2, t )
-- Linear interpolation.
_M.lerp = lerp

-- r, g, b    = Gui.lerpColor( r1,g1,b1,    r2,g2,b2,    t )
-- r, g, b, a = Gui.lerpColor( r1,g1,b1,a1, r2,g2,b2,a2, t )
-- Linear interpolation for color components.
function _M.lerpColor(r1,g1,b1,a1, r2,g2,b2,a2, t)
	if a2 then
		return lerp(r1, r2, t), lerp(g1, g2, t), lerp(b1, b2, t), lerp(a1, a2, t)
	else
		r2,g2,b2, t = a1, r2,g2,b2
		return lerp(r1, r2, t), lerp(g1, g2, t), lerp(b1, b2, t)
	end
end

-- value = Gui.damp( currentValue, targetValue, lambda, deltaTime )
-- Make a value decelerate / move towards another value over an infinite amount of time.
-- Higher lambda values means the movement takes longer.
-- lambda=0 means no interpolation (i.e. reach target immediately).
-- Example: newX = Gui.damp(lastX, targetX, 100, dt)
_M.damp = damp

-- value = Gui.remap( value, fromLow,fromHigh, toLow,toHigh )
-- Remap a value from one range to another.
function _M.remap(v, from1,from2, to1,to2)
	return lerp(to1, to2, (v-from1)/(from2-from1))
end



-- Gui.setColor( red, green, blue [, alpha=1 ] )
-- Set the current color in LÖVE. Color component values are within the range of 0 to 1 (even in LÖVE versions prior to 11.0).
_M.setColor = setColor



-- value = Gui.clamp( value, min, max )
-- Clamp a value between two other values.
_M.clamp = clamp

-- value = Gui.clamp01( value )
-- Clamp a value between 0 and 1.
_M.clamp01 = clamp01

-- value = Gui.clamp11( value )
-- Clamp a value between -1 and +1.
_M.clamp11 = clamp11



local defaultFont = nil

-- font = Gui.getDefaultFont()
function _M.getDefaultFont()
	defaultFont = defaultFont or love.graphics.newFont(12)
	return defaultFont
end



--==============================================================
--= GUI class ==================================================
--==============================================================



-- Gui( )
function Gui.init(gui)
	gui._allAnimations = {}
	gui._defaultSounds = {}
	gui._heres         = {}

	gui._soundPlayer = love.audio.play

	gui._mouseFocusButtonStates = {false, false, false} -- We only handle mouse button 1-3.

	gui._styles = {
		["_MENU"] = {},
	}
end



-- gui:update( deltaTime )
function Gui.update(gui, dt)
	local time               = gui._time + dt
	gui._time                = time
	gui._tooltipTimer        = gui._tooltipTimer + dt
	gui._timeSinceNavigation = gui._timeSinceNavigation + dt

	local allAnims = gui._allAnimations

	if allAnims[1] then
		for iInAllAnims, anim in ipairsr(allAnims) do
			local el = anim.element

			if time >= anim.endTime then
				local cb = anim.callbacks["update"]
				if cb then  cb(el, "update", 1)  end -- Make sure 'update' gets progress=1.

				cb = anim.callbacks["done"]
				if cb then  cb(el, "done")  end

				local anims = el._animations       or error("Internal error: Element has an animation but has no animation table.")
				local i     = indexOf(anims, anim) or error("Internal error: Element is part of an animation that is not in its animation table.")

				table.remove(allAnims, iInAllAnims)
				table.remove(anims   , i          )

				if anim.lockInteraction then
					gui._animationLockCount = gui._animationLockCount-1
				end

			else
				local cb = anim.callbacks["update"]
				if cb then
					cb(el, "update", (time-anim.startTime)/anim.duration)
				end
			end
		end

		if gui._animationLockCount == 0 then
			updateHoveredElement(gui)
		end
	end

	if gui._root then
		gui._root:_update(dt)

		if gui._root:isVisible() then
			trigger(gui._root, "update", dt)

			gui._root:visitVisible(__LAMBDA2(trigger, dt))
		end
	end

	-- The navigation target has a special additional update event.
	local nav = gui._navigationTarget
	if nav then  trigger(nav, "navupdate", dt)  end

	-- Check if mouse is inside window.
	if gui._mouseX ~=  -999999 and not love.window.hasMouseFocus() then
		gui:mousemoved( -999999,  -999999, 0, 0)
	end

	--
	-- Update mouse cursor.
	--
	local el  = gui._mouseFocus or gui._hoveredElement
	local cur = el and el:getResultingMouseCursor()

	if gui._currentMouseCursor ~= cur then
		gui._currentMouseCursor = cur
		love.mouse.setCursor(cur)
	end

	gui._ignoreKeyboardInputThisFrame = false
end



-- gui:draw( )
function Gui.draw(gui)
	if not gui._root or gui._root._hidden then  return  end

	updateLayoutIfNeeded(gui)

	--
	-- Prepare navigation target. @Speed
	--
	local childToDrawNavTargetAfter = gui._navigationTarget

	if childToDrawNavTargetAfter then  while childToDrawNavTargetAfter._parent do
		local parent = childToDrawNavTargetAfter._parent

		-- Draw at the current floating element. (All children of non-bar containers are floating.)
		if not parent:is(Cs.bar) then
			break

		else
			-- Draw before the next floating sibling if there are any. Hopefully the user
			-- has placed all significant floating elements high up in the tree and not
			-- inside non-floating wrappers!
			for i = childToDrawNavTargetAfter:getIndex()+1, #parent do
				if parent[i]._floating then
					childToDrawNavTargetAfter = parent[i-1]
					break
				end
			end

			-- Confine to scrollable area.
			if parent:canScrollAny() then
				childToDrawNavTargetAfter = parent[#parent]
				break
			end
		end

		childToDrawNavTargetAfter = parent
	end end

	--
	-- Draw stuff.
	--
	local cullX1, cullY1, cullX2, cullY2
	if gui._culling then
		local rootX, rootY, rootW, rootH = gui._root:getLayout()
		cullX1 = rootX
		cullY1 = rootY
		cullX2 = rootX + rootW
		cullY2 = rootY + rootH
	else
		cullX1 = -1/0
		cullY1 = -1/0
		cullX2 = 1/0
		cullY2 = 1/0
	end

	gui._root:_draw(cullX1, cullY1, cullX2, cullY2, childToDrawNavTargetAfter)

	if gui._tooltipElement then
		if gui._mouseFocus then
			gui._tooltipElement = nil
		else
			gui._tooltipElement:_drawTooltip()
		end
	end
end



-- handled = gui:keypressed( key, scancode, isRepeat )
function Gui.keypressed(gui, key, scancode, isRepeat)
	if type(key)~="string" then argerror(2,1,"key",key,"string") end
	if type(scancode)~="string" then argerror(2,2,"scancode",scancode,"string") end
	if type(isRepeat)~="boolean" then argerror(2,3,"isRepeat",isRepeat,"boolean") end

	if gui._ignoreKeyboardInputThisFrame then  return true  end
	if gui._animationLockCount > 0       then  return true  end

	do
		local focus = gui._keyboardFocus or gui._mouseFocus
		local el    = focus or gui._hoveredElement or gui._navigationTarget or gui:getInputCapturingElement(true) or gui._root

		if el then
			if focus then
				if trigger(focus,     "keypressed", key, scancode, isRepeat) then  return true  end -- The focus has exclusive rights to the event. No bubbling!
			else
				if el:triggerBubbling("keypressed", key, scancode, isRepeat) then  return true  end
			end

			local handled, grabKbFocus = el:_keypressed(key, scancode, isRepeat) -- @Cleanup: I don't think grabKbFocus is ever true.

			if handled then
				if grabKbFocus then  setKeyboardFocus(gui, el)  end
				return true
			end
		end

		if focus then  return true  end
	end

	if gui._standardKeysAreActive then
		local navTarget = gui._navigationTarget

		if key == "left" then
			if navTarget and navTarget:is(Cs.slider) and not navTarget._vertical then
				navTarget:decrease()
			else
				gui:navigate(3.1415926535898)
			end
			return true

		elseif key == "right" then
			if navTarget and navTarget:is(Cs.slider) and not navTarget._vertical then
				navTarget:increase()
			else
				gui:navigate(0)
			end
			return true

		elseif key == "up" then
			if navTarget and navTarget:is(Cs.slider) and navTarget._vertical then
				navTarget:increase()
			else
				gui:navigate( -1.5707963267949)
			end
			return true

		elseif key == "down" then
			if navTarget and navTarget:is(Cs.slider) and navTarget._vertical then
				navTarget:decrease()
			else
				gui:navigate(1.5707963267949)
			end
			return true

		elseif key == "tab" then
			if love.keyboard.isDown("lshift","rshift") then
				gui:navigateToPrevious()
			else
				gui:navigateToNext()
			end
			return true

		elseif key == "return" or key == "kpenter" then
			if isRepeat and navTarget and navTarget._active and navTarget:is(Cs.input) then
				-- Prevent input focus right after submission.
				return true
			end
			if gui:ok() then  return true  end

		elseif key == "escape" then
			if gui:back() then  return true  end
		end
	end

	local root = gui._root

	if root and not root._hidden then
		local elToClose = nil

		for _, el in ipairs(root:_collectVisibleUntilInputCapture(__STATIC1)) do
			if key == "escape" and el:canClose() then
				elToClose = el
				break
			elseif el._captureInput then
				return true
			elseif el._captureGuiInput then
				break
			end
		end

		if elToClose then
			elToClose:close()
			return true
		end
	end

	return false
end

-- handled = gui:keyreleased( key, scancode )
function Gui.keyreleased(gui, key, scancode)
	if type(key)~="string" then argerror(2,1,"key",key,"string") end
	if type(scancode)~="string" then argerror(2,2,"scancode",scancode,"string") end

	if gui._keyboardFocus then
		gui._keyboardFocus:_keyreleased(key, scancode)
		return true
	end

	return false
end

-- handled = gui:textinput( text )
function Gui.textinput(gui, text)
	if type(text)~="string" then argerror(2,1,"text",text,"string") end

	if gui._ignoreKeyboardInputThisFrame then  return true  end
	if gui._animationLockCount > 0       then  return true  end

	do
		local focus = gui._keyboardFocus or gui._mouseFocus
		local el    = focus or gui._hoveredElement or gui._navigationTarget or gui:getInputCapturingElement(true) or gui._root

		if el then
			if not focus and el:triggerBubbling("textinput", text) then  return true  end -- Should there not be an event if there is focus? @Revise

			if el:_textinput(text) then  return true  end
		end

		if focus then  return true  end
	end

	local root = gui._root

	if root and not root._hidden then
		for _, el in ipairs(root:_collectVisibleUntilInputCapture(__STATIC2)) do
			if el._captureInput    then  return true  end
			if el._captureGuiInput then  break        end
		end
	end

	return false
end



-- handled = gui:mousepressed( mouseX, mouseY, mouseButton, pressCount )
function Gui.mousepressed(gui, mx, my, mbutton, pressCount)
	if type(mx)~="number" then argerror(2,1,"mx",mx,"number") end
	if type(my)~="number" then argerror(2,2,"my",my,"number") end
	if type(mbutton)~="number" then argerror(2,3,"mbutton",mbutton,"number") end
	if type(pressCount)~="number" then argerror(2,4,"pressCount",pressCount,"number") end
	if mbutton > 3 then  return false  end

	gui._mouseX = mx
	gui._mouseY = my

	if gui._animationLockCount > 0 then  return true  end

	if gui._mouseFocusButtonStates[mbutton] then
		-- The mouse button got pressed twice or more with no release inbetween.
		-- Should be an error, but it's not really an issue.
		return true
	end

	updateLayoutIfNeeded(gui) -- Updates hovered element.

	local mouseFocus = gui._mouseFocus
	local currentEl  = mouseFocus or gui._hoveredElement

	if gui._keyboardFocus and currentEl ~= gui._keyboardFocus then
		gui._keyboardFocus:blur() -- We assume this is a GuiInput. @Volatile
	end

	while currentEl do
		-- Trigger any custom mousepressed event handler.
		-- Returning true from the handler suppresses the default behavior.
		local screenX, screenY = currentEl:getPositionOnScreen()
		if currentEl:trigger("mousepressed", mx-screenX, my-screenY, mbutton, pressCount) then
			return true
		end

		-- Trigger the internal mousepressed event handler.
		local handled, grabMouseFocus = currentEl:_mousepressed(mx, my, mbutton, pressCount)
		if handled then
			if grabMouseFocus then  setMouseFocus(gui, mbutton, currentEl)  end
			return true
		end

		if mouseFocus or currentEl._captureInput or currentEl._captureGuiInput or currentEl:isSolid() then
			return true
		end

		currentEl = currentEl._parent
	end

	return false
end

-- handled = gui:mousemoved( mouseX, mouseY, deltaX, deltaY )
function Gui.mousemoved(gui, mx, my, dx, dy)
	if type(mx)~="number" then argerror(2,1,"mx",mx,"number") end
	if type(my)~="number" then argerror(2,2,"my",my,"number") end
	if type(dx)~="number" then argerror(2,3,"dx",dx,"number") end
	if type(dy)~="number" then argerror(2,4,"dy",dy,"number") end

	gui._mouseX = mx
	gui._mouseY = my

	if gui._animationLockCount > 0 then  return true  end

	if not updateLayoutIfNeeded(gui) then
		updateHoveredElement(gui) -- Make sure hovered element updates whenever mouse moves.
	end

	local mouseFocus = gui._mouseFocus
	if not mouseFocus then  return false  end

	local el = (mx and mouseFocus or gui._hoveredElement)
	if el then
		el:_mousemoved(mx, my, dx, dy)
		trigger(el, "mousemoved", mx-el:getXOnScreen(), my-el:getYOnScreen(), dx, dy)
	end

	return true
end

-- handled = gui:mousereleased( mouseX, mouseY, mouseButton, pressCount )
function Gui.mousereleased(gui, mx, my, mbutton, pressCount)
	if type(mx)~="number" then argerror(2,1,"mx",mx,"number") end
	if type(my)~="number" then argerror(2,2,"my",my,"number") end
	if type(mbutton)~="number" then argerror(2,3,"mbutton",mbutton,"number") end
	if type(pressCount)~="number" then argerror(2,4,"pressCount",pressCount,"number") end
	if mbutton > 3 then  return false  end

	gui._mouseX = mx
	gui._mouseY = my

	local mouseFocus = gui._mouseFocus
	if not (mouseFocus and gui._mouseFocusButtonStates[mbutton]) then
		return false
	end

	blurMouseFocus(gui, mbutton)
	updateLayoutIfNeeded(gui) -- Updates hovered element.

	local el = mouseFocus or gui._hoveredElement
	if el then
		el:_mousereleased(mx, my, mbutton, pressCount)
	end

	if el then
		trigger(el, "mousereleased", mx-el:getXOnScreen(), my-el:getYOnScreen(), mbutton, pressCount)
	end

	return true
end

-- handled = gui:wheelmoved( dx, dy )
function Gui.wheelmoved(gui, dx, dy)
	if type(dx)~="number" then argerror(2,1,"dx",dx,"number") end
	if type(dy)~="number" then argerror(2,2,"dy",dy,"number") end

	if gui._animationLockCount > 0 then  return true  end

	local isScroll = (dx ~= 0 or dy ~= 0)

	-- Shift key swaps X and Y scrolling.
	local dx0 = dx
	local dy0 = dy
	if love.keyboard.isDown("lshift","rshift") then
		dx, dy = dy, dx
	end

	local mouseFocus = gui._mouseFocus
	if not mouseFocus then
		updateLayoutIfNeeded(gui) -- Updates hovered element.
	end

	-- Focus (non-bubbling event)
	-- OR hovered element (bubbling event).
	local el         = mouseFocus or gui._hoveredElement
	local anyIsSolid = false

	while el do
		if isScroll then
			-- Trigger any custom wheelmoved event handler.
			-- Returning true from the handler suppresses the default behavior.
			if el:trigger("wheelmoved", dx, dy) then  return true  end

			if el:_wheelmoved(dx, dy, dx0, dy0) then  return true  end
		end

		if mouseFocus then  return mouseFocus:isSolid()  end

		anyIsSolid = anyIsSolid or el:isSolid()
		el         = el._parent
	end

	return anyIsSolid
end



--==============================================================



-- bool = gui:areStandardKeysActive( )
-- bool = gui:areStandardKeysActiveInMenus( )
function Gui.areStandardKeysActive(gui)
	return gui._standardKeysAreActive
end
function Gui.areStandardKeysActiveInMenus(gui)
	return gui._standardKeysAreActiveInMenus
end

-- gui:setStandardKeysActive( bool )
-- gui:setStandardKeysActiveInMenus( bool )
function Gui.setStandardKeysActive(gui, active)
	gui._standardKeysAreActive = active
end
function Gui.setStandardKeysActiveInMenus(gui, active)
	gui._standardKeysAreActiveInMenus = active
end



-- gui:blur( )
function Gui.blur(gui)
	if gui._mouseFocus then
		for mbutton, state in ipairs(gui._mouseFocusButtonStates) do
			if state then
				gui:mousereleased(gui._mouseX, gui._mouseY, mbutton, 1--[[ @Polish: Keep track of pressCount. ]])
			end
		end
	end

	blurMouseFocus(gui, nil)

	if gui._keyboardFocus then
		gui._keyboardFocus:blur() -- We assume this is a GuiInput. @Volatile
	end
end



--
-- gui:defineStyle( styleName, styleData )
-- styleData = { parameter1=value, ..., [1]=child1StyleData, ... }
--
-- Examples:
--     gui:defineStyle("centered", {originX=.5, originY=.5, anchorX=.5, anchorY=.5})
--     gui:defineStyle("dialogHeader", {background="header",
--         [2] = {minWidth=200, textColor={1,1,1,.86}}, -- Style data for the second child.
--     })
--
-- @Incomplete: A way to specify style for a child (or grandchild?) by ID.
--
function Gui.defineStyle(gui, styleName, styleData)
	if type(styleName)~="string" then argerror(2,1,"styleName",styleName,"string") end
	if type(styleData)~="table" then argerror(2,2,"styleData",styleData,"table") end
	gui._styles[styleName] = styleData
end



-- element = gui:find( id )
function Gui.find(gui, id)
	local root = gui._root
	return root and (root._id == id and root or root:find(id))
end

-- elements = gui:findAll( id )
function Gui.findAll(gui, id)
	local root = gui._root
	if not root then  return {}  end

	local els = root:findAll(id)
	if root._id == id then
		table.insert(els, 1, root)
	end

	return els
end

-- element = gui:findActive( )
function Gui.findActive(gui)
	local root = gui._root
	return root and root:findActive()
end

-- element = gui:findToggled( )
function Gui.findToggled(gui)
	local root = gui._root
	return root and root:findToggled()
end

-- Match an element using a CSS-like selector.
-- element  = gui:match( selector )
-- selector = "elementType #id .tag" -- Sequence of space-separated element types, IDs and tags.
-- Note: Element types include subtypes (e.g. 'bar' includes both 'vbar' and 'hbar').
function Gui.match(gui, selector)
	local root = gui._root
	if not root then  return nil  end
	return (root:match(selector, true))
end

-- Match elements using a CSS-like selector.
-- elements = gui:matchAll( selector )
-- selector = "elementType #id .tag" -- Sequence of space-separated element types, IDs and tags.
-- Note: Element types include subtypes (e.g. 'bar' includes both 'vbar' and 'hbar').
function Gui.matchAll(gui, selector)
	local root = gui._root
	if not root then  return {}  end
	return (root:matchAll(selector, true))
end



-- sound = gui:getDefaultSound( soundKey )
function Gui.getDefaultSound(gui, soundK)
	if type(soundK)~="string" then argerror(2,1,"soundK",soundK,"string") end
	checkValidSoundKey(soundK, 2)
	return gui._defaultSounds[soundK]
end

-- gui:setDefaultSound( soundKey, sound )
-- gui:setDefaultSound( soundKey, nil ) -- Remove default sound.
-- Note: 'sound' is the value sent to the GUI sound player callback.
function Gui.setDefaultSound(gui, soundK, sound)
	if type(soundK)~="string" then argerror(2,1,"soundK",soundK,"string") end
	checkValidSoundKey(soundK, 2)
	gui._defaultSounds[soundK] = sound
end



-- element = gui:getElementAt( x, y [, includeNonSolid=false ] )
function Gui.getElementAt(gui, x, y, nonSolid)
	local root = gui._root
	if root and not root._hidden then
		return root:getElementAt(x, y, nonSolid)
	end
	return nil
end



-- font|nil = gui:getFont( )
-- font|nil = gui:getTooltipFont( )
function Gui.getFont       (gui)  return gui._font         end
function Gui.getTooltipFont(gui)  return gui._fontTooltip  end

-- gui:setFont( font|nil )
-- gui:setTooltipFont( font|nil )
-- A nil font will result in a default font being used.
function Gui.setFont(gui, font)
	if not((type(font)=='userdata'and(font):typeOf"Font") or font==nil) then argerror(2,1,"font",font,"Font","nil") end
	if gui._font == font then  return  end
	gui._font              = font
	gui._layoutNeedsUpdate = true
end
function Gui.setTooltipFont(gui, font)
	if not((type(font)=='userdata'and(font):typeOf"Font") or font==nil) then argerror(2,1,"font",font,"Font","nil") end
	gui._fontTooltip = font -- No need to update layout for tooltips currently. :CacheTooltipValues
end



-- element = gui:getHoveredElement( )
function Gui.getHoveredElement(gui)
	updateLayoutIfNeeded(gui)
	return gui._hoveredElement
end



do
	local function setNavigationTarget(gui, widget)
		if gui._navigationTarget == widget then  return false  end -- No change.

		gui._navigationTarget    = widget
		gui._timeSinceNavigation = 0

		updateTooltip(gui, widget)
		gui._tooltipTimer = 0 -- Always reset when navigating.

		if widget then
			widget:scrollIntoView(false)
			if gui._navigateSoundSuppressionLevel == 0 then
				widget:playSound("navigate") -- @Robustness: May have to add more limitations to whether the "navigate" sound plays or not.
			end
		end

		;(widget or gui._root):triggerBubbling("navigated", widget)

		return true -- Change happened!
	end

	-- widget = gui:getNavigationTarget( )
	function Gui.getNavigationTarget(gui)
		return gui._navigationTarget
	end

	-- success = gui:navigateTo( widget )
	function Gui.navigateTo(gui, widget)
		if gui._navigationTarget == widget then  return true   end
		if gui._lockNavigation             then  return false  end
		if not gui:canNavigateTo(widget)   then  return false  end
		setNavigationTarget(gui, widget)
		return true
	end

	do
		local function navigateToNextOrPrevious(gui, id, allowNone, usePrev)
			local root = gui._root
			if not root or root._hidden then  return nil  end

			local nav = gui._navigationTarget
			if not nav and not usePrev then  return gui:navigateToFirst()  end

			local foundNav   = false
			local lastWidget = nil

			for _, el in ipairs((nav and nav:getNavigationRoot() or root):_collectVisibleUntilInputCapture(__STATIC3)) do
				-- Note: Remember that we're traversing backwards.
				local elIsValid = el:is(Cs.widget) and (not id or el._id == id)

				if elIsValid and usePrev and foundNav then
					setNavigationTarget(gui, el)
					return el
				end

				foundNav = (foundNav or el == nav)

				if not usePrev and foundNav then
					if lastWidget or allowNone then
						setNavigationTarget(gui, lastWidget)
						return lastWidget
					end
					return nav
				end

				if elIsValid then  lastWidget = el  end
			end

			if not allowNone then  return nav  end

			setNavigationTarget(gui, nil)
			return nil
		end

		-- element = gui:navigateToNext( [ id=any, allowNone=false ] )
		-- Note: Calls gui:navigateToFirst() if there's no current navigation target.
		function Gui.navigateToNext(gui, id, allowNone)
			return (navigateToNextOrPrevious(gui, id, allowNone, false))
		end

		-- element = gui:navigateToPrevious( [ id=any, allowNone=false ] )
		function Gui.navigateToPrevious(gui, id, allowNone)
			return (navigateToNextOrPrevious(gui, id, allowNone, true))
		end
	end

	-- element = gui:navigateToFirst( )
	function Gui.navigateToFirst(gui)
		if gui._lockNavigation then  return nil  end

		local root = gui._root
		if not root or root._hidden then  return nil  end

		local first = nil

		for _, el in ipairs(root:_collectVisibleUntilInputCapture(__STATIC4)) do
			if el:is(Cs.widget) and not (first and first._priority > el._priority) then
				first = el
			end
		end

		setNavigationTarget(gui, first)
		return first
	end

	-- landingElement = gui:navigate( angle )
	function Gui.navigate(gui, angle)
		if gui._lockNavigation then  return nil  end

		local root = gui._root
		if not root or root._hidden then  return nil  end

		local nav = gui._navigationTarget
		if not nav then  return gui:navigateToFirst()  end

		if trigger(nav, "navigate", angle) then
			return gui._navigationTarget -- Suppress default behavior.
		end

		local closestEl = nav:getClosestInDirection(angle)
		if closestEl then
			setNavigationTarget(gui, closestEl)
		end

		return closestEl or nav
	end

	-- bool = gui:canNavigateTo( element|nil )
	-- Note: Does not check if navigation is locked.
	function Gui.canNavigateTo(gui, widget)
		if widget == nil            then  return true   end -- Navigation target can always be nothing.
		if not widget:is(Cs.widget) then  return false  end
		if not widget:isDisplayed() then  return false  end

		local root = gui._root
		if not root or root._hidden then  return false  end

		for _, el in ipairs(root:_collectVisibleUntilInputCapture(__STATIC5)) do
			if el == widget then
				return true
			elseif el._captureInput or el._captureGuiInput then
				return false
			end
		end

		error("Somehow the element is a displayed active widget but not among the visible elements under the root.")
	end
end



-- root = gui:getRoot( )
function Gui.getRoot(gui)
	return gui._root
end



-- converter|nil = gui:getScissorCoordsConverter( )
function Gui.getScissorCoordsConverter(gui)
	return gui._scissorCoordsConverter
end

--
-- gui:setScissorCoordsConverter( converter|nil )
-- x, y, width, height = converter( x, y, width, height )
--
-- If the graphics transform is changed outside the GUI system then a scissor
-- coordinate converter is needed for scissoring to work properly (for inputs
-- and scrollable containers).
--
function Gui.setScissorCoordsConverter(gui, converter)
	gui._scissorCoordsConverter = converter
end



-- speedX, speedY = gui:getScrollSpeed( )
function Gui.getScrollSpeed(gui)
	return gui._scrollSpeedX, gui._scrollSpeedY
end

-- gui:setScrollSpeed( speedX [, speedY=speedX ] )
-- Note: The scroll speed is relative to the GUI's font size (gui:getFont() or Gui.getDefaultFont()).
function Gui.setScrollSpeed(gui, speedX, speedY)
	if type(speedX)~="number" then argerror(2,1,"speedX",speedX,"number") end
	if not(type(speedY)=="number" or speedY==nil) then argerror(2,2,"speedY",speedY,"number","nil") end
	gui._scrollSpeedX = speedX
	gui._scrollSpeedY = speedY or speedX
end



-- smoothness = gui:getScrollSmoothness( )
function Gui.getScrollSmoothness(gui)
	return gui._scrollSmoothness
end

-- gui:setScrollSmoothness( smoothness )
-- 0 disables smoothness.
function Gui.setScrollSmoothness(gui, smoothness)
	if type(smoothness)~="number" then argerror(2,1,"smoothness",smoothness,"number") end
	gui._scrollSmoothness = math.max(smoothness, 0)
end



-- soundPlayer = gui:getSoundPlayer( )
function Gui.getSoundPlayer(gui)
	return gui._soundPlayer
end

-- gui:setSoundPlayer( soundPlayer|nil )
-- soundPlayer = function( sound )
function Gui.setSoundPlayer(gui, soundPlayer)
	gui._soundPlayer = soundPlayer
end



-- spriteLoader = gui:getSpriteLoader( )
function Gui.getSpriteLoader(gui)
	return gui._spriteLoader
end

-- gui:setSpriteLoader( spriteLoader|nil )
-- image, frames = spriteLoader( spriteName )
-- frames        = { frame1, ... }
-- frame         = { duration=duration, quad=quad }
function Gui.setSpriteLoader(gui, spriteLoader)
	gui._spriteLoader = spriteLoader
end



-- targetElement = gui:getTarget( target )
-- target        = "ID.subID.anotherSubID" -- Sequence of dot-separated IDs.
-- Returns nil and a message on error.
function Gui.getTarget(gui, target)
	local el = gui._root
	if not el then  return nil, "There is no root element."  end

	local ids = matchAll(target, "[^.]+") -- @Memory

	for i = 1, #ids do
		if not el:is(Cs.container) then
			return false, F("'%s' is not a container.", el._id)
		end

		el = el:find(ids[i])
		if not el then
			return nil, F("'%s' does not exist in '%s'.", ids[i], (ids[i-1] or "root"))
		end
	end

	return el
end

-- callback       = gui:getTargetCallback( targetAndEvent )
-- targetAndEvent = "ID.subID.anotherSubID.event" -- Sequence of dot-separated IDs followed by a dot and an event name.
-- Returns nil and a message on error.
-- Returns nil (and no message) if there's no callback.
function Gui.getTargetCallback(gui, targetAndEvent)
	local target, eventOrErr = _M.parseTargetAndEvent(targetAndEvent)
	if not target then  return nil, eventOrErr  end

	local el, err = gui:getTarget(target)
	if not el then  return nil, err  end

	return el:getCallback(eventOrErr)
end

-- targetElement  = gui:setTargetCallback( targetAndEvent, callback|nil )
-- targetAndEvent = "ID.subID.anotherSubID.event" -- Sequence of dot-separated IDs followed by a dot and an event name.
-- Returns nil and a message on error.
function Gui.setTargetCallback(gui, targetAndEvent, cb)
	local target, eventOrErr = _M.parseTargetAndEvent(targetAndEvent)
	if not target then  return nil, eventOrErr  end

	local el, err = gui:getTarget(target)
	if not el then  return nil, err  end

	el:on(eventOrErr, cb)
	return el
end



-- textPreprocessor|nil = gui:getTextPreprocessor( )
function Gui.getTextPreprocessor(gui)
	return gui._textPreprocessor
end

-- gui:setTextPreprocessor( textPreprocessor|nil )
-- newText = textPreprocessor( text, element, mnemonicsAreEnabled )
function Gui.setTextPreprocessor(gui, func)
	if not(type(func)=="function" or func==nil) then argerror(2,1,"func",func,"function","nil") end
	if gui._textPreprocessor == func then  return  end
	gui._textPreprocessor = func
	gui:reprocessTexts() -- @Speed: Maybe add a system for scheduling reprocessing of texts. (Probably not necessary.)
end

-- gui:reprocessTexts( )
-- Manually re-preprocess texts. Useful if e.g. the program's language has changed.
function Gui.reprocessTexts(gui)
	if gui._root then
		gui._root:reprocessTexts()
	end
end



-- theme|nil = gui:getTheme( )
function Gui.getTheme(gui)
	return gui._theme
end

-- gui:setTheme( theme|nil )
function Gui.setTheme(gui, theme)
	if not(type(theme)=="table" or theme==nil) then argerror(2,1,"theme",theme,"table","nil") end
	if gui._theme == theme then  return  end
	gui._theme             = theme
	gui._layoutNeedsUpdate = true
end



-- delay    = gui:getTooltipDelay( )
-- duration = gui:getTooltipDuration( )
function Gui.getTooltipDelay(gui)
	return gui._tooltipDelay
end
function Gui.getTooltipDuration(gui)
	return gui._tooltipDuration
end

-- gui:setTooltipDelay( delay )
-- gui:setTooltipDuration( duration )
function Gui.setTooltipDelay(gui, delay)
	if type(delay)~="number" then argerror(2,1,"delay",delay,"number") end
	gui._tooltipDelay = delay
end
function Gui.setTooltipDuration(gui, duration)
	if type(duration)~="number" then argerror(2,1,"duration",duration,"number") end
	gui._tooltipDuration = duration
end



-- time = gui:getTime( )
function Gui.getTime(gui)
	return gui._time
end

-- time = gui:getTimeSinceNavigation( )
function Gui.getTimeSinceNavigation(gui)
	return gui._timeSinceNavigation
end



-- bool = gui:isBusy( )
function Gui.isBusy(gui)
	return gui:isKeyboardBusy() or gui:isMouseBusy()
end

-- bool = gui:isKeyboardBusy( )
function Gui.isKeyboardBusy(gui)
	return gui._keyboardFocus ~= nil
end

-- bool = gui:isMouseBusy( )
function Gui.isMouseBusy(gui)
	return gui._mouseFocus ~= nil
end



-- bool = gui:isIgnoringKeyboardInput( )
function Gui.isIgnoringKeyboardInput(gui)
	return gui._ignoreKeyboardInputThisFrame
end



-- bool = gui:isInputCaptured( [ includeGuiInput=false ] )
function Gui.isInputCaptured(gui, includeGuiInput) -- @Cleanup: Remove in favor of getInputCapturingElement.
	local root = gui._root
	if not root or root._hidden then  return false  end

	for _, el in ipairs(root:collectVisible(__STATIC6)) do
		if el._captureInput or (includeGuiInput and el._captureGuiInput) then
			return true
		end
	end

	return false
end

-- element|nil = gui:getInputCapturingElement( [ includeGuiInput=false ] )
function Gui.getInputCapturingElement(gui, includeGuiInput)
	local root = gui._root
	if not root or root._hidden then  return false  end

	for _, el in ipairs(root:collectVisible(__STATIC7)) do
		if el._captureInput or (includeGuiInput and el._captureGuiInput) then
			return el
		end
	end

	return nil
end



-- bool = gui:isInteractionLocked( )
function Gui.isInteractionLocked(gui)
	return gui._animationLockCount > 0
end



-- bool = gui:isMouseGrabbed( )
function Gui.isMouseGrabbed(gui)
	return gui._mouseIsGrabbed
end

-- gui:setMouseIsGrabbed( bool )
function Gui.setMouseIsGrabbed(gui, grabbed)
	gui._mouseIsGrabbed = grabbed
end



-- gui:load( elementData )
-- elementData = { type=elementType, parameter1=value, ..., [1]=child1Data, ... }
-- elementData = {      elementType, parameter1=value, ..., [1]=child1Data, ... }
function Gui.load(gui, elData)
	if getTypeFromElementData(elData) ~= "root" then
		errorf(2, "Gui root element must be of type 'root'.")
	end

	local root = Cs.root(gui, elData, nil)
	gui._root  = root

	printHeres(gui)

	local themeInit = themeGet(gui, "init")
	themeInit(root)
	for el in root:traverse() do
		themeInit(el)
	end

	gui._layoutNeedsUpdate = true
end



-- handled = gui:ok( )
-- Trigger 'ok' action.
function Gui.ok(gui)
	updateTooltip(gui, nil)
	local nav = gui._navigationTarget
	if nav and nav._active then  return nav:_ok()  end
	return false
end

-- handled = gui:back( )
-- Trigger 'back' action.
function Gui.back(gui)
	updateTooltip(gui, nil)

	local root = gui._root
	if not root or root._hidden then  return false  end

	-- Close closable (like Escape does).
	local elToClose = nil

	for _, el in ipairs(root:_collectVisibleUntilInputCapture(__STATIC8)) do
		if el:canClose() then
			elToClose = el
			break
		end
	end

	if elToClose then
		elToClose:close()
		return true
	end

	return false
end



-- gui:scheduleLayoutUpdate( )
-- Schedule a layout update. (Should never be needed as the layout is updated automatically.)
function Gui.scheduleLayoutUpdate(gui)
	gui._layoutNeedsUpdate = true
end

-- gui:updateLayoutNow( )
-- Force a layout update. (Should never be needed as it's done automatically.)
function Gui.updateLayoutNow(gui)
	local root = gui._root
	if root and not root._hidden then
		updateLayout(root)
	end
end

-- realTime = gui:getLayoutUpdateTime( )
-- Returns the time it took to update the layout the last time, or 0 if no update has occurred yet.
function Gui.getLayoutUpdateTime(gui)
	return gui._layoutUpdateTime
end



-- bool = gui:isCullingActive( )
function Gui.isCullingActive(gui)
	return gui._culling
end

-- gui:setCullingActive( bool )
function Gui.setCullingActive(gui, culling)
	gui._culling = culling
end



-- bool = gui:isTriggeringOnMousepressed( )
function Gui.isTriggeringOnMousepressed(gui)
	return gui._triggerOnMousepressed
end

-- gui:setTriggerOnMousepressed( bool )
function Gui.setTriggerOnMousepressed(gui, doTrigger)
	gui._triggerOnMousepressed = doTrigger
end



--==============================================================
--= Image include ==============================================
--==============================================================



Is.imageInclude = {
	-- Parameters.
	_imageBackgroundColor = nil,
	_imageColor           = nil,

	_imageScaleX = 1.0,
	_imageScaleY = 1.0,

	_sprite = nil,
	--

	_spriteName = nil,
}

local function initImageInclude(imageInc, elData)
	if elData.imageBackgroundColor ~= nil then imageInc._imageBackgroundColor = elData.imageBackgroundColor end
	if elData.imageColor ~= nil then imageInc._imageColor = elData.imageColor end
	-- @@retrieve(imageInc, elData, _imageScaleX,_imageScaleY)
	-- @@retrieve(imageInc, elData, _sprite)

	imageInc._imageScaleX = elData.imageScaleX or elData.imageScale
	imageInc._imageScaleY = elData.imageScaleY or elData.imageScale

	imageInc:setSprite(elData.sprite)
end



-- imageIncludeElement:drawImage( x, y )
function Is.imageInclude.drawImage(imageInc, x, y)
	if not imageInc._sprite then  return  end

	local image, quad = getCurrentViewOfSprite(imageInc._sprite)
	local padding     = imageInc:is(Cs.button) and imageInc._imagePadding or 0

	love.graphics.draw(image, quad, x+padding, y+padding, 0, imageInc._imageScaleX, imageInc._imageScaleY)
end



-- colorTable|nil = imageIncludeElement:getImageBackgroundColor( )
function Is.imageInclude.getImageBackgroundColor(imageInc)
	return imageInc._imageBackgroundColor
end

-- imageIncludeElement:setImageBackgroundColor( colorTable|nil )
function Is.imageInclude.setImageBackgroundColor(imageInc, color)
	imageInc._imageBackgroundColor = color
end

-- bool = imageIncludeElement:hasImageBackgroundColor( )
function Is.imageInclude.hasImageBackgroundColor(imageInc)
	return imageInc._imageBackgroundColor ~= nil
end

-- hasImageBackgroundColor = imageIncludeElement:useImageBackgroundColor( [ alphaMultiplier=1 ] )
-- Tell LÖVE to use the imageInclude's resulting image background color.
function Is.imageInclude.useImageBackgroundColor(imageInc, opacity)
	local color = imageInc._imageBackgroundColor
	useColor((color or COLOR_TRANSPARENT_WHITE), opacity)
	return color ~= nil
end



-- colorTable|nil = imageIncludeElement:getImageColor( )
function Is.imageInclude.getImageColor(imageInc)
	return imageInc._imageColor
end

-- imageIncludeElement:setImageColor( colorTable|nil )
function Is.imageInclude.setImageColor(imageInc, color)
	imageInc._imageColor = color
end

-- bool = imageIncludeElement:hasImageColor( )
function Is.imageInclude.hasImageColor(imageInc)
	return imageInc._imageColor ~= nil
end

-- hasImageColor = imageIncludeElement:useImageColor( [ alphaMultiplier=1 ] )
-- Tell LÖVE to use the imageInclude's resulting image color.
function Is.imageInclude.useImageColor(imageInc, opacity)
	local color = imageInc._imageColor
	useColor((color or COLOR_WHITE), opacity)
	return color ~= nil
end



-- width, height = imageIncludeElement:getImageDimensions( )
function Is.imageInclude.getImageDimensions(imageInc)
	local sprite = imageInc._sprite
	if not sprite then  return 0, 0  end
	return sprite.width, sprite.height
end

-- Sets the scale of the image by specifying a size. Does nothing if there's no image.
-- imageIncludeElement:setImageSize( width, height )
function Is.imageInclude.setImageSize(imageInc, w, h)
	local sprite = imageInc._sprite
	if not sprite then  return  end
	imageInc:setImageScale(w/sprite.width, h/sprite.height)
end

-- Scales the image so it fills the element. Does nothing if there's no image or if no dimensions are set.
-- imageIncludeElement:maximizeImageSize( [ extraWidth=0, extraHeight=0 ] )
function Is.imageInclude.maximizeImageSize(imageInc, extraW, extraH)
	local sprite = imageInc._sprite
	if not sprite then  return  end

	local paddingSum = imageInc:is(Cs.button) and 2*imageInc._imagePadding or 0

	local scaleX = imageInc:hasFixedWidth () and ((imageInc._width  - paddingSum + (extraH or 0)) / sprite.width ) or imageInc._imageScaleX
	local scaleY = imageInc:hasFixedHeight() and ((imageInc._height - paddingSum + (extraW or 0)) / sprite.height) or imageInc._imageScaleY
	imageInc:setImageScale(scaleX, scaleY)
end



-- scaleX, scaleY = imageIncludeElement:getImageScale( )
-- scale = imageIncludeElement:getImageScaleX( )
-- scale = imageIncludeElement:getImageScaleY( )
function Is.imageInclude.getImageScale(imageInc)
	return imageInc._imageScaleX, imageInc._imageScaleY
end
function Is.imageInclude.getImageScaleX(imageInc)
	return imageInc._imageScaleX
end
function Is.imageInclude.getImageScaleY(imageInc)
	return imageInc._imageScaleY
end

-- imageIncludeElement:setImageScale( scaleX [, scaleY=scaleX ] )
-- imageIncludeElement:setImageScaleX( scale )
-- imageIncludeElement:setImageScaleY( scale )
function Is.imageInclude.setImageScale(imageInc, sx, sy)
	if type(sx)~="number" then argerror(2,1,"sx",sx,"number") end
	if not(type(sy)=="number" or sy==nil) then argerror(2,2,"sy",sy,"number","nil") end

	sy = sy or sx
	if imageInc._imageScaleX == sx and imageInc._imageScaleY == sy then  return  end

	imageInc._imageScaleX = sx
	imageInc._imageScaleY = sy
	if imageInc._sprite then  scheduleLayoutUpdateIfDisplayed(imageInc)  end
end
function Is.imageInclude.setImageScaleX(imageInc, sx)
	if type(sx)~="number" then argerror(2,1,"sx",sx,"number") end
	if imageInc._imageScaleX == sx then  return  end

	imageInc:setImageScale(sx, imageInc._imageScaleY)
	if imageInc._sprite then  scheduleLayoutUpdateIfDisplayed(imageInc)  end
end
function Is.imageInclude.setImageScaleY(imageInc, sy)
	if type(sy)~="number" then argerror(2,1,"sy",sy,"number") end
	if imageInc._imageScaleY == sy then  return  end

	imageInc:setImageScale(imageInc._imageScaleY, sy)
	if imageInc._sprite then  scheduleLayoutUpdateIfDisplayed(imageInc)  end
end



-- spriteName|nil = imageIncludeElement:getSprite( )
function Is.imageInclude.getSprite(imageInc)
	return imageInc._spriteName
end

-- imageIncludeElement:setSprite( image [, quad ] )
-- imageIncludeElement:setSprite( image, frames )
-- imageIncludeElement:setSprite( spriteName )
-- imageIncludeElement:setSprite( nil ) -- Remove sprite.
-- frames = { frame1, ... }
-- frame  = { duration=duration, quad=quad }
function Is.imageInclude.setSprite(imageInc, imageOrName, framesOrQuad)
	if not((type(imageOrName)=='userdata'and(imageOrName):typeOf"Image") or type(imageOrName)=="string" or imageOrName==nil) then argerror(2,1,"imageOrName",imageOrName,"Image","string","nil") end

	local image      = nil
	local spriteName = ""

	if type(imageOrName) == "string" then
		spriteName = imageOrName
		if spriteName ~= "" and spriteName == imageInc._spriteName then  return  end

		local spriteLoader = imageInc._gui._spriteLoader
		if not spriteLoader then
			printerr(2, "There is no sprite loader to convert the sprite name %q to a sprite.", spriteName)
			return
		end

		image, framesOrQuad = spriteLoader(spriteName)
		if not image then
			printerr(2, "The sprite loader did not return a required image for sprite name %q.", spriteName)
			return
		end

	elseif imageOrName then
		if not((type(framesOrQuad)=='userdata'and(framesOrQuad):typeOf"Quad") or type(framesOrQuad)=="table" or framesOrQuad==nil) then argerror(2,2,"framesOrQuad",framesOrQuad,"Quad","table","nil") end
		image = imageOrName
	end

	local oldIw = imageInc._sprite and imageInc._sprite.width  or 0
	local oldIh = imageInc._sprite and imageInc._sprite.height or 0

	imageInc._sprite     = image and newSprite(image, framesOrQuad, 2)
	imageInc._spriteName = spriteName

	local iw = imageInc._sprite and imageInc._sprite.width  or 0
	local ih = imageInc._sprite and imageInc._sprite.height or 0

	if not (iw == oldIw and ih == oldIh) then
		scheduleLayoutUpdateIfDisplayed(imageInc)
	end
end

-- bool = imageIncludeElement:hasSprite( )
function Is.imageInclude.hasSprite(imageInc)
	return imageInc._sprite ~= nil
end



--==============================================================
--= Element class (abstract) ===================================
--==============================================================



Cs.element = newElementClass(true, "GuiElement", nil, {}, {
	--[[STATIC]] _events = {--[[ event1, [event1]=true, ... ]]},

	-- Parameters.
	_id   = "",
	_data = nil,

	_hidden   = false,
	_floating = false, -- Disables natural positioning in certain parents (e.g. bars).
	_closable = false,

	_captureInput    = false, -- All input.
	_captureGuiInput = false, -- All input affecting GUI.

	_width          = -1, -- Negative means dynamic (unless relative size is set).
	_height         = -1,
	_relativeWidth  = -1, -- Negative means dynamic (unless fixed size is set).
	_relativeHeight = -1,

	_weight = 0, -- Weight of the element during expansion by the parent container. 0 means no expansion.

	_minWidth  = 0,
	_minHeight = 0,
	_maxWidth  = -1, -- Negative means no max limit.
	_maxHeight = -1,

	_x = 0, -- Offset from the origin.
	_y = 0,

	_originX = 0.0, -- Where in the parent to base x and y off.
	_originY = 0.0,

	_anchorX = 0.0, -- Where in self to base off x and y.
	_anchorY = 0.0,

	_spacingLeft   = 0, -- Falls back to 'spacingHorizontal' and 'spacing'.
	_spacingRight  = 0, -- Falls back to 'spacingHorizontal' and 'spacing'.
	_spacingTop    = 0, -- Falls back to 'spacingVertical' and 'spacing'.
	_spacingBottom = 0, -- Falls back to 'spacingVertical' and 'spacing'.

	_background = "",
	_style      = "",
	_tags       = nil,

	_mouseCursor = nil, -- cursor | systemCursorType | nil
	_sounds      = nil,

	_tooltip            = "",
	_unprocessedTooltip = "",
	--

	_automaticId = false,

	_timeBecomingVisible = 0.00,

	_callbacks  = nil,
	_animations = nil,

	_gui    = nil,
	_parent = nil,

	_layoutOffsetX          = 0.0, -- Sum of parents' scrolling.
	_layoutOffsetY          = 0.0,
	_layoutImmediateOffsetX = 0, -- Sum of parents' scrolling, excluding smooth scrolling.
	_layoutImmediateOffsetY = 0,

	_layoutWidth  = 0,
	_layoutHeight = 0,

	_layoutX = 0,
	_layoutY = 0,

	data = nil, -- Alias for _data.
}, {
	"beforedraw"   , --            function( element, event, x, y, w, h )
	"afterdraw"    , --            function( element, event, x, y, w, h )

	"close"        , -- suppress = function( element, event )
	"closed"       , --            function( element, event )

	"focused"      , --            function( element, event )
	"blurred"      , --            function( element, event )

	"init"         , --            function( element, event )

	"keypressed"   , -- suppress = function( element, event, key, scancode, isRepeat )

	"layout"       , --            function( element, event )

	"mousepressed" , --            function( element, event, mx, my, mbutton, pressCount )
	"mousemoved"   , --            function( element, event, mx, my, deltaX, deltaY )
	"mousereleased", --            function( element, event, mx, my, mbutton, pressCount )

	"navigated"    , --            function( element, event )

	"pressed"      , --            function( element, event )

	"refresh"      , --            function( element, event )

	"show"         , --            function( element, event )
	"hide"         , --            function( element, event )

	"textinput"    , -- suppress = function( element, event, text )

	"update"       , --            function( element, event, deltaTime )

	"wheelmoved"   , -- suppress = function( element, event, dx, dy )
})

function Cs.element.init(el, gui, elData, parent)
	if el._abstract then
		errorf("Cannot instantiate abstract class '%s'.", el.__name)
	end

	el._gui    = gui or error("Missing gui object argument.")
	el._parent = parent

	local styleName = elData.style

	if styleName then
		local styleData = gui._styles[styleName] or errorf("No style with name '%s' exist.", styleName)
		applyStyle(elData, styleData)
		el._style = styleName
	end

	if elData.anchorX ~= nil then el._anchorX = elData.anchorX end if elData.anchorY ~= nil then el._anchorY = elData.anchorY end
	if elData.background ~= nil then el._background = elData.background end
	if elData.captureInput ~= nil then el._captureInput = elData.captureInput end if elData.captureGuiInput ~= nil then el._captureGuiInput = elData.captureGuiInput end
	if elData.closable ~= nil then el._closable = elData.closable end
	-- @@retrieve(el, elData, _data)
	if elData.floating ~= nil then el._floating = elData.floating end
	if elData.hidden ~= nil then el._hidden = elData.hidden end
	if elData.id ~= nil then el._id = elData.id end
	if elData.maxWidth ~= nil then el._maxWidth = elData.maxWidth end if elData.maxHeight ~= nil then el._maxHeight = elData.maxHeight end
	-- @@retrieve(el, elData, _minWidth, _minHeight)
	-- @@retrieve(el, elData, _mouseCursor)
	if elData.originX ~= nil then el._originX = elData.originX end if elData.originY ~= nil then el._originY = elData.originY end
	if elData.relativeWidth ~= nil then el._relativeWidth = elData.relativeWidth end if elData.relativeHeight ~= nil then el._relativeHeight = elData.relativeHeight end
	-- @@retrieve(el, elData, _sounds)
	-- @@retrieve(el, elData, _spacingLeft, _spacingRight, _spacingTop, _spacingBottom)
	-- @@retrieve(el, elData, _style)
	-- @@retrieve(el, elData, _tags)
	-- @@retrieve(el, elData, _tooltip)
	-- @@retrieve(el, elData, _weight)
	-- @@retrieve(el, elData, _width, _height)
	if elData.x ~= nil then el._x = elData.x end if elData.y ~= nil then el._y = elData.y end

	el._timeBecomingVisible = gui._time

	if elData.width     ~= nil then  el:setWidth    (elData.width    )  end
	if elData.height    ~= nil then  el:setHeight   (elData.height   )  end
	if elData.minWidth  ~= nil then  el:setMinWidth (elData.minWidth )  end
	if elData.minHeight ~= nil then  el:setMinHeight(elData.minHeight)  end

	el._spacingLeft   = elData.spacingLeft   or elData.spacingHorizontal or elData.spacing
	el._spacingRight  = elData.spacingRight  or elData.spacingHorizontal or elData.spacing
	el._spacingTop    = elData.spacingTop    or elData.spacingVertical   or elData.spacing
	el._spacingBottom = elData.spacingBottom or elData.spacingVertical   or elData.spacing

	if elData.weight ~= nil then  el:setWeight(elData.weight)  end

	-- Set data table.
	if not (elData.data == nil or type(elData.data) == "table") then  error("Assertion failed: elData.data == nil or type(elData.data) == \"table\"")  end
	el._data = elData.data or {}
	el.data  = el._data -- element.data is exposed for easy access.

	-- Make sure the element has an ID.
	if el._id == "" then
		local numId          = gui._lastAutomaticId + 1
		gui._lastAutomaticId = numId
		el._id               = "__" .. numId
		el._automaticId      = true
	end

	-- Set sounds table.
	if elData.sounds ~= nil then
		for soundK, sound in pairs(elData.sounds) do
			checkValidSoundKey(soundK, 2)
			el._sounds         = el._sounds or {}
			el._sounds[soundK] = sound
		end
	end

	-- Add tags.
	if elData.tags ~= nil then
		for _, tag in ipairs(elData.tags) do
			el._tags      = el._tags or {}
			el._tags[tag] = true
		end
	end

	if elData.mouseCursor ~= nil then  el:setMouseCursor(elData.mouseCursor)  end
	if elData.tooltip     ~= nil then  el:setTooltip(elData.tooltip)          end

	-- Set initial offset.
	if parent then
		el._layoutImmediateOffsetX = parent._layoutImmediateOffsetX + parent._scrollX
		el._layoutImmediateOffsetY = parent._layoutImmediateOffsetY + parent._scrollY
		el._layoutOffsetX          = parent._layoutOffsetX          + parent._visualScrollX
		el._layoutOffsetY          = parent._layoutOffsetY          + parent._visualScrollY
	end

	-- The 'here' debug attribute prints the path to the element.
	if elData.here then  table.insert(gui._heres, el)  end

	if elData.debug then  gui.debug = true  end
end



-- INTERNAL  element:_update( deltaTime )
function Cs.element._update(el, dt)
	-- void
end



-- INTERNAL  element:_draw( cullX1, cullY1, cullX2, cullY2, childToDrawNavTargetAfter )
function Cs.element._draw(el, cullX1, cullY1, cullX2, cullY2, childToDrawNavTargetAfter)
	local x, y, w, h = xywhOnScreen(el)

	if not el._gui.debug then
		triggerIncludingAnimations(el, "beforedraw", x, y, w, h)
	end

	drawLayoutBackground(el)

	if not el._gui.debug then
		triggerIncludingAnimations(el, "afterdraw", x, y, w, h)
	end
end

-- INTERNAL  element:_drawDebug( red, green, blue [, backgroundOpacity=1 ] )
function Cs.element._drawDebug(el, r, g, b, bgOpacity)
	local gui = el._gui
	if not gui.debug then  return  end

	local isContainer = el:is(Cs.container)
	local x, y, w, h  = xywhOnScreen(el)
	local paddingL    = isContainer and el._paddingLeft or 0
	local paddingT    = isContainer and el._paddingTop  or 0
	local lw          = clamp(paddingL, 1, paddingT) -- @Polish: Better border width.

	local sbW = themeGet(gui, "scrollbarWidth")

	if el:isKeyboardFocus() then
		r, g, b = 1, 1, 0
	elseif el:isNavigationTarget() then
		r, g, b = 1, 1, 1
	end

	love.graphics.push("all")

	love.graphics.translate(x, y)

	-- Background and center line.
	setColor(r, g, b, .24*(bgOpacity or 1))
	love.graphics.rectangle("fill", 0, 0, w, h)
	love.graphics.line(paddingL, paddingT, w/2, h/2)

	-- Border.
	love.graphics.setLineWidth(lw)
	setColor(r, g, b, .4)
	love.graphics.rectangle("line", lw/2, lw/2, w-lw, h-lw)
	if isContainer then
		if el:canScrollY() then  love.graphics.rectangle("fill", w-lw-sbW, lw, sbW, h-2*lw)  end
		if el:canScrollX() then  love.graphics.rectangle("fill", lw, h-lw-sbW, w-w*lw, sbW)  end
	end
	love.graphics.setLineWidth(1)
	setColor(r, g, b, .6)
	love.graphics.rectangle("line", 0.5, 0.5, w-1, h-1)

	-- Info.
	r = lerp(r, 1, .5)
	g = lerp(g, 1, .5)
	b = lerp(b, 1, .5)
	love.graphics.setFont(gui._font or _M.getDefaultFont())
	setColor(r, g, b, .8)
	if el._automaticId then
		love.graphics.print(F("%d.%d"   , el:getDepth(), (el:getIndex() or 0)        ), 2, 1)
	else
		love.graphics.print(F("%d.%d:%s", el:getDepth(), (el:getIndex() or 0), el._id), 2, 1)
	end

	love.graphics.pop()
end

-- INTERNAL  element:_drawTooltip( )
function Cs.element._drawTooltip(el)
	local gui  = el._gui
	local text = el._tooltip

	if text == "" then  return  end

	if gui._tooltipTimer < gui._tooltipDelay                      then  return  end
	if gui._tooltipTimer > gui._tooltipDelay+gui._tooltipDuration then  return  end

	local root = gui._root
	local font = el:getResultingTooltipFont()

	local textW, textH = getTextDimensions(font, text, 1/0)

	local w, h = themeGetSize(el, "tooltip", textW, textH) -- @Speed: Get tooltip size when tooltip text changes. :CacheTooltipValues

	local x = clamp(el._layoutX+el._layoutImmediateOffsetX, 0, root._width-w)
	local y = el._layoutY + el._layoutHeight + el._layoutImmediateOffsetY

	if y+h > root._height then
		y = math.max(y-h-el._layoutHeight, 0)
	end

	themeRenderOnScreen(
		el, "tooltip",
		x, y, w, h,
		text, textW, textH,
		gui._tooltipTimer-gui._tooltipDelay,
		gui._tooltipDelay+gui._tooltipDuration-gui._tooltipTimer
	)
end



--
-- element:animate( duration, [ lockInteraction=false, ] callbackTable )
-- callbackTable = { [event1]=callback, ... }
-- callback      = function( element, event, progress, ... ) -- Unlike in normal event callbacks there's an extra 'progress' argument before the rest of the arguments.
--
-- Example:
--     myGui:find("myButton"):animate(1, true, {
--         afterdraw = function(myButton, event, progress, x, y, w, h)
--             -- Fade in and out a green cover over the button.
--             setColor(0, 1, 0, .5+.5*math.sin(progress*math.pi))
--             love.graphics.rectangle("fill", x, y, w, h)
--         end,
--     })
--
function Cs.element.animate(el, duration, lockInteraction, callbacks)
	if type(duration)~="number" then argerror(2,1,"duration",duration,"number") end

	if type(lockInteraction) == "table" then
		lockInteraction, callbacks = false, lockInteraction
	else
		if type(lockInteraction)~="boolean" then argerror(2,2,"lockInteraction",lockInteraction,"boolean") end
	end

	local gui = el._gui

	local anim = {
		element         = el,
		lockInteraction = lockInteraction,
		callbacks       = callbacks,

		startTime       = gui._time,
		endTime         = gui._time+duration,
		duration        = duration,
	}

	el._animations = el._animations or {}
	table.insert(el._animations    , anim)
	table.insert(gui._allAnimations, anim)

	if lockInteraction then
		gui._animationLockCount = gui._animationLockCount+1
	end
end



-- success = element:close( )
-- Trigger 'close' action, if possible.
function Cs.element.close(el)
	if not el:canClose() then
		return false
	end

	local preparedSound = prepareSound(el, "close")
	if trigger(el, "close") then
		return false -- Suppress default behavior.
	end

	if preparedSound then
		preparedSound()
	end
	el:hide()
	el:triggerBubbling("closed", el)

	return true
end

-- result = element:canClose( )
function Cs.element.canClose(el)
	return el._closable and not el._gui._lockNavigation and el:isDisplayed()
end



-- bool = element:exists( )
function Cs.element.exists(el)
	return el._parent ~= nil or el == el._gui._root
end



-- anchorX, anchorY = element:getAnchor( )
-- anchor = element:getAnchorX( )
-- anchor = element:getAnchorY( )
function Cs.element.getAnchor(el)
	return el._anchorX, el._anchorY
end
function Cs.element.getAnchorX(el)
	return el._anchorX
end
function Cs.element.getAnchorY(el)
	return el._anchorY
end

-- element:setAnchor( anchorX, anchorY )
-- element:setAnchorX( anchor )
-- element:setAnchorY( anchor )
function Cs.element.setAnchor(el, anchorX, anchorY)
	if el._anchorX == anchorX and el._anchorY == anchorY then  return  end
	el._anchorX = anchorX
	el._anchorY = anchorY
	scheduleLayoutUpdateIfDisplayed(el)
end
function Cs.element.setAnchorX(el, anchor)
	if el._anchorX == anchor then  return  end
	el._anchorX = anchor
	scheduleLayoutUpdateIfDisplayed(el)
end
function Cs.element.setAnchorY(el, anchor)
	if el._anchorY == anchor then  return  end
	el._anchorY = anchor
	scheduleLayoutUpdateIfDisplayed(el)
end



-- callback|nil = element:getCallback( event )
function Cs.element.getCallback(el, event)
	return el._callbacks and el._callbacks[event]
end

-- element:setCallback( event, callback|nil )
function Cs.element.setCallback(el, event, cb)
	if type(event)~="string" then argerror(2,1,"event",event,"string") end
	if not(type(cb)=="function" or cb==nil) then argerror(2,2,"cb",cb,"function","nil") end

	if not el._events[event] then
		printerr(2, "Unknown event '%s'. (%s)", event, el:getPathDescription())
		return
	end

	if not (cb or el._callbacks) then  return  end

	el._callbacks        = el._callbacks or {}
	el._callbacks[event] = cb

	-- Since callbacks can only be attached to elements after the actual
	-- initialization has happened we instead trigger the init event here.
	if cb and event == "init" then
		trigger(el, "init")
	end
end

-- element:on( event, callback|nil )
-- Alias for element:setCallback().
Cs.element.on = Cs.element.setCallback

-- element:off( event )
function Cs.element.off(el, event)
	el:on(event, nil)
end

-- value = element:trigger( event [, extraArgument1, ... ] )
function Cs.element.trigger(el, event, ...)
	if type(event)~="string" then argerror(2,1,"event",event,"string") end
	if not el._events[event] then
		printerr(2, "Unknown event '%s'. (%s)", event, el:getPathDescription())
		return nil
	end
	return (trigger(el, event, ...))
end

-- value = element:triggerBubbling( event [, extraArgument1, ... ] )
function Cs.element.triggerBubbling(el, event, ...)
	if type(event)~="string" then argerror(2,1,"event",event,"string") end

	if not el._events[event] then
		printerr(2, "Unknown event '%s'. (%s)", event, el:getPathDescription())
		return nil
	end

	local returnV = nil
	repeat
		returnV = trigger(el, event, ...)
		el      = el._parent
	until returnV or not el

	return returnV
end



-- closestElement|nil = element:getClosest( elementType )
-- Returns closest ancestor matching elementType (including self).
function Cs.element.getClosest(el, elType)
	local class = requireElementClass(elType, 2)
	repeat
		if el:is(class) then  return el  end
		el = el._parent
	until not el
	return nil
end



do
	local function countScrollables(parents, toIndex)
		local count = 0
		for i = 1, toIndex do
			if parents[i]:canScrollAny() then  count = count + 1  end
		end
		return count
	end

	local function getScrollableJumps(el, otherElParents, abortAtJumps)
		local jumps = 0

		while true do
			el = el._parent
			if not el then  break  end

			local i = indexOf(otherElParents, el)
			if i then
				jumps = jumps + countScrollables(otherElParents, i-1)
				break
			end

			if el:canScrollAny() then
				jumps = jumps + 1
				if jumps == abortAtJumps then  return jumps  end
			end
		end

		return jumps
	end

	-- element|nil = _getClosestInDirection( elements, class, fromX,fromY, angle, ignoreCapture, elementToIgnore|nil )
	local function _getClosestInDirection(elements, class, fromX,fromY, angle, ignoreCapture, elToIgnore)
		fromX = round(fromX)
		fromY = round(fromY)

		local elParents = __STATIC9
		for i = 1, #elParents do  elParents[i] = nil  end

		if elToIgnore then
			local parent = elToIgnore
			while true do
				parent = parent._parent
				if not parent then
					break
				else
					table.insert(elParents, parent)
				end
			end
		end

		local closestEl                 = nil
		local closestDistSq             = 1/0
		local closestDistSqForJumpCount = 1/0
		local closestAngDiff            = 1/0
		local closestScrollableJumps    = 1/0

		local min   = math.min
		local max   = math.max
		local sin   = math.sin
		local cos   = math.cos
		local atan2 = math.atan2
		local abs   = math.abs

		-- print("_getClosestInDirection")

		-- @Speed!!!
		for _, otherEl in ipairs(elements) do
			if otherEl ~= elToIgnore and otherEl:is(class) then
				local x1, y1 = otherEl:getPositionOnScreen()
				local x2     = x1 + otherEl._layoutWidth
				local y2     = y1 + otherEl._layoutHeight
				local dx, dy

				if fromX < x1+.01 or fromY < y1+.01 or fromX > x2-.01 or fromY > y2-.01 or not elToIgnore then
					dx = clamp(fromX, x1+.01, x2-.01) - fromX
					dy = clamp(fromY, y1+.01, y2-.01) - fromY

				else
					dx = .000001 * (.5*(x1+x2) - (elToIgnore:getXOnScreen()+.5*elToIgnore._layoutWidth ))
					dy = .000001 * (.5*(y1+y2) - (elToIgnore:getYOnScreen()+.5*elToIgnore._layoutHeight))
					-- print(dx/.000001, dy/.000001, math.sqrt(dx*dx+dy*dy), getScrollableJumps(otherEl, elParents, 1/0), otherEl:getPathDescription())
				end



				local angDiff = atan2(dy, dx) - angle
				angDiff       = abs(atan2(sin(angDiff), cos(angDiff))) -- Normalize. @Speed

				if angDiff < 0.78539816339745 then
					local jumps  = elToIgnore and getScrollableJumps(otherEl, elParents, closestScrollableJumps+1) or 0
					local distSq = dx*dx + dy*dy

					-- @Incomplete: This fails jumping from one scrollable sibling to another
					-- if there are valid targets outside scrollables in farther siblings.

					if jumps < closestScrollableJumps then
						-- printf("jumps=%d\tdist=%.6f\tangDiff=%d\t%s", jumps, math.sqrt(distSq), round(math.deg(angDiff)), otherEl:getPathDescription())
						closestEl              = otherEl
						closestDistSq          = distSq
						closestAngDiff         = angDiff
						closestScrollableJumps = jumps

					elseif jumps == closestScrollableJumps and distSq < closestDistSq then
						-- printf("jumps=%s\tdist=%.6f\tangDiff=%d\t%s", "^"  , math.sqrt(distSq), round(math.deg(angDiff)), otherEl:getPathDescription())
						closestEl      = otherEl
						closestDistSq  = distSq
						closestAngDiff = angDiff
					end
				end
			end

			if not ignoreCapture and (otherEl._captureInput or otherEl._captureGuiInput) then
				break
			end
		end

		return closestEl
	end

	-- otherElement|nil = element:getClosestInDirection( angle [, elementType="widget", ignoreInputCaptureState=false, ignoreConfinement=false ] )
	function Cs.element.getClosestInDirection(el, angle, elType, ignoreCapture, ignoreConfinement)
		if type(angle)~="number" then argerror(2,1,"angle",angle,"number") end
		if not(type(elType)=="string" or elType==nil) then argerror(2,2,"elType",elType,"string","nil") end
		if not(type(ignoreCapture)=="boolean" or ignoreCapture==nil) then argerror(2,3,"ignoreCapture",ignoreCapture,"boolean","nil") end
		if not(type(ignoreConfinement)=="boolean" or ignoreConfinement==nil) then argerror(2,4,"ignoreConfinement",ignoreConfinement,"boolean","nil") end
		-- local time = love.timer.getTime()

		local class = elType and requireElementClass(elType, 2) or Cs.widget

		updateLayoutIfNeeded(el._gui)

		-- @Robustness @Speed: The way we do things here is not great!
		-- @Robustness @Speed: The way we do things here is not great!
		-- @Robustness @Speed: The way we do things here is not great!

		local navRoot  = ignoreConfinement and el._gui._root or el:getNavigationRoot()
		local elements = navRoot:collectVisible(__STATIC10)

		local centerX, centerY = el:getCenterPositionOnScreen()

		local fromX     = centerX + .495*el._layoutWidth *math.cos(angle)
		local fromY     = centerY + .495*el._layoutHeight*math.sin(angle)
		local closestEl = _getClosestInDirection(elements, class, fromX,fromY, angle, ignoreCapture, el)

		if not closestEl and not ignoreConfinement and navRoot._confineNavigation then
			fromX     = centerX - 10000*math.cos(angle)
			fromY     = centerY - 10000*math.sin(angle)
			closestEl = _getClosestInDirection(elements, class, fromX,fromY, angle, ignoreCapture, nil)
		end

		-- print("time", (love.timer.getTime()-time)*1000)
		return closestEl
	end
end

do
	-- otherElement|nil = element:getClosestInDirection( angle [, elementType="widget", ignoreInputCaptureState=false, ignoreConfinement=false ] )
	function Cs.element.getClosestInDirection(el, angle, elType, ignoreCapture, ignoreConfinement)
		if type(angle)~="number" then argerror(2,1,"angle",angle,"number") end
		if not(type(elType)=="string" or elType==nil) then argerror(2,2,"elType",elType,"string","nil") end
		if not(type(ignoreCapture)=="boolean" or ignoreCapture==nil) then argerror(2,3,"ignoreCapture",ignoreCapture,"boolean","nil") end
		if not(type(ignoreConfinement)=="boolean" or ignoreConfinement==nil) then argerror(2,4,"ignoreConfinement",ignoreConfinement,"boolean","nil") end
		-- local time = love.timer.getTime()

		local class = elType and requireElementClass(elType, 2) or Cs.widget

		updateLayoutIfNeeded(el._gui)

		local lastNavRoot      = ignoreConfinement and el._gui._root or el:getNavigationRoot()
		local centerX, centerY = el:getCenterPositionOnScreen()
		local fromX            = centerX + .495*el._layoutWidth *math.cos(angle)
		local fromY            = centerY + .495*el._layoutHeight*math.sin(angle)

		-- @Incomplete:
		-- * traverse up through scrollables and use them as nav roots
		-- * loop through valid targets in nav root, finding the best fit
		-- * if encountering scrollable, treat as valid target if it contains any valid targets inside - ignore otherwise

		-- print("time", (love.timer.getTime()-time)*1000)
		return nil
	end
end

do
	local function getNextOrPrevious(el, elType, ignoreCapture, usePrev)
		local class = elType and requireElementClass(elType, 3) or Cs.widget

		local root = el._gui._root
		if not root or root._hidden then  return nil  end

		local foundSelf = false
		local lastMatch = nil

		for _, otherEl in ipairs(el:getNavigationRoot():collectVisible(__STATIC11)) do
			-- Note: Remember that we're traversing backwards.

			local elIsValid = otherEl:is(class)
			if elIsValid and usePrev and foundSelf then  return otherEl  end

			foundSelf = (foundSelf or otherEl == el)
			if not usePrev and foundSelf then
				return lastMatch -- May be nil.
			end

			if elIsValid then  lastMatch = otherEl  end

			if not ignoreCapture and (otherEl._captureInput or otherEl._captureGuiInput) then
				break
			end
		end

		return nil
	end

	-- otherElement = element:getNext( [ elType="widget", ignoreInputCaptureState=false ] )
	function Cs.element.getNext(el, elType, ignoreCapture)
		return (getNextOrPrevious(el, elType, ignoreCapture, false))
	end

	-- otherElement = element:getPrevious( [ elType="widget", ignoreInputCaptureState=false ] )
	function Cs.element.getPrevious(el, elType, ignoreCapture)
		return (getNextOrPrevious(el, elType, ignoreCapture, true))
	end
end



-- value = element:getData( key )
-- Note: element:getData(k) is the same as element.data[k]
function Cs.element.getData(el, k)
	-- @Memory: We probably don't need _data to always be set, but we'd probably
	-- have to remove the element.data property and change some other things.
	return el._data[k]
end

-- element:setData( key, value )
-- Note: element:setData(key, value) is the same as element.data[key]=value
function Cs.element.setData(el, k, v)
	el._data[k] = v
end

-- oldDataTable = element:swapData( newDataTable )
function Cs.element.swapData(el, data)
	if type(data)~="table" then argerror(2,1,"data",data,"table") end
	local oldData = el._data
	el._data      = data
	el.data       = data
	return oldData
end



-- width, height = element:getDimensions( )
-- width  = element:getWidth( )
-- height = element:getHeight( )
function Cs.element.getDimensions(el)
	return el._width, el._height
end
function Cs.element.getWidth(el)
	return el._width
end
function Cs.element.getHeight(el)
	return el._height
end

-- element:setDimensions( width, height )
-- element:setWidth( width )
-- element:setHeight( height )
-- Negative values means dynamic size.
function Cs.element.setDimensions(el, w, h)
	if type(w)~="number" then argerror(2,1,"w",w,"number") end
	if type(h)~="number" then argerror(2,2,"h",h,"number") end
	if el._width == w and el._height == h then  return  end
	el._width  = w
	el._height = h
	scheduleLayoutUpdateIfDisplayed(el)
end
function Cs.element.setWidth(el, w)
	if type(w)~="number" then argerror(2,1,"w",w,"number") end
	if el._width == w then  return  end
	el._width = w
	scheduleLayoutUpdateIfDisplayed(el)
end
function Cs.element.setHeight(el, h)
	if type(h)~="number" then argerror(2,1,"h",h,"number") end
	if el._height == h then  return  end
	el._height = h
	scheduleLayoutUpdateIfDisplayed(el)
end



-- width, height = element:getRelativeDimensions( )
-- width  = element:getRelativeWidth( )
-- height = element:getRelativeHeight( )
function Cs.element.getRelativeDimensions(el)
	return el._relativeWidth, el._relativeHeight
end
function Cs.element.getRelativeWidth(el)
	return el._relativeWidth
end
function Cs.element.getRelativeHeight(el)
	return el._relativeHeight
end

-- element:setRelativeDimensions( width, height )
-- element:setRelativeWidth( width )
-- element:setRelativeHeight( height )
-- Negative values disable relative size.
function Cs.element.setRelativeDimensions(el, w, h)
	if type(w)~="number" then argerror(2,1,"w",w,"number") end
	if type(h)~="number" then argerror(2,2,"h",h,"number") end
	if el._relativeWidth == w and el._relativeHeight == h then  return  end
	el._relativeWidth  = w
	el._relativeHeight = h
	scheduleLayoutUpdateIfDisplayed(el)
end
function Cs.element.setRelativeWidth(el, w)
	if type(w)~="number" then argerror(2,1,"w",w,"number") end
	if el._relativeWidth == w then  return  end
	el._relativeWidth = w
	scheduleLayoutUpdateIfDisplayed(el)
end
function Cs.element.setRelativeHeight(el, h)
	if type(h)~="number" then argerror(2,1,"h",h,"number") end
	if el._relativeHeight == h then  return  end
	el._relativeHeight = h
	scheduleLayoutUpdateIfDisplayed(el)
end



-- width, height = element:getMinDimensions( )
-- width  = element:getMinWidth( )
-- height = element:getMinHeight( )
function Cs.element.getMinDimensions(el)
	return el._minWidth, el._minHeight
end
function Cs.element.getMinWidth(el)
	return el._minWidth
end
function Cs.element.getMinHeight(el)
	return el._minHeight
end

-- element:setMinDimensions( width, height )
-- element:setMinWidth( width )
-- element:setMinHeight( height )
function Cs.element.setMinDimensions(el, w, h)
	if type(w)~="number" then argerror(2,1,"w",w,"number") end
	if type(h)~="number" then argerror(2,2,"h",h,"number") end
	w = math.max(w, 0)
	h = math.max(h, 0)
	if el._minWidth == w and el._minHeight == h then  return  end
	el._minWidth  = w
	el._minHeight = h
	scheduleLayoutUpdateIfDisplayed(el)
end
function Cs.element.setMinWidth(el, w)
	if type(w)~="number" then argerror(2,1,"w",w,"number") end
	w = math.max(w, 0)
	if el._minWidth == w then  return  end
	el._minWidth = w
	scheduleLayoutUpdateIfDisplayed(el)
end
function Cs.element.setMinHeight(el, h)
	if type(h)~="number" then argerror(2,1,"h",h,"number") end
	h = math.max(h, 0)
	if el._minHeight == h then  return  end
	el._minHeight = h
	scheduleLayoutUpdateIfDisplayed(el)
end



-- width, height = element:getMaxDimensions( )
-- width  = element:getMaxWidth( )
-- height = element:getMaxHeight( )
function Cs.element.getMaxDimensions(el)
	return el._maxWidth, el._maxHeight
end
function Cs.element.getMaxWidth(el)
	return el._maxWidth
end
function Cs.element.getMaxHeight(el)
	return el._maxHeight
end

-- element:setMaxDimensions( width, height )
-- element:setMaxWidth( width )
-- element:setMaxHeight( height )
-- Negative values remove restrictions.
function Cs.element.setMaxDimensions(el, w, h)
	if type(w)~="number" then argerror(2,1,"w",w,"number") end
	if type(h)~="number" then argerror(2,2,"h",h,"number") end
	if el._maxWidth == w and el._maxHeight == h then  return  end
	el._maxWidth  = w
	el._maxHeight = h
	scheduleLayoutUpdateIfDisplayed(el)
end
function Cs.element.setMaxWidth(el, w)
	if type(w)~="number" then argerror(2,1,"w",w,"number") end
	if el._maxWidth == w then  return  end
	el._maxWidth = w
	scheduleLayoutUpdateIfDisplayed(el)
end
function Cs.element.setMaxHeight(el, h)
	if type(h)~="number" then argerror(2,1,"h",h,"number") end
	if el._maxHeight == h then  return  end
	el._maxHeight = h
	scheduleLayoutUpdateIfDisplayed(el)
end



-- weight = element:getWeight( )
function Cs.element.getWeight(el)
	return el._weight
end

-- element:setWeight( weight )
function Cs.element.setWeight(el, weight)
	if type(weight)~="number" then argerror(2,1,"weight",weight,"number") end
	weight = math.max(weight, 0)
	if el._weight == weight then  return  end
	el._weight = weight
	scheduleLayoutUpdateIfDisplayed(el)
end



-- bool = element:hasFixedWidth( )
-- bool = element:hasFixedHeight( )
-- bool = element:hasDynamicWidth( )
-- bool = element:hasDynamicHeight( )
function Cs.element.hasFixedWidth   (el)  return el._width  >= 0  end
function Cs.element.hasFixedHeight  (el)  return el._height >= 0  end
function Cs.element.hasDynamicWidth (el)  return el._width  <  0  end
function Cs.element.hasDynamicHeight(el)  return el._height <  0  end

-- bool = element:hasRelativeWidth( )
-- bool = element:hasRelativeHeight( )
function Cs.element.hasRelativeWidth (el)  return el._width  < 0 and el._relativeWidth  >= 0  end
function Cs.element.hasRelativeHeight(el)  return el._height < 0 and el._relativeHeight >= 0  end



-- spacingLeft, spacingRight, spacingTop, spacingBottom = element:getSpacing( )
-- spacing = element:getSpacingLeft( )
-- spacing = element:getSpacingRight( )
-- spacing = element:getSpacingTop( )
-- spacing = element:getSpacingBottom( )
function Cs.element.getSpacing(el)
	return el._spacingLeft, el._spacingRight, el._spacingTop, el._spacingBottom
end
function Cs.element.getSpacingLeft  (el)  return el._spacingLeft    end
function Cs.element.getSpacingRight (el)  return el._spacingRight   end
function Cs.element.getSpacingTop   (el)  return el._spacingTop     end
function Cs.element.getSpacingBottom(el)  return el._spacingBottom  end

-- element:setSpacing( spacing )
-- element:setSpacing( spacingHorizontal, spacingVertical )
-- element:setSpacing( spacingLeft, spacingRight, spacingTop, spacingBottom )
-- element:setSpacingLeft( spacing )
-- element:setSpacingRight( spacing )
-- element:setSpacingTop( spacing )
-- element:setSpacingBottom( spacing )
function Cs.element.setSpacing(el, spacingL, spacingR, spacingT, spacingB)
	if type(spacingL)~="number" then argerror(2,1,"spacingL",spacingL,"number") end

	if not spacingR then
		spacingL, spacingR, spacingT, spacingB = spacingL, spacingL, spacingL, spacingL
	elseif not spacingB then
		spacingL, spacingR, spacingT, spacingB = spacingL, spacingL, spacingR, spacingR
	end

	if
		el._spacingLeft   == spacingL and
		el._spacingRight  == spacingR and
		el._spacingTop    == spacingT and
		el._spacingBottom == spacingB
	then
		return
	end

	el._spacingLeft   = spacingL
	el._spacingRight  = spacingR
	el._spacingTop    = spacingT
	el._spacingBottom = spacingB

	scheduleLayoutUpdateIfDisplayed(el)
end
function Cs.element.setSpacingLeft(el, spacing)
	if type(spacing)~="number" then argerror(2,1,"spacing",spacing,"number") end
	if el._spacingLeft == spacing then  return  end
	el._spacingLeft = spacing
	scheduleLayoutUpdateIfDisplayed(el)
end
function Cs.element.setSpacingRight(el, spacing)
	if type(spacing)~="number" then argerror(2,1,"spacing",spacing,"number") end
	if el._spacingRight == spacing then  return  end
	el._spacingRight = spacing
	scheduleLayoutUpdateIfDisplayed(el)
end
function Cs.element.setSpacingTop(el, spacing)
	if type(spacing)~="number" then argerror(2,1,"spacing",spacing,"number") end
	if el._spacingTop == spacing then  return  end
	el._spacingTop = spacing
	scheduleLayoutUpdateIfDisplayed(el)
end
function Cs.element.setSpacingBottom(el, spacing)
	if type(spacing)~="number" then argerror(2,1,"spacing",spacing,"number") end
	if el._spacingBottom == spacing then  return  end
	el._spacingBottom = spacing
	scheduleLayoutUpdateIfDisplayed(el)
end



-- gui = element:getGui( )
function Cs.element.getGui(el)
	return el._gui
end



-- time = element:getGuiTime( )
-- Alias for element:getGui():getTime().
function Cs.element.getGuiTime(el)
	return el._gui._time
end



-- id = element:getId( )
function Cs.element.getId(el)
	return el._id
end

-- element:setId( id )
function Cs.element.setId(el, id)
	if type(id)~="string" then argerror(2,1,"id",id,"string") end
	if id == "" then
		local gui            = el._gui
		local numId          = gui._lastAutomaticId + 1
		gui._lastAutomaticId = numId
		el._id               = "__" .. numId
		el._automaticId      = true
	else
		el._id               = id
		el._automaticId      = false
	end
end

-- bool = element:hasId( id1, ... )
function Cs.element.hasId(el, ...)
	for i = 1, select("#", ...) do
		if el._id == select(i, ...) then  return true  end
	end
	return false
end



-- index|nil = element:getIndex( )
-- Get the child index in the parent, if there is a parent.
function Cs.element.getIndex(el)
	return el._parent and el._parent:indexOf(el)
end

-- depth = element:getDepth( )
function Cs.element.getDepth(el)
	local depth = 0

	while el._parent do
		el    = el._parent
		depth = depth + 1
	end

	return depth
end



-- x, y, width, height = element:getLayout( )
function Cs.element.getLayout(el)
	updateLayoutIfNeeded(el._gui)
	return el._layoutX, el._layoutY, el._layoutWidth, el._layoutHeight
end

-- width, height = element:getLayoutDimensions( )
-- width  = element:getLayoutWidth( )
-- height = element:getLayoutHeight( )
function Cs.element.getLayoutDimensions(el)
	updateLayoutIfNeeded(el._gui)
	return el._layoutWidth, el._layoutHeight
end
function Cs.element.getLayoutWidth(el)
	updateLayoutIfNeeded(el._gui)
	return el._layoutWidth
end
function Cs.element.getLayoutHeight(el)
	updateLayoutIfNeeded(el._gui)
	return el._layoutHeight
end

-- x, y = element:getLayoutPosition( )
-- x = element:getLayoutX( )
-- y = element:getLayoutY( )
function Cs.element.getLayoutPosition(el)
	updateLayoutIfNeeded(el._gui)
	return el._layoutX, el._layoutY
end
function Cs.element.getLayoutX(el)
	updateLayoutIfNeeded(el._gui)
	return el._layoutX
end
function Cs.element.getLayoutY(el)
	updateLayoutIfNeeded(el._gui)
	return el._layoutY
end

-- x, y = element:getLayoutCenterPosition( )
function Cs.element.getLayoutCenterPosition(el)
	updateLayoutIfNeeded(el._gui)
	return el._layoutX + .5*el._layoutWidth,
	       el._layoutY + .5*el._layoutHeight
end



-- cursor|systemCursorType|nil = element:getMouseCursor( )
function Cs.element.getMouseCursor(el)
	return el._mouseCursor
end

-- cursor|nil = element:getResultingMouseCursor( )
function Cs.element.getResultingMouseCursor(el)
	local cur = el._mouseCursor
	if type(cur) ~= "string" then  return cur  end
	return love.mouse.getSystemCursor(cur)
end

-- element:setMouseCursor( cursor|systemCursorType|nil )
function Cs.element.setMouseCursor(el, cur)
	if not((type(cur)=='userdata'and(cur):typeOf"Cursor") or type(cur)=="string" or cur==nil) then argerror(2,1,"cur",cur,"Cursor","string","nil") end

	if type(cur) == "string" and not pcall(love.mouse.getSystemCursor, cur) then
		errorf(2, "Invalid system cursor type '%s'.", cur)
	end

	el._mouseCursor = cur
end



-- x, y = element:getMousePosition( )
-- x = element:getMouseX( )
-- y = element:getMouseY( )
-- Get the mouse position relative the element.
-- Returns nil if the mouse position is unknown.
function Cs.element.getMousePosition(el)
	local gui = el._gui
	if gui._mouseX ==  -999999 then  return nil  end
	local x, y = el:getPositionOnScreen()
	return gui._mouseX-x, gui._mouseY-y
end
function Cs.element.getMouseX(el)
	local x = el._gui._mouseX
	return x ~=  -999999 and x-el:getXOnScreen() or nil
end
function Cs.element.getMouseY(el)
	local y = el._gui._mouseY
	return y ~=  -999999 and y-el:getYOnScreen() or nil
end



-- originX, originY = element:getOrigin( )
-- origin = element:getOriginX( )
-- origin = element:getOriginY( )
function Cs.element.getOrigin(el)
	return el._originX, el._originY
end
function Cs.element.getOriginX(el)
	return el._originX
end
function Cs.element.getOriginY(el)
	return el._originY
end

-- element:setOrigin( originX, originY )
-- element:setOriginX( origin )
-- element:setOriginY( origin )
function Cs.element.setOrigin(el, originX, originY)
	if el._originX == originX and el._originY == originY then  return  end
	el._originX = originX
	el._originY = originY
	scheduleLayoutUpdateIfDisplayed(el)
end
function Cs.element.setOriginX(el, originX)
	if el._originX == originX then  return  end
	el._originX = originX
	scheduleLayoutUpdateIfDisplayed(el)
end
function Cs.element.setOriginY(el, originY)
	if el._originY == originY then  return  end
	el._originY = originY
	scheduleLayoutUpdateIfDisplayed(el)
end



-- container|nil = element:getParent( )
function Cs.element.getParent(el)
	return el._parent
end

-- containers = element:getAllParents( )
-- Returns an array of parents, with the closest parent first.
function Cs.element.getAllParents(el)
	local parents = {} -- @Memory
	local i       = 0

	while true do
		el = el._parent
		if not el then  return parents  end

		i          = i + 1
		parents[i] = el
	end
end

-- bool = element:hasParent( parent )
-- Note: Checks all grandparents too.
function Cs.element.hasParent(el, parent)
	while true do
		el = el._parent
		if not el       then  return false  end
		if el == parent then  return true   end
	end
	return false
end

-- container = element:getParentWithId( id )
function Cs.element.getParentWithId(el, id)
	while true do
		el = el._parent
		if not el       then  return nil  end
		if el._id == id then  return el   end
	end
	return nil
end

-- bool = element:hasParentWithId( id )
function Cs.element.hasParentWithId(el, id)
	return el:getParentWithId(id) ~= nil
end

-- for index, container in element:parents( )
-- Iterate over parents, from parent to grandparent.
function Cs.element.parents(el)
	local i = 0

	return function() -- @Memory: Don't use :parents() internally.
		el = el._parent
		if not el then  return  end

		i = i + 1
		return i, el
	end
end

-- for index, container in element:parentsr( )
-- Iterate over parents in reverse, from grandparent to parent.
function Cs.element.parentsr(el)
	return ipairsr(el:getAllParents())
end

-- for index, element in element:lineageUp( )
-- Traverse from self to the grandest parent.
function Cs.element.lineageUp(el)
	local i = 0

	return function()
		if not el then  return  end

		local current = el

		i  = i + 1
		el = el._parent

		return i, current
	end
end



local parts = {}

-- description = element:getPathDescription( )
function Cs.element.getPathDescription(el)
	for i = 1, #parts do  parts[i] = nil  end

	while true do
		-- Note that we construct the description in reverse.
		if not el._automaticId then
			table.insert(parts, ")")
			table.insert(parts, el._id)
			table.insert(parts, "(")
		end

		table.insert(parts, el.__name:sub(4)) -- Remove the "Gui" prefix from the class name.

		local i = el:getIndex()
		if i then
			table.insert(parts, ":")
			table.insert(parts, i)
		end

		el = el._parent
		if not el then  break  end

		table.insert(parts, "/")
	end

	reverseArray(parts)
	return table.concat(parts)
end



-- x, y = element:getPosition( )
-- x = element:getX( )
-- y = element:getY( )
function Cs.element.getPosition(el)
	return el._x, el._y
end
function Cs.element.getX(el)
	return el._x
end
function Cs.element.getY(el)
	return el._y
end

-- element:setPosition( x, y )
-- element:setX( x )
-- element:setY( y )
function Cs.element.setPosition(el, x, y)
	if el._x == x and el._y == y then  return  end
	el._x = x
	el._y = y
	scheduleLayoutUpdateIfDisplayed(el)
end
function Cs.element.setX(el, x)
	if el._x == x then  return  end
	el._x = x
	scheduleLayoutUpdateIfDisplayed(el)
end
function Cs.element.setY(el, y)
	if el._y == y then  return  end
	el._y = y
	scheduleLayoutUpdateIfDisplayed(el)
end



-- x, y = element:getPositionOnScreen( [ ignoreSmoothScrolling=false ] )
-- x = element:getXOnScreen( [ ignoreSmoothScrolling=false ] )
-- y = element:getYOnScreen( [ ignoreSmoothScrolling=false ] )
function Cs.element.getPositionOnScreen(el, ignoreSmoothScrolling)
	updateLayoutIfNeeded(el._gui)
	if    ignoreSmoothScrolling
	then  return el._layoutX+el._layoutImmediateOffsetX, el._layoutY+el._layoutImmediateOffsetY
	else  return el._layoutX+el._layoutOffsetX         , el._layoutY+el._layoutOffsetY  end
end
function Cs.element.getXOnScreen(el, ignoreSmoothScrolling)
	updateLayoutIfNeeded(el._gui)
	if    ignoreSmoothScrolling
	then  return el._layoutX+el._layoutImmediateOffsetX
	else  return el._layoutX+el._layoutOffsetX  end
end
function Cs.element.getYOnScreen(el, ignoreSmoothScrolling)
	updateLayoutIfNeeded(el._gui)
	if    ignoreSmoothScrolling
	then  return el._layoutY+el._layoutImmediateOffsetY
	else  return el._layoutY+el._layoutOffsetY  end
end

-- x, y = element:getLayoutOnScreen( [ ignoreSmoothScrolling=false ] )
function Cs.element.getLayoutOnScreen(el, ignoreSmoothScrolling)
	updateLayoutIfNeeded(el._gui)
	if    ignoreSmoothScrolling
	then  return el._layoutX+el._layoutImmediateOffsetX, el._layoutY+el._layoutImmediateOffsetY, el._layoutWidth, el._layoutHeight
	else  return el._layoutX+el._layoutOffsetX         , el._layoutY+el._layoutOffsetY         , el._layoutWidth, el._layoutHeight  end
end

-- x, y = element:getCenterPositionOnScreen( [ ignoreSmoothScrolling=false ] )
function Cs.element.getCenterPositionOnScreen(el, ignoreSmoothScrolling)
	updateLayoutIfNeeded(el._gui)
	if    ignoreSmoothScrolling
	then  return el._layoutX+.5*el._layoutWidth+el._layoutImmediateOffsetX, el._layoutY+.5*el._layoutHeight+el._layoutImmediateOffsetY
	else  return el._layoutX+.5*el._layoutWidth+el._layoutOffsetX         , el._layoutY+.5*el._layoutHeight+el._layoutOffsetY           end
end



-- root|nil = element:getRoot( )
-- Note: Returns the root the element knows of, which itself may have been
-- removed from the GUI. So this function differs slightly from gui:getRoot().
function Cs.element.getRoot(el)
	repeat
		if el.class == Cs.root then  return el  end
		el = el._parent
	until not el
	return nil -- We've been removed from the root.
end

-- container = element:getNavigationRoot( )
function Cs.element.getNavigationRoot(el)
	local container = el._parent
	if not container then  return nil  end -- Should we allow returning self if we're a container?

	while container._parent do
		if container._confineNavigation then  return container  end
		container = container._parent
	end

	return container -- We've reached the top container we know of.
end



-- sibling = element:getSibling( offset )
-- getSibling(1) returns the next sibling etc.
function Cs.element.getSibling(el, offset)
	local i = el:getIndex()
	return i and el._parent[i+offset]
end



-- sound|nil = element:getSound( soundKey )
function Cs.element.getSound(el, soundK)
	if type(soundK)~="string" then argerror(2,1,"soundK",soundK,"string") end
	checkValidSoundKey(soundK, 2)
	return el._sounds and el._sounds[soundK]
end

-- sound|nil = element:getResultingSound( soundKey )
function Cs.element.getResultingSound(el, soundK)
	if type(soundK)~="string" then argerror(2,1,"soundK",soundK,"string") end
	checkValidSoundKey(soundK, 2)

	local sound = el._sounds and el._sounds[soundK]

	if sound == nil then
		for _, parent in el:parents() do
			sound = parent._sounds and parent._sounds[soundK]
			if sound ~= nil then  break  end
		end
		if sound == nil and el._gui then
			sound = el._gui._defaultSounds[soundK]
		end
	end

	if sound == false then  sound = nil  end -- Special case: The value false intercepts the bubbling and tells that no sound should be played.

	return sound
end

-- element:setSound( soundKey, sound )
-- element:setSound( soundKey, false ) -- Prevent sound from playing, even if a default sound is set.
-- element:setSound( soundKey, nil   ) -- Remove sound.
function Cs.element.setSound(el, soundK, sound)
	if type(soundK)~="string" then argerror(2,1,"soundK",soundK,"string") end
	checkValidSoundKey(soundK, 2)
	el._sounds         = el._sounds or {}
	el._sounds[soundK] = sound
end



-- style = element:getStyle( )
function Cs.element.getStyle(el)
	return el._style
end



-- duration = element:getTimeSinceBecomingVisible( )
function Cs.element.getTimeSinceBecomingVisible(el)
	return el._gui._time - el._timeBecomingVisible
end



-- tooltip = element:getTooltip( )
function Cs.element.getTooltip(el)
	return el._tooltip
end

-- element:setTooltip( text )
function Cs.element.setTooltip(el, unprocessedText)
	unprocessedText = tostring(unprocessedText == nil and "" or unprocessedText)

	local text = preprocessText(el._gui, unprocessedText, el, false)
	if el._tooltip == text then  return  end -- @Speed: Maybe do this check for the unprocessedText?

	el._tooltip            = text
	el._unprocessedTooltip = unprocessedText
end



-- element:drawTooltip( x, y )
function Cs.element.drawTooltip(el, x, y)
	love.graphics.print(el._tooltip, x, y)
end



-- font = element:getResultingTooltipFont( )
function Cs.element.getResultingTooltipFont(el)
	return el._gui._fontTooltip or _M.getDefaultFont()
end

-- fontBeingUsed = element:useTooltipFont( )
-- Tell LÖVE to use the element's resulting tooltip font.
function Cs.element.useTooltipFont(el)
	local font = el:getResultingTooltipFont()
	love.graphics.setFont(font)
	return font
end



-- bool = element:hasTag( tag )
function Cs.element.hasTag(el, tag)
	return (el._tags and el._tags[tag]) ~= nil
end

-- element:addTag( tag )
function Cs.element.addTag(el, tag)
	el._tags      = el._tags or {}
	el._tags[tag] = true
end

-- element:removeTag( tag )
-- element:removeAllTags( )
function Cs.element.removeTag(el, tag)
	if not el._tags then  return  end
	el._tags[tag] = nil
end
function Cs.element.removeAllTags(el)
	if el._tags and next(el._tags) then
		el._tags = nil
	end
end

-- element:setTag( tag, bool )
function Cs.element.setTag(el, tag, state)
	if state then  el:addTag(tag)
	else           el:removeTag(tag)  end
end



-- bool = element:isAt( x, y )
function Cs.element.isAt(el, x, y)
	updateLayoutIfNeeded(el._gui)

	x = x - el._layoutOffsetX
	y = y - el._layoutOffsetY

	return x >= el._layoutX
	   and y >= el._layoutY
	   and x <  el._layoutX + el._layoutWidth
	   and y <  el._layoutY + el._layoutHeight
end



-- handled, grabKeyboardFocus = element:_keypressed( key, scancode, isRepeat )
function Cs.element._keypressed(el, key, scancode, isRepeat)
	return false, false
end

-- INTERNAL  element:_keyreleased( key, scancode )
function Cs.element._keyreleased(el, key, scancode)
	-- void
end

-- handled = element:_textinput( text )
function Cs.element._textinput(el, text)
	return false
end



-- handled, grabMouseFocus = element:_mousepressed( mouseX, mouseY, mouseButton, pressCount )
function Cs.element._mousepressed(el, mx, my, mbutton, pressCount)
	return false, false
end

-- INTERNAL  element:_mousemoved( mouseX, mouseY, deltaX, deltaY )
function Cs.element._mousemoved(el, mx, my, dx, dy)
	-- void
end

-- INTERNAL  element:_mousereleased( mouseX, mouseY, mouseButton, pressCount )
function Cs.element._mousereleased(el, mx, my, mbutton, pressCount)
	-- void
end

-- handled = element:_wheelmoved( deltaX, deltaY, deltaX0, deltaY0 )
function Cs.element._wheelmoved(el, dx, dy, dx0, dy0)
	return false
end



-- bool = element:isDisplayed( )
-- Returns true if the element and its parents are visible (and the element exists).
function Cs.element.isDisplayed(el)
	if not el:exists() then  return false  end
	repeat
		if el._hidden then  return false  end
		el = el._parent
	until not el
	return true
end

-- hiddenElement|nil = element:getClosestHiddenElement( )
-- hiddenElement|nil = element:getFarthestHiddenElement( )
function Cs.element.getClosestHiddenElement(el)
	repeat
		if el._hidden then  return el  end
		el = el._parent
	until not el
	return nil
end
function Cs.element.getFarthestHiddenElement(el)
	local hiddenEl = nil
	repeat
		if el._hidden then  hiddenEl = el  end
		el = el._parent
	until not el
	return hiddenEl
end



-- bool = element:isFirst( )
-- bool = element:isLast( )
function Cs.element.isFirst(el)
	return not el._parent or el:getIndex() == 1
end
function Cs.element.isLast(el)
	return not el._parent or el:getIndex() == #el._parent
end



-- bool = element:isHidden( )
-- bool = element:isVisible( )
function Cs.element.isHidden(el)
	return el._hidden
end
function Cs.element.isVisible(el)
	return not el._hidden
end

-- stateChanged = element:setHidden( bool )
function Cs.element.setHidden(el, hidden)
	if type(hidden)~="boolean" then argerror(2,1,"hidden",hidden,"boolean") end
	if el._hidden == hidden then  return false  end

	local wasDisplayed = el:isDisplayed()
	el._hidden         = hidden
	local isDisplayed  = el:isDisplayed()
	local gui          = el._gui

	if wasDisplayed or isDisplayed then
		if wasDisplayed then  validateVariousCurrentElements(gui)  end

		gui._layoutNeedsUpdate = true

		if isDisplayed then
			local time              = gui._time
			el._timeBecomingVisible = time

			if el:is(Cs.container) then
				el:visitVisible(__LAMBDA3(time))
			end
		end
	end

	trigger(el, (hidden and "hide" or "show"))
	return true
end

-- stateChanged = element:setVisible( bool )
function Cs.element.setVisible(el, visible)
	return el:setHidden(not visible)
end

-- stateChanged = element:show( )
-- stateChanged = element:hide( )
-- stateChanged = element:toggleHidden( )
function Cs.element.show(el)
	return el:setHidden(false)
end
function Cs.element.hide(el)
	return el:setHidden(true)
end
function Cs.element.toggleHidden(el)
	return el:setHidden(not el._hidden)
end



-- bool = element:isHovered( [ ignoreMouseFocus=false ] )
function Cs.element.isHovered(el, ignoreMouseFocus)
	local gui = el._gui
	updateLayoutIfNeeded(gui) -- Updates hovered element.
	return el == gui._hoveredElement and (ignoreMouseFocus or el == (gui._mouseFocus or el))
end



-- bool = element:isMouseFocus( )
-- bool = element:isKeyboardFocus( )
function Cs.element.isMouseFocus(el)
	return el == el._gui._mouseFocus
end
function Cs.element.isKeyboardFocus(el)
	return el == el._gui._keyboardFocus
end



-- bool = element:isNavigationTarget( )
function Cs.element.isNavigationTarget(el)
	return el == el._gui._navigationTarget
end



-- bool = element:isSolid( )
-- Solid elements have collision and cannot be clicked through.
function Cs.element.isSolid(el)
	return false
end



-- bool = element:isType( elementType )
function Cs.element.isType(el, elType)
	return el:is(requireElementClass(elType, 2))
end



-- element:playSound( soundKey )
function Cs.element.playSound(el, soundK)
	if type(soundK)~="string" then argerror(2,1,"soundK",soundK,"string") end
	checkValidSoundKey(soundK, 2)

	local soundPlayer = el._gui     and el._gui._soundPlayer
	local sound       = soundPlayer and el:getResultingSound(soundK)

	if sound ~= nil then  soundPlayer(sound)  end
end



-- element:refresh( )
-- Trigger helper event "refresh".
function Cs.element.refresh(el)
	trigger(el, "refresh")
end



-- handled = element:_ok( )
function Cs.element._ok(el)
	return false
end



-- element:remove( )
-- Remove element from parent.
function Cs.element.remove(el)
	local parent = el._parent
	if parent then
		parent:removeAt(parent:indexOf(el))
	end
end



-- element:reprocessTexts( )
-- Manually re-preprocess texts. Also see gui:reprocessTexts().
function Cs.element.reprocessTexts(el)
	el:setTooltip(el._unprocessedTooltip)
end



-- element:scrollIntoView( [ scrollToDetail=false ] )
-- For input elements, scrollToDetail scrolls to the text cursor.
function Cs.element.scrollIntoView(el, scrollToDetail)
	updateLayoutIfNeeded(el._gui)

	local sbW     = themeGet(el._gui, "scrollbarWidth")
	local navSize = themeGet(el._gui, "navigationSize")

	local x1, y1 = el:getPositionOnScreen(true)
	local x2, y2 = x1+el._layoutWidth, y1+el._layoutHeight

	if scrollToDetail and el:is(Cs.input) then
		local inputEl                      = el
		local valueX, valueY               = inputEl:getValueLayout()
		local curOffsetX, curOffsetY, curH = inputEl._field:getCursorLayout()
		local inputIndent                  = themeGet(inputEl._gui, "inputIndentation")

		x1 = x1 + valueX + curOffsetX - inputIndent
		y1 = y1 + valueY + curOffsetY - inputIndent
		x2 = x1                       + 2*inputIndent
		y2 = y1 + curH                + 2*inputIndent
	end

	x1 = x1 - navSize
	y1 = y1 - navSize
	x2 = x2 + navSize
	y2 = y2 + navSize

	-- @Incomplete: navSize should probably be applied in places here below,
	-- (though it only matters if there are scrollables inside scrollables).

	repeat
		local parent = el._parent

		if parent:canScrollX() or parent:canScrollY() then
			local scrollX = parent._scrollX
			local scrollY = parent._scrollY

			if parent:canScrollX() then
				local distOutside = parent:getXOnScreen(true) - x1
				if distOutside >= 0 then
					scrollX = scrollX + distOutside
				else
					distOutside = x2 - (parent:getXOnScreen(true) + parent._layoutWidth - (parent:canScrollY() and sbW or 0))
					if distOutside > 0 then  scrollX = scrollX - distOutside  end
				end
				x1 = el:getXOnScreen(true)
				x2 = x1 + el._layoutWidth
			end

			if parent:canScrollY() then
				local distOutside = parent:getYOnScreen(true) - y1
				if distOutside >= 0 then
					scrollY = scrollY + distOutside
				else
					distOutside = y2 - (parent:getYOnScreen(true) + parent._layoutHeight - (parent:canScrollX() and sbW or 0))
					if distOutside > 0 then  scrollY = scrollY - distOutside  end
				end
				y1 = el:getYOnScreen(true)
				y2 = y1 + el._layoutHeight
			end

			parent:setScroll(scrollX, scrollY)
		end

		el, parent = parent, parent._parent
	until not parent
end



-- element:setScissor( relativeX, relativeY, width, height [, ignoreParentScrollables=false ] )
-- element:setScissor( ) -- Only applies scissors from parent scrollables.
-- Helper function for themes' drawing functions.
-- Note that each call replaces the previous scissor.
function Cs.element.setScissor(el, x, y, w, h, ignoreScrollables)
	local gui = el._gui

	el:unsetScissor()

	if x then
		setScissor(gui, el:getXOnScreen()+x, el:getYOnScreen()+y, w, h)
		gui._elementScissorIsSet = true
	end

	if not ignoreScrollables then
		local parent = el._parent

		while parent do
			if not parent then  break  end

			if parent:canScrollAny() then
				local parentX, parentY = parent:getPositionOnScreen()

				if not gui._elementScissorIsSet then
					setScissor(gui, parentX, parentY, parent:getChildAreaDimensions())
					gui._elementScissorIsSet = true
				else
					intersectScissor(el._gui, parentX, parentY, parent:getChildAreaDimensions())
				end
			end

			parent = parent._parent
		end
	end
end

-- element:unsetScissor( )
-- Remove scissor set by element:setScissor().
-- Helper function for themes' drawing functions.
function Cs.element.unsetScissor(el)
	local gui = el._gui
	if gui._elementScissorIsSet then
		setScissor(gui, nil)
		gui._elementScissorIsSet = false
	end
end



-- menuElement = element:showMenu( items [, highlightedIndex|highlightedIndices ][, offsetX=0, offsetY=0 ][, callback ] )
-- items       = { itemText1|itemInfo1, ... }
-- itemInfo    = { itemText1, itemExtraText1 }
-- callback    = function( index, itemText ) -- 'index' will be 0 if no item was chosen.
function Cs.element.showMenu(el, items, hlIndices, offsetX, offsetY, cb)
	if type(items)~="table" then argerror(2,1,"items",items,"table") end
	-- @Cleanup

	-- showMenu( items, highlightedIndex,   offsetX, offsetY, callback )
	-- showMenu( items, highlightedIndices, offsetX, offsetY, callback )
	if (type(hlIndices) == "number" or type(hlIndices) == "table") and type(offsetX) == "number" and type(offsetY) == "number" then
		-- void

	-- showMenu( items, offsetX, offsetY, callback )
	elseif (type(hlIndices) == "number" or type(hlIndices) == "table") and type(offsetX) == "number" then
		hlIndices, offsetX, offsetY, cb = nil, hlIndices, offsetX, offsetY

	-- showMenu( items, highlightedIndex,   callback )
	-- showMenu( items, highlightedIndices, callback )
	elseif type(hlIndices) == "number" or type(hlIndices) == "table" then
		offsetX, offsetY, cb = 0, 0, offsetX

	-- showMenu( items, callback )
	else
		hlIndices, offsetX, offsetY, cb = nil, 0, 0, hlIndices
	end

	if type(cb) ~= "function" then
		error("Missing callback argument.", 2)
	end
	if type(hlIndices) == "number" then
		hlIndices = {hlIndices}
	end

	local gui  = el._gui
	local root = el:getRoot()

	updateLayoutIfNeeded(gui) -- So we get the correct self size and position here below.

	-- Create menu.

	local menu = root:insert{
		type="container", style="_MENU", relativeWidth=1, relativeHeight=1,
		closable=true, captureGuiInput=true, confineNavigation=true,
		[1] = {type="vbar", minWidth=el._layoutWidth, maxHeight=root._layoutHeight-root:getInnerSpaceY()},
	}

	menu:on("closed", function(button, event)
		local _cb = cb
		cb        = nil

		menu:remove()

		if _cb then  _cb(0, "")  end
	end)

	menu:on("mousepressed", function(button, event, mx, my, mbutton, pressCount)
		menu:close()
	end)

	-- Add menu items.
	local buttons = menu[1]

	for i, text in ipairs(items) do
		local text2 = nil
		if type(text) == "table" then  text, text2 = unpack(text)  end

		local isToggled = (hlIndices ~= nil and indexOf(hlIndices, i) ~= nil)
		local button    = buttons:insert{ type="button", text=text, text2=text2, align="left", toggled=isToggled }

		button:on("mousepressed", function(button, event, mx, my, mbutton, pressCount)
			if mbutton == 1 then  button:press()  end
			return true -- Prevent the menu from receiving the mousepressed event.
		end)

		button:on("press", function(button, event)
			local _cb = cb
			cb        = nil

			menu:remove()

			if _cb then  _cb(i, text)  end
		end)

		button:on("navigated", function(button, event)
			buttons:setToggledChild(button._id)
		end)
	end

	if not buttons[1] then
		warn(2, "No menu buttons.")
	end

	local searchTerm       = ""
	local searchStartIndex = 1
	local lastInputTime    = -99

	if gui._standardKeysAreActive or gui._standardKeysAreActiveInMenus then
		menu:on("keypressed", function(button, event, key, scancode, isRepeat)
			if key == "up" then
				local button     = buttons:getToggledChild()
				searchStartIndex = button and (button:getIndex()-2)%#buttons+1 or 1
				lastInputTime    = -99
				gui:navigateTo(buttons[searchStartIndex])
				return true

			elseif key == "down" then
				local button     = buttons:getToggledChild()
				searchStartIndex = button and button:getIndex()%#buttons+1 or 1
				lastInputTime    = -99
				gui:navigateTo(buttons[searchStartIndex])
				return true

			elseif key == "home" or key == "pageup" then
				searchStartIndex = 1
				lastInputTime    = -99
				gui:navigateTo(buttons[searchStartIndex])
				return true

			elseif key == "end" or key == "pagedown" then
				searchStartIndex = #buttons
				lastInputTime    = -99
				gui:navigateTo(buttons[searchStartIndex])
				return true

			elseif key == "return" or key == "kpenter" then
				local button = buttons:getToggledChild()
				if button then  button:press()  end
				return true

			elseif gui._standardKeysAreActive and (key == "left" or key == "right" or key == "tab") then
				-- Prevent _standardKeysAreActive from doing stuff in gui:keypressed().
				return true
			end
		end)
	end

	menu:on("textinput", function(button, event, text)
		if not buttons[1] then  return  end

		-- Append to old or start a new term.
		local time = gui._time
		if time-lastInputTime > 1.00 then
			searchTerm       = text:lower()
			local button     = buttons:getToggledChild()
			searchStartIndex = button and button:getIndex() or 1
		else
			searchTerm = searchTerm..text:lower()
		end
		lastInputTime = time

		-- Pressing the same letter over and over should just cycle through all items starting with that letter.
		if #searchTerm > 1 then -- @Robustness: Use UTF-8 character length - not byte length!
			local firstChar = searchTerm:match"^[%z\1-\127\194-\244][\128-\191]*"
			local reps      = #searchTerm / #firstChar

			if reps == math.floor(reps) and searchTerm == firstChar:rep(reps) then
				local i        = searchStartIndex
				local foundAny = false

				while true do
					i            = i % #buttons + 1
					local button = buttons[i]

					if button._text:lower():find(firstChar, 1, true) == 1 then
						reps     = reps - 1
						foundAny = true

						if reps <= 0 then
							gui:navigateTo(button)
							return
						end

					elseif i == searchStartIndex and not foundAny then
						return
					end
				end

			end
		end

		-- Otherwise search for the whole term.
		for i = 1, #buttons do
			i = (searchStartIndex+i-1)%#buttons+1
			local button = buttons[i]

			if button._text:lower():find(searchTerm, 1, true) == 1 then
				gui:navigateTo(button)
				break
			end
		end
	end)

	-- Set position.

	menu:_calculateNaturalSize() -- Expanding and positioning of the whole menu isn't necessary right here.

	if buttons._layoutHeight >= buttons._maxHeight then
		buttons._canScrollY = true -- @Incomplete @Cleanup: Add setCanScrollX/Y() method.
	end

	buttons:setPosition(
		clamp(el:getXOnScreen()-(root:getXOnScreen()+root._paddingLeft)+offsetX, 0, root._width -root:getInnerSpaceX()-buttons._layoutWidth ),
		clamp(el:getYOnScreen()-(root:getYOnScreen()+root._paddingTop )+offsetY, 0, root._height-root:getInnerSpaceY()-buttons._layoutHeight)
	)

	local button = buttons:getToggledChild()
	if button then  gui:navigateTo(button)  end

	return menu
end



-- FINAL  element:updateLayoutNow( )
-- Force a layout update. (Should never be needed as it's done automatically.)
-- Also see gui:scheduleLayoutUpdate() and gui:updateLayoutNow().
function Cs.element.updateLayoutNow(el)
	updateLayout(el)
end

-- INTERNAL  element:_calculateNaturalSize( )
-- (Subclasses should replace this method.)
function Cs.element._calculateNaturalSize(el)
	-- void
end

-- INTERNAL  element:_expandAndPositionChildren( )
function Cs.element._expandAndPositionChildren(el)
	-- void
end



--==============================================================
--= Container element class ====================================
--==============================================================



Cs.container = newElementClass(false, "GuiContainer", Cs.element, {}, {
	-- Parameters.
	_confineNavigation = false,
	_solid             = false,

	_paddingLeft   = 0, -- Falls back to 'paddingHorizontal' and 'padding'.
	_paddingRight  = 0, -- Falls back to 'paddingHorizontal' and 'padding'.
	_paddingTop    = 0, -- Falls back to 'paddingVertical' and 'padding'.
	_paddingBottom = 0, -- Falls back to 'paddingVertical' and 'padding'.

	_canScrollX = false,
	_canScrollY = false,
	--

	_contentWidth  = 0,
	_contentHeight = 0,

	_mouseScrollDirection = "", -- "" | "x" | "y"
	_mouseScrollOffset    = 0,

	_scrollX = 0.0,
	_scrollY = 0.0,

	_visualScrollX = 0.0,
	_visualScrollY = 0.0,
}, {
	-- void
})

function Cs.container.init(container, gui, elData, parent)
	Cs.container.super.init(container, gui, elData, parent)

	if elData.canScrollX ~= nil then container._canScrollX = elData.canScrollX end if elData.canScrollY ~= nil then container._canScrollY = elData.canScrollY end
	if elData.confineNavigation ~= nil then container._confineNavigation = elData.confineNavigation end
	-- @@retrieve(container, elData, _paddingLeft, _paddingRight, _paddingTop, _paddingBottom)
	if elData.solid ~= nil then container._solid = elData.solid end

	container._paddingLeft   = elData.paddingLeft   or elData.paddingHorizontal or elData.padding
	container._paddingRight  = elData.paddingRight  or elData.paddingHorizontal or elData.padding
	container._paddingTop    = elData.paddingTop    or elData.paddingVertical   or elData.padding
	container._paddingBottom = elData.paddingBottom or elData.paddingVertical   or elData.padding

	for i, childData in ipairs(elData) do
		local class  = Cs[getTypeFromElementData(childData)] or errorf("Bad element type '%s'.", getTypeFromElementData(childData))
		local child  = class(gui, childData, container)
		container[i] = child
	end
end



-- INTERNAL OVERRIDE  container:_update( deltaTime )
function Cs.container._update(container, dt)
	Cs.container.super._update(container, dt)

	for _, child in ipairs(container) do
		child:_update(dt)
	end

	local scrollX = container._scrollX
	local scrollY = container._scrollY

	local visualScrollX = container._visualScrollX
	local visualScrollY = container._visualScrollY

	local didScroll = false

	if visualScrollX ~= scrollX then
		visualScrollX = damp(scrollX, visualScrollX, container._gui._scrollSmoothness, dt)
		if math.abs(visualScrollX-scrollX) < .5 then  visualScrollX = scrollX  end
		didScroll = true
	end
	if visualScrollY ~= scrollY then
		visualScrollY = damp(scrollY, visualScrollY, container._gui._scrollSmoothness, dt)
		if math.abs(visualScrollY-scrollY) < .5 then  visualScrollY = scrollY  end
		didScroll = true
	end

	if didScroll then
		setVisualScroll(container, visualScrollX, visualScrollY)
	end
end



local function drawChildrenAndMaybeNavigationTarget(container, cullX1, cullY1, cullX2, cullY2, childToDrawNavTargetAfter)
	for _, child in ipairs(container) do
		local x, y, w, h = xywhOnScreen(child)
		local drawChild  = child:is(Cs.container) or (x+w >= cullX1-1 and y+h >= cullY1-1 and x < cullX2+1 and y < cullY2+1)

		if child == childToDrawNavTargetAfter then
			if drawChild then
				child:_draw(cullX1, cullY1, cullX2, cullY2, nil)
			end
			if not container._gui.debug then
				themeRender(container._gui._navigationTarget, "navigation", container._gui._timeSinceNavigation) -- We don't really need to cull this.
			end
		else
			if drawChild then
				child:_draw(cullX1, cullY1, cullX2, cullY2, childToDrawNavTargetAfter)
			end
		end
	end
end

-- INTERNAL REPLACE  container:_draw( cullX1, cullY1, cullX2, cullY2, childToDrawNavTargetAfter )
function Cs.container._draw(container, cullX1, cullY1, cullX2, cullY2, childToDrawNavTargetAfter)
	if container._hidden then  return  end

	local gui        = container._gui
	local x, y, w, h = xywhOnScreen(container)

	local childAreaW, childAreaH = container:getChildAreaDimensions()

	local sbW = themeGet(gui, "scrollbarWidth") -- @Incomplete: Get scrollbar width through themeGetSize().

	local canScrollX = container:canScrollX()
	local canScrollY = container:canScrollY()

	if not container._gui.debug then
		triggerIncludingAnimations(container, "beforedraw", x, y, w, h)
	end

	drawLayoutBackground(container)
	container:_drawDebug(0, 0, 1)

	if canScrollX or canScrollY then
		setScissor(gui, x, y, childAreaW, childAreaH) -- Should there be an option to not scissor scrollable containers? @Incomplete
		if container._gui._culling then
			cullX1 = math.max(cullX1, x)
			cullY1 = math.max(cullY1, y)
			cullX2 = math.min(cullX2, x+childAreaW)
			cullY2 = math.min(cullY2, y+childAreaH)
		end
	end
	drawChildrenAndMaybeNavigationTarget(container, cullX1, cullY1, cullX2, cullY2, childToDrawNavTargetAfter)
	if canScrollX or canScrollY then
		setScissor(gui, nil)
	end

	if not container._gui.debug then
		-- Scrollbars.
		if canScrollX then
			local handlePos, handleLen = container:getScrollHandleX()
			themeRenderArea(container, "scrollbar", 0, h-sbW, childAreaW, sbW, "x", round(handlePos), handleLen)
		end
		if canScrollY then
			local handlePos, handleLen = container:getScrollHandleY()
			themeRenderArea(container, "scrollbar", w-sbW, 0, sbW, childAreaH, "y", round(handlePos), handleLen)
		end
		if canScrollX and canScrollY then
			themeRenderArea(container, "scrollbardeadzone", w-sbW, h-sbW, sbW, sbW)
		end

		triggerIncludingAnimations(container, "afterdraw", x, y, w, h)
	end
end



-- element|nil = container:find( id )
function Cs.container.find(container, id)
	for el in container:traverse() do
		if el._id == id then  return el  end
	end
	return nil
end

-- elements = container:findAll( id )
function Cs.container.findAll(container, id)
	local els = {}
	for el in container:traverse() do
		if el._id == id then  table.insert(els, el)  end
	end
	return els
end

-- element|nil = container:findType( elementType )
function Cs.container.findType(container, elType)
	local class = requireElementClass(elType, 2)

	for el in container:traverse() do
		if el:is(class) then  return el  end
	end

	return nil
end

-- widget|nil = container:findActive( )
function Cs.container.findActive(container)
	for el in container:traverse() do
		if el:is(Cs.widget) and el._active then  return el  end
	end
	return nil
end

-- button|nil = container:findToggled( )
function Cs.container.findToggled(container)
	for el in container:traverse() do
		if el:is(Cs.button) and el._toggled then  return el  end
	end
	return nil
end

-- element|nil = container:match( selector [, includeSelf=false ] )
-- selector    = "elementType #id .tag" -- Sequence of space-separated element types, IDs and tags.
-- Match an element using a CSS-like selector.
-- Note: Element types include subtypes (e.g. 'bar' includes both 'vbar' and 'hbar').
function Cs.container.match(container, selector, includeSelf)
	local selPath = parseSelector(selector)
	if not selPath then  return nil  end

	local breakElement = (not includeSelf) and container or container._parent
	if includeSelf and isElementMatchingSelectorPath(container, selPath, breakElement) then
		return container
	end

	for el in container:traverse() do
		if isElementMatchingSelectorPath(el, selPath, breakElement) then
			return el
		end
	end

	return nil
end

-- elements = container:matchAll( selector [, includeSelf=false ] )
-- selector = "elementType #id .tag" -- Sequence of space-separated element types, IDs and tags.
-- Match elements using a CSS-like selector.
-- Note: Element types include subtypes (e.g. 'bar' includes both 'vbar' and 'hbar').
function Cs.container.matchAll(container, selector, includeSelf)
	local elements = {}
	local selPath  = parseSelector(selector)

	if selPath then
		local breakElement = (not includeSelf) and container or container._parent
		if includeSelf and isElementMatchingSelectorPath(container, selPath, breakElement) then
			table.insert(elements, container)
		end

		for el in container:traverse() do
			if isElementMatchingSelectorPath(el, selPath, breakElement) then
				table.insert(elements, el)
			end
		end
	end

	return elements
end



-- spaceX, spaceY = container:getInnerSpace( )
-- space = container:getInnerSpaceX( )
-- space = container:getInnerSpaceY( )
function Cs.container.getInnerSpace(container)
	local spaceX = container._paddingLeft + container._paddingRight
	local spaceY = container._paddingTop  + container._paddingBottom
	local sbW    = themeGet(container._gui, "scrollbarWidth")
	if container:canScrollY() then  spaceX = spaceX + sbW  end
	if container:canScrollX() then  spaceY = spaceY + sbW  end
	return spaceX, spaceY
end
function Cs.container.getInnerSpaceX(container)
	local space = container._paddingLeft + container._paddingRight
	if container:canScrollY() then
		space = space + themeGet(container._gui, "scrollbarWidth")
	end
	return space
end
function Cs.container.getInnerSpaceY(container)
	local space = container._paddingTop + container._paddingBottom
	if container:canScrollX() then
		space = space + themeGet(container._gui, "scrollbarWidth")
	end
	return space
end



-- paddingLeft, paddingRight, paddingTop, paddingBottom = container:getPadding( )
-- padding = container:getPaddingLeft( )
-- padding = container:getPaddingRight( )
-- padding = container:getPaddingTop( )
-- padding = container:getPaddingBottom( )
function Cs.container.getPadding(container)
	return container._paddingLeft, container._paddingRight, container._paddingTop, container._paddingBottom
end
function Cs.container.getPaddingLeft  (container)  return container._paddingLeft    end
function Cs.container.getPaddingRight (container)  return container._paddingRight   end
function Cs.container.getPaddingTop   (container)  return container._paddingTop     end
function Cs.container.getPaddingBottom(container)  return container._paddingBottom  end

-- container:setPadding( padding )
-- container:setPadding( paddingHorizontal, paddingVertical )
-- container:setPadding( paddingLeft, paddingRight, paddingTop, paddingBottom )
-- container:setPaddingLeft( padding )
-- container:setPaddingRight( padding )
-- container:setPaddingTop( padding )
-- container:setPaddingBottom( padding )
function Cs.container.setPadding(container, paddingL, paddingR, paddingT, paddingB)
	if type(paddingL)~="number" then argerror(2,1,"paddingL",paddingL,"number") end

	if not paddingR then
		paddingL, paddingR, paddingT, paddingB = paddingL, paddingL, paddingL, paddingL
	elseif not paddingB then
		paddingL, paddingR, paddingT, paddingB = paddingL, paddingL, paddingR, paddingR
	end

	if
		container._paddingLeft   == paddingL and
		container._paddingRight  == paddingR and
		container._paddingTop    == paddingT and
		container._paddingBottom == paddingB
	then
		return
	end

	container._paddingLeft   = paddingL
	container._paddingRight  = paddingR
	container._paddingTop    = paddingT
	container._paddingBottom = paddingB

	scheduleLayoutUpdateIfDisplayed(container)
end
function Cs.container.setPaddingLeft(container, padding)
	if type(padding)~="number" then argerror(2,1,"padding",padding,"number") end
	if container._paddingLeft == padding then  return  end
	container._paddingLeft = padding
	scheduleLayoutUpdateIfDisplayed(container)
end
function Cs.container.setPaddingRight(container, padding)
	if type(padding)~="number" then argerror(2,1,"padding",padding,"number") end
	if container._paddingRight == padding then  return  end
	container._paddingRight = padding
	scheduleLayoutUpdateIfDisplayed(container)
end
function Cs.container.setPaddingTop(container, padding)
	if type(padding)~="number" then argerror(2,1,"padding",padding,"number") end
	if container._paddingTop == padding then  return  end
	container._paddingTop = padding
	scheduleLayoutUpdateIfDisplayed(container)
end
function Cs.container.setPaddingBottom(container, padding)
	if type(padding)~="number" then argerror(2,1,"padding",padding,"number") end
	if container._paddingBottom == padding then  return  end
	container._paddingBottom = padding
	scheduleLayoutUpdateIfDisplayed(container)
end



-- -- bool = element:isHovered( [ ignoreMouseFocus=false ] )
-- function Cs.element.isHovered(el, ignoreMouseFocus)
-- 	local gui = el._gui
-- 	updateLayoutIfNeeded(gui) -- Updates hovered element.
-- 	return el == gui._hoveredElement and (ignoreMouseFocus or el == (gui._mouseFocus or el))
-- end

-- bool = container:isScrollbarXHovered( [ ignoreMouseFocus=false ] )
-- bool = container:isScrollbarYHovered( [ ignoreMouseFocus=false ] )
function Cs.container.isScrollbarXHovered(container, ignoreMouseFocus)
	local gui = container._gui
	local x   = gui._mouseX
	local y   = gui._mouseY
	if x ==  -999999 then  return false  end

	if container ~= gui:getHoveredElement() then  return false  end

	if not (ignoreMouseFocus or container == (gui._mouseFocus or container)) then
		return false
	end

	local x1, y1 = container:getPositionOnScreen()
	local x2, y2 = x1+container:getChildAreaWidth(), y1+container._layoutHeight
	y1           = y2 - themeGet(container._gui, "scrollbarWidth")

	return x >= x1 and x < x2 and y >= y1 and y < y2
end
function Cs.container.isScrollbarYHovered(container, ignoreMouseFocus)
	local gui = container._gui
	local x   = gui._mouseX
	local y   = gui._mouseY
	if x ==  -999999 then  return false  end

	if container ~= gui:getHoveredElement() then  return false  end

	if not (ignoreMouseFocus or container == (gui._mouseFocus or container)) then
		return false
	end

	local x1, y1 = container:getPositionOnScreen()
	local x2, y2 = x1+container._layoutWidth, y1+container:getChildAreaHeight()
	x1           = x2 - themeGet(container._gui, "scrollbarWidth")

	return x >= x1 and x < x2 and y >= y1 and y < y2
end

-- bool = container:isScrollbarXHandleHovered( [ ignoreMouseFocus=false ] )
-- bool = container:isScrollbarYHandleHovered( [ ignoreMouseFocus=false ] )
function Cs.container.isScrollbarXHandleHovered(container, ignoreMouseFocus)
	local gui = container._gui
	local x   = gui._mouseX
	local y   = gui._mouseY
	if x ==  -999999 then  return false  end

	if container ~= gui:getHoveredElement() then  return false  end

	if not (ignoreMouseFocus or container == (gui._mouseFocus or container)) then
		return false
	end

	local handlePos, handleLen = container:getScrollHandleX()
	local x1, y1               = container:getPositionOnScreen()

	x1       = x1 + handlePos
	local x2 = x1 + handleLen

	local y2 = y1 + container._layoutHeight
	y1       = y2 - themeGet(container._gui, "scrollbarWidth")

	return x >= x1 and x < x2 and y >= y1 and y < y2
end
function Cs.container.isScrollbarYHandleHovered(container, ignoreMouseFocus)
	local gui = container._gui
	local x   = gui._mouseX
	local y   = gui._mouseY
	if x ==  -999999 then  return false  end

	if container ~= gui:getHoveredElement() then  return false  end

	if not (ignoreMouseFocus or container == (gui._mouseFocus or container)) then
		return false
	end

	local handlePos, handleLen = container:getScrollHandleY()
	local x1, y1               = container:getPositionOnScreen()

	local x2 = x1 + container._layoutWidth
	x1       = x2 - themeGet(container._gui, "scrollbarWidth")

	y1       = y1 + handlePos
	local y2 = y1 + handleLen

	return x >= x1 and x < x2 and y >= y1 and y < y2
end



-- bool = container:isScrollingX( )
-- bool = container:isScrollingY( )
function Cs.container.isScrollingX(container)
	return container._mouseScrollDirection == "x"
end
function Cs.container.isScrollingY(container)
	return container._mouseScrollDirection == "y"
end



-- x, y = container:getScroll( )
-- x = container:getScrollX( )
-- y = container:getScrollY( )
function Cs.container.getScroll(container)
	return container._scrollX, container._scrollY
end
function Cs.container.getScrollX(container)
	return container._scrollX
end
function Cs.container.getScrollY(container)
	return container._scrollY
end

-- scrollChanged = container:setScroll( x, y [, immediate=false ] )
function Cs.container.setScroll(container, scrollX, scrollY, immediate)
	if type(scrollX)~="number" then argerror(2,1,"scrollX",scrollX,"number") end
	if type(scrollY)~="number" then argerror(2,2,"scrollY",scrollY,"number") end
	updateLayoutIfNeeded(container._gui)

	-- Limit scrolling.
	local limitX, limitY = container:getScrollLimit()

	scrollX  = math.min(math.max(scrollX, limitX), 0)
	scrollY  = math.min(math.max(scrollY, limitY), 0)
	local dx = scrollX - container._scrollX
	local dy = scrollY - container._scrollY

	if dx == 0 and dy == 0 then  return false  end
	--

	container._scrollX = scrollX
	container._scrollY = scrollY

	for el in container:traverse() do
		el._layoutImmediateOffsetX = el._layoutImmediateOffsetX + dx
		el._layoutImmediateOffsetY = el._layoutImmediateOffsetY + dy
	end

	if immediate then  setVisualScroll(container, scrollX, scrollY)  end

	if container:isDisplayed() then
		updateHoveredElement(container._gui)
	end

	return true
end

-- scrollChanged = container:setScrollX( x [, immediate=false ] )
-- scrollChanged = container:setScrollY( y [, immediate=false ] )
function Cs.container.setScrollX(container, scrollX, immediate)
	return (container:setScroll(scrollX, container._scrollY, immediate))
end
function Cs.container.setScrollY(container, scrollY, immediate)
	return (container:setScroll(container._scrollX, scrollY, immediate))
end

-- scrollChanged = container:scroll( deltaX, deltaY [, immediate=false ] )
function Cs.container.scroll(container, dx, dy, immediate)
	local scrolled = container:setScroll(container._scrollX+dx, container._scrollY+dy, immediate)
	if scrolled then
		container:playSound("scroll") -- @Robustness: May have to add more limitations to whether the "scroll" sound plays or not.
	end
	return scrolled
end

local function updateScroll(container)
	container:setScroll(container._scrollX, container._scrollY, false)
end



do
	local function getScrollHandle(container, padding, childAreaSize, contentSize, scroll)
		local insideSize = childAreaSize - padding

		local handleLen = math.max(
			round(childAreaSize * math.min(insideSize/contentSize, 1)),
			themeGet(container._gui, "scrollbarMinLength")
		)

		local handlePos    = 0
		local handleMaxPos = 0

		if contentSize > insideSize then
			handleMaxPos = childAreaSize - handleLen
			handlePos    = -scroll * handleMaxPos / (contentSize - insideSize)
			handlePos    = math.min(handlePos, handleMaxPos)
		end

		return handlePos, handleLen, handleMaxPos
	end

	-- @Incomplete: container:getScrollHandles()?

	-- position, length, maxPosition = container:getScrollHandleX( )
	-- position, length, maxPosition = container:getScrollHandleY( )
	-- Units are in pixels.
	function Cs.container.getScrollHandleX(container)
		updateLayoutIfNeeded(container._gui)
		return getScrollHandle(container, container._paddingLeft+container._paddingRight, container:getChildAreaWidth(), container._contentWidth, container._scrollX)
	end
	function Cs.container.getScrollHandleY(container)
		updateLayoutIfNeeded(container._gui)
		return getScrollHandle(container, container._paddingTop+container._paddingBottom, container:getChildAreaHeight(), container._contentHeight, container._scrollY)
	end
end



-- x, y = container:getScrollLimit( )
-- x = container:getScrollLimitX( )
-- y = container:getScrollLimitY( )
function Cs.container.getScrollLimit(container)
	local w, h = container:getChildAreaDimensions()
	return
		w - (container._paddingLeft+container._paddingRight) - container._contentWidth,
		h - (container._paddingTop+container._paddingBottom) - container._contentHeight
end
function Cs.container.getScrollLimitX(container)
	return container:getChildAreaWidth()  - (container._paddingLeft+container._paddingRight) - container._contentWidth
end
function Cs.container.getScrollLimitY(container)
	return container:getChildAreaHeight() - (container._paddingTop+container._paddingBottom) - container._contentHeight
end



-- child = container:getVisibleChild( [ number=1 ] )
function Cs.container.getVisibleChild(container, n)
	n = n or 1
	for _, child in ipairs(container) do
		if not child._hidden then
			n = n - 1
			if n == 0 then  return child  end
		end
	end
	return nil
end

-- number = container:getVisibleChildNumber( child )
function Cs.container.getVisibleChildNumber(container, el)
	local n = 0
	for _, child in ipairs(container) do
		if not child._hidden then
			n = n + 1
			if child == el then  return n  end
		end
	end
	return nil
end

-- count = container:getVisibleChildCount( )
function Cs.container.getVisibleChildCount(container)
	local count = 0
	for _, child in ipairs(container) do
		if not child._hidden then  count = count + 1  end
	end
	return count
end

-- visibleChild = container:setVisibleChild( id|index )
-- If multiple children have the given ID then the last one is returned.
-- @Cleanup: Split into setVisibleChildById() and setVisibleChildByIndex()? Maybe more functions should be changed too.
function Cs.container.setVisibleChild(container, idOrIndex)
	local visibleChild = nil
	if type(idOrIndex) == "number" then
		for i, child in ipairs(container) do
			if i == idOrIndex then
				child:show()
				visibleChild = child
			else
				child:hide()
			end
		end
	else
		for _, child in ipairs(container) do
			if child._id == idOrIndex then
				child:show()
				visibleChild = child
			else
				child:hide()
			end
		end
	end
	return visibleChild
end



-- x, y = container:getVisualScroll( )
-- x = container:getVisualScrollX( )
-- y = container:getVisualScrollY( )
function Cs.container.getVisualScroll(container)
	return container._visualScrollX, container._visualScrollY
end
function Cs.container.getVisualScrollX(container)
	return container._visualScrollX
end
function Cs.container.getVisualScrollY(container)
	return container._visualScrollY
end



-- bool = container:canScrollAny( )
-- bool = container:canScrollX( ) -- Horizontal scrolling, scrollbar on the bottom side.
-- bool = container:canScrollY( ) -- Vertical scrolling, scrollbar on the right side.
function Cs.container.canScrollAny(container)
	return container._canScrollX or container._canScrollY
end
function Cs.container.canScrollX(container)
	return container._canScrollX
end
function Cs.container.canScrollY(container)
	return container._canScrollY
end



-- index|nil = container:indexOf( element )
-- Returns nil if the element isn't a child.
Cs.container.indexOf = indexOf



-- REPLACE  bool = container:isSolid( )
function Cs.container.isSolid(container)
	return container._solid or container._background ~= "" or (container._gui.canScrollMeansSolid and container:canScrollAny()) -- @Edit
end



-- child, index = container:get( index )
-- child, index = container:get( id )
-- Note: container:get(index) is the same as container[index].
-- Returns nil if no child matches.
function Cs.container.get(container, iOrId)
	if type(iOrId) == "string" then
		for i, child in ipairs(container) do
			if child._id == iOrId then  return child, i  end
		end
		return nil
	else
		local child = container[iOrId]
		return child, (child and iOrId or nil)
	end
end

-- for index, child in container:children( )
Cs.container.children = ipairs



-- width, height = container:getChildAreaDimensions( )
-- width  = container:getChildAreaWidth( )
-- height = container:getChildAreaHeight( )
function Cs.container.getChildAreaDimensions(container)
	updateLayoutIfNeeded(container._gui)
	local sbW = themeGet(container._gui, "scrollbarWidth")
	return
		(container:canScrollY() and container._layoutWidth -sbW or container._layoutWidth ),
		(container:canScrollX() and container._layoutHeight-sbW or container._layoutHeight)
end
function Cs.container.getChildAreaWidth(container)
	updateLayoutIfNeeded(container._gui)
	return
		container:canScrollY()
		and container._layoutWidth - themeGet(container._gui, "scrollbarWidth")
		or  container._layoutWidth
end
function Cs.container.getChildAreaHeight(container)
	updateLayoutIfNeeded(container._gui)
	return
		container:canScrollX()
		and container._layoutHeight - themeGet(container._gui, "scrollbarWidth")
		or  container._layoutHeight
end



-- child|nil = container:getChildWithData( dataKey, dataValue )
function Cs.container.getChildWithData(container, k, v)
	for _, child in ipairs(container) do
		if child._data[k] == v then  return child  end
	end
	return nil
end



-- element|nil = container:getElementAt( x, y [, includeNonSolid=false ] )
function Cs.container.getElementAt(container, x, y, nonSolid)
	updateLayoutIfNeeded(container._gui)

	if container:canScrollAny() then
		local containerX, containerY = container:getPositionOnScreen()
		if x <  containerX                                then  return nil  end
		if y <  containerY                                then  return nil  end
		if x >= containerX+container:getChildAreaWidth()  then  return nil  end
		if y >= containerY+container:getChildAreaHeight() then  return nil  end
	end

	for _, el in ipairs(container:_collectVisibleUntilInputCapture(x, y, __STATIC12)) do
		if ((nonSolid or el:isSolid()) and el:isAt(x, y)) or (el._captureInput or el._captureGuiInput) then
			return el
		end
	end

	return nil
end



-- child = container:insert( elementData [, index=atEnd ] )
-- See gui:load() for the elementData format.
function Cs.container.insert(container, childData, i)
	if type(childData)~="table" then argerror(2,1,"childData",childData,"table") end
	if not(type(i)=="number" or i==nil) then argerror(2,2,"i",i,"number","nil") end

	local class = Cs[getTypeFromElementData(childData)] or errorf("Bad element type '%s'.", getTypeFromElementData(childData))
	local child = class(container._gui, childData, container)
	table.insert(container, (i or #container+1), child)

	printHeres(container._gui)
	scheduleLayoutUpdateIfDisplayed(child)

	local themeInit = themeGet(container._gui, "init")
	themeInit(child)
	if child:is(Cs.container) then
		for el in child:traverse() do
			themeInit(el)
		end
	end

	validateVariousCurrentElements(container._gui) -- This is needed in case we get new capturing elements.
	scheduleLayoutUpdateIfDisplayed(child)

	return child
end

-- REPLACE  container:removeAt( index )
-- Note that grandchildren are also removed from their parent. (Is this good?)
function Cs.container.removeAt(container, i)
	if type(i)~="number" then argerror(2,1,"i",i,"number") end

	local child = container[i]
	if not child then
		printerr(2, "Child index %d is out of bounds.", i)
		return
	end

	if child:is(Cs.container) then
		child:empty()
	end

	-- Note: The child still keeps the reference to the GUI.
	child._parent = nil
	table.remove(container, i)

	validateVariousCurrentElements(container._gui)
	scheduleLayoutUpdateIfDisplayed(container)
end

-- container:empty( )
-- Note that children are also emptied recursively. (Is this good?)
function Cs.container.empty(container)
	for i = #container, 1, -1 do
		container:removeAt(i)
	end
end



-- INTERNAL REPLACE  handled, grabMouseFocus = container:_mousepressed( mouseX, mouseY, mouseButton, pressCount )
function Cs.container._mousepressed(container, mx, my, mbutton, pressCount)
	if mbutton == 1 then
		local x0        , y0         = container:getPositionOnScreen()
		local childAreaW, childAreaH = container:getChildAreaDimensions()
		local sbW                    = themeGet(container._gui, "scrollbarWidth")

		-- Horizontal scrolling.
		----------------------------------------------------------------
		local x2, y2 = x0+childAreaW, y0+container._layoutHeight
		local x1, y1 = x0           , y2-sbW

		if mx >= x1 and mx < x2 and my >= y1 and my < y2 then
			local handlePos, handleLen      = container:getScrollHandleX()
			container._mouseScrollDirection = "x"

			-- Drag handle.
			if mx >= x1+handlePos and mx < x1+handlePos+handleLen then
				container._mouseScrollOffset = mx - x1 - handlePos

			-- Jump and drag.
			else
				container._mouseScrollOffset = handleLen / 2
				container:_mousemoved(mx, my, 0, 0)
			end

			return true, true
		end

		-- Vertical scrolling.
		----------------------------------------------------------------
		local y2, x2 = y0+childAreaH, x0+container._layoutWidth
		local y1, x1 = y0           , x2-sbW

		if mx >= x1 and mx < x2 and my >= y1 and my < y2 then
			local handlePos, handleLen      = container:getScrollHandleY()
			container._mouseScrollDirection = "y"

			-- Drag handle.
			if my >= y1+handlePos and my < y1+handlePos+handleLen then
				container._mouseScrollOffset = my - y1 - handlePos

			-- Jump and drag.
			else
				container._mouseScrollOffset = handleLen / 2
				container:_mousemoved(mx, my, 0, 0)
			end

			return true, true
		end

		----------------------------------------------------------------
	end

	return false, false
end

-- INTERNAL REPLACE  container:_mousemoved( mouseX, mouseY, deltaX, deltaY )
function Cs.container._mousemoved(container, mx, my, dx, dy)
	-- Horizontal scrolling.
	if container._mouseScrollDirection == "x" then
		local _, _, handleMaxPos = container:getScrollHandleX()
		container:setScrollX((mx - container:getXOnScreen() - container._mouseScrollOffset) * container:getScrollLimitX() / handleMaxPos, true)

	-- Vertical scrolling.
	elseif container._mouseScrollDirection == "y" then
		local _, _, handleMaxPos = container:getScrollHandleY()
		container:setScrollY((my - container:getYOnScreen() - container._mouseScrollOffset) * container:getScrollLimitY() / handleMaxPos, true)
	end
end

-- INTERNAL REPLACE  container:_mousereleased( mouseX, mouseY, mouseButton, pressCount )
function Cs.container._mousereleased(container, mx, my, mbutton, pressCount)
	if mbutton == 1 then
		container._mouseScrollDirection = ""
		container._mouseScrollOffset    = 0
	end
end

-- INTERNAL REPLACE  handled = container:_wheelmoved( deltaX, deltaY, deltaX0, deltaY0 )
function Cs.container._wheelmoved(container, dx, dy, dx0, dy0)
	if (dx ~= 0 and container:canScrollX()) or (dy ~= 0 and container:canScrollY()) then
		local gui      = container._gui
		local fontH    = (gui._font or _M.getDefaultFont()):getHeight()
		local scrolled = container:scroll(gui._scrollSpeedX*fontH*dx, gui._scrollSpeedY*fontH*dy)

		return scrolled
	end

	return false
end



-- OVERRIDE  container:remove( )
function Cs.container.remove(container, _removeAt_i)
	if _removeAt_i ~= nil then
		warn(2, "container:remove() called with an argument. Did you mean to call container:removeAt(index)?")
	end
	return Cs.container.super.remove(container)
end



-- OVERRIDE  container:reprocessTexts( )
function Cs.container.reprocessTexts(container)
	Cs.container.super.reprocessTexts(container)
	for _, child in ipairs(container) do
		child:reprocessTexts()
	end
end



-- container:setChildrenActive( bool )
function Cs.container.setChildrenActive(container, active)
	for _, child in ipairs(container) do
		if child:is(Cs.widget) then  child:setActive(active)  end
	end
end



-- container:setChildrenHidden( bool )
function Cs.container.setChildrenHidden(container, hidden)
	for _, child in ipairs(container) do
		child:setHidden(hidden)
	end
end



-- button|nil = container:getToggledChild( [ includeGrandchildren=false ] )
function Cs.container.getToggledChild(container, deep)
	if deep then
		for button in container:traverseType"button" do
			if button:isToggled() then  return button  end
		end
	else
		for _, child in ipairs(container) do
			if child:is(Cs.button) and child:isToggled() then  return child  end
		end
	end
	return nil
end

-- button|nil = container:setToggledChild( id [, includeGrandchildren=false ] )
-- button|nil = container:setToggledChild( index )
-- If multiple children have the given ID then the last one is returned.
function Cs.container.setToggledChild(container, idOrIndex, deep)
	local toggledChild = nil
	if type(idOrIndex) == "number" then
		for i, child in ipairs(container) do
			if child:is(Cs.button) then
				if i == idOrIndex then
					child:setToggled(true)
					toggledChild = child
				else
					child:setToggled(false)
				end
			end
		end
	elseif deep then
		for button in container:traverseType"button" do
			if button._id == idOrIndex then
				button:setToggled(true)
				toggledChild = button
			else
				button:setToggled(false)
			end
		end
	else
		for _, child in ipairs(container) do
			if child:is(Cs.button) then
				if child._id == idOrIndex then
					child:setToggled(true)
					toggledChild = child
				else
					child:setToggled(false)
				end
			end
		end
	end
	return toggledChild
end



-- container:sort( sortFunction )
-- aIsLessThanB = sortFunction( elementA, elementB )
function Cs.container.sort(container, func)
	if type(func)~="function" then argerror(2,1,"func",func,"function") end
	table.sort(container, func)
	scheduleLayoutUpdateIfDisplayed(container)
end



-- for element in container:traverse( )
function Cs.container.traverse(container)

	return function(stack) -- @Memory
		local len = stack[0]
		local child


			-- Get next child.
			repeat
				local i    = stack[len] + 1
				stack[len] = i
				child      = stack[len-1][i]

				if not child then
					len = len - 2 -- Don't bother removing values from the stack.
					if len == 0 then  return  end -- Done traversing!
				end
			until child

			if child:is(Cs.container) then
				len          = len + 2
				stack[len-1] = child
				stack[len  ] = 0
			end


		stack[0] = len
		return child
	end, {[0--[[length]]]=2, container, 0} -- @Memory

end

-- for element in container:traverseType( elementType )
function Cs.container.traverseType(container, elType)
	local class = requireElementClass(elType, 2)

	return function(stack) -- @Memory
		local len = stack[0]
		local child

		repeat
			-- Get next child.
			repeat
				local i    = stack[len] + 1
				stack[len] = i
				child      = stack[len-1][i]

				if not child then
					len = len - 2 -- Don't bother removing values from the stack.
					if len == 0 then  return  end -- Done traversing!
				end
			until child

			if child:is(Cs.container) then
				len          = len + 2
				stack[len-1] = child
				stack[len  ] = 0
			end
		until child:is(class)

		stack[0] = len
		return child
	end, {[0--[[length]]]=2, container, 0} -- @Memory

end

do

	local function _traverseVisible(el)

		for i = #el, 1, -1 do
			local child = el[i]

			if not child._hidden then
				if child:is(Cs.container) then
					_traverseVisible(child)
				end
				coroutine.yield(child)
			end


		end

	end
	local function _visitVisible(el, cb)

		for i = #el, 1, -1 do
			local child = el[i]

			if not child._hidden then
				if child:is(Cs.container) then
					if _visitVisible(child, cb) == "stop" then  return "stop"  end
				end
				if cb(child) == "stop" then  return "stop"  end
			end


		end

	end
	local function _collectVisible(el, elements)

		for i = #el, 1, -1 do
			local child = el[i]

			if not child._hidden then
				if child:is(Cs.container) then
					_collectVisible(child, elements)
				end
				table.insert(elements, child)
			end


		end

	end
	local function _collectVisibleUntilInputCapture(el, elements)

		for i = #el, 1, -1 do
			local child = el[i]

			if not child._hidden then
				if child:is(Cs.container) then
					if _collectVisibleUntilInputCapture(child, elements) then  return true  end
				end
				table.insert(elements, child)
			end

			if child._captureInput or child._captureGuiInput then  return true  end
		end

	end


	local function _traverseVisibleAt(el, x, y, sbW)

		for i = #el, 1, -1 do
			local child = el[i]

			if not child._hidden then
				local isContainer     = child:is(Cs.container)
				local includeSelf     = true
				local includeChildren = isContainer

				if isContainer and child:canScrollAny() then
					local childX, childY, childW, childH = xywhOnScreen(child)
					if x < childX or y < childY then
						includeSelf     = false
						includeChildren = false
					else
						includeSelf     = (x < childX+childW and y < childY+childH)
						includeChildren = (includeSelf and x < childX+child:getChildAreaWidth() and y < childY+child:getChildAreaHeight())
					end
				end

				if includeSelf then
					if includeChildren then
						_traverseVisibleAt(child, x, y, sbW)
					end
					coroutine.yield(child)
				end
			end


		end

	end
	local function _visitVisibleAt(el, x, y, sbW, cb)

		for i = #el, 1, -1 do
			local child = el[i]

			if not child._hidden then
				local isContainer     = child:is(Cs.container)
				local includeSelf     = true
				local includeChildren = isContainer

				if isContainer and child:canScrollAny() then
					local childX, childY, childW, childH = xywhOnScreen(child)
					if x < childX or y < childY then
						includeSelf     = false
						includeChildren = false
					else
						includeSelf     = (x < childX+childW and y < childY+childH)
						includeChildren = (includeSelf and x < childX+child:getChildAreaWidth() and y < childY+child:getChildAreaHeight())
					end
				end

				if includeSelf then
					if includeChildren then
						if _visitVisibleAt(child, x, y, sbW, cb) == "stop" then  return "stop"  end
					end
					if cb(child) == "stop" then  return "stop"  end
				end
			end


		end

	end
	local function _collectVisibleAt(el, x, y, sbW, elements)

		for i = #el, 1, -1 do
			local child = el[i]

			if not child._hidden then
				local isContainer     = child:is(Cs.container)
				local includeSelf     = true
				local includeChildren = isContainer

				if isContainer and child:canScrollAny() then
					local childX, childY, childW, childH = xywhOnScreen(child)
					if x < childX or y < childY then
						includeSelf     = false
						includeChildren = false
					else
						includeSelf     = (x < childX+childW and y < childY+childH)
						includeChildren = (includeSelf and x < childX+child:getChildAreaWidth() and y < childY+child:getChildAreaHeight())
					end
				end

				if includeSelf then
					if includeChildren then
						_collectVisibleAt(child, x, y, sbW, elements)
					end
					table.insert(elements, child)
				end
			end


		end

	end
	local function _collectVisibleUntilInputCaptureAt(el, x, y, sbW, elements)

		for i = #el, 1, -1 do
			local child = el[i]

			if not child._hidden then
				local isContainer     = child:is(Cs.container)
				local includeSelf     = true
				local includeChildren = isContainer

				if isContainer and child:canScrollAny() then
					local childX, childY, childW, childH = xywhOnScreen(child)
					if x < childX or y < childY then
						includeSelf     = false
						includeChildren = false
					else
						includeSelf     = (x < childX+childW and y < childY+childH)
						includeChildren = (includeSelf and x < childX+child:getChildAreaWidth() and y < childY+child:getChildAreaHeight())
					end
				end

				if includeSelf then
					if includeChildren then
						if _collectVisibleUntilInputCaptureAt(child, x, y, sbW, elements) then  return true  end
					end
					table.insert(elements, child)
				end
			end

			if child._captureInput or child._captureGuiInput then  return true  end
		end

	end

	-- for element in container:traverseVisible( ) -- @Cleanup: Maybe remove in favor of visitVisible()? Easy way to get rid of newIteratorCoroutine()!
	-- for element in container:traverseVisible( x, y )
	function Cs.container.traverseVisible(container, x, y)
		if x then  return newIteratorCoroutine(_traverseVisibleAt, container, x, y, themeGet(container._gui, "scrollbarWidth"))
		else       return newIteratorCoroutine(_traverseVisible  , container)  end
	end

	-- container:visitVisible( callback ) -- @Doc and maybe @Cleanup.
	-- container:visitVisible( x, y, callback )
	-- traversalAction = callback( element )
	-- traversalAction = "continue" | "stop" -- Returning nil means "continue".
	function Cs.container.visitVisible(container, x, y, cb)
		if y then  _visitVisibleAt(container, x, y, themeGet(container._gui, "scrollbarWidth"), cb)
		else       _visitVisible  (container, x)  end
	end

	-- elements = container:collectVisible( [ array={} ] ) -- @Doc and maybe @Cleanup.
	-- elements = container:collectVisible( x, y, [, array={} ] )
	function Cs.container.collectVisible(container, x, y, elements)
		if y then
			elements = elements or {}
			for i = 1, #elements do  elements[i] = nil  end
			_collectVisibleAt(container, x, y, themeGet(container._gui, "scrollbarWidth"), elements)
		else
			elements = x or {}
			for i = 1, #elements do  elements[i] = nil  end
			_collectVisible(container, elements)
		end
		return elements
	end

	-- INTERNAL  elements = container:_collectVisibleUntilInputCapture( array )
	-- INTERNAL  elements = container:_collectVisibleUntilInputCapture( x, y, array )
	function Cs.container._collectVisibleUntilInputCapture(container, x, y, elements)
		if y then
			for i = 1, #elements do  elements[i] = nil  end
			_collectVisibleUntilInputCaptureAt(container, x, y, themeGet(container._gui, "scrollbarWidth"), elements)
		else
			elements = x
			for i = 1, #elements do  elements[i] = nil  end
			_collectVisibleUntilInputCapture(container, elements)
		end
		return elements
	end
end



-- INTERNAL REPLACE  container:_calculateNaturalSize( )
function Cs.container._calculateNaturalSize(container)
	calculateContainerChildNaturalSizes(container)

	local maxX = 0
	local maxY = 0

	for _, child in ipairs(container) do
		if not (child._hidden or child._floating) then
			-- Note: We don't consider the anchor as we only care about the size here.
			-- We do treat the position offset as part of the size (added to the top left of the child).
			-- (Maybe the reasoning is flawed somewhere here but it seems to work.)
			maxX = math.max(maxX, child._x+child._layoutWidth )
			maxY = math.max(maxY, child._y+child._layoutHeight)
		end
	end

	updateContainerNaturalSize(container, maxX, maxY)
end

-- INTERNAL REPLACE  container:_expandAndPositionChildren( )
function Cs.container._expandAndPositionChildren(container)
	local innerW = container._layoutWidth  - container:getInnerSpaceX() -- Should we use _content* here? I think no.
	local innerH = container._layoutHeight - container:getInnerSpaceY()

	for _, child in ipairs(container) do
		if not child._hidden then
			expandAndPositionFloatingElement(child, innerW, innerH) -- All children count as floating in plain/non-layout containers.
		end
	end

	updateScroll(container)
end



--==============================================================
--= Bar element class (abstract) ===============================
--==============================================================



Cs.bar = newElementClass(true, "GuiBar", Cs.container, {}, {
	-- Parameters.
	_expandPerpendicular = true,  -- Perpendicular to the layout direction of the bar.
	_homogeneous         = false, -- If children should be the same size.
	--

	_layoutInnerStaticWidth  = 0,
	_layoutInnerStaticHeight = 0,
	_layoutInnerSpacingsX    = 0,
	_layoutInnerSpacingsY    = 0,
	_layoutWeight            = 0.0,
}, {
	-- void
})

function Cs.bar.init(bar, gui, elData, parent)
	Cs.bar.super.init(bar, gui, elData, parent)

	if elData.expandPerpendicular ~= nil then bar._expandPerpendicular = elData.expandPerpendicular end
	if elData.homogeneous ~= nil then bar._homogeneous = elData.homogeneous end
end



--==============================================================
--= Hbar and Vbar element classes ==============================
--==============================================================



Cs.hbar = newElementClass(false, "GuiHorizontalBar", Cs.bar, {}, {
	-- void
}, {
	-- void
})
Cs.vbar = newElementClass(false, "GuiVerticalBar", Cs.bar, {}, {
	-- void
}, {
	-- void
})

-- function Cs.hbar.init(bar, gui, elData, parent)
-- 	Cs.hbar.super.init(bar, gui, elData, parent)
-- end
-- function Cs.vbar.init(bar, gui, elData, parent)
-- 	Cs.vbar.super.init(bar, gui, elData, parent)
-- end



-- INTERNAL REPLACE  hbar:_calculateNaturalSize( )
-- INTERNAL REPLACE  vbar:_calculateNaturalSize( )
function Cs.hbar._calculateNaturalSize(bar)
	calculateContainerChildNaturalSizes(bar)

	local staticW, dynamicW, highestW, highestDynamicW, sumSpaceX,
	      staticH, dynamicH, highestH, highestDynamicH, sumSpaceY,
	      totalWeight = barGetNaturalSizeValues(bar)

	local innerW = (bar._homogeneous and highestDynamicW*totalWeight or dynamicW) + staticW + sumSpaceX

	innerW   = math.max(innerW,   bar._minWidth -bar:getInnerSpaceX())
	highestH = math.max(highestH, bar._minHeight-bar:getInnerSpaceY())

	bar._layoutInnerStaticHeight, bar._layoutInnerStaticWidth = 0, staticW
	bar._layoutInnerSpacingsY   , bar._layoutInnerSpacingsX   = 0, sumSpaceX

	bar._layoutWeight = totalWeight

	updateContainerNaturalSize(bar, innerW, highestH)
end
function Cs.vbar._calculateNaturalSize(bar)
	calculateContainerChildNaturalSizes(bar)

	local staticW, dynamicW, highestW, highestDynamicW, sumSpaceX,
	      staticH, dynamicH, highestH, highestDynamicH, sumSpaceY,
	      totalWeight = barGetNaturalSizeValues(bar)

	local innerH = (bar._homogeneous and highestDynamicH*totalWeight or dynamicH) + staticH + sumSpaceY

	innerH   = math.max(innerH,   bar._minHeight-bar:getInnerSpaceY())
	highestW = math.max(highestW, bar._minWidth -bar:getInnerSpaceX())

	bar._layoutInnerStaticWidth, bar._layoutInnerStaticHeight = 0, staticH
	bar._layoutInnerSpacingsX  , bar._layoutInnerSpacingsY    = 0, sumSpaceY

	bar._layoutWeight = totalWeight

	updateContainerNaturalSize(bar, highestW, innerH)
end



-- INTERNAL REPLACE  hbar:_expandAndPositionChildren( )
-- INTERNAL REPLACE  vbar:_expandAndPositionChildren( )
function Cs.hbar._expandAndPositionChildren(bar)



	--
	-- Calculate amount of space for children to expand into (total if homogeneous,
	-- extra if not) and convert relative sizes into static.
	--
	local childSizeSum = 0
	local innerSize    = bar._layoutWidth - bar:getInnerSpaceX() - bar._layoutInnerSpacingsX
	local staticSize   = bar._layoutInnerStaticWidth
	local homogeneous  = bar._homogeneous

	for _, child in ipairs(bar) do
		if not (child._hidden or child._floating) then
			if child:hasRelativeWidth() and not (child._weight > 0 and homogeneous) then
				local size       = round(child._relativeWidth*innerSize)
				staticSize       = staticSize - child._layoutWidth + size
				child._layoutWidth = size
			end
			childSizeSum = childSizeSum + child._layoutWidth
		end
	end

	local canScrollPerp = bar:canScrollY()
	local expandPerp    = bar._expandPerpendicular and (bar._layoutHeight - bar:getInnerSpaceY()) or nil

	if canScrollPerp and expandPerp then
		expandPerp = math.max(expandPerp, bar._contentHeight)
	end

	local expansionWeight0 = bar._layoutWeight
	local expansionSpace0  = innerSize - (homogeneous and staticSize or childSizeSum)

	--
	-- Expand and position children.
	--

	-- Calculate dimensions.
	local widths  = __STATIC13
	local heights = __STATIC14
	local ignore  = __STATIC15

	for phase = 1, 2 do -- We need two phases to apply min/max size properly when also expanding.
		local advance         = 0
		local expansionWeight = expansionWeight0
		local expansionSpace  = expansionSpace0

		for i, child in ipairs(bar) do
			if phase == 1 then
				ignore[i] = false
			end

			if not (child._hidden or child._floating or ignore[i]) then
				local childWidth  = child._layoutWidth
				local childHeight = child._layoutHeight

				if child._weight > 0 then
					local space     = round(expansionSpace * child._weight/expansionWeight)
					childWidth        = (homogeneous and 0 or childWidth) + space
					expansionSpace  = expansionSpace  - space
					expansionWeight = expansionWeight - child._weight
				end

				if expandPerp then
					childHeight = expandPerp -- Expand all children the same amount. (Better, I think.)
					-- child$WHPERP = canScrollPerp and math.max(child$WHPERP, expandPerp) or expandPerp -- Only expand too short children. (Worse, I think.)
				end

				local beforeLimit       = childWidth
				childWidth, childHeight = applySizeLimits(child, childWidth, childHeight)

				-- This is what's necessary for min/max to work.
				if childWidth ~= beforeLimit then
					ignore[i]        = true
					expansionWeight0 = expansionWeight0 - child._weight

					if homogeneous then
						expansionSpace0 = expansionSpace0 - childWidth
					else
						local diffFromNaturalSize = child._layoutWidth - childWidth
						expansionSpace0           = expansionSpace0 + diffFromNaturalSize
					end
				end

				widths[i]  = childWidth
				heights[i] = childHeight
				advance    = advance + childWidth
			end
		end

		if advance == innerSize or bar._layoutWeight == 0 then
			break
		end

		--[[ @Debug
		if phase == 1 then
			local ignores = 0
			for i = 1, #bar do
				if ignore[i] then  ignores = ignores+1  end
			end
			printf("diff=%-5d ignores=%d %s", advance-innerSize, ignores, bar:getPathDescription())
		end
		--]]
	end

	-- Update children.
	local innerWidth  = bar._layoutWidth  - bar:getInnerSpaceX() -- Should we use _content* here? I think no.
	local innerHeight = bar._layoutHeight - bar:getInnerSpaceY()
	local baseX       = bar._layoutX + bar._paddingLeft
	local baseY       = bar._layoutY + bar._paddingTop
	local x           = 0
	local y           = 0
	local spacing     = 0
	local first       = true


	for i, child in ipairs(bar) do
		if not (child._hidden or child._floating) then
			if not first then
				spacing  = math.max(spacing, child._spacingLeft)
				x = x + spacing
			end

			child._layoutX      = baseX + x
			child._layoutY      = baseY + y
			child._layoutWidth  = widths[i]
			child._layoutHeight = heights[i]

			x = x + child._layoutWidth
			spacing  = child._spacingRight
			first    = false
		end
	end

	local maxPerp = baseY

	for _, child in ipairs(bar) do
		if child._hidden then
			-- void
		elseif child._floating then
			expandAndPositionFloatingElement(child, innerWidth, innerHeight)
			-- Should we update maxPerp here? If so then we should update $advance too appropriately.
		else
			child:_expandAndPositionChildren()
			maxPerp = math.max(maxPerp, child._layoutY+child._layoutHeight)
		end
	end

	-- Make sure scrolling uses the final expanded content size.
	bar._contentWidth     = x
	bar._contentHeight = maxPerp - baseY

	updateScroll(bar)

end
function Cs.vbar._expandAndPositionChildren(bar)



	--
	-- Calculate amount of space for children to expand into (total if homogeneous,
	-- extra if not) and convert relative sizes into static.
	--
	local childSizeSum = 0
	local innerSize    = bar._layoutHeight - bar:getInnerSpaceY() - bar._layoutInnerSpacingsY
	local staticSize   = bar._layoutInnerStaticHeight
	local homogeneous  = bar._homogeneous

	for _, child in ipairs(bar) do
		if not (child._hidden or child._floating) then
			if child:hasRelativeHeight() and not (child._weight > 0 and homogeneous) then
				local size       = round(child._relativeHeight*innerSize)
				staticSize       = staticSize - child._layoutHeight + size
				child._layoutHeight = size
			end
			childSizeSum = childSizeSum + child._layoutHeight
		end
	end

	local canScrollPerp = bar:canScrollX()
	local expandPerp    = bar._expandPerpendicular and (bar._layoutWidth - bar:getInnerSpaceX()) or nil

	if canScrollPerp and expandPerp then
		expandPerp = math.max(expandPerp, bar._contentWidth)
	end

	local expansionWeight0 = bar._layoutWeight
	local expansionSpace0  = innerSize - (homogeneous and staticSize or childSizeSum)

	--
	-- Expand and position children.
	--

	-- Calculate dimensions.
	local widths  = __STATIC16
	local heights = __STATIC17
	local ignore  = __STATIC18

	for phase = 1, 2 do -- We need two phases to apply min/max size properly when also expanding.
		local advance         = 0
		local expansionWeight = expansionWeight0
		local expansionSpace  = expansionSpace0

		for i, child in ipairs(bar) do
			if phase == 1 then
				ignore[i] = false
			end

			if not (child._hidden or child._floating or ignore[i]) then
				local childWidth  = child._layoutWidth
				local childHeight = child._layoutHeight

				if child._weight > 0 then
					local space     = round(expansionSpace * child._weight/expansionWeight)
					childHeight        = (homogeneous and 0 or childHeight) + space
					expansionSpace  = expansionSpace  - space
					expansionWeight = expansionWeight - child._weight
				end

				if expandPerp then
					childWidth = expandPerp -- Expand all children the same amount. (Better, I think.)
					-- child$WHPERP = canScrollPerp and math.max(child$WHPERP, expandPerp) or expandPerp -- Only expand too short children. (Worse, I think.)
				end

				local beforeLimit       = childHeight
				childWidth, childHeight = applySizeLimits(child, childWidth, childHeight)

				-- This is what's necessary for min/max to work.
				if childHeight ~= beforeLimit then
					ignore[i]        = true
					expansionWeight0 = expansionWeight0 - child._weight

					if homogeneous then
						expansionSpace0 = expansionSpace0 - childHeight
					else
						local diffFromNaturalSize = child._layoutHeight - childHeight
						expansionSpace0           = expansionSpace0 + diffFromNaturalSize
					end
				end

				widths[i]  = childWidth
				heights[i] = childHeight
				advance    = advance + childHeight
			end
		end

		if advance == innerSize or bar._layoutWeight == 0 then
			break
		end

		--[[ @Debug
		if phase == 1 then
			local ignores = 0
			for i = 1, #bar do
				if ignore[i] then  ignores = ignores+1  end
			end
			printf("diff=%-5d ignores=%d %s", advance-innerSize, ignores, bar:getPathDescription())
		end
		--]]
	end

	-- Update children.
	local innerWidth  = bar._layoutWidth  - bar:getInnerSpaceX() -- Should we use _content* here? I think no.
	local innerHeight = bar._layoutHeight - bar:getInnerSpaceY()
	local baseX       = bar._layoutX + bar._paddingLeft
	local baseY       = bar._layoutY + bar._paddingTop
	local x           = 0
	local y           = 0
	local spacing     = 0
	local first       = true


	for i, child in ipairs(bar) do
		if not (child._hidden or child._floating) then
			if not first then
				spacing  = math.max(spacing, child._spacingTop)
				y = y + spacing
			end

			child._layoutX      = baseX + x
			child._layoutY      = baseY + y
			child._layoutWidth  = widths[i]
			child._layoutHeight = heights[i]

			y = y + child._layoutHeight
			spacing  = child._spacingBottom
			first    = false
		end
	end

	local maxPerp = baseX

	for _, child in ipairs(bar) do
		if child._hidden then
			-- void
		elseif child._floating then
			expandAndPositionFloatingElement(child, innerWidth, innerHeight)
			-- Should we update maxPerp here? If so then we should update $advance too appropriately.
		else
			child:_expandAndPositionChildren()
			maxPerp = math.max(maxPerp, child._layoutX+child._layoutWidth)
		end
	end

	-- Make sure scrolling uses the final expanded content size.
	bar._contentHeight     = y
	bar._contentWidth = maxPerp - baseX

	updateScroll(bar)

end



--==============================================================
--= Root element class =========================================
--==============================================================



Cs.root = newElementClass(false, "GuiRoot", Cs.container, {}, {
	--[[REPLACE]] _width  = 0, -- The root always has a fixed size (i.e. not dynamic).
	--[[REPLACE]] _height = 0,
}, {
	-- void
})

-- function Cs.root.init(root, gui, elData, parent)
-- 	Cs.root.super.init(root, gui, elData, parent)
-- end



-- INTERNAL REPLACE  root:_draw( cullX1, cullY1, cullX2, cullY2, childToDrawNavTargetAfter )
function Cs.root._draw(root, cullX1, cullY1, cullX2, cullY2, childToDrawNavTargetAfter)
	if root._hidden then  return  end

	local x, y, w, h = xywhOnScreen(root)

	if not root._gui.debug then
		triggerIncludingAnimations(root, "beforedraw", x, y, w, h)
	end

	drawLayoutBackground(root)
	root:_drawDebug(0, 0, 1, 0)

	-- @Cleanup: Move root culling from caller to here.
	drawChildrenAndMaybeNavigationTarget(root, cullX1, cullY1, cullX2, cullY2, childToDrawNavTargetAfter)

	if not root._gui.debug then
		triggerIncludingAnimations(root, "afterdraw", x, y, w, h)
	end
end



-- OVERRIDE  root:setDimensions( width, height )
-- OVERRIDE  root:setWidth( width )
-- OVERRIDE  root:setHeight( height )
function Cs.root.setDimensions(root, w, h)
	if type(w)~="number" then argerror(2,1,"w",w,"number") end
	if type(h)~="number" then argerror(2,2,"h",h,"number") end
	Cs.root.super.setDimensions(root, math.max(w, 0), math.max(h, 0))
end
function Cs.root.setWidth(root, w)
	if type(w)~="number" then argerror(2,1,"w",w,"number") end
	Cs.root.super.setWidth(root, math.max(w, 0))
end
function Cs.root.setHeight(root, h)
	if type(h)~="number" then argerror(2,1,"h",h,"number") end
	Cs.root.super.setHeight(root, math.max(h, 0))
end



-- INTERNAL REPLACE  root:_calculateNaturalSize( )
function Cs.root._calculateNaturalSize(root)
	root._layoutWidth  = root._width
	root._layoutHeight = root._height
	calculateContainerChildNaturalSizes(root)
end

-- INTERNAL OVERRIDE  root:_expandAndPositionChildren( )
function Cs.root._expandAndPositionChildren(root)
	root._layoutX = root._x
	root._layoutY = root._y
	Cs.root.super._expandAndPositionChildren(root)
end



--==============================================================
--= Leaf element class (abstract) ==============================
--==============================================================



Cs.leaf = newElementClass(true, "GuiLeaf", Cs.element, {}, {
	-- Parameters.
	_align = "center", -- "left" | "right" | "center"

	_font = nil, -- Overrides gui._font if set.

	_mnemonics = false,

	_text = "",

	_textColor = nil,
	--

	_mnemonicBytePosition = 0, -- 0 means no position.
	_textWidth            = 0, _textHeight = 0,
	_unprocessedText      = "",
}, {
	-- void
})

function Cs.leaf.init(leaf, gui, elData, parent)
	Cs.leaf.super.init(leaf, gui, elData, parent)

	if elData.align ~= nil then leaf._align = elData.align end
	if elData.font ~= nil then leaf._font = elData.font end
	if elData.mnemonics ~= nil then leaf._mnemonics = elData.mnemonics end
	-- @@retrieve(leaf, elData, _text)
	if elData.textColor ~= nil then leaf._textColor = elData.textColor end

	if elData.text ~= nil then
		leaf:setText(elData.text)
	end
end



-- align = leaf:getAlign( )
function Cs.leaf.getAlign(leaf)
	return leaf._align
end

-- leaf:setAlign( align )
function Cs.leaf.setAlign(leaf, align)
	leaf._align = align -- Note: We shouldn't have to update the layout after changing the alignment.
end



-- font|nil = leaf:getFont( )
function Cs.leaf.getFont(leaf)
	return leaf._font
end

-- font = leaf:getResultingFont( )
function Cs.leaf.getResultingFont(leaf)
	return leaf._font or leaf._gui._font or _M.getDefaultFont()
end

-- leaf:setFont( font|nil )
function Cs.leaf.setFont(leaf, font)
	if leaf._font == font then  return  end
	leaf._font = font
	scheduleLayoutUpdateIfDisplayed(leaf)
end

-- fontBeingUsed = leaf:useFont( )
-- Tell LÖVE to use the leaf's resulting font.
function Cs.leaf.useFont(leaf)
	local font = leaf:getResultingFont()
	love.graphics.setFont(font)
	return font
end



-- offsetX, offsetY, width = leaf:getMnemonicOffset( )
-- Returns nil if there's no mnemonic.
function Cs.leaf.getMnemonicOffset(leaf)
	if leaf._mnemonicBytePosition == 0 then  return nil  end

	local font = leaf:getResultingFont()
	local text = leaf._text

	-- @Polish: Handle kerning.
	local    i1 = leaf._mnemonicBytePosition
	local _, i2 = text:find("^[%z\1-\127\194-\244][\128-\191]*", i1)
	local x1    = font:getWidth(text:sub(1, i1-1)) -- @Speed @Memory
	local x2    = font:getWidth(text:sub(1, i2  ))

	return x1, font:getBaseline(), math.max(x2-x1, 1)
end



-- text = leaf:getText( )
function Cs.leaf.getText(leaf)
	return leaf._text
end

-- text = leaf:getUnprocessedText( )
-- Also see gui:setTextPreprocessor().
function Cs.leaf.getUnprocessedText(leaf)
	return leaf._unprocessedText
end

-- leaf:setText( text )
function Cs.leaf.setText(leaf, unprocessedText)
	unprocessedText = tostring(unprocessedText == nil and "" or unprocessedText)

	local text = preprocessText(leaf._gui, unprocessedText, leaf, leaf._mnemonics)
	if leaf._text == text then  return  end

	-- Check text for mnemonics (using "&").
	leaf._mnemonicBytePosition = 0

	if leaf._mnemonics then
		local matchCount    = 0
		local mnemonicCount = 0

		local cleanText = text:gsub("()&(.)", function(pos, c)
			if c ~= "&" then
				if mnemonicCount == 0 then
					leaf._mnemonicBytePosition = pos - matchCount
				end
				mnemonicCount = mnemonicCount + 1
			end
			matchCount = matchCount + 1
			return c
		end)

		if mnemonicCount > 1 then
			printerr(2, "Multiple mnemonics in '%s'.", text)
		end

		text = cleanText
	end

	leaf._text            = text
	leaf._unprocessedText = unprocessedText

	local oldW      = leaf._textWidth
	leaf._textWidth = leaf:getResultingFont():getWidth(text)

	if leaf._textWidth ~= oldW then
		scheduleLayoutUpdateIfDisplayed(leaf)
	end
end



-- leaf:drawText( x, y )
function Cs.leaf.drawText(leaf, x, y)
	love.graphics.print(leaf._text, x, y)
end

-- leaf:drawAlignedText( areaX, areaY, areaWidth [, align=leaf:getAlign() ] )
function Cs.leaf.drawAlignedText(leaf, x, y, w, align)
	align = align or leaf._align
	if align == "right" then
		x = x + w - leaf._textWidth
	elseif align == "center" then
		x = x + math.floor((w-leaf._textWidth)/2)
	end
	leaf:drawText(x, y)
end



-- colorTable|nil = leaf:getTextColor( )
function Cs.leaf.getTextColor(leaf)
	return leaf._textColor
end

-- leaf:setTextColor( colorTable|nil )
function Cs.leaf.setTextColor(leaf, color)
	leaf._textColor = color
end

-- bool = leaf:hasTextColor( )
function Cs.leaf.hasTextColor(leaf)
	return leaf._textColor ~= nil
end

-- hasTextColor = leaf:useTextColor( [ alphaMultiplier=1 ] )
-- Tell LÖVE to use the leaf's resulting text color.
function Cs.leaf.useTextColor(leaf, opacity)
	local color = leaf._textColor
	useColor((color or COLOR_TEXT), opacity) -- @Edit
	return color ~= nil
end



-- REPLACE  bool = leaf:isSolid( )
function Cs.leaf.isSolid(leaf)
	return true
end



-- OVERRIDE  leaf:reprocessTexts( )
function Cs.leaf.reprocessTexts(leaf)
	Cs.leaf.super.reprocessTexts(leaf)
	leaf:setText(leaf._unprocessedText)
end



--==============================================================
--= Canvas element class =======================================
--==============================================================



Cs.canvas = newElementClass(false, "GuiCanvas", Cs.leaf, {}, {
	-- Parameters.
	_canvasBackgroundColor = nil,
	-- @Incomplete: Padding?
}, {
	"draw", -- function( canvasElement, event, drawAreaWidth, drawAreaHeight )
})

function Cs.canvas.init(canvas, gui, elData, parent)
	Cs.canvas.super.init(canvas, gui, elData, parent)

	if elData.canvasBackgroundColor ~= nil then canvas._canvasBackgroundColor = elData.canvasBackgroundColor end
end



-- INTERNAL REPLACE  canvas:_draw( cullX1, cullY1, cullX2, cullY2, childToDrawNavTargetAfter )
function Cs.canvas._draw(canvas, cullX1, cullY1, cullX2, cullY2, childToDrawNavTargetAfter)
	if canvas._hidden then  return  end

	local gui = canvas._gui
	if gui.debug then  return canvas:_drawDebug(1, 0, 0)  end

	local x, y, w, h = xywhOnScreen(canvas)

	triggerIncludingAnimations(canvas, "beforedraw", x, y, w, h)
	drawLayoutBackground(canvas)

	-- Draw canvas.
	-- We don't call themeRender() for canvases as they should only draw things through the "draw" event.
	local cw = canvas:hasFixedWidth () and canvas._width  or w -- Good behavior? @Revise
	local ch = canvas:hasFixedHeight() and canvas._height or h

	if cw > 0 and ch > 0 then
		love.graphics.push("all")

		local cx      = x + math.floor((w-cw)/2)
		local cy      = y + math.floor((h-ch)/2)
		local bgColor = canvas._canvasBackgroundColor

		if bgColor then
			setColor(unpack(bgColor))
			love.graphics.rectangle("fill", cx, cy, cw, ch)
		end

		setScissor(gui, cx, cy, cw, ch)
		love.graphics.translate(cx, cy)
		setColor(1, 1, 1)

		triggerIncludingAnimations(canvas, "draw", cw, ch)
		canvas:unsetScissor()

		setScissor(gui, nil) -- Why do we call unsetScissor() and then this? 2022-04-04
		love.graphics.pop()
	end

	triggerIncludingAnimations(canvas, "afterdraw", x, y, w, h)
end



-- colorTable|nil = canvas:getCanvasBackgroundColor( )
function Cs.canvas.getCanvasBackgroundColor(canvas)
	return canvas._canvasBackgroundColor
end

-- canvas:setCanvasBackgroundColor( colorTable|nil )
function Cs.canvas.setCanvasBackgroundColor(canvas, color)
	canvas._canvasBackgroundColor = color
end



-- INTERNAL REPLACE  handled, grabMouseFocus = canvas:_mousepressed( mouseX, mouseY, mouseButton, pressCount )
function Cs.canvas._mousepressed(canvas, mx, my, mbutton, pressCount)
	return true, true
end



-- INTERNAL REPLACE  canvas:_calculateNaturalSize( )
function Cs.canvas._calculateNaturalSize(canvas)
	-- We don't call themeGetSize() for canvases - they always have their own private "theme".
	canvas._layoutWidth  = math.max(canvas._width , 0)
	canvas._layoutHeight = math.max(canvas._height, 0)
end



--==============================================================
--= Image element class ========================================
--==============================================================



Cs.image = newElementClass(false, "GuiImage", Cs.leaf, {"imageInclude"}, {
	-- void
}, {
	-- void
})

function Cs.image.init(imageEl, gui, elData, parent)
	Cs.image.super.init(imageEl, gui, elData, parent)
	initImageInclude(imageEl, elData)
end



-- INTERNAL OVERRIDE  image:_update( deltaTime )
function Cs.image._update(imageEl, dt)
	Cs.image.super._update(imageEl, dt)
	local sprite = imageEl._sprite
	if sprite then  updateSprite(sprite, dt)  end
end



-- INTERNAL REPLACE  image:_draw( cullX1, cullY1, cullX2, cullY2, childToDrawNavTargetAfter )
function Cs.image._draw(imageEl, cullX1, cullY1, cullX2, cullY2, childToDrawNavTargetAfter)
	if imageEl._hidden    then  return  end
	if imageEl._gui.debug then  return imageEl:_drawDebug(1, 0, 0)  end

	local x, y, w, h = xywhOnScreen(imageEl)

	triggerIncludingAnimations(imageEl, "beforedraw", x, y, w, h)
	drawLayoutBackground(imageEl)

	local image = nil
	local quad  = nil
	local iw    = 0
	local ih    = 0

	if imageEl._sprite then
		image, quad, iw, ih = getCurrentViewOfSprite(imageEl._sprite)
	end
	themeRender(imageEl, "image", round(iw*imageEl._imageScaleX), round(ih*imageEl._imageScaleY))

	triggerIncludingAnimations(imageEl, "afterdraw", x, y, w, h)
end



-- INTERNAL REPLACE  image:_calculateNaturalSize( )
function Cs.image._calculateNaturalSize(imageEl)
	local iw, ih = imageEl:getImageDimensions()
	local  w,  h = themeGetSize(imageEl, "image", round(iw*imageEl._imageScaleX), round(ih*imageEl._imageScaleY))

	imageEl._layoutWidth, imageEl._layoutHeight = applySizeLimits(imageEl, w, h)

	if imageEl:hasFixedWidth () then  imageEl._layoutWidth  = imageEl._width   end
	if imageEl:hasFixedHeight() then  imageEl._layoutHeight = imageEl._height  end
end



--==============================================================
--= Text element class =========================================
--==============================================================



Cs.text = newElementClass(false, "GuiText", Cs.leaf, {}, {
	-- Parameters.
	_wrapText      = false,
	_textWrapLimit = -1, -- Negative means no limit.
}, {
	-- void
})

function Cs.text.init(textEl, gui, elData, parent)
	Cs.text.super.init(textEl, gui, elData, parent)

	if elData.wrapText ~= nil then textEl._wrapText = elData.wrapText end if elData.textWrapLimit ~= nil then textEl._textWrapLimit = elData.textWrapLimit end
end



-- INTERNAL REPLACE  text:_draw( cullX1, cullY1, cullX2, cullY2, childToDrawNavTargetAfter )
function Cs.text._draw(textEl, cullX1, cullY1, cullX2, cullY2, childToDrawNavTargetAfter)
	if textEl._hidden    then  return  end
	if textEl._gui.debug then  return textEl:_drawDebug(1, 0, 0)  end

	local x, y, w, h = xywhOnScreen(textEl)

	triggerIncludingAnimations(textEl, "beforedraw", x, y, w, h)
	drawLayoutBackground(textEl)

	local textIndent = themeGet(textEl._gui, "textIndentation")
	themeRender(textEl, "text", textIndent, textEl._textWidth, textEl._textHeight)

	triggerIncludingAnimations(textEl, "afterdraw", x, y, w, h)
end



-- INTERNAL REPLACE  text:_calculateNaturalSize( )
function Cs.text._calculateNaturalSize(textEl)
	local wrapLimit = textEl._textWrapLimit
	if wrapLimit < 0 then  wrapLimit = 1/0  end

	if wrapLimit == 1/0 and textEl._wrapText then
		local innerSpaceSum = 0

		for _, parent in textEl:parents() do
			innerSpaceSum = innerSpaceSum + parent:getInnerSpaceX()

			-- At most this will be the root, as the root always has a fixed size.
			if parent:hasFixedWidth() then
				wrapLimit = parent._width - innerSpaceSum - 2*themeGet(textEl._gui, "textIndentation")

				if wrapLimit <= 0 then
					-- Maybe the root's size is 0x0?
					wrapLimit = 1/0
				end

				break
			end
		end
	end

	local textW, textH = getTextDimensions(textEl:getResultingFont(), textEl._text, wrapLimit)
	textEl._textWidth  = textW
	textEl._textHeight = textH

	local textIndent = themeGet(textEl._gui, "textIndentation")
	local w, h       = themeGetSize(textEl, "text", textIndent, textW, textH)

	textEl._layoutWidth, textEl._layoutHeight = applySizeLimits(textEl, w, h)

	if textEl:hasFixedWidth () then  textEl._layoutWidth  = textEl._width   end
	if textEl:hasFixedHeight() then  textEl._layoutHeight = textEl._height  end
end



-- REPLACE  text:drawText( x, y )
function Cs.text.drawText(textEl, x, y)
	if textEl._wrapText or textEl._textWrapLimit >= 0 then
		love.graphics.printf(textEl._text, x, y, textEl._textWidth, textEl._align)
	else
		love.graphics.print(textEl._text, x, y)
	end
end



--==============================================================
--= Widget element class (abstract) ============================
--==============================================================



Cs.widget = newElementClass(true, "GuiWidget", Cs.leaf, {}, {
	-- Parameters.
	_active   = true, -- If the widget can be interacted with or is grayed out.
	_priority = 0,    -- Navigation priority.
}, {
	"navigate" , -- suppress = function( widgetElement, event )
	"navupdate", --            function( widgetElement, event, deltaTime )
})

function Cs.widget.init(widget, gui, elData, parent)
	Cs.widget.super.init(widget, gui, elData, parent)

	if elData.active ~= nil then widget._active = elData.active end
	if elData.priority ~= nil then widget._priority = elData.priority end
end



-- priority = widget:getPriority( )
function Cs.widget.getPriority(widget)
	return widget._priority
end

-- widget:setPriority( priority )
function Cs.widget.setPriority(widget, priority)
	widget._priority = priority
end



-- bool = widget:isActive( )
function Cs.widget.isActive(widget)
	return widget._active
end

-- stateChanged = widget:setActive( bool )
function Cs.widget.setActive(widget, active)
	if widget._active == active then  return false  end
	widget._active = active
	return true
end



--==============================================================
--= Button element class =======================================
--==============================================================



Cs.button = newElementClass(false, "GuiButton", Cs.widget, {"imageInclude"}, {
	-- Parameters.
	_pressable = true,
	_canToggle = false,
	_close     = false,

	_toggled = false,
	_radio   = "", -- Only used if canToggle is set.

	_text2 = "",

	_imagePadding = 0,

	_toggledSprite   = nil,
	_untoggledSprite = nil,
	--

	_isPressed = false,

	_textWidth1 = 0,
	_textWidth2 = 0,

	_unprocessedText2 = "",
}, {
	"press"    , -- function( buttonElement, event )
	"toggle"   , -- function( buttonElement, event )
	"toggleon" , -- function( buttonElement, event )
	"toggleoff", -- function( buttonElement, event )
})

function Cs.button.init(button, gui, elData, parent)
	Cs.button.super.init(button, gui, elData, parent)
	initImageInclude(button, elData)

	if elData.canToggle ~= nil then button._canToggle = elData.canToggle end
	if elData.close ~= nil then button._close = elData.close end
	if elData.imagePadding ~= nil then button._imagePadding = elData.imagePadding end
	if elData.pressable ~= nil then button._pressable = elData.pressable end
	if elData.radio ~= nil then button._radio = elData.radio end
	-- @@retrieve(button, elData, _text2)
	if elData.toggled ~= nil then button._toggled = elData.toggled end
	if elData.toggledSprite ~= nil then button._toggledSprite = elData.toggledSprite end if elData.untoggledSprite ~= nil then button._untoggledSprite = elData.untoggledSprite end

	if elData.sprite then
		-- void
	elseif button._toggledSprite and button._toggled then
		button:setSprite(button._toggledSprite)
	elseif button._untoggledSprite and not button._toggled then
		button:setSprite(button._untoggledSprite)
	end

	if elData.text2 ~= nil then
		button:setText2(elData.text2)
	end
end



-- INTERNAL OVERRIDE  button:_update( deltaTime )
function Cs.button._update(button, dt)
	Cs.button.super._update(button, dt)
	local sprite = button._sprite
	if sprite then  updateSprite(sprite, dt)  end
end



-- INTERNAL REPLACE  button:_draw( cullX1, cullY1, cullX2, cullY2, childToDrawNavTargetAfter )
function Cs.button._draw(button, cullX1, cullY1, cullX2, cullY2, childToDrawNavTargetAfter)
	if button._hidden    then  return  end
	if button._gui.debug then  return button:_drawDebug(0, 180, 0)  end

	local x, y, w, h = xywhOnScreen(button)

	triggerIncludingAnimations(button, "beforedraw", x, y, w, h)
	drawLayoutBackground(button)

	local image = nil
	local quad  = nil
	local iw    = 0
	local ih    = 0

	if button._sprite then
		image, quad, iw, ih = getCurrentViewOfSprite(button._sprite)
	end
	themeRender(
		button, "button", button._textWidth1, button._textWidth2, button._textHeight,
		round(iw*button._imageScaleX+2*button._imagePadding),
		round(ih*button._imageScaleY+2*button._imagePadding)
	)

	triggerIncludingAnimations(button, "afterdraw", x, y, w, h)
end



-- text2 = button:getText2( )
function Cs.button.getText2(button)
	return button._text2
end

-- text = button:getUnprocessedText2( )
function Cs.button.getUnprocessedText2(button)
	return button._unprocessedText2
end

-- OVERRIDE  button:setText( text )
function Cs.button.setText(button, text)
	local oldText = button._text
	local oldW    = button._textWidth

	Cs.button.super.setText(button, text)
	text = nil -- Don't use this anymore!

	if button._text == oldText then  return  end

	button._textWidth1 = button._textWidth
	button._textWidth  = button._textWidth1 + button._textWidth2

	if button._textWidth ~= oldW then
		scheduleLayoutUpdateIfDisplayed(button)
	end
end

-- button:setText2( text )
function Cs.button.setText2(button, unprocessedText)
	unprocessedText = tostring(unprocessedText == nil and "" or unprocessedText)

	local text = preprocessText(button._gui, unprocessedText, button, false)
	if button._text2 == text then  return  end

	button._text2            = text
	button._unprocessedText2 = unprocessedText

	local oldW         = button._textWidth
	button._textWidth2 = button:getResultingFont():getWidth(text)
	button._textWidth  = button._textWidth1 + button._textWidth2

	if button._textWidth ~= oldW then
		scheduleLayoutUpdateIfDisplayed(button)
	end
end



-- button:drawText2( x, y )
function Cs.button.drawText2(button, x, y)
	love.graphics.print(button._text2, x, y)
end

-- button:drawAlignedText2( areaX, areaY, areaWidth [, align=button:getAlign() ] )
function Cs.button.drawAlignedText2(button, x, y, w, align)
	align = align or button._align
	if align == "right" then
		x = x + w - button._textWidth2
	elseif align == "center" then
		x = x + math.floor((w-button._textWidth2)/2)
	end
	button:drawText(x, y)
end



-- bool = button:isPressable( )
function Cs.button.isPressable(button)
	return button._pressable
end

-- button:setPressable( bool )
function Cs.button.setPressable(button, pressable)
	button._pressable = pressable
end



-- bool = button:isToggled( )
function Cs.button.isToggled(button)
	return button._toggled
end

-- button:setToggled( bool )
function Cs.button.setToggled(button, toggled)
	if button._toggled == toggled then  return  end

	button._toggled = toggled

	if toggled and button._toggledSprite then
		button:setSprite(button._toggledSprite)
	elseif not toggled and button._untoggledSprite then
		button:setSprite(button._untoggledSprite)
	end

	trigger(button, (toggled and "toggleon" or "toggleoff"))
	trigger(button, "toggle")
end



-- bool = button:isRadio( )
function Cs.button.isRadio(button)
	return button._radio ~= ""
end

-- radioName = button:getRadio( )
function Cs.button.getRadio(button)
	return button._radio
end

-- button:setRadio( radioName )
-- An empty name disables radio.
function Cs.button.setRadio(button, radioName)
	button._radio = radioName
end



-- INTERNAL REPLACE  handled, grabMouseFocus = button:_mousepressed( mouseX, mouseY, mouseButton, pressCount )
function Cs.button._mousepressed(button, mx, my, mbutton, pressCount)
	if mbutton == 1 then
		if not button._active then  return true, false  end

		local gui = button._gui

		if gui._triggerOnMousepressed then
			gui._navigateSoundSuppressionLevel = gui._navigateSoundSuppressionLevel + 1
			gui:navigateTo(gui._navigationTarget and button or nil)
			gui._navigateSoundSuppressionLevel = gui._navigateSoundSuppressionLevel - 1

			button:press()
			return true, false

		else
			button._isPressed = true
			button:playSound("buttondown")

			gui._navigateSoundSuppressionLevel = gui._navigateSoundSuppressionLevel + 1
			gui:navigateTo(gui._navigationTarget and button or nil)
			gui._navigateSoundSuppressionLevel = gui._navigateSoundSuppressionLevel - 1

			return true, true
		end
	end
	-- @Incomplete: Trigger events and stuff for other mouse buttons.

	return false, false
end

-- -- INTERNAL REPLACE  button:_mousemoved( mouseX, mouseY, deltaX, deltaY )
-- function Cs.button._mousemoved(button, mx, my, dx, dy)
-- end

-- INTERNAL REPLACE  button:_mousereleased( mouseX, mouseY, mouseButton, pressCount )
function Cs.button._mousereleased(button, mx, my, mbutton, pressCount)
	if mbutton == 1 then
		button._isPressed = false
		if button:isHovered() then  button:press()  end
	end
end



-- INTERNAL REPLACE  handled = button:_ok( )
function Cs.button._ok(button)
	button:press()
	return true
end



-- success = button:press( [ ignoreActiveState=false ] )
function Cs.button.press(button, ignoreActiveState)
	if not ignoreActiveState and not (button._active and button._pressable) then
		return false
	end

	-- Press/toggle the button.
	local preparedSound = button._canToggle and prepareSound(button, "toggle") or prepareSound(button, "press") -- "toggle" falls back to "press".
	local toggled       = button._toggled

	if button._canToggle then
		if button._radio ~= "" then
			if toggled then  return true  end -- Assume this is the only toggled button in the radio group.

			for otherButton in button:getRoot():traverseType"button" do
				if otherButton == button then
					-- void
				elseif otherButton._radio == button._radio then
					-- Should we collect all buttons first so we don't invoke user code during traversal? @Robustness
					otherButton:setToggled(false)
				end
			end
		end

		toggled         = not toggled
		button._toggled = toggled -- We need to toggle before the press event in case the callback uses the value.

		if toggled and button._toggledSprite then
			button:setSprite(button._toggledSprite)
		elseif not toggled and button._untoggledSprite then
			button:setSprite(button._untoggledSprite)
		end
	end

	button._gui._ignoreKeyboardInputThisFrame = true

	trigger(button, "press")
	if button._canToggle then
		trigger(button, (toggled and "toggleon" or "toggleoff"))
		trigger(button, "toggle")
	end

	button:triggerBubbling("pressed", button)

	-- Close closest closable. heh
	local closedAnything = false

	if not button._close then
		-- void
	elseif button:canClose() then
		closedAnything = button:close()
	else
		for _, parent in button:parents() do
			if parent:canClose() then
				closedAnything = parent:close()
				break
			end
		end
	end
	if preparedSound and not closedAnything then
		preparedSound() -- 'close' has its own sound.
	end

	return true
end

-- bool = button:isPressed( )
function Cs.button.isPressed(button)
	return button._isPressed
end



-- OVERRIDE  button:reprocessTexts( )
function Cs.button.reprocessTexts(button)
	Cs.button.super.reprocessTexts(button)
	button:setText2(button._unprocessedText2)
end



-- INTERNAL REPLACE  button:_calculateNaturalSize( )
function Cs.button._calculateNaturalSize(button)
	local font         = button:getResultingFont()
	button._textWidth1 = font:getWidth(button._text)
	button._textWidth2 = font:getWidth(button._text2)
	button._textWidth  = button._textWidth1 + button._textWidth2 -- This value is pretty useless...
	button._textHeight = font:getHeight()

	local iw, ih = button:getImageDimensions()
	local  w,  h = themeGetSize(
		button, "button", button._textWidth1, button._textWidth2, button._textHeight,
		round(iw*button._imageScaleX+2*button._imagePadding),
		round(ih*button._imageScaleY+2*button._imagePadding)
	)

	button._layoutWidth, button._layoutHeight = applySizeLimits(button, w, h)

	if button:hasFixedWidth () then  button._layoutWidth  = button._width   end
	if button:hasFixedHeight() then  button._layoutHeight = button._height  end
end



--==============================================================
--= Input element class ========================================
--==============================================================



Cs.input = newElementClass(false, "GuiInput", Cs.widget, {}, {
	-- Parameters.
	--[[OVERRIDE]] _mouseCursor = "ibeam",

	--[[REPLACE]] _minWidth = 10,

	_placeholder = "",

	_mask = "",

	_spin = 0, -- Non-zero enables number value spinning.

	_spinMin = -1/0,
	_spinMax = 1/0,
	--

	_field = nil,

	_savedKeyRepeat = false,
	_savedValue     = "",
}, {
	"change"     , -- function( inputElement, event ) -- Triggered on blur and the value has changed since before focus.
	"submit"     , -- function( inputElement, event )
	"valuechange", -- function( inputElement, event ) -- Triggered after every value change while focused.
})

function Cs.input.init(inputEl, gui, elData, parent)
	Cs.input.super.init(inputEl, gui, elData, parent)

	-- @@retrieve(inputEl, elData, _fieldType) -- This is saved in the field instead.
	if elData.mask ~= nil then inputEl._mask = elData.mask end
	if elData.placeholder ~= nil then inputEl._placeholder = elData.placeholder end
	if elData.spin ~= nil then inputEl._spin = elData.spin end
	if elData.spinMin ~= nil then inputEl._spinMin = elData.spinMin end if elData.spinMax ~= nil then inputEl._spinMax = elData.spinMax end
	-- @@retrieve(inputEl, elData, _value) -- This is saved in the field instead.

	inputEl._field = InputField(elData.value--[[default=""]], elData.fieldType--[[default="normal"]])
	inputEl._field:setFont(inputEl:getResultingFont())
	inputEl._field:setFontFilteringActive(true)
end



-- INTERNAL OVERRIDE  input:_update( deltaTime )
function Cs.input._update(inputEl, dt)
	Cs.input.super._update(inputEl, dt)
	inputEl._field:update(dt)
end



-- INTERNAL REPLACE  input:_draw( cullX1, cullY1, cullX2, cullY2, childToDrawNavTargetAfter )
function Cs.input._draw(inputEl, cullX1, cullY1, cullX2, cullY2, childToDrawNavTargetAfter)
	if inputEl._hidden    then  return  end
	if inputEl._gui.debug then  return inputEl:_drawDebug(0, 180, 0)  end

	local x, y, w, h                     = xywhOnScreen(inputEl)
	local valueX, valueY, valueW, valueH = inputEl:getValueLayout()
	local curOffsetX, curOffsetY, curH   = inputEl._field:getCursorLayout()

	-- @Incomplete: Draw scrollbars. (We really ought to handle mouse events for them too!)

	triggerIncludingAnimations(inputEl, "beforedraw", x, y, w, h)

	drawLayoutBackground(inputEl)
	themeRender(inputEl, "input", valueX, valueY, valueW, valueH, curOffsetX, curOffsetY, curH)

	triggerIncludingAnimations(inputEl, "afterdraw", x, y, w, h)
end



-- input:drawValue( x, y )
function Cs.input.drawValue(inputEl, x0, y0)
	for _, line, x, y in inputEl._field:eachVisibleLine() do
		love.graphics.print(line, x0+x, y0+y)
	end
end

-- input:drawPlaceholder( x, y )
function Cs.input.drawPlaceholder(inputEl, x, y)
	love.graphics.print(inputEl._placeholder, x, y)
end

-- input:drawValueOrPlaceholder( x, y )
function Cs.input.drawValueOrPlaceholder(inputEl, x, y)
	if    inputEl:getValue() ~= ""
	then  inputEl:drawValue(x, y)
	else  inputEl:drawPlaceholder(x, y)  end
end

-- input:drawSelections( x, y [, callback ] )
-- callback = function( x, y, width, height )
-- If no callback is given then a filled rectangle is drawn for each selection.
function Cs.input.drawSelections(input, x0, y0, cb)
	for _, x, y, w, h in input._field:eachSelectionOptimized() do
		if cb then  cb           (        x0+x, y0+y, w, h)
		else        love.graphics.rectangle("fill", x0+x, y0+y, w, h)  end
	end
end



-- input:focus( )
function Cs.input.focus(inputEl)
	local gui = inputEl._gui
	if gui._keyboardFocus == inputEl then  return  end

	inputEl._savedValue     = inputEl:getValue()
	inputEl._savedKeyRepeat = love.keyboard.hasKeyRepeat()

	gui:navigateTo(gui._navigationTarget and inputEl or nil)
	gui._lockNavigation = true

	setKeyboardFocus(gui, inputEl)

	love.keyboard.setKeyRepeat(true)
	inputEl._field:resetBlinking()

	inputEl:playSound("focus")
	inputEl:triggerBubbling("focused", inputEl)
end

-- success = input:blur( )
function Cs.input.blur(inputEl)
	local gui = inputEl._gui
	if gui._keyboardFocus ~= inputEl then  return false  end

	blurKeyboardFocus(gui)
	gui._lockNavigation = false

	love.keyboard.setKeyRepeat(inputEl._savedKeyRepeat)

	inputEl._field:setScroll(0, 0)

	local v = inputEl:getValue()
	if v ~= inputEl._savedValue then
		trigger(inputEl, "change", v)
	end

	inputEl:triggerBubbling("blurred", inputEl)
	return true
end

-- bool = input:isFocused( )
function Cs.input.isFocused(inputEl)
	return inputEl:isKeyboardFocus()
end



--
-- inputField = input:getField( )
--
-- Inputs use the InputField library for many things. This method gives direct access to
-- the internal InputField instance. (See https://github.com/ReFreezed/InputField)
--
-- Warning: Changing things in the inputField directly may mess up GuiLove!
--
function Cs.input.getField(inputEl)
	return inputEl._field
end



-- value = input:getValue( )
function Cs.input.getValue(inputEl)
	return inputEl._field:getText()
end

-- input:setValue( value )
function Cs.input.setValue(inputEl, value)
	inputEl._field:setText(value)
end

-- value = input:getVisibleValue( )
-- Returns *** for passwords.
function Cs.input.getVisibleValue(inputEl)
	return inputEl._field:getVisibleText()
end



-- fieldType = input:getFieldType( )
function Cs.input.getFieldType(inputEl)
	return inputEl._field:getType()
end

-- input:setFieldType( fieldType )
-- fieldType = "normal" | "password" | "multiwrap" | "multinowrap"
function Cs.input.setFieldType(inputEl, fieldType)
	inputEl._field:setType(fieldType)
end



-- INTERNAL REPLACE  handled, grabKeyboardFocus = input:_keypressed( key, scancode, isRepeat )
function Cs.input._keypressed(inputEl, key, scancode, isRepeat)
	if not inputEl:isKeyboardFocus() then  return false, false  end

	local oldCurOffsetX, oldCurOffsetY = inputEl._field:getCursorLayout()

	if key == "escape" then
		if not isRepeat then
			if inputEl:getValue() ~= inputEl._savedValue then
				inputEl._field:setText(inputEl._savedValue)
				trigger(inputEl, "valuechange")
			end
			inputEl:blur()
			inputEl:playSound("inputrevert")
		end

	elseif (key == "return" or key == "kpenter") and not (inputEl._field:isMultiline() and not love.keyboard.isDown(LCTRL,RCTRL)) then
		if not isRepeat then
			inputEl:blur()
			inputEl:playSound("inputsubmit")
			trigger(inputEl, "submit")
		end

	elseif inputEl._spin ~= 0 and (key == "up" or key == "down") then
		local oldValue = inputEl:getValue()
		local n        = tonumber(oldValue) or 0

		if key == "up" then
			n = n + inputEl._spin
		elseif key == "down" then
			n = n - inputEl._spin
		end
		n = math.min(math.max(n, inputEl._spinMin), inputEl._spinMax)

		local newValue = tostring(n)
		if newValue ~= oldValue then
			inputEl:setValue(newValue)
			inputEl._field:selectAll()
			inputEl:playSound("type")
			trigger(inputEl, "valuechange")
		end

	else
		local oldValue             = inputEl:getValue()
		local handled, textChanged = inputEl._field:keypressed(key, isRepeat)

		if not textChanged then
			-- void
		elseif inputEl._mask ~= "" and not inputEl:getValue():find(inputEl._mask) then
			inputEl:setValue(oldValue) -- Undo the change.  @UX: Handle the cursor better.
		else
			inputEl:playSound("type")
			trigger(inputEl, "valuechange")
		end
	end

	if inputEl:isFocused() then
		local curOffsetX, curOffsetY = inputEl._field:getCursorLayout()
		if curOffsetX ~= oldCurOffsetX or curOffsetY ~= oldCurOffsetY then
			inputEl:scrollIntoView(true)
		end
	end

	return true, false
end

-- -- INTERNAL REPLACE  input:_keyreleased( key, scancode )
-- function Cs.input._keyreleased(inputEl, key, scancode)
-- end

-- INTERNAL REPLACE  handled = input:_textinput( text )
function Cs.input._textinput(inputEl, text)
	if not inputEl:isKeyboardFocus() then  return false  end

	local oldValue             = inputEl:getValue()
	local handled, textChanged = inputEl._field:textinput(text)

	if not textChanged then
		-- void
	elseif inputEl._mask ~= "" and not inputEl:getValue():find(inputEl._mask) then
		inputEl:setValue(oldValue) -- Undo the change.  @UX: Handle the cursor better.
		inputEl:scrollIntoView(true)
	else
		inputEl:scrollIntoView(true)
		inputEl:playSound("type")
		trigger(inputEl, "valuechange")
	end

	return true
end



-- INTERNAL REPLACE  handled, grabMouseFocus = input:_mousepressed( mouseX, mouseY, mouseButton, pressCount )
function Cs.input._mousepressed(inputEl, mx, my, mbutton, pressCount)
	if not inputEl._active then  return true, false  end

	inputEl:focus()

	if mbutton == 1 then
		local x, y        = inputEl:getPositionOnScreen()
		local inputIndent = themeGet(inputEl._gui, "inputIndentation")
		inputEl._field:mousepressed(mx-x-inputIndent, my-y-inputIndent, mbutton, pressCount)
		inputEl:scrollIntoView(true) -- @Incomplete: Scroll to the mouse cursor instead of the text cursor (but do it smoothly over time in the update event). :SmoothScrollInputToMouse
		return true, true
	else
		return true, false
	end
end

-- INTERNAL REPLACE  input:_mousemoved( mouseX, mouseY, deltaX, deltaY )
function Cs.input._mousemoved(inputEl, mx, my, dx, dy)
	local x, y        = inputEl:getPositionOnScreen()
	local inputIndent = themeGet(inputEl._gui, "inputIndentation")
	inputEl._field:mousemoved(mx-x-inputIndent, my-y-inputIndent)
	inputEl:scrollIntoView(true) -- :SmoothScrollInputToMouse
end

-- INTERNAL REPLACE  input:_mousereleased( mouseX, mouseY, mouseButton, pressCount )
function Cs.input._mousereleased(inputEl, mx, my, mbutton, pressCount)
	local x, y        = inputEl:getPositionOnScreen()
	local inputIndent = themeGet(inputEl._gui, "inputIndentation")
	inputEl._field:mousereleased(mx-x-inputIndent, my-y-inputIndent, mbutton)
end

-- INTERNAL REPLACE  handled = input:_wheelmoved( deltaX, deltaY, deltaX0, deltaY0 )
function Cs.input._wheelmoved(inputEl, dx, dy, dx0, dy0)
	local handled = inputEl._field:wheelmoved(dx0, dy0) -- @Incomplete: Smooth scrolling for inputs. (Maybe it should be implemented in InputField?)
	if handled then
		inputEl:playSound("scroll")
	end
	return handled
end



-- INTERNAL REPLACE  handled = input:_ok( )
function Cs.input._ok(inputEl)
	inputEl._gui._ignoreKeyboardInputThisFrame = true
	if inputEl:isFocused() then
		inputEl:blur()
	else
		inputEl:focus()
	end
	return true
end



-- OVERRIDE  input:setActive( bool )
function Cs.input.setActive(inputEl, active)
	if not active then  inputEl:blur()  end
	Cs.input.super.setActive(inputEl, active)
end



-- INTERNAL REPLACE  input:_calculateNaturalSize( )
function Cs.input._calculateNaturalSize(inputEl)
	local font = inputEl:getResultingFont()
	inputEl._field:setFont(font)

	local _, h = themeGetSize(inputEl, "input", _, font:getHeight())

	inputEl._layoutWidth, inputEl._layoutHeight = applySizeLimits(inputEl, 0, h)

	if inputEl:hasFixedWidth () then  inputEl._layoutWidth  = inputEl._width   end
	if inputEl:hasFixedHeight() then  inputEl._layoutHeight = inputEl._height  end
end

-- INTERNAL OVERRIDE  input:_expandAndPositionChildren( )
function Cs.input._expandAndPositionChildren(inputEl)
	Cs.input.super._expandAndPositionChildren(inputEl)

	local inputIndent = themeGet(inputEl._gui, "inputIndentation")
	inputEl._field:setDimensions(inputEl._layoutWidth-2*inputIndent, inputEl._layoutHeight-2*inputIndent) -- Maybe there should be a separate vertical inputIndentation? @Incomplete
end



-- valueX, valueY, valueWidth, valueHeight = input:getValueLayout( )
function Cs.input.getValueLayout(inputEl)
	updateLayoutIfNeeded(inputEl._gui)

	local inputIndent    = themeGet(inputEl._gui, "inputIndentation")
	local valueW, valueH = inputEl._field:getTextDimensions()
	local valueX         = inputIndent
	local valueY         = inputEl._field:isMultiline() and inputIndent or math.floor((inputEl._layoutHeight-valueH)/2) -- @Incomplete: Maybe add parameters for aligning the value.

	return valueX, valueY, valueW, valueH
end

-- offsetX, offsetY, height = input:getCursorLayout( )
function Cs.input.getCursorLayout(inputEl)
	return inputEl._field:getCursorLayout()
end



-- phase = input:getBlinkPhase( )
function Cs.input.getBlinkPhase(inputEl)
	return inputEl._field:getBlinkPhase()
end



--==============================================================
--= Slider element class =======================================
--==============================================================



Cs.slider = newElementClass(false, "GuiSlider", Cs.widget, {}, {
	-- Parameters.
	_value = 0.0,
	_step  = 0.0, -- 0 means no step value.
	_min   = 0.0,
	_max   = 1.0,

	_vertical = false,

	_continuous      = false,
	_continuousSpeed = 0.01, -- Used if _continuous is set.

	_valueFormat = "", -- Empty means automatic.
	--

	_savedValue = 0.0,

	_continuousValue = 0.0,
	_savedMouseX     = 0.0,
	_savedMouseY     = 0.0,
	_savedMouseRealX = 0,
	_savedMouseRealY = 0,
}, {
	"change"     , -- function( sliderElement, event ) -- Triggered on blur and the value has changed since before focus.
	"valuechange", -- function( sliderElement, event ) -- Triggered after every value change while focused.
})

function Cs.slider.init(slider, gui, elData, parent)
	Cs.slider.super.init(slider, gui, elData, parent)

	if elData.continuous ~= nil then slider._continuous = elData.continuous end if elData.continuousSpeed ~= nil then slider._continuousSpeed = elData.continuousSpeed end
	if elData.value ~= nil then slider._value = elData.value end if elData.step ~= nil then slider._step = elData.step end if elData.min ~= nil then slider._min = elData.min end if elData.max ~= nil then slider._max = elData.max end
	if elData.valueFormat ~= nil then slider._valueFormat = elData.valueFormat end
	if elData.vertical ~= nil then slider._vertical = elData.vertical end

	local v = slider._value
	if slider._step ~= 0 then
		v = round(v / slider._step) * slider._step
	end
	slider._value = clamp(v, slider._min, slider._max)
end



-- INTERNAL REPLACE  slider:_calculateNaturalSize( )
function Cs.slider._calculateNaturalSize(slider)
	local sliderIndent = themeGet(slider._gui, "sliderIndentation")
	local fontH        = slider:getResultingFont():getHeight()
	local w, h         = themeGetSize(slider, "slider", 0, 0, sliderIndent, fontH)

	slider._layoutWidth, slider._layoutHeight = applySizeLimits(slider, w, h)

	if slider:hasFixedWidth () then  slider._layoutWidth  = slider._width   end
	if slider:hasFixedHeight() then  slider._layoutHeight = slider._height  end
end

-- -- INTERNAL OVERRIDE  slider:_expandAndPositionChildren( )
-- function Cs.slider._expandAndPositionChildren(slider)
-- 	Cs.slider.super._expandAndPositionChildren(slider)
-- end



-- INTERNAL REPLACE  slider:_draw( cullX1, cullY1, cullX2, cullY2, childToDrawNavTargetAfter )
function Cs.slider._draw(slider, cullX1, cullY1, cullX2, cullY2, childToDrawNavTargetAfter)
	if slider._hidden    then  return  end
	if slider._gui.debug then  return slider:_drawDebug(0, 180, 0)  end

	local x, y, w, h   = xywhOnScreen(slider)
	local sliderIndent = themeGet(slider._gui, "sliderIndentation")

	triggerIncludingAnimations(slider, "beforedraw", x, y, w, h)

	drawLayoutBackground(slider)
	themeRender(slider, "slider", sliderIndent)

	triggerIncludingAnimations(slider, "afterdraw", x, y, w, h)
end



-- drawValue( x, y [, anchorX=0, anchorY=0 ] )
function Cs.slider.drawValue(slider, x, y, ax, ay)
	ax = ax or 0
	ay = ay or 0

	local text = slider:getValueText()
	local font = love.graphics.getFont() -- Should be the same font as getResultingFont() returns, but whatever.

	if ax ~= 0 then  x = x - round(ax*font:getWidth(text))  end
	if ay ~= 0 then  y = y - round(ay*font:getHeight()   )  end

	love.graphics.print(text, x, y)
end



-- INTERNAL REPLACE  handled, grabMouseFocus = slider:_mousepressed( mouseX, mouseY, mouseButton, pressCount )
function Cs.slider._mousepressed(slider, mx, my, mbutton, pressCount)
	if not slider._active then  return true, false  end
	if mbutton ~= 1       then  return true, false  end

	slider._savedValue = slider._value
	slider._gui:navigateTo(slider._gui._navigationTarget and slider or nil)

	if slider._continuous then
		slider._continuousValue = slider._value
		slider._savedMouseX     = mx
		slider._savedMouseY     = my

		slider._savedMouseRealX, slider._savedMouseRealY = love.mouse.getPosition()
		love.mouse.setRelativeMode(true)

	else
		slider:_mousemoved(mx, my, 0, 0)
	end

	return true, true
end

-- INTERNAL REPLACE  slider:_mousemoved( mouseX, mouseY, deltaX, deltaY )
function Cs.slider._mousemoved(slider, mx, my, dx, dy)
	local x, y, w, h = xywhOnScreen(slider)

	if slider._vertical then
		x  = y
		w  = h
		mx = my
	end

	local sliderIndent = themeGet(slider._gui, "sliderIndentation")
	local v

	if slider._continuous then
		v = slider._continuousValue - dy * slider._continuousSpeed

		local overshoot = slider._continuousSpeed * 50 -- @Hardcoded: May want a parameter for this.
		v               = clamp(v, slider._min-overshoot, slider._max+overshoot)

		slider._continuousValue = v

	else
		local t = (mx-x-sliderIndent) / (w-2*sliderIndent)
		if slider._vertical then  t = 1-t  end

		v = lerp(slider._min, slider._max, t)
	end

	if slider._step ~= 0 then
		v = round(v / slider._step) * slider._step
	end
	v = clamp(v, slider._min, slider._max) -- @Incomplete: Support min>max?

	if slider._value ~= v then
		slider._value = v
		slider:playSound("slidermove")
		trigger(slider, "valuechange")
	end
end

-- INTERNAL REPLACE  slider:_mousereleased( mouseX, mouseY, mouseButton, pressCount )
function Cs.slider._mousereleased(slider, mx, my, mbutton, pressCount)
	if slider._continuous then
		slider._gui:mousemoved( -999999,  -999999, 0, 0) -- Maybe @Temp? It improves the glitchy situation.
		love.mouse.setRelativeMode(false) -- @Bug: Fix mouse position flicker. Also, freeze gui._mouseX/Y.
		love.mouse.setPosition(slider._savedMouseRealX, slider._savedMouseRealY)
		-- @Incomplete: updateHoveredElement?
	end

	if slider._value ~= slider._savedValue then
		trigger(slider, "change")
	end
end



-- value = slider:getValue( )
function Cs.slider.getValue(slider)
	return slider._value
end

-- normalizedValue = slider:getNormalizedValue( )
-- normalizedValue is between 0(min) and 1(max).
function Cs.slider.getNormalizedValue(slider)
	return (slider._value-slider._min) / (slider._max-slider._min)
end

-- slider:setValue( value )
function Cs.slider.setValue(slider, v)
	if slider._step ~= 0 then
		v = round(v / slider._step) * slider._step
	end
	slider._value = clamp(v, slider._min, slider._max)
end

-- valueChanged = slider:increase( [ amount=auto ] )
-- valueChanged = slider:decrease( [ amount=auto ] )
function Cs.slider.increase(slider, amount)
	amount  = amount or ((slider._step ~= 0) and slider._step or .1*(slider._max-slider._min))
	local v = clamp(slider._value+amount, slider._min, slider._max)

	if slider._value == v then  return false  end

	slider._value = v
	slider:playSound("slidermove")
	return true
end
function Cs.slider.decrease(slider, amount)
	amount  = amount or ((slider._step ~= 0) and slider._step or .1*(slider._max-slider._min))
	local v = clamp(slider._value-amount, slider._min, slider._max)

	if slider._value == v then  return false  end

	slider._value = v
	slider:playSound("slidermove")
	return true
end



-- value = slider:getMin( )
-- value = slider:getMax( )
function Cs.slider.getMin(slider)
	return slider._min
end
function Cs.slider.getMax(slider)
	return slider._max
end

-- slider:setMin( value )
-- slider:setMax( value )
function Cs.slider.setMin(slider, v)
	slider._min   = v
	slider._value = clamp(v, slider._min, slider._max)
end
function Cs.slider.setMax(slider, v)
	slider._max   = v
	slider._value = clamp(v, slider._min, slider._max)
end



-- format = slider:getValueFormat( )
function Cs.slider.getValueFormat(slider)
	return slider._valueFormat
end

-- format = slider:getResultingValueFormat( )
function Cs.slider.getResultingValueFormat(slider)
	if slider._valueFormat ~= "" then  return slider._valueFormat  end

	return (slider._step > 1 and slider._step == math.floor(slider._step))
	   and "%d"
	   or  "%.2f"
end

-- slider:setValueFormat( format )
-- An empty string means automatic format.
function Cs.slider.setValueFormat(slider, valueFormat)
	if type(valueFormat)~="string" then argerror(2,1,"valueFormat",valueFormat,"string") end
	slider._valueFormat = valueFormat
end



-- text = slider:getValueText( )
function Cs.slider.getValueText(slider)
	-- @Incomplete: Special texts for specific user-defined values.
	return F(slider:getResultingValueFormat(), slider._value)
end



-- bool = slider:isVertical( )
function Cs.slider.isVertical(slider)
	return slider._vertical
end

-- slider:setVertical( bool )
function Cs.slider.setVertical(slider, vertical)
	if slider._vertical == vertical then  return  end
	slider._vertical = vertical
	scheduleLayoutUpdateIfDisplayed(slider)
end



-- REPLACE  cursor|nil = slider:getResultingMouseCursor( )
function Cs.slider.getResultingMouseCursor(slider)
	local cur = slider._mouseCursor or (slider._continuous and (slider._vertical and "sizens" or "sizewe") or nil)
	if type(cur) ~= "string" then  return cur  end
	return love.mouse.getSystemCursor(cur)
end



-- bool = slider:isContinuous( )
function Cs.slider.isContinuous(slider)
	return slider._continuous
end

-- slider:setContinuous( bool )
function Cs.slider.setContinuous(slider, continuous)
	if slider._continuous == continuous then  return  end
	slider._continuous = continuous
	scheduleLayoutUpdateIfDisplayed(slider)
end



--==============================================================
--= Default theme ==============================================
--==============================================================

do
local Gui    = _M
defaultTheme = (function()
	local TAU = 2*math.pi



	-- Settings.

	local BUTTON_PADDING       = 3
	local BUTTON_IMAGE_SPACING = 3 -- Between text and image.
	local BUTTON_TEXT_SPACING  = 6 -- Between the texts, if there are two.

	local INPUT_PADDING = 4

	local SLIDER_PADDING          = 6
	local SLIDER_WIDTH            = 16
	local SLIDER_DEFAULT_LENGTH   = 80
	local SLIDER_HANDLE_THICKNESS = 3
	local SLIDER_MARKER_WIDTH     = 6

	local CONTINUOUS_SLIDER_DEFAULT_WIDTH = 3 -- Relative to font size.

	local NAV_EXTRA_SIZE      = 10 -- In each direction.
	local NAV_SHRINK_DURATION = .10

	local SCROLLBAR_WIDTH      = 8
	local SCROLLBAR_MIN_LENGTH = 12

	local TEXT_PADDING = 1 -- For text elements.

	local TOOLTIP_PADDING       = 3
	local TOOLTIP_FADE_DURATION = .15



	-- Images.

	local buttonBackgroundImage = Gui.newMonochromeImage{
		"3cffffc3",
		"cffffffc",
		"ffffffff",
		"ffffffff",
		"ffffffff",
		"ffffffff",
		"cffffffc",
		"3cffffc3",
	}
	local buttonBackgroundQuads = Gui.create9SliceQuads(buttonBackgroundImage, 3, 3)

	local navigationImage = Gui.newMonochromeImage{
		" 4cffffc4 ",
		"4e822228e4",
		"c82222228c",
		"f22222222f",
		"f22222222f",
		"f22222222f",
		"f22222222f",
		"c82222228c",
		"4e822228e4",
		" 4cffffc4 ",
	}
	local navigationQuads = Gui.create9SliceQuads(navigationImage, 4, 4)

	local continuousSliderImage = Gui.newMonochromeImage{
		"ff",
		"66",
		"22",
		"00",
		"00",
		"22",
		"66",
		"ff",
	}
	continuousSliderImage:setFilter("linear", "linear")



	--==============================================================
	--==============================================================
	--==============================================================

	return {



		-- Basic theme parameters.
		----------------------------------------------------------------

		inputIndentation   = INPUT_PADDING,  -- Affects mouse interactions and scrolling for inputs.
		sliderIndentation  = SLIDER_PADDING, -- Affects mouse interactions for sliders.

		navigationSize     = NAV_EXTRA_SIZE, -- How much extra size the highlight of the navigation target has. Affects scrollIntoView().

		scrollbarWidth     = SCROLLBAR_WIDTH,
		scrollbarMinLength = SCROLLBAR_MIN_LENGTH,

		textIndentation    = TEXT_PADDING, -- Affects how multiline texts wraps in text elements.



		-- Special callbacks.
		----------------------------------------------------------------

		init = function(el)
			-- This function is called for every newly created element.
		end,



		-- Size callbacks.
		----------------------------------------------------------------

		-- These return the (minimum) dimensions for elements.

		-- If a width or height is 0 it generally means that that component is
		-- missing from the element, i.e. a button may not have an image.

		size = {
			-- Image element.
			-- size.image( imageElement, imageWidth, imageHeight )
			["image"] = function(imageEl, imageW, imageH)
				return imageW, imageH
			end,

			-- Text element.
			-- size.text( textElement, textIndentation, textWidth, textHeight )
			["text"] = function(textEl, textIndent, textW, textH)
				return textW+2*textIndent, textH+2*TEXT_PADDING
			end,

			-- Button element.
			-- size.button( buttonElement, text1Width, text2Width, textHeight, imageWidth, imageHeight )
			["button"] = function(button, text1W, text2W, textH, imageW, imageH)
				--
				-- Buttons generally have 3 main states: only image, only text, or both image
				-- and text. The text can include two texts - a main and a secondary. In this
				-- theme all these parameters affects the size and looks differently.
				--
				local textW = text1W + (text2W > 0 and BUTTON_TEXT_SPACING+text2W or 0)
				local w, h

				-- Only image.
				if imageW > 0 and textW == 0 then
					w = imageW
					h = imageH

				-- Only text.
				elseif imageW == 0 then
					w = textW
					h = textH

				-- Image and text.
				else
					w = imageW + BUTTON_IMAGE_SPACING + textW
					h = math.max(textH, imageH)
				end

				w = w + 2*BUTTON_PADDING
				h = h + 2*BUTTON_PADDING

				return w, h
			end,

			-- Input element.
			-- size.input( inputElement, _, fontHeight ) -- Ignore the 'width' argument for inputs.
			["input"] = function(input, _, fontHeight)
				-- Only the returned height is actually used. For inputs, the width
				-- is always specified directly on the element outside the theme.
				return 0, fontHeight+2*INPUT_PADDING
			end,

			-- Slider element.
			-- size.slider( sliderElement, zeroWidth, zeroHeight, sliderIndentation, fontHeight )
			["slider"] = function(slider, w, h, sliderIndent, fontH)
				if slider:isContinuous() then
					w = CONTINUOUS_SLIDER_DEFAULT_WIDTH*fontH + 2*SLIDER_PADDING
					h = fontH + 2*SLIDER_PADDING

				else
					w = SLIDER_DEFAULT_LENGTH + 2*sliderIndent
					h = SLIDER_WIDTH + 2*SLIDER_PADDING

					if slider:isVertical() then
						w, h = h, w
					end
				end

				return w, h
			end,

			-- Tooltip.
			-- size.tooltip( element, textWidth, textHeight )
			["tooltip"] = function(el, textW, textH)
				return textW+2*TOOLTIP_PADDING, textH+2*TOOLTIP_PADDING
			end,
		},



		-- Draw callbacks.
		----------------------------------------------------------------

		draw = {
			-- The background of an element with the 'background' attribute specified.
			-- draw.background( element, elementWidth, elementHeight, background )
			["background"] = function(el, w, h, bg)
				if bg == "warning" then
					Gui.setColor(.4, 0, 0, .9)
					love.graphics.rectangle("fill", 0, 0, w, h)
				else
					Gui.setColor(.17, .17, .17, .9)
					love.graphics.rectangle("fill", 0, 0, w, h)
				end
			end,

			-- Image element.
			-- draw.image( imageElement, elementWidth, elementHeight, imageWidth, imageHeight )
			["image"] = function(imageEl, w, h, imageW, imageH)
				local imageX = math.floor((w-imageW)/2)
				local imageY = math.floor((h-imageH)/2)

				if imageEl:hasImageBackgroundColor() then
					imageEl:useImageBackgroundColor()
					love.graphics.rectangle("fill", imageX, imageY, imageW, imageH)
				end

				imageEl:useImageColor()
				imageEl:drawImage(imageX, imageY)
			end,

			-- Text element.
			-- draw.text( textElement, elementWidth, elementHeight, textIndentation, textWidth, textHeight )
			["text"] = function(textEl, w, h, textIndent, textW, textH)
				local textAreaX = textIndent
				local textAreaY = math.floor((h-textH)/2)
				local textAreaW = w - 2*textIndent

				textEl:setScissor(0, 0, w, h) -- Make sure text doesn't render outside the element.

				textEl:useFont()
				textEl:useTextColor()
				textEl:drawAlignedText(textAreaX, textAreaY, textAreaW)
			end,

			-- Button element.
			-- draw.button( buttonElement, elementWidth, elementHeight, text1Width, text2Width, textHeight, imageWidth )
			["button"] = function(button, w, h, text1W, text2W, textH, imageW, imageH)
				local align = button:getAlign()

				local midX  = math.floor(w/2)
				local midY  = math.floor(h/2)
				local textY = math.floor((h-textH)/2)

				local opacity = button:isActive() and 1 or .3

				local isHovered = button:isActive() and button:isHovered()

				-- Background.
				local r, g, b = .4, .4, .4
				if button:isToggled() then  r, g, b = .4, .6, 1 end

				local highlight = isHovered and not button:isPressed() and 1 or 0
				if button:isPressed() and isHovered then  r, g, b = r*.25, g*.25, b*.25  end

				r, g, b = Gui.lerpColor(r,g,b, 1,1,1, .3*highlight)
				local a = .8 * opacity

				Gui.setColor(r, g, b, a)
				Gui.draw9SliceScaled(1, 1, w-2, h-2, buttonBackgroundImage, unpack(buttonBackgroundQuads))

				button:setScissor(2, 2, w-2*2, h-2*2) -- Make sure the contents does not render outside the element.

				-- Only image.
				-- @Incomplete: Support 'align' for no-text image buttons.
				if button:hasSprite() and button:getText() == "" and button:getText2() == "" then
					if button:hasImageBackgroundColor() then
						button:useImageBackgroundColor(opacity)
						love.graphics.rectangle("fill", math.floor(midX-imageW/2), math.floor(midY-imageH/2), imageW, imageH)
					end

					button:useImageColor(opacity)
					button:drawImage(math.floor(midX-imageW/2), math.floor(midY-imageH/2))

				-- Only text
				elseif not button:hasSprite() then
					local text1X, text2X

					if align == "left" then
						text1X      = BUTTON_PADDING
						text2X      = math.max(w-BUTTON_PADDING-text2W, text1X+text1W+BUTTON_TEXT_SPACING)
					elseif align == "right" then
						text1X      = math.max(w-BUTTON_PADDING-text1W, BUTTON_PADDING)
						text2X      = math.min(BUTTON_PADDING, text1X-BUTTON_TEXT_SPACING-text2W)
					elseif align == "center" then
						local textW = text1W+(text2W > 0 and BUTTON_TEXT_SPACING+text2W or 0)
						text1X      = math.max(midX-math.floor(textW/2), BUTTON_PADDING)
						text2X      = text1X + text1W + BUTTON_TEXT_SPACING
					end

					button:useFont()
					Gui.setColor(1, 1, 1, .6*opacity)
					button:drawText2(text2X, textY)
					Gui.setColor(1, 1, 1, opacity)
					button:drawText(text1X, textY)

					local mnemonicX, mnemonicY, mnemonicW = button:getMnemonicOffset()
					if mnemonicX then
						love.graphics.rectangle("fill", text1X+mnemonicX, textY+mnemonicY+1, mnemonicW, 1)
					end

				-- Image and text.
				-- We'll ignore the align property and assume "left" alignment in this situation, for now.
				else
					if button:hasImageBackgroundColor() then
						button:useImageBackgroundColor(opacity)
						love.graphics.rectangle("fill", BUTTON_PADDING, math.floor(midY-imageH/2), imageW, imageH)
					end

					local text1X =     BUTTON_PADDING + imageW + BUTTON_IMAGE_SPACING
					local text2X = w - BUTTON_PADDING - text2W

					button:useImageColor(opacity)
					button:drawImage(BUTTON_PADDING, math.floor(midY-imageH/2))

					button:useFont()
					Gui.setColor(1, 1, 1, .6*opacity)
					button:drawText2(text2X, textY)
					Gui.setColor(1, 1, 1, opacity)
					button:drawText(text1X, textY)

					local mnemonicX, mnemonicY, mnemonicW = button:getMnemonicOffset()
					if mnemonicX then
						love.graphics.rectangle("fill", text1X+mnemonicX, textY+mnemonicY+1, mnemonicW, 1)
					end
				end
			end,

			-- Input element.
			-- draw.input( inputElement, elementWidth, elementHeight, valueX, valueY, valueWidth, valueHeight, cursorOffsetX, cursorOffsetY, fontHeight )
			["input"] = function(input, w, h, valueX, valueY, valueW, valueH, curOffsetX, curOffsetY, fontHeight)
				local opacity = input:isActive() and 1 or .3

				-- Background.
				if input:isKeyboardFocus() then
					Gui.setColor(.3, .7, .3, .3)
					love.graphics.rectangle("fill", 1, 1, w-2, h-2)
				end

				-- Border.
				local isHighlighted = (input:isActive() and input:isHovered()) or input:isKeyboardFocus()
				local a             = (isHighlighted and 1 or .4) * opacity
				Gui.setColor(1, 1, 1, a)
				love.graphics.rectangle("line", 1+.5, 1+.5, w-2-1, h-2-1)

				input:setScissor(2, 2, w-2*2, h-2*2) -- Make sure the contents does not render outside the element.

				--
				-- Note: If the user can use the mouse to interact with the GUI then we're
				-- quite restricted to how we can render the value, the cursor and selections
				-- for the mechanics and the visuals to stay in sync.
				--

				-- Selections.
				if input:isKeyboardFocus() then
					Gui.setColor(1, 1, 1, .35)
					input:drawSelections(valueX, valueY)
				end

				-- Value.
				input:useFont()
				if input:getValue() ~= "" then
					Gui.setColor(1, 1, 1, opacity)
					input:drawValue(valueX, valueY)
				else
					Gui.setColor(1, 1, 1, .5*opacity)
					input:drawPlaceholder(valueX, valueY)
				end

				-- Cursor.
				if input:isKeyboardFocus() then
					local cursorOpacity = ((math.cos(5*input:getBlinkPhase()) + 1) / 2) ^ .5
					Gui.setColor(1, 1, 1, cursorOpacity)
					love.graphics.rectangle("fill", valueX+curOffsetX-1, valueY+curOffsetY, 1, fontHeight)
				end
			end,

			-- Slider element.
			-- draw.slider( inputElement, elementWidth, elementHeight, sliderIndentation )
			["slider"] = function(slider, w, h, sliderIndent)
				if slider:isContinuous() then
					local opacity       = slider:isActive() and 1 or .3
					local isHighlighted = (slider:isActive() and slider:isHovered()) or slider:isMouseFocus()
					local a             = (isHighlighted and 1 or .7) * opacity

					Gui.setColor(1, 1, 1, .6*a)
					love.graphics.rectangle("fill", 0, 0,  2, h)
					love.graphics.rectangle("fill", w, 0, -2, h)
					love.graphics.draw(continuousSliderImage, 0,0, 0, w/continuousSliderImage:getWidth(),h/continuousSliderImage:getHeight())

					Gui.setColor(1, 1, 1, opacity)
					slider:useFont()
					slider:drawValue(math.floor(w/2), math.floor(h/2), .5, .5)

				else
					if slider:isVertical() then
						love.graphics.push()
						love.graphics.translate(w, 0)
						love.graphics.rotate(TAU/4)
						w, h = h, w
					end

					local railX1  = sliderIndent
					local railX2  = w - sliderIndent
					local railW   = railX2 - railX1
					local handleX = railX1 + railW * (slider:isVertical() and 1-slider:getNormalizedValue() or slider:getNormalizedValue())
					local railY   = math.floor(.5*h)

					local opacity       = slider:isActive() and 1 or .3
					local isHighlighted = (slider:isActive() and slider:isHovered()) or slider:isMouseFocus()
					local a             = (isHighlighted and 1 or .7) * opacity

					-- Rail.
					Gui.setColor(1, 1, 1, .7*a)
					love.graphics.rectangle("fill", railX1, railY-1, railW, 2)

					-- Helper markers.
					Gui.setColor(1, 1, 1, .7*a)
					love.graphics.rectangle("fill",            railX1                , railY-.5*SLIDER_MARKER_WIDTH, 1, SLIDER_MARKER_WIDTH)
					love.graphics.rectangle("fill", math.floor(railX1+0.25*(railW-1)), railY-.5*SLIDER_MARKER_WIDTH, 1, SLIDER_MARKER_WIDTH)
					love.graphics.rectangle("fill", math.floor(railX1+0.50*(railW-1)), railY-.5*SLIDER_MARKER_WIDTH, 1, SLIDER_MARKER_WIDTH)
					love.graphics.rectangle("fill", math.floor(railX1+0.75*(railW-1)), railY-.5*SLIDER_MARKER_WIDTH, 1, SLIDER_MARKER_WIDTH)
					love.graphics.rectangle("fill",            railX2-1              , railY-.5*SLIDER_MARKER_WIDTH, 1, SLIDER_MARKER_WIDTH)

					-- Value handle.
					Gui.setColor(1, 1, 1, a)
					love.graphics.rectangle("fill", math.floor(handleX-.5*SLIDER_HANDLE_THICKNESS), railY-.5*SLIDER_WIDTH, SLIDER_HANDLE_THICKNESS, SLIDER_WIDTH)

					if slider:isVertical() then
						love.graphics.pop()
					end
				end
			end,

			-- Scrollbar.
			-- draw.scrollbar( container, scrollbarWidth, scrollbarHeight, direction, handlePosition, handleLength )
			-- draw.scrollbardeadzone( container, deadzoneWidth, deadzoneHeight )
			["scrollbar"] = function(container, w, h, dir, pos, len)
				local isScrolling     = container[dir == "x" and "isScrollingX"              or "isScrollingY"             ](container)
				local isBarHovered    = container[dir == "x" and "isScrollbarXHovered"       or "isScrollbarYHovered"      ](container)
				local isHandleHovered = container[dir == "x" and "isScrollbarXHandleHovered" or "isScrollbarYHandleHovered"](container)

				-- Background.
				local a = (isBarHovered or isScrolling) and .1 or 0
				Gui.setColor(1, 1, 1, a)
				love.graphics.rectangle("fill", 0, 0, w, h)

				-- Scrollbar handle.
				local handleX, handleY, handleW, handleH

				if    dir == "x"
				then  handleX, handleY, handleW, handleH = pos+1, 1, len-2, h-2
				else  handleY, handleX, handleH, handleW = pos+1, 1, len-2, w-2  end

				local a = (isScrolling and .2) or (isHandleHovered and .3) or (.2)
				Gui.setColor(1, 1, 1, a)

				Gui.draw9SliceScaled(handleX, handleY, handleW, handleH, buttonBackgroundImage, unpack(buttonBackgroundQuads))
			end,
			["scrollbardeadzone"] = function(container, w, h)
				-- This is the area where the two scrollbars meet (if there are two).
				-- In this theme we just leave it empty.
			end,

			-- Highlight of current navigation target.
			-- draw.navigation( widget, elementWidth, elementHeight, timeSinceNavigation )
			["navigation"] = function(widget, w, h, timeSinceNav)
				-- Use a bigger highlight size right after navigation, then quickly shrink to same size as the element.
				local offset = NAV_EXTRA_SIZE * math.max(1-timeSinceNav/NAV_SHRINK_DURATION, 0)
				local x      = -offset
				local y      = -offset
				w            = w + 2*offset
				h            = h + 2*offset

				Gui.setColor(1, 1, 0, 1)
				Gui.draw9SliceScaled(x, y, w, h, navigationImage, unpack(navigationQuads))
			end,

			-- Tooltip.
			-- draw.tooltip( element, tooltipWidth, tooltipHeight, text, textWidth, textHeight, timeVisible, timeUntilInvisible )
			["tooltip"] = function(el, w, h, text, textW, textH, timeVisible, timeUntilInvisible)
				local opacity = math.min(timeVisible, timeUntilInvisible) / TOOLTIP_FADE_DURATION
				opacity       = math.min(opacity, 1)

				-- Background.
				Gui.setColor(1, 1, 1, opacity)
				love.graphics.rectangle("fill", 1, 1, w-2, h-2)
				love.graphics.setLineWidth(1)
				Gui.setColor(0, 0, 0)
				love.graphics.rectangle("line", .5, .5, w-1, h-1)

				-- Text.
				local x = TOOLTIP_PADDING
				local y = TOOLTIP_PADDING
				el:useTooltipFont()
				Gui.setColor(0, 0, 0, opacity)
				el:drawTooltip(x, y)
			end,
		},



		----------------------------------------------------------------
	}

	--==============================================================
	--==============================================================
	--==============================================================

  end)()
end



--==============================================================
--==============================================================
--==============================================================

return setmetatable(_M, {
	__call = function(_M, ...)
		return (Gui(...))
	end,
})

--==============================================================
--=
--=  MIT License
--=
--=  Copyright © 2017-2022 Marcus 'ReFreezed' Thunström
--=
--=  Permission is hereby granted, free of charge, to any person obtaining a copy
--=  of this software and associated documentation files (the "Software"), to deal
--=  in the Software without restriction, including without limitation the rights
--=  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
--=  copies of the Software, and to permit persons to whom the Software is
--=  furnished to do so, subject to the following conditions:
--=
--=  The above copyright notice and this permission notice shall be included in all
--=  copies or substantial portions of the Software.
--=
--=  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
--=  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
--=  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
--=  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
--=  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
--=  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
--=  SOFTWARE.
--=
--==============================================================
