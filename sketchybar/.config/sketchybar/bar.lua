local colors = require("colors")

sbar.bar({
	height = 40,
	color = colors.system.transparent,
	border_color = colors.bar.border,
	shadow = true,
	sticky = true,
	padding_right = 10,
	padding_left = 10,
	blur_radius = 0,
	topmost = "window",
})
