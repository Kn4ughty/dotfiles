-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
lvim.plugins = {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 };
  { "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        window = {
          width = 30,
          mappings = {
          ["p"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
          }
        },
        buffers = {
          follow_current_file = true,
        },
        filesystem = {
          follow_current_file = true,
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = {
              "node_modules"
            },
            never_show = {
              ".DS_Store",
              "thumbs.db"
            },
          },
        },
      })
    end
  };
  {"mfussenegger/nvim-dap-python"};
  {"christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  {"AckslD/swenv.nvim"};
  -- { -- Useful plugin to show you pending keybinds.
  --   "folke/which-key.nvim",
  --   event = "VimEnter", -- Sets the loading event to 'VimEnter'
  --   config = function() -- This is the function that runs, AFTER loading
  --     require("which-key").setup()

  --     -- Document existing key chains
  --     require("which-key").register {
  --       ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
  --       ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
  --       ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
  --       ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
  --       ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
  --       ["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
  --       ["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
  --     }
  --     -- visual mode
  --     require("which-key").register({
  --       ["<leader>h"] = { "Git [H]unk" },
  --     }, { mode = "v" })
  --   end,
  -- },
  {'NFrid/due.nvim',
    config = function()
      require('due_nvim').setup {}
    end
  },
}
-- lua require("which-key").show("'", {mode = "n", auto = true})
-- vim.cmd.colorscheme "catppuccin"
lvim.colorscheme = "catppuccin-mocha"
lvim.transparent_window = true

-- Folding
-- https://www.jackfranklin.co.uk/blog/code-folding-in-vim-neovim/
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- Text movement with arrow keys
vim.keymap.set("n", "<Left>", "<<")
vim.keymap.set("n", "<Right>", ">>")
vim.keymap.set("n", "<Up>", "<cmd>m -2<CR>")
vim.keymap.set("n", "<Down>", "<cmd>m +1<CR>")

vim.keymap.set("v", "<Left>", "<gv")
vim.keymap.set("v", "<Right>", ">gv")
-- Could not get text shifting with visual mode working :(
-- vim.keymap.set("v", "<Up>",   "<cmd>m '<-2<CR>gv=gv")
-- vim.keymap.set("v", "<Down>", "<cmd>m '>+1<CR>gv=gv")

-- Add newlines with o binds
vim.keymap.set("n", "<M-o>", "o<Esc>")
vim.keymap.set("n", "<M-S-o>", "O<Esc>")

-- neo-tree
lvim.builtin.nvimtree.active = false -- NOTE: using neo-tree
lvim.builtin.which_key.mappings["e"] = {
  ":Neotree toggle<CR>", "side file tree"
}
lvim.builtin.which_key.mappings["<s-e>"] = {
  ":Neotree position=float toggle<CR>", "full file tree"
}

--NOTES FOR FUTURE ME
-- https://github.com/nvim-neo-tree/neo-tree.nvim
-- https://github.com/3rd/image.nvim?tab=readme-ov-file#installing-imagemagick
-- https://github.com/leafo/magick

-- Python stuff
-- automatically install python syntax highlighting
lvim.builtin.treesitter.ensure_installed = {
  "python",
}

-- setup debug adapter
lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
pcall(function()
  require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

-- binding for switching
lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}

-- Per project run comamnd
lvim.builtin.which_key.mappings["rr"] = {
      ":!make run<CR>", "run project"
    }
lvim.builtin.which_key.mappings["rc"] = {
      ":!make build<CR>", "compile project"
    }

-- Pipe current class into manim run script

function Get_current_class_name()
    -- Get the current cursor position
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local line_number = cursor_pos[1] - 1 -- Convert to zero-based index

    -- Get the lines above the cursor
    local lines = vim.api.nvim_buf_get_lines(0, 0, line_number + 1, false)
    local class_name = ""

    -- Search for the class definition in the lines above the cursor
    for i = #lines, 1, -1 do
        local class_match = lines[i]:match("class%s+(%w+)")
        if class_match then
            class_name = class_match
            break
        end
    end

    return class_name
end

function Class_name_to_script(script_path)
    local class_name = Get_current_class_name()
    if class_name ~= "" then
        -- Replace 'your_script.sh' with your actual script path
        local command = string.format("bash %s %s > /dev/null",script_path, class_name)
        os.execute(command)
    else
        print("No class found.")
    end
end
-- Pipe_to_bash_script("a")


lvim.builtin.which_key.mappings["rp"] = {

  "<cmd>lua Class_name_to_script('run.sh')<CR>", "Run current scene"
}
lvim.builtin.which_key.mappings["rf"] = {

  "<cmd>lua Class_name_to_script('compile.sh')<CR>", "Compile current scene"
}
