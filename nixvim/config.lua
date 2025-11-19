-- TODO: How do I make separate Lua modules for stuff like the codeoptions?


local utils = {}

utils.unload_lua_namespace = function(prefix)
    local prefix_with_dot = prefix .. "."
    for key, _ in pairs(package.loaded) do
        if key == prefix or key:sub(1, #prefix_with_dot) == prefix_with_dot then
            package.loaded[key] = nil
        end
    end
end

utils.buffer_empty = function()
    local buffer_lines =
        vim.api.nvim_buf_get_lines(0, 0, vim.fn.line("$"), true)
    if buffer_lines[1] == "" and #buffer_lines == 1 then
        return true
    else
        return false
    end
end

utils.smart_open_file = function(path)
    if utils.buffer_empty() then
        vim.cmd("edit " .. path)
    else
        vim.cmd("vsplit " .. path)
    end
end

utils.show_documentation = function()
    local filetype = vim.bo.filetype
    if vim.tbl_contains({ "vim", "help" }, filetype) then
        vim.cmd("help " .. vim.fn.expand("<cword>"))
    elseif vim.tbl_contains({ "man" }, filetype) then
        vim.cmd("Man " .. vim.fn.expand("<cword>"))
    elseif
        vim.fn.expand("%:t") == "Cargo.toml"
        and require("crates").popup_available()
    then
        require("crates").show_popup()
    else
        vim.lsp.buf.hover()
    end
end

-- Applies common settings for code files that might differ based on file type
-- or file location
do
    -- Control if tabs are the expected indent or not. If yes they are invisible
    -- and not expanded. If no, they are expanded and any tab characters are
    -- marked.
    local function use_tabs(usetabs)
        if usetabs then
            vim.opt_local.expandtab = false
            vim.opt_local.list = false
            vim.opt_local.listchars = "tab:  ,trail:·,nbsp:~"
        else
            vim.opt_local.expandtab = true
            vim.opt_local.list = true
            vim.opt_local.listchars = "tab:»»,trail:·,nbsp:~"
        end
    end

    -- Control tab width
    local function tab_width(width)
        vim.opt_local.shiftwidth = width
        vim.opt_local.softtabstop = width
        vim.opt_local.tabstop = width
    end

    -- Add subtle marker to certain column widths
    local function overlength(column)
        if column == nil then
            vim.opt_local.colorcolumn = ""
        else
            vim.opt_local.colorcolumn = tostring(column)
        end
    end

    local function apply_options(options)
        use_tabs(options.use_tabs)
        tab_width(options.tab_width)
        overlength(options.overlength_column)
        vim.opt_local.conceallevel = options.conceal_level
        vim.opt_local.fillchars = "fold:·"
        vim.opt_local.foldenable = options.fold_enable
        vim.opt_local.foldexpr = options.fold_expr
        vim.opt_local.foldlevel = options.fold_level
        vim.opt_local.foldmethod = options.fold_method
        vim.opt_local.foldnestmax = options.fold_nest_max
        vim.opt_local.foldtext = ""
        vim.opt_local.formatoptions = options.format_options
        vim.opt_local.smartindent = options.smart_indent
        vim.opt_local.textwidth = options.text_width
        vim.opt_local.wrap = options.wrap
    end

    local function setup()
        vim.cmd([[
            augroup codeoptions
            au!
            au FileType * lua CodeoptionsApply(vim.fn.expand('<amatch>'))
            augroup END
        ]])

        -- Overlength mappings
        -- TODO
        -- local vimp = require("vimp")
        -- vimp.nnoremap("<leader>l1", function()
        -- 	require("config.codeoptions").overlength(80)
        -- end)
        -- vimp.nnoremap("<leader>l2", function()
        -- 	require("config.codeoptions").overlength(120)
        -- end)
        -- vimp.nnoremap("<leader>l3", function()
        -- 	require("config.codeoptions").overlength(200)
        -- end)
        -- vimp.nnoremap("<leader>lo", function()
        -- 	require("config.codeoptions").overlength(nil)
        -- end)
    end

    local DEFAULTS = {
        conceal_level = 2,
        fold_enable = false,
        fold_expr = "nvim_treesitter#foldexpr()",
        fold_level = 99,
        fold_method = "expr",
        fold_nest_max = 10,
        format_options = "cjnqr",
        overlength_column = 80,
        smart_indent = true,
        tab_width = 4,
        text_width = 0,
        use_tabs = false,
        wrap = false,
    }

    local function c_custom()
        local linux_source = [[\v%(linux|u\-?boot|optee).{-}\/.*\.%([ch])]]
        local fe_source = [[\vprojects\/forwardedge\/.*\.%([ch]|cpp)]]
        local work_source = [[\vprojects\/.*\.%([ch]|cpp)]]
        local path = vim.fn.expand("%:p")
        local options

        if vim.regex(linux_source):match_str(path) then
            options = vim.tbl_deep_extend("force", DEFAULTS, {
                overlength_column = 80,
                tab_width = 8,
                use_tabs = true,
            })
        elseif vim.regex(fe_source):match_str(path) then
            options = vim.tbl_deep_extend("force", DEFAULTS, {
                overlength_column = 80,
                tab_width = 4,
                use_tabs = true,
            })
        elseif vim.regex(work_source):match_str(path) then
            options = vim.tbl_deep_extend("force", DEFAULTS, {
                overlength_column = 80,
                tab_width = 2,
                use_tabs = false,
            })
        else
            options = DEFAULTS
        end

        apply_options(options)
    end

    local OVERRIDES = {
        ["bitbake"] = { overlength_column = 160 },
        ["c"] = c_custom,
        ["cpp"] = c_custom,
        ["cmake"] = { tab_width = 2, overlength_column = nil },
        ["dts"] = { tab_width = 8, use_tabs = true },
        ["gradle"] = { tab_width = 2, overlength_column = 160 },
        ["groovy"] = { tab_width = 2, overlength_column = 160 },
        ["help"] = { conceal_level = 0, use_tabs = true },
        ["html"] = { tab_width = 2, overlength_column = nil },
        ["java"] = { overlength_column = 160 },
        ["javascript"] = { tab_width = 2 },
        ["javascriptreact"] = { tab_width = 2 },
        ["json"] = { tab_width = 2 },
        ["jsonc"] = { tab_width = 2 },
        ["markdown"] = {
            conceal_level = 0,
            format_options = "cjnqtr",
            text_width = 80,
        },
        ["nix"] = { tab_width = 2 },
        ["proto"] = { tab_width = 2 },
        ["ruby"] = { tab_width = 2 },
        ["rust"] = { overlength_column = 99 },
        ["terraform"] = { tab_width = 2 },
        ["typescript"] = { tab_width = 2 },
        ["typescriptreact"] = { tab_width = 2 },
        ["vim"] = { tab_width = 2 },
        ["vimwiki"] = {
            format_options = "cjnqtr",
            tab_width = 2,
            overlength_column = nil,
        },
        ["xml"] = { overlength_column = 200 },
        ["xsl"] = { overlength_column = 200 },
        ["yaml"] = { tab_width = 2 },
        ["yuck"] = { tab_width = 2 },
    }

    function CodeoptionsApply(filetype)
        if #vim.api.nvim_buf_get_name(0) == 0 then
            return
        end

        local options
        local override = OVERRIDES[filetype]
        if type(override) == "function" then
            -- `apply_options` is not called for functions so they can programmatically
            -- change values if needed
            override()
        elseif type(override) == "table" then
            options = vim.tbl_deep_extend("force", DEFAULTS, override)
            apply_options(options)
        else
            options = DEFAULTS
            apply_options(options)
        end
    end

    -- Export as a no-argument function for use by keybindings
    function CodeoptionsOverlength(width)
        return function()
            overlength(width)
        end
    end

    setup()
end

-- Configure vimwiki
-- TODO: Currently bindings are global, not just vimwiki buffers. But I need
-- filetype working correctly to make them buffer-local.
do
    -- TODO: I think a lot of this could be done in pure Nix
    if vim.env.DROPBOX then
        local wiki_base = {
            template_path = vim.env.DROPBOX .. "/vimwiki-html/assets/",
            template_default = "default",
            template_ext = ".tpl",
            auto_export = 0,
            nested_syntaxes = {
                bash = "bash",
                ebnf = "ebnf",
                groovy = "groovy",
                markdown = "markdown",
                python = "python",
                rust = "rust",
                sh = "sh",
                toml = "toml",
                verilog = "verilog",
                xml = "xml",
                zsh = "zsh",
            },
        }
        local wiki_personal = vim.tbl_deep_extend("force", wiki_base, {
            path = vim.env.DROPBOX .. "/vimwiki/",
            path_html = vim.env.DROPBOX .. "/vimwiki-html/",
        })

        local wiki_work = vim.tbl_deep_extend("force", wiki_base, {
            path = vim.env.DROPBOX .. "/work/vimwiki/",
            path_html = vim.env.DROPBOX .. "/work/vimwiki-html/",
        })
        vim.g.vimwiki_list = { wiki_personal, wiki_work }

        vim.g.vimwiki_global_ext = 0

        vim.cmd([[
            augroup vimwikiscratch
                autocmd!
                autocmd BufRead scratchpad.wiki setfiletype vimwiki
            augroup END
        ]])

        -- Vimwiki mappings
        vim.keymap.set("n", "<leader>wp", "<cmd>norm 1<leader>ww<cr>")
        vim.keymap.set("n", "<leader>wo", "<cmd>norm 2<leader>ww<cr>")
        vim.keymap.set("n", "<leader>sc", function()
            local path = vim.env.DROPBOX .. "/scratchpad.wiki"
            utils.smart_open_file(path)
        end)

        local function project_link(name)
            return "* [[/projects/" .. name .. "|" .. name .. "]]"
        end

        local function project_template(name)
            return {
                "= " .. name .. " =",
                "",
                "== Reference ==",
            }
        end

        -- Adds a new project
        vim.keymap.set("n", "<leader>wa", function()
            vim.ui.input(
                { prompt = "New project name: " },
                function(input)
                    if input then
                        local path = vim.call("vimwiki#vars#get_wikilocal", "path")
                        local ext = vim.call("vimwiki#vars#get_wikilocal", "ext")
                        local ft_is_vw = vim.call("vimwiki#u#ft_is_vw")
                        local wiki_file = path .. "projects/" .. input .. ext

                        -- When we return put the cursor on the link we create (one line
                        -- below the current line)
                        local pos = vim.fn.getpos(".")
                        pos[2] = pos[2] + 1
                        local prev_link = {
                            vim.call("vimwiki#path#current_wiki_file"),
                            pos,
                        }

                        -- Add link below current cursor position
                        vim.fn.append(vim.fn.line("."), project_link(input))

                        -- Write out the template and open it
                        if vim.fn.filereadable(wiki_file) == 0 then
                            vim.fn.writefile(project_template(input), wiki_file)
                        end
                        vim.call(
                            "vimwiki#base#edit_file",
                            "edit",
                            wiki_file,
                            "",
                            prev_link,
                            ft_is_vw
                        )
                    end
                end
            )
        end)
    end
end

-- Configure windows.nvim
do
    require("windows").setup()
end

-- Insert current date/time
do
    vim.cmd("iabbrev <expr> dts strftime('%Y-%m-%d')")
    vim.cmd("iabbrev <expr> dtt strftime('%H:%M:%S')")
end

-- Load Telescope plugins
do
    require("neoclip").setup()
    require("telescope").load_extension("neoclip")
    require("telescope").load_extension("emoji")
end

-- Hydra
do
    local Hydra = require("hydra")
    local cmd = require("hydra.keymap-util").cmd
    local hint = nil

    local function search_root()
        local ok, is_vimwiki = pcall(vim.fn["vimwiki#u#ft_is_vw"])
        if ok and is_vimwiki == 1 then
            return vim.fn["vimwiki#vars#get_wikilocal"]("path")
        else
            return vim.fn.getcwd()
        end
    end

    local function find_files()
        require("telescope.builtin").find_files {
            cwd = search_root(),
        }
    end

    local function live_grep()
        require("telescope.builtin").live_grep {
            cwd = search_root(),
        }
    end

    -- Telescope on C-f
    hint = [[
    _f_: files         _m_: marks          _o_: old files
    _p_: live grep     _/_: grep in file   _?_: search history
    _R_: registers     _q_: quickfix       _b_: buffers

    _h_: vim help      _O_: vim options    _c_: commands
    _k_: keymaps       _x_: clipboard      _C_: command history

    _s_: snippets      _t_: treesitter     _S_: spelling
    _M_: manpage       _d_: diagnostics

    _e_: emoji         _l_: luapad

    _r_: resume       _<Enter>_: Telescope      _<Esc>_
    ]]

    Hydra {
        name = "Telescope",
        hint = hint,
        config = {
            color = "teal",
            invoke_on_body = true,
            hint = {
                position = "middle",
                float_opts = {
                    border = "rounded",
                    focusable = false,
                    noautocmd = true,
                    style = "minimal",
                },
            },
        },
        mode = "n",
        body = "<C-f>",
        heads = {
            { "f", find_files },
            { "m", cmd("Telescope marks") },
            { "o", cmd("Telescope oldfiles") },
            { "p", live_grep },
            { "/", cmd("Telescope current_buffer_fuzzy_find") },
            { "?", cmd("Telescope search_history") },
            { "R", cmd("Telescope registers") },
            { "q", cmd("Telescope quickfix") },
            { "b", cmd("Telescope buffers") },
            { "h", cmd("Telescope help_tags") },
            { "O", cmd("Telescope vim_options") },
            { "c", cmd("Telescope commands") },
            { "k", cmd("Telescope keymaps") },
            { "x", cmd("Telescope neoclip") },
            { "C", cmd("Telescope command_history") },
            { "s", cmd("Telescope luasnip") },
            { "t", cmd("Telescope treesitter") },
            { "S", cmd("Telescope spell_suggest") },
            {
                "M",
                cmd(
                    "Telescope man_pages  sections={'1','2','3','4','5','6','7','8'}"
                ),
            },
            { "d",       cmd("Telescope diagnostics") },
            { "e",       cmd("Telescope emoji") },
            { "l",       cmd("Luapad") },
            { "<Enter>", cmd("Telescope"),            { exit = true } },
            { "r",       cmd("Telescope resume") },
            {
                "<Esc>",
                nil,
                { exit = true, nowait = true },
            },
        },
    }
end
