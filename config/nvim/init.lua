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
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "clojure", "java", "rust", "typescript", "tsx",
        "javascript", "python", "lua", "vim", "vimdoc",
        "json", "yaml", "toml", "bash",
      })
    end,
  },

  -- LSP
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim" },
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
        { "<leader>e", group = "eval" },
        { "<leader>l", group = "log" },
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
    cmd = { "Neotree" },
    keys = {
      { "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "Toggle file tree" },
      { "<leader>fe", "<cmd>Neotree focus<cr>", desc = "Focus file tree" },
    },
    opts = {
      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
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

  -- Claude Code integration (connects to Claude running in tmux pane)
  {
    "coder/claudecode.nvim",
    opts = {
      terminal = {
        provider = "none",
      },
    },
    keys = {
      { "<leader>cc", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    },
  },

  -- Seamless tmux/nvim pane navigation
  {
    "christoomey/vim-tmux-navigator",
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Navigate left" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Navigate down" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Navigate up" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate right" },
    },
  },

  -- Clojure REPL
  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "scheme" },
  },

  -- Strict paren balancing (auto-close, balanced delete)
  {
    "sundbp/strict-paredit.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "clojure", "fennel", "scheme" },
    opts = {},
  },

  -- Paredit structural editing (slurp, barf, drag)
  {
    "julienvincent/nvim-paredit",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "clojure", "fennel", "scheme" },
    opts = {},
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
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup()
      local gs = require("gitsigns")
      vim.keymap.set("n", "<leader>gl", gs.toggle_linehl, { desc = "Toggle line highlight" })
      vim.keymap.set("n", "<leader>gw", gs.toggle_word_diff, { desc = "Toggle word diff" })
      vim.keymap.set("n", "<leader>gb", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
      vim.keymap.set("n", "<leader>gd", gs.toggle_deleted, { desc = "Toggle deleted lines" })
      vim.keymap.set("n", "]c", function() gs.nav_hunk("next") end, { desc = "Next hunk" })
      vim.keymap.set("n", "[c", function() gs.nav_hunk("prev") end, { desc = "Prev hunk" })

      -- Green for added, red for removed, yellow for changed
      vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#859900" })
      vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#b58900" })
      vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#dc322f" })
      vim.api.nvim_set_hl(0, "GitSignsAddLn", { bg = "#1a3a1a" })
      vim.api.nvim_set_hl(0, "GitSignsChangeLn", { bg = "#3a3010" })
      vim.api.nvim_set_hl(0, "GitSignsDeleteLn", { bg = "#3a1a1a" })
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
}, {
  git = {
    url_format = "git@github.com:%s.git",
  },
})

-- Enable treesitter highlight and indent
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- Auto-open neo-tree in workmux sessions (close the empty starter buffer)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.g.workmux then
      vim.cmd("Neotree action=focus")
      local bufs = vim.fn.getbufinfo({ buflisted = 1 })
      for _, buf in ipairs(bufs) do
        if buf.name == "" and buf.linecount <= 1 then
          vim.api.nvim_buf_delete(buf.bufnr, {})
        end
      end
    end
  end,
})

-- LSP servers (configured but not auto-started; use <leader>cl to start)
local lsp_servers = { "rust_analyzer", "ts_ls", "pyright", "jdtls", "clojure_lsp", "lua_ls" }

vim.keymap.set("n", "<leader>cl", function()
  vim.lsp.enable(lsp_servers)
  vim.notify("LSP servers enabled")
end, { desc = "Start LSP" })

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
    map("<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
  end,
})

-- Clojure filetype settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "clojure" },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.expandtab = true
    vim.bo.lisp = true
    vim.bo.lispwords =
      "defn,defmacro,defmethod,defprotocol,defrecord,deftype,deftest,testing,"
      .. "are,let,when,if,cond,condp,do,doseq,for,loop,fn,ns,binding,"
      .. "with-open,with-redefs,reify,extend-type,extend-protocol"
  end,
})
