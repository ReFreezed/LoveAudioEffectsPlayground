function love.conf(t)
	t.identity = "LoveAudioEffectsPlayground"
	t.version  = "11.4"

	t.window.title     = "LÖVE Audio Effects Playground"
	t.window.width     = 1100
	t.window.height    = 760
	t.window.resizable = true

	t.modules.audio    = true
	t.modules.data     = false
	t.modules.event    = true
	t.modules.font     = true
	t.modules.graphics = true
	t.modules.image    = true
	t.modules.joystick = false
	t.modules.keyboard = true
	t.modules.math     = false
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