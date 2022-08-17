--[[============================================================
--=
--=  GUI theme
--=
--=-------------------------------------------------------------
--=
--=  LÖVE Audio Effects Playground
--=  by Marcus 'ReFreezed' Thunström
--=
--============================================================]]

local Gui = require"Gui"
local TAU = 2*math.pi



-- Settings.

local BUTTON_PADDING_X     = 4
local BUTTON_PADDING_Y     = 2
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

local buttonBackground2Image = Gui.newMonochromeImage{
	"  5cffc5  ",
	" bffffffb ",
	"5ffffffff5",
	"cffffffffc",
	"ffffffffff",
	"ffffffffff",
	"ffffffffff",
	"cffffffffc",
	"5ffffffff5",
	" bffffffb ",
	"  5cffc5  ",
}
local buttonBackground2Quads = Gui.create9SliceQuads(buttonBackground2Image, 4, 4)

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



return {
	inputIndentation   = INPUT_PADDING,  -- Affects mouse interactions and scrolling for inputs.
	sliderIndentation  = SLIDER_PADDING, -- Affects mouse interactions for sliders.

	navigationSize     = NAV_EXTRA_SIZE, -- How much extra size the highlight of the navigation target has. Affects scrollIntoView().

	scrollbarWidth     = SCROLLBAR_WIDTH,
	scrollbarMinLength = SCROLLBAR_MIN_LENGTH,

	textIndentation    = TEXT_PADDING, -- Affects how multiline texts wraps in text elements.



	-- Special callbacks.
	----------------------------------------------------------------

	init = function(el)
		-- ...
	end,



	-- Size callbacks.
	----------------------------------------------------------------

	size = {
		["image"] = function(imageEl, imageW, imageH)
			return imageW, imageH
		end,

		["text"] = function(textEl, textIndent, textW, textH)
			return textW+2*textIndent, textH+2*TEXT_PADDING
		end,

		["button"] = function(button, text1W, text2W, textH, imageW, imageH)
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

			w = w + 2*BUTTON_PADDING_X
			h = h + 2*BUTTON_PADDING_Y

			return w, h
		end,

		["input"] = function(input, _, fontH)
			return 0, fontH+2*INPUT_PADDING
		end,

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

		["tooltip"] = function(el, textW, textH)
			return textW+2*TOOLTIP_PADDING, textH+2*TOOLTIP_PADDING
		end,
	},



	-- Draw callbacks.
	----------------------------------------------------------------

	draw = {
		["background"] = function(el, w, h, bg)
			if bg == "faded" then
				local r, g, b = Color"b1e3fa"
				Gui.setColor(r, g, b, .3)
				LG.rectangle("fill", 0,0, w,h)
			elseif bg == "box" then
				Gui.setColor(Color"e0f4fc")
				Gui.draw9SliceScaled(0,0, w,h, buttonBackground2Image,unpack(buttonBackground2Quads))
			elseif bg == "shadowbox" then
				Gui.setColor(0, 0, 0, .2)
				Gui.draw9SliceScaled(-6,-6, w+2*6,h+2*6, buttonBackground2Image,unpack(buttonBackground2Quads))
				Gui.setColor(Color"e0f4fc")
				Gui.draw9SliceScaled(0,0, w,h, buttonBackground2Image,unpack(buttonBackground2Quads))
			else
				Gui.setColor(0, 0, 0)
				LG.rectangle("fill", 0,0, w,h)
			end
		end,

		["image"] = function(imageEl, w, h, imageW, imageH)
			local imageX = math.floor((w-imageW)/2)
			local imageY = math.floor((h-imageH)/2)

			if imageEl:hasImageBackgroundColor() then
				imageEl:useImageBackgroundColor()
				LG.rectangle("fill", imageX, imageY, imageW, imageH)
			end

			imageEl:useImageColor()
			imageEl:drawImage(imageX, imageY)
		end,

		["text"] = function(textEl, w, h, textIndent, textW, textH)
			local textAreaX = textIndent
			local textAreaY = math.floor((h-textH)/2)
			local textAreaW = w - 2*textIndent

			-- textEl:setScissor(0, 0, w, h) -- Make sure text doesn't render outside the element.

			textEl:useFont()
			textEl:useTextColor()
			textEl:drawAlignedText(textAreaX, textAreaY, textAreaW)
		end,

		["button"] = function(button, w, h, text1W, text2W, textH, imageW, imageH)
			local align = button:getAlign()

			local midX  = math.floor(w/2)
			local midY  = math.floor(h/2)
			local textY = math.floor((h-textH)/2)

			local opacity = button:isActive() and 1 or .3

			local isHovered = button:isActive() and button:isHovered()

			-- Background.
			local r, g, b = Color"1e86be"
			if button:isToggled() then  r, g, b = Color"25b786"
			elseif isHovered      then  r, g, b = Color"da5d86"  end

			local highlight = isHovered and button:isToggled() and not button:isPressed() and 1 or 0
			if button:isPressed() and isHovered then  r, g, b = r*.8, g*.8, b*.8  end

			r, g, b = Gui.lerpColor(r,g,b, 1,1,1, .2*highlight)
			local a = .8 * opacity

			Gui.setColor(r, g, b, a)
			Gui.draw9SliceScaled(1, 1, w-2, h-2, buttonBackgroundImage, unpack(buttonBackgroundQuads))

			button:setScissor(1, 1, w-2*1, h-2*1) -- Make sure the contents does not render outside the element.

			-- Only image.
			-- @Incomplete: Support 'align' for no-text image buttons.
			if button:hasSprite() and button:getText() == "" and button:getText2() == "" then
				if button:hasImageBackgroundColor() then
					button:useImageBackgroundColor(opacity)
					LG.rectangle("fill", math.floor(midX-imageW/2), math.floor(midY-imageH/2), imageW, imageH)
				end

				button:useImageColor(opacity)
				button:drawImage(math.floor(midX-imageW/2), math.floor(midY-imageH/2))

			-- Only text
			elseif not button:hasSprite() then
				local text1X, text2X

				if align == "left" then
					text1X      = BUTTON_PADDING_X
					text2X      = math.max(w-BUTTON_PADDING_X-text2W, text1X+text1W+BUTTON_TEXT_SPACING)
				elseif align == "right" then
					text1X      = math.max(w-BUTTON_PADDING_X-text1W, BUTTON_PADDING_X)
					text2X      = math.min(BUTTON_PADDING_X, text1X-BUTTON_TEXT_SPACING-text2W)
				elseif align == "center" then
					local textW = text1W+(text2W > 0 and BUTTON_TEXT_SPACING+text2W or 0)
					text1X      = math.max(midX-math.floor(textW/2), BUTTON_PADDING_X)
					text2X      = text1X + text1W + BUTTON_TEXT_SPACING
				end

				button:useFont()
				Gui.setColor(1, 1, 1, .6*opacity)
				button:drawText2(text2X, textY)
				Gui.setColor(1, 1, 1, opacity)
				button:drawText(text1X, textY)

				local mnemonicX, mnemonicY, mnemonicW = button:getMnemonicOffset()
				if mnemonicX then
					LG.rectangle("fill", text1X+mnemonicX, textY+mnemonicY+1, mnemonicW, 1)
				end

			-- Image and text.
			-- We'll ignore the align property and assume "left" alignment in this situation, for now.
			else
				if button:hasImageBackgroundColor() then
					button:useImageBackgroundColor(opacity)
					LG.rectangle("fill", BUTTON_PADDING_X, math.floor(midY-imageH/2), imageW, imageH)
				end

				local text1X =     BUTTON_PADDING_X + imageW + BUTTON_IMAGE_SPACING
				local text2X = w - BUTTON_PADDING_X - text2W

				button:useImageColor(opacity)
				button:drawImage(BUTTON_PADDING_X, math.floor(midY-imageH/2))

				button:useFont()
				Gui.setColor(1, 1, 1, .6*opacity)
				button:drawText2(text2X, textY)
				Gui.setColor(1, 1, 1, opacity)
				button:drawText(text1X, textY)

				local mnemonicX, mnemonicY, mnemonicW = button:getMnemonicOffset()
				if mnemonicX then
					LG.rectangle("fill", text1X+mnemonicX, textY+mnemonicY+1, mnemonicW, 1)
				end
			end
		end,

		["input"] = function(input, w, h, valueX, valueY, valueW, valueH, curOffsetX, curOffsetY, fontH)
			local r, g, b = Color"1b4d68"
			local opacity = input:isActive() and 1 or .3

			-- Background.
			if input:isKeyboardFocus() then
				local bgR, bgG, bgB = Color"25b786"
				Gui.setColor(bgR, bgG, bgB, .2)
				LG.rectangle("fill", 1, 1, w-2, h-2)
			end

			-- Border.
			local isHighlighted = (input:isActive() and input:isHovered()) or input:isKeyboardFocus()
			local a             = (isHighlighted and 1 or .4) * opacity
			Gui.setColor(r, g, b, a)
			LG.rectangle("line", 1+.5, 1+.5, w-2-1, h-2-1)

			input:setScissor(2, 2, w-2*2, h-2*2) -- Make sure the contents does not render outside the element.

			-- Selections.
			if input:isKeyboardFocus() then
				Gui.setColor(r, g, b, .35)
				input:drawSelections(valueX, valueY)
			end

			-- Value.
			input:useFont()
			if input:getValue() ~= "" then
				Gui.setColor(r, g, b, opacity)
				input:drawValue(valueX, valueY)
			else
				Gui.setColor(r, g, b, .5*opacity)
				input:drawPlaceholder(valueX, valueY)
			end

			-- Cursor.
			if input:isKeyboardFocus() then
				local cursorOpacity = ((math.cos(5*input:getBlinkPhase()) + 1) / 2) ^ .5
				Gui.setColor(r, g, b, cursorOpacity)
				LG.rectangle("fill", valueX+curOffsetX-1, valueY+curOffsetY, 1, fontH)
			end
		end,

		["slider"] = function(slider, w, h, sliderIndent)
			local r, g, b = Color"1b4d68"

			if slider:isContinuous() then
				local opacity       = slider:isActive() and 1 or .3
				local isHighlighted = (slider:isActive() and slider:isHovered()) or slider:isMouseFocus()
				local a             = (isHighlighted and 1 or .7) * opacity

				Gui.setColor(r, g, b, .6*a)
				LG.rectangle("fill", 0, 0,  2, h)
				LG.rectangle("fill", w, 0, -2, h)
				LG.draw(continuousSliderImage, 0,0, 0, w/continuousSliderImage:getWidth(),h/continuousSliderImage:getHeight())

				Gui.setColor(r, g, b, opacity)
				slider:useFont()
				slider:drawValue(math.floor(w/2), math.floor(h/2), .5, .5)

			else
				if slider:isVertical() then
					LG.push()
					LG.translate(w, 0)
					LG.rotate(TAU/4)
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
				Gui.setColor(r, g, b, .7*a)
				LG.rectangle("fill", railX1, railY-1, railW, 2)

				-- Helper markers.
				Gui.setColor(r, g, b, .7*a)
				LG.rectangle("fill",            railX1                , railY-.5*SLIDER_MARKER_WIDTH, 1, SLIDER_MARKER_WIDTH)
				LG.rectangle("fill", math.floor(railX1+0.25*(railW-1)), railY-.5*SLIDER_MARKER_WIDTH, 1, SLIDER_MARKER_WIDTH)
				LG.rectangle("fill", math.floor(railX1+0.50*(railW-1)), railY-.5*SLIDER_MARKER_WIDTH, 1, SLIDER_MARKER_WIDTH)
				LG.rectangle("fill", math.floor(railX1+0.75*(railW-1)), railY-.5*SLIDER_MARKER_WIDTH, 1, SLIDER_MARKER_WIDTH)
				LG.rectangle("fill",            railX2-1              , railY-.5*SLIDER_MARKER_WIDTH, 1, SLIDER_MARKER_WIDTH)

				-- Value handle.
				Gui.setColor(r, g, b, a)
				LG.rectangle("fill", math.floor(handleX-.5*SLIDER_HANDLE_THICKNESS), railY-.5*SLIDER_WIDTH, SLIDER_HANDLE_THICKNESS, SLIDER_WIDTH)

				if slider:isVertical() then
					LG.pop()
				end
			end
		end,

		["scrollbar"] = function(container, w, h, dir, pos, len)
			local isScrolling     = container[dir == "x" and "isScrollingX"              or "isScrollingY"             ](container)
			local isBarHovered    = container[dir == "x" and "isScrollbarXHovered"       or "isScrollbarYHovered"      ](container)
			local isHandleHovered = container[dir == "x" and "isScrollbarXHandleHovered" or "isScrollbarYHandleHovered"](container)

			local r, g, b = Color"1b4d68"

			-- Background.
			local a = (isBarHovered or isScrolling) and .2 or 0
			Gui.setColor(r, g, b, a)
			LG.rectangle("fill", 0, 0, w, h)

			-- Scrollbar handle.
			local handleX, handleY, handleW, handleH

			if    dir == "x"
			then  handleX, handleY, handleW, handleH = pos+1, 1, len-2, h-2
			else  handleY, handleX, handleH, handleW = pos+1, 1, len-2, w-2  end

			local a = (isScrolling and .3) or (isHandleHovered and .4) or (.3)
			Gui.setColor(r, g, b, a)

			Gui.draw9SliceScaled(handleX, handleY, handleW, handleH, buttonBackgroundImage, unpack(buttonBackgroundQuads))
		end,
		["scrollbardeadzone"] = function(container, w, h)
			-- void
		end,

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

		["tooltip"] = function(el, w, h, text, textW, textH, timeVisible, timeUntilInvisible)
			local opacity = math.min(timeVisible, timeUntilInvisible) / TOOLTIP_FADE_DURATION
			opacity       = math.min(opacity, 1)

			-- Background.
			Gui.setColor(1, 1, 1, opacity)
			LG.rectangle("fill", 1, 1, w-2, h-2)
			LG.setLineWidth(1)
			Gui.setColor(0, 0, 0)
			LG.rectangle("line", .5, .5, w-1, h-1)

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
