local decoration = table.concat({
	"           _                          ",
	"           `*-.                       ",
	"            )  _`-.                   ",
	"           .  : `. .                  ",
	"           : _   '                    ",
	"           ; *` _.   `*-._            ",
	"           `-.-'          `-.         ",
	"             ;       `       `.       ",
	"             :.       .               ",
	"             .   .   :   .-'    .     ",
	"             '  `+.;  ;  '      :     ",
	"             :  '  |    ;       ;-.   ",
	"             ; '   : :`-:     _.`* ;  ",
	"    [bug] .*' /  .*' ; .*`- +'  `*'   ",
	"          `*-*   `*-*  `*-*'          ",
}, "\n")

local starter = require("mini.starter")

starter.setup({
	header = decoration,
})

require("mini.sessions").setup({
	autoread = true,
	autowrite = true,
})
