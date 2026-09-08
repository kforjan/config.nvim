local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.smartindent = true
opt.wrap = false
opt.hlsearch = false
opt.incsearch = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true
opt.termguicolors = true

opt.scrolloff = 8
opt.signcolumn = 'yes'
opt.isfname:append '@-@'

opt.updatetime = 50

opt.colorcolumn = '80'

vim.g.have_nerd_font = true
opt.showmode = false

opt.swapfile = false
opt.backup = false
opt.undofile = true

opt.ignorecase = true
opt.smartcase = true

opt.splitright = true
opt.splitbelow = true

opt.title = true
opt.titlelen = 0
opt.titlestring = '%{expand("%:t")}'

opt.cursorline = true
opt.inccommand = 'split'

opt.confirm = true
opt.splitkeep = 'screen'
opt.timeoutlen = 400
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
