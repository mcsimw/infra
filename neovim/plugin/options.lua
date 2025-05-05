local opt = vim.opt

opt.inccommand = "split"

opt.scs = true
opt.ignorecase = true

opt.nu = true
opt.rnu = true

opt.signcolumn = "yes"
opt.shada = { "'10", "<0", "s10", "h" }

opt.swf = false

opt.formatoptions:remove("o")

opt.wrap = true
opt.linebreak = true

opt.ts = 4
opt.shiftwidth = 4

opt.more = false

opt.foldmethod = "manual"

opt.title = true
opt.titlestring = '%t%( %M%)%( (%{expand("%:~:h")})%)%a (nvim)'

opt.undofile = true
