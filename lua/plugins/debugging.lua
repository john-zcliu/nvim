return {
    -- nvim-dap core plugin
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            -- Recommended UI for nvim-dap
            "rcarriga/nvim-dap-ui",
            -- Dependency for dap-ui
            "nvim-neotest/nvim-nio",
            -- Optional: For virtual text showing variable values
            "theHamsta/nvim-dap-virtual-text",
            -- Optional: For easier installation of debug adapters
            "jay-babu/mason-nvim-dap.nvim",
        },
        config = function()
            -- Configure dap-ui
            local dapui = require("dapui")
            dapui.setup({})

            -- Configure nvim-dap-virtual-text
            require("nvim-dap-virtual-text").setup({})

            -- Setup mason-nvim-dap (if included)
            require("mason-nvim-dap").setup({
                -- Makes a best effort to setup the various debuggers with
                -- reasonable debug configurations.
                automatic_installation = true,
                ensure_installed = {
                    -- Add DAP servers for your languages here (e.g., "python", "go", "codelldb")
                },
            })

            -- Optional: Define listeners to automatically open/close DAP UI
            local dap = require("dap")

	    dap.adapters.python = function(cb, config)
		if config.request == 'attach' then
		    ---@diagnostic disable-next-line: undefined-field
		    local port = (config.connect or config).port
		    ---@diagnostic disable-next-line: undefined-field
		    local host = (config.connect or config).host or '127.0.0.1'
		    cb({
			type = 'server',
			port = assert(port, '`connect.port` is required for a python `attach` configuration'),
			host = host,
			options = {
			    source_filetype = 'python',
			},
		    })
		else
		    -- Find the correct Python path for your Conda environment.
		    local conda_python_path = os.getenv("CONDA_PREFIX") .. "/bin/python"

		    -- Fallback to system Python if CONDA_PREFIX isn't set (optional)
		    if vim.fn.isdirectory(os.getenv("CONDA_PREFIX")) == 0 then
			conda_python_path = "/usr/bin/python" -- Or whatever your default is
			-- You might want to print a warning here if CONDA_PREFIX is missing
		    end

		    cb({
			type = 'executable',
			-- Use the path to the Python in your Conda environment
			command = conda_python_path,
			args = { '-m', 'debugpy.adapter' },
			options = {
			    source_filetype = 'python',
			},
		    })
		end
	    end

	    dap.configurations.python = {
	      {
		type = 'python', -- Must match the key in dap.adapters.python
		request = 'launch',
		name = "Launch current file (Conda)",
		
		-- The program to debug. It uses the currently open file.
		program = '${file}',
		
		-- Optional: Specify your working directory
		cwd = vim.fn.getcwd(),
		
		-- Optional: Allows you to pass command line arguments if needed
		args = {},
		
		-- Optional: A useful setting to stop on the first line of the file
		stopOnEntry = false,
		
		-- Optional: Setting environment variables (e.g., if your app needs them)
		-- env = {},
	      },
	    }

	    -- Normal mode keymaps (nnoremap)
	    vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = 'Debug: Terminate' })
	    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debug: Continue/Start' })
	    vim.keymap.set('n', '<leader>dr', dap.repl.toggle, { desc = 'Debug: Toggle REPL' })
	    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
	    vim.keymap.set('n', '<leader>dB', function()
		dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
	    end, { desc = 'Debug: Conditional Breakpoint' })

	    -- Stepping/Navigation
	    vim.keymap.set('n', '<leader>do', dap.step_out, { desc = 'Debug: Step Out' })
	    vim.keymap.set('n', '<leader>dO', dap.step_over, { desc = 'Debug: Step Over' })
	    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Debug: Step Into' })

	    -- Dap UI Mappings (if you use nvim-dap-ui)
	    vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Debug: Toggle DAP UI' })
	    vim.keymap.set('n', '<leader>de', dapui.eval, { desc = 'Debug: Evaluate (Visual/Normal)' })
	    vim.keymap.set('v', '<leader>de', dapui.eval, { desc = 'Debug: Evaluate (Visual/Normal)' })

	    -- Optional: Run to cursor
	    vim.keymap.set('n', '<leader>dC', dap.run_to_cursor, { desc = 'Debug: Run to Cursor' })

	    -- Optional: Inspect variable under cursor
	    vim.keymap.set('n', 'K', function()
		require('dap.ui.widgets').hover()
	    end, { desc = 'Debug: Hover Variable Info' })

	    -- Optional: make REPL modifiable
	    vim.keymap.set('t', '<leader>m', function()
	      vim.cmd('setlocal modifiable')
	      vim.cmd('startinsert') -- Immediately put you in insert mode
	    end, { buffer = true, desc = 'Make terminal modifiable' })

	    dap.listeners.before.attach.dapui_config = function()
	      dapui.open()
	    end
	    dap.listeners.before.launch.dapui_config = function()
	      dapui.open()
	    end
	    dap.listeners.before.event_terminated.dapui_config = function()
	      dapui.close()
	    end
	    dap.listeners.before.event_exited.dapui_config = function()
	      dapui.close()
	    end
        end,
    },
}
