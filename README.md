# Next todos
1. Install Ruff and Black with Mason
1. Research Python/C++ interactive debugging support
1. Add markdown previewer
1. Add LS for Latex and pdf viewer
Watch this video: https://www.youtube.com/watch?v=4BnVeOUeZxc

# System-level dependencies
* xclip -- for accessing clipboard
* nodejs, npm -- for Mason (LSP manager)
* fzf, ripgrep, fd-find -- for fuzzy finding

## System-level python packages
* pyright, black, pynvim -- for LSP, linting and formatting

# Neovim Keybinds Documentation

This document provides a simple and organized overview of all the custom keybinds defined in my Neovim configuration.

## General Keybinds

| Mode | Key             | Action                                                                                      |
|------|-----------------|---------------------------------------------------------------------------------------------|
| `n`  | `<leader>cd`    | Open Ex mode (`:Ex`)                                                                        |
| `n`  | `J`             | Join lines while keeping the cursor in place                                                |
| `n`  | `<C-d>`         | Scroll half-page down and keep the cursor centered                                          |
| `n`  | `<C-u>`         | Scroll half-page up and keep the cursor centered                                            |
| `n`  | `n`             | Move to next search result and keep it centered                                             |
| `n`  | `N`             | Move to previous search result and keep it centered                                         |
| `n`  | `Q`             | Disable Ex mode                                                                             |
| `n`  | `<C-k>`         | Jump to next quickfix entry and keep it centered                                            |
| `n`  | `<C-j>`         | Jump to previous quickfix entry and keep it centered                                        |
| `n`  | `<leader>k`     | Jump to next location entry and keep it centered                                            |
| `n`  | `<leader>j`     | Jump to previous location entry and keep it centered                                        |
| `i`  | `<C-c>`         | Exit insert mode (acts like `Esc`)                                                          |
| `n`  | `<leader>x`     | Make current file executable (`chmod +x`)                                                   |
| `n`  | `<leader>u`     | Toggle Undotree                                                                             |
| `n`  | `<leader>rl`    | Reload the Neovim config (`~/.config/nvim/init.lua`)                                        |
| `n`  | `<leader><leader>` | Source the current file (`:so`)                                                          |

---

## Visual Mode Keybinds

| Mode | Key             | Action                                                                                      |
|------|-----------------|---------------------------------------------------------------------------------------------|
| `v`  | `J`             | Move selected block down                                                                    |
| `v`  | `K`             | Move selected block up                                                                      |
| `x`  | `<leader>p`     | Paste without overwriting clipboard                                                         |
| `v`  | `<leader>y`     | Yank into system clipboard (even on SSH)                                                    |

---

## Linting and Formatting

| Mode | Key             | Action                                                                                      |
|------|-----------------|---------------------------------------------------------------------------------------------|
| `n`  | `<leader>cc`    | Run `php-cs-fixer` to lint and format PHP files                                             |
| `n`  | `<F3>`          | Format code (`LSP`)                                                                         |

---

## Telescope Keybinds

| Mode | Key             | Action                                                                                      |
|------|-----------------|---------------------------------------------------------------------------------------------|
| `n`  | `<leader>ff`    | Find files                                                                                  |
| `n`  | `<leader>fg`    | Find git-tracked files                                                                      |
| `n`  | `<leader>fo`    | Open recent files                                                                           |
| `n`  | `<leader>fq`    | Open quickfix list                                                                          |
| `n`  | `<leader>fh`    | Open help tags                                                                              |
| `n`  | `<leader>fb`    | Open buffer list                                                                            |
| `n`  | `<leader>fs`    | Grep current string                                                                         |
| `n`  | `<leader>fc`    | Grep instances of the current file name without the extension                               |
| `n`  | `<leader>fi`    | Find files in Neovim configuration directory (`~/.config/nvim/`)                            |


Mappings	Action
<C-n>/<Down>	Next item
<C-p>/<Up>	Previous item
j/k	Next/previous (in normal mode)
H/M/L	Select High/Middle/Low (in normal mode)
gg/G	Select the first/last item (in normal mode)
<CR>	Confirm selection
<C-x>	Go to file selection as a split
<C-v>	Go to file selection as a vsplit
<C-t>	Go to a file in a new tab
<C-u>	Scroll up in preview window
<C-d>	Scroll down in preview window
<C-f>	Scroll left in preview window
<C-k>	Scroll right in preview window
<M-f>	Scroll left in results window
<M-k>	Scroll right in results window
<C-/>	Show mappings for picker actions (insert mode)
?	Show mappings for picker actions (normal mode)
<C-c>	Close telescope (insert mode)
<Esc>	Close telescope (in normal mode)
<Tab>	Toggle selection and move to next selection
<S-Tab>	Toggle selection and move to prev selection
<C-q>	Send all items not filtered to quickfixlist (qflist)
<M-q>	Send all selected items to qflist
<C-r><C-w>	Insert cword in original window into prompt (insert mode)
<C-r><C-a>	Insert cWORD in original window into prompt (insert mode)
<C-r><C-f>	Insert cfile in original window into prompt (insert mode)
<C-r><C-l>	Insert cline in original window into prompt (insert mode)
---

## Harpoon Integration

| Mode | Key             | Action                                                                                      |
|------|-----------------|---------------------------------------------------------------------------------------------|
| `n`  | `<leader>a`     | Add current file to Harpoon list                                                            |
| `n`  | `<leader>h`     | Toggle Harpoon quick menu                                                                   |
| `n`  | `<leader>fl`    | Open Harpoon window with Telescope                                                          |
| `n`  | `<C-p>`         | Go to previous Harpoon mark                                                                 |
| `n`  | `<C-n>`         | Go to next Harpoon mark                                                                     |

---

## LSP Keybinds

| Mode      | Key        | Action                                                                                      |
|-----------|------------|---------------------------------------------------------------------------------------------|
| `n`       | `K`        | Show hover information                                                                      |
| `n`       | `gd`       | Go to definition                                                                            |
| `n`       | `gD`       | Go to declaration                                                                           |
| `n`       | `gi`       | Go to implementation                                                                        |
| `n`       | `go`       | Go to type definition                                                                       |
| `n`       | `gr`       | Show references                                                                             |
| `n`       | `gs`       | Show signature help                                                                         |
| `n`       | `gl`       | Show diagnostics in a floating window                                                       |
| `n`       | `<F2>`     | Rename symbol                                                                               |
| `n`, `x`  | `<F3>`     | Format code asynchronously                                                                 |
| `n`       | `<F4>`     | Show code actions                                                                           |

<!-- TODO: convert this csv into md table: -->

Keymap (Normal Mode),Action,Function,Description
<leader>dc,Continue/Start,dap.continue(),Runs/Continues the debug session. Starts the session if one isn't active.
<leader>db,Toggle Breakpoint,dap.toggle_breakpoint(),Sets or removes a breakpoint on the current line.
<leader>di,Step Into,dap.step_into(),Executes the current line and jumps into a function call.
<leader>dO,Step Over,dap.step_over(),Executes the current line and steps over any function calls.
<leader>do,Step Out,dap.step_out(),Continues execution until the current function returns.
<leader>dt,Terminate,dap.terminate(),Stops the entire debug session.
<leader>du,Toggle UI,dapui.toggle({}),"Opens or closes the DAP UI windows (Scopes, Stacks, etc.)."
<leader>dr,Toggle REPL,dap.repl.toggle(),Opens the debugger REPL window for interactive evaluation.
<leader>de,Evaluate,dapui.eval(),Evaluates the word under the cursor (or visual selection) and shows the value.

---

## Miscellaneous

| Mode | Key             | Action                                                                                      |
|------|-----------------|---------------------------------------------------------------------------------------------|
| `n`  | `<leader>dg`    | Run `DogeGenerate` (comment documentation generation)                                       |
| `n`  | `<leader>s`     | Replace all instances of the word under the cursor on the current line                      |

---

# LSP servers:

I am migrating my lsp config to /lua/plugins/lsp.lua because nvim v0.11 allows a very minimal debloated way to setup language server protocols. 

Below is a running list of what and how to install the lsp's that are going to be configured in this build. I will avoid mason for now because I think its better to have full control over your system, and not outsource it to mason. Just uncommonet `return {` in /plugins/lsp.lua from the original lspconfig if you want to go that route.

1. { lua-language-server } 
  - refer to distro ( pacman -Ss lua-language-server )
2. { css-language-server --studio, html-language-server }
  - npm install -g vscode-langservers-extracted
3. { intelephense }
  - npm install -g intelephense
4. { typescript-language-server }
  - npm install -g typescript-language-server typescript




That's a fantastic goal. The most reliable and simple way to ensure your Neovim plugins (like `nvim-lspconfig` and `conform.nvim`) know the correct Conda paths is to use the **`nvim-conda`** plugin.

This plugin handles the complex shell activation logic for you, making your LSP and formatter executables available inside Neovim without manual path manipulation.

Here is the complete guide.

-----

## 🐍 Part 1: Conda Setup and Package Installation

First, you need a dedicated environment for your editor tools and the necessary Python packages.

### Step 1: Create and Activate the Environment

Open your terminal and create a new Conda environment. This is where your language server and formatter will live.

```bash
# 1. Create a new environment (e.g., nvim-lsp)
conda create -n nvim-lsp python=3.11 -y

# 2. Activate it (You'll only do this once for the install)
conda activate nvim-lsp
```

### Step 2: Install LSP and Formatter Tools

While the `nvim-lspconfig` plugin uses the name `pyright` for its configuration, you need to install the actual Python packages inside this environment. We also install `pynvim` for better general Python provider support in Neovim.

```bash
# Install the core tools
pip install pyright black pynvim
```

### Step 3: Deactivate the Environment

Go back to your base shell environment before opening Neovim.

```bash
conda deactivate
```

-----

## ⚙️ Part 2: Neovim Plugin Configuration (using LazyVim)

You'll add two key plugins: **`nvim-conda`** to manage the paths, and **`conform.nvim`** for formatting. `nvim-lspconfig` is usually already part of your LazyVim setup.

### 1\. Install `nvim-conda`

Add this to your `lazy.nvim` specification (e.g., in your `plugins/` directory or `init.lua`):

```lua
-- lua/plugins/conda.lua
return {
    "kmontocam/nvim-conda",
    dependencies = {
        "nvim-lua/plenary.nvim", -- A common utility dependency
    },
    -- Auto-activate the environment when you open a Python file
    config = function()
        require("nvim-conda").setup({
            auto_activate = true,
            -- Use the dedicated environment we created in Part 1
            default_env = "nvim-lsp", 
        })
    end,
}
```

### 2\. Configure Pyright LSP

With `nvim-conda` active, Neovim will automatically pick up `pyright` from the activated environment's PATH. You don't need a special path configuration for this to work.

If you were customizing your `pyright` setup, it would look like this (but should work fine without specific path changes):

```lua
-- This assumes you are configuring LSP servers separately
require('lspconfig').pyright.setup({
    -- Pyright will inherit the PATH from the activated nvim-lsp environment
    -- to find its executable and resolve packages.
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "basic", -- Recommended setting
            }
        }
    }
})
```

### 3\. Configure Black Formatter

Use `conform.nvim` to execute `black` from the Conda environment.

```lua
-- lua/plugins/conform.lua
return {
    "stevearc/conform.nvim",
    event = "BufWritePost",
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                python = { "black" }, -- It will find 'black' in the activated Conda PATH
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
        })
    end,
}
```

-----

## ✅ Workflow: Launching Neovim

After installing the plugins and packages, your workflow is now simple:

1.  **Open Neovim** (`nvim`).
2.  **Open a Python file** (`my_project.py`).
3.  The **`nvim-conda`** plugin detects the filetype and automatically runs the equivalent of `conda activate nvim-lsp` *within Neovim's session*.
4.  `nvim-lspconfig` then launches the `pyright` server, which uses the now-correct path to find the Pyright executable and resolve all your Python dependencies from the activated `nvim-lsp` environment.

This method eliminates the need for any manual path manipulation in your Lua config files.

If you'd like a visual guide on setting up Python tools in Neovim, [Setting up Python for Neovim: conda and flake8](https://www.youtube.com/watch?v=CKl336ffqC8) demonstrates configuring a similar setup with Conda.
http://googleusercontent.com/youtube_content/2
