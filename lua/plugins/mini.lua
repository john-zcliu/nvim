return {
    -- 1. Plugin dependency for the mini.nvim library (required to use mini.move)
    {
        'nvim-mini/mini.nvim',
        version = false, -- Use latest
        config = function()
            -- require('mini').setup({})
        end
    },

    -- 2. Separate configuration for the specific module: mini.move
    {
        'nvim-mini/mini.move',
        -- This module is part of mini.nvim, but is often loaded separately
        -- or configured to be loaded when needed (e.g., event = 'VeryLazy').
        -- The mappings and options go into its setup function.
        config = function()
            require('mini.move').setup({
                -- Module mappings. Use `''` (empty string) to disable one.
                mappings = {
                    -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
                    left = '<M-h>',
                    right = '<M-l>',
                    down = '<M-j>',
                    up = '<M-k>',

                    -- Move current line in Normal mode
                    line_left = '<M-h>',
                    line_right = '<M-l>',
                    line_down = '<M-j>',
                    line_up = '<M-k>',
                },

                -- Options which control moving behavior
                options = {
                    -- Automatically reindent selection during linewise vertical move
                    reindent_linewise = true,
                }
            }) -- end of mini-move configs
        end
    },
}
