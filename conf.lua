function love.conf(t)
	t.identity = "LoveAudioEffectsPlayground"
	t.version  = "11.4"

	t.window.title     = "LÖVE Audio Effects Playground"
	t.window.icon      = "gfx/appIcon16.png"
	t.window.resizable = true
	t.window.width     = 1200
	t.window.height    = 680
	t.window.minwidth  = 950
	t.window.minheight = 550
	-- t.window.msaa   = 3^2

	t.modules.audio    = true
	t.modules.data     = false
	t.modules.event    = true
	t.modules.font     = true
	t.modules.graphics = true
	t.modules.image    = true
	t.modules.joystick = false
	t.modules.keyboard = true
	t.modules.math     = true
	t.modules.mouse    = true
	t.modules.physics  = false
	t.modules.sound    = true
	t.modules.system   = true
	t.modules.thread   = false
	t.modules.timer    = true
	t.modules.touch    = false
	t.modules.video    = false
	t.modules.window   = true
end
