-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Basic options
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.scrolloff = 8
vim.opt.updatetime = 250

require("lazy").setup({
  -- Colorscheme
  {
    "maxmx03/solarized.nvim",
    priority = 1000,
    config = function()
      require("solarized").setup({
        variant = "autumn",
      })
      vim.o.background = "dark"
      vim.cmd.colorscheme("solarized")
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "clojure", "java", "rust", "typescript", "tsx",
        "javascript", "python", "lua", "vim", "vimdoc",
        "json", "yaml", "toml", "bash",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },

  -- LSP
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "rust_analyzer",
          "ts_ls",
          "pyright",
          "jdtls",
          "clojure_lsp",
          "lua_ls",
        },
      })
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      -- SPC f — files
      { "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find file" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
      { "<leader>fs", "<cmd>w<cr>", desc = "Save file" },
      -- SPC b — buffers
      { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Switch buffer" },
      { "<leader>bd", "<cmd>bdelete<cr>", desc = "Kill buffer" },
      -- SPC s — search
      { "<leader>sp", "<cmd>Telescope live_grep<cr>", desc = "Search project" },
      { "<leader>ss", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search buffer" },
      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Search project" },
      -- SPC h — help
      { "<leader>hh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<leader>hk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "%.git/" },
        },
      })
      require("telescope").load_extension("fzf")
    end,
  },

  -- Which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "file" },
        { "<leader>g", group = "git" },
        { "<leader>h", group = "help" },
        { "<leader>s", group = "search" },
        { "<leader>x", group = "diagnostics" },
      },
    },
  },

  -- Noice (modern cmdline, messages, popups)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
    },
  },

  -- Trouble (better diagnostics list)
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
    },
  },

  -- Fidget (LSP progress indicator)
  {
    "j-hui/fidget.nvim",
    opts = {},
  },

  -- File tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "Toggle file tree" },
      { "<leader>fe", "<cmd>Neotree focus<cr>", desc = "Focus file tree" },
    },
    opts = {
      filesystem = {
        follow_current_file = { enabled = true },
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      default_component_configs = {
        git_status = {
          symbols = {
            added = "A",
            modified = "M",
            deleted = "D",
            renamed = "R",
            untracked = "?",
            ignored = "!",
            unstaged = "U",
            staged = "S",
            conflict = "C",
          },
        },
      },
    },
  },

  -- Clojure REPL
  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "scheme" },
  },

  -- Paredit for s-expression editing
  {
    "julienvincent/nvim-paredit",
    ft = { "clojure", "fennel", "scheme" },
    config = function()
      require("nvim-paredit").setup()
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = { theme = "solarized" },
      })
    end,
  },

  -- Git signs in gutter
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- Git status interface
  {
    "NeogitOrg/neogit",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "<leader>gg", function() require("neogit").open() end, desc = "Git status" },
    },
  },
})

-- Auto-open neogit in workmux sessions
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.g.workmux then
      require("neogit").open()
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", { callback = function() focused = true end })
      vim.api.nvim_create_autocmd("FocusLost", { callback = function() focused = false end })
      local timer = vim.uv.new_timer()
      timer:start(5000, 5000, vim.schedule_wrap(function()
        if focused then return end
        pcall(function() require("neogit").refresh() end)
      end))
    end
  end,
})

-- LSP server configs (Neovim 0.11+ native API)
local servers = { "rust_analyzer", "ts_ls", "pyright", "jdtls", "clojure_lsp", "lua_ls" }
for _, server in ipairs(servers) do
  vim.lsp.config(server, {})
end
vim.lsp.enable(servers)

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = args.buf, desc = desc })
    end
    -- SPC c — code (DOOM style)
    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gr", vim.lsp.buf.references, "Go to references")
    map("K", vim.lsp.buf.hover, "Hover")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("<leader>cr", vim.lsp.buf.rename, "Rename")
    map("<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
    map("<leader>cD", "<cmd>Telescope diagnostics<cr>", "Project diagnostics")
  end,
})
