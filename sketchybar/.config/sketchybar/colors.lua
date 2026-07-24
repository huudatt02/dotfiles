return {
	black = 0xff000000,
	white = 0xffffffff,
	red = 0xffff4245,
	orange = 0xffff9230,
	yellow = 0xffffd600,
	green = 0xff30d158,
	mint = 0xff00dac3,
	teal = 0xff00d2e0,
	cyan = 0xff3cd3fe,
	blue = 0xff0091ff,
	indigo = 0xff6d7cff,
	purple = 0xffdb34f2,
	pink = 0xffff375f,
	brown = 0xffb78a66,
	grey = 0xff8e8e93,
	transparent = 0x00000000,

	bar = {
		bg = 0xff1c1c1e,
		border = 0xff3a3a3c,
	},

	popup = {
		bg = 0xff1c1c1e,
		border = 0xff3a3a3c,
	},

	bg1 = 0xff1c1c1e,
	bg2 = 0xff48484a,

	with_alpha = function(color, alpha)
		if alpha > 1.0 or alpha < 0.0 then
			return color
		end
		return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
	end,
}
