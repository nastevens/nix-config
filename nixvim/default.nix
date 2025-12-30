{ lib, pkgs, ... }:
{
  colorschemes.onedark.enable = true;
  opts = {
    completeopt = [
      "menuone"
      "noinsert"
      "noselect"
    ];
    equalalways = false;
    fileformat = "unix";
    ignorecase = true;
    mouse = "";
    number = true;
    relativenumber = true;
    scrolloff = 4;
    shiftround = true;
    shortmess = "cfilnxtToOF";
    showmatch = true;
    sidescrolloff = 4;
    signcolumn = "yes";
    smartcase = true;
    smarttab = true;
    spelllang = "en_us";
    splitbelow = true;
    splitright = true;
    termguicolors = true;
    undofile = true;
    virtualedit = [ "block" ];
    wildmode = [
      "longest"
      "full"
    ];
    winwidth = 10;
    winminwidth = 10;
    wrap = false;
  };

  # Set unused plugins as pre-loaded to save time
  globals = {
    loaded_shada_plugin = 1;
    loaded_gzip = 1;
    loaded_tarPlugin = 1;
    loaded_zipPlugin = 1;
    loaded_tutor_mode_plugin = 1;
    loaded_2html_plugin = 1;
    loaded_netrwPlugin = 1;
  };

  localOpts = {
    # Customize contents of line number column
    statuscolumn = ''%s%=%{v:relnum?printf("%3d",v:relnum):""}%#StatusColumnCurrentLine#%{v:relnum?"":printf("%3d",v:lnum)}%* │ '';
  };

  autoCmd = [
    {
      desc = "Briefly highlight yanked text.";
      event = [ "TextYankPost" ];
      pattern = [ "*" ];
      command = "lua vim.highlight.on_yank { on_visual = false }";
    }

    {
      desc = "Return to the last position in a file when reopened.";
      event = [ "BufReadPost" ];
      pattern = [ "*" ];
      command = ''if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif'';
    }

    {
      desc = "Make vim-commentary work in Nix files.";
      event = [ "FileType" ];
      pattern = [ "nix" ];
      command = "setlocal commentstring=#\\ %s";
    }

    {
      desc = "Template for new vimwiki diary files.";
      event = [ "BufNewFile" ];
      pattern = [ "*/vimwiki/diary/*.wiki" ];
      command = ''silent 0r ${./diary.tmpl.wiki} | exe "1,1s/dts/" .. expand('%:t:r') .. "/"'';
    }
  ];

  filetype.extension = {
    "rasi" = "rasi";
  };
  filetype.pattern.".*%.conf" = [
    "hyprlang"
    { priority = 1000000; }
  ];

  plugins = {
    treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
    };
    treesitter-context.enable = true;
    notify.enable = true;
    vim-surround.enable = true;

    lsp.enable = true;
    lsp.servers = {
      bashls.enable = true;
      clangd.enable = true;
      cmake.enable = true;
      dockerls.enable = true;
      hls = {
        enable = true;
        installGhc = true;
      };
      jsonls.enable = true;
      lua_ls.enable = true;
      marksman.enable = true;
      nil_ls = {
        # Nix LSP
        enable = true;
        settings.nix.flake.autoArchive = true;
      };
      # pylsp.enable = true;
      pyright.enable = true;
      ruff.enable = true;
      superhtml.enable = true;
      taplo.enable = true;
      terraformls.enable = true;
      ts_ls.enable = true;
      typos_lsp.enable = true;
      yamlls.enable = true;
    };

    lsp-lines.enable = true;
    lspkind.enable = true;

    none-ls = {
      enable = true;
      sources.formatting = {
        stylua.enable = true;
        nixpkgs_fmt.enable = true;
      };
    };

    # Sneak-like functionality.
    leap.enable = true;

    # Highlight todo's with different colors and gutter icons.
    todo-comments = {
      enable = true;
      settings.highlight.keyword = "bg";
    };

    nvim-tree = {
      enable = true;
      settings = {
        diagnostics.enable = true;
        filters.dotfiles = true;
        hijack_cursor = true;
        modified.enable = true;
        renderer = {
          add_trailing = true;
          group_empty = true;
          highlight_git = true;
        };
        update_focused_file = {
          enable = true;
          ignore_list = [
            ".git"
            "node_modules"
            ".cache"
          ];
        };
        view.side = "right";
      };
    };

    telescope = {
      enable = true;
      settings.defaults = {
        prompt_prefix = "🔍 ";
        mappings.__raw = ''
          (function()
              local actions = require("telescope.actions")
              -- local trouble = require("trouble.sources.telescope")
              local bindings = {
                  ["<c-j>"] = actions.move_selection_next,
                  ["<c-k>"] = actions.move_selection_previous,
                  ["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                  ["<c-v>"] = actions.file_vsplit,
                  ["<c-s>"] = actions.file_split,
                  -- ["<c-t>"] = trouble.open,
              }
              return {
                  i = bindings,
                  n = bindings,
              }
          end)()
        '';
        dynamic_preview_title = true;
      };
      extensions = {
        ui-select = {
          enable = true;
          settings.__raw = ''
            require("telescope.themes").get_dropdown()
          '';
        };
      };
    };

    # TODO: so many more cmp extensions that would be useful!
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings.mapping = {
        "<C-n>" = ''
          cmp.mapping(function(fallback)
              if cmp.visible() then
                  cmp.select_next_item()
              else
                  fallback()
              end
          end, { "i", "s" })
        '';
        "<C-p>" = ''
          cmp.mapping(function(fallback)
              if cmp.visible() then
                  cmp.select_prev_item()
              else
                  fallback()
              end
          end, { "i", "s" })
        '';
        "<C-j>" = ''
          cmp.mapping(function(fallback)
              local luasnip = require("luasnip")
              if luasnip.jumpable(1) then
                  luasnip.jump(1)
              end
          end, { "i", "s" })
        '';
        "<C-k>" = ''
          cmp.mapping(function(fallback)
              local luasnip = require("luasnip")
              if luasnip.jumpable(-1) then
                  luasnip.jump(-1)
              end
          end, { "i", "s" })
        '';
        "<C-e>" = "cmp.mapping.abort()";
        "<Tab>" = ''
          cmp.mapping.confirm {
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
          }
        '';
      };
      settings.snippet.expand = ''
        function(args)
            require('luasnip').lsp_expand(args.body)
        end
      '';
      # TODO: why are LSP completions disappearing early?
      settings.sources = [
        {
          name = "nvim_lsp";
          group_index = 1;
        }
        {
          name = "buffer";
          group_index = 2;
        }
        { name = "crates"; }
        { name = "luasnip"; }
        { name = "nvim_lua"; }
        { name = "path"; }
      ];
      filetype.vimwiki.sources = [ { name = "luasnip"; } ];
      settings.experimental.ghost_text = true;
    };

    nvim-autopairs.enable = true;

    # Snippets
    luasnip = {
      enable = true;
      fromSnipmate = [
        { paths = ./snippets; }
      ];
      # settings.ext_opts = {
      #   active.hl_group = "Todo";
      #   passive.hl_group = "SpecialChar";
      # };
    };
    friendly-snippets.enable = true;

    # Git
    fugitive.enable = true;
    gitsigns.enable = true;

    # Statusline
    lualine = {
      enable = true;
      settings = {
        globalstatus = true;
        sections = {
          lualine_y = [
            "progress"
            "location"
          ];
          lualine_z = [ "lsp_status" ];
        };
        theme = "onedark";
      };
    };

    # Quickfix/diagnostics browser
    # trouble.enable = true;

    # Prevents cursor from trailing behind when typing 'k' as part of escape
    better-escape = {
      enable = true;
      settings = {
        default_mappings = false;
        mappings = {
          i.k.j = "<Esc>";
          t.k.j = "<C-\\><C-n>";
        };
      };
    };

    # Rust
    crates.enable = true;

    rustaceanvim.enable = true;

    # Completions, syntax, cheatsheet, and more
    # openscad.enable = true;

    # Extra icons for telescope and nvim-tree
    web-devicons.enable = true;
  };

  extraPlugins = with pkgs.vimPlugins; [
    # Pairs of keybindings to jump files, buffers, etc.
    vim-unimpaired

    # Help plugins support repeating operations.
    vim-repeat

    # Comments and uncomments lines.
    vim-commentary

    # Colorize hex codes.
    colorizer

    # Delete buffers without losing windows (Bdelete/Bwipeout).
    bufdelete-nvim

    # UI for chained keybindings.
    hydra-nvim

    # Clipboard manager.
    nvim-neoclip-lua

    # Search for emoji with Telescope
    (pkgs.vimUtils.buildVimPlugin rec {
      name = "neovim-telescope-emoji";
      version = "86248d97be84a1ce83f0541500ef9edc99ea2aa1";
      src = pkgs.fetchFromGitHub {
        owner = "xiyaowong";
        repo = "telescope-emoji.nvim";
        rev = "${version}";
        hash = "sha256-8V3MTporANLtZkH0RuLviWlgMmR6fay0WmZ3ZOQzpKI=";
      };
    })

    # Some sums
    (pkgs.vimUtils.buildVimPlugin rec {
      name = "neovim-vissum";
      version = "abfe7936b7ba30e355b0646b2c57e35e7edb1b99";
      src = pkgs.fetchFromGitHub {
        owner = "vim-scripts";
        repo = "visSum.vim";
        rev = "${version}";
        hash = "sha256-WA+qW4Ku2Nk5CjOXq48jL4HIblvzhHvzHZtntv0X3ps=";
      };
    })

    # Interactive real time neovim Lua scratchpad
    nvim-luapad

    # Automatically expand width of current window.
    windows-nvim

    # Manages my life
    vimwiki

    # Additional text targets
    targets-vim

    # Bicep format
    (pkgs.vimUtils.buildVimPlugin rec {
      name = "vim-bicep";
      version = "8172cf773d52302d6c9d663487f56630302b2fda";
      src = pkgs.fetchFromGitHub {
        owner = "carlsmedstad";
        repo = "vim-bicep";
        rev = "${version}";
        hash = "sha256-ls3+V51l6xq16ZIf5N9THsQ/rIgK+OXovND8//avs/0=";
      };
    })
  ];

  extraConfigLua = builtins.readFile ./config.lua;

  keymaps =
    let
      normalBind = key: action: {
        inherit key action;
        mode = "n";
      };
      normalBindLua = key: action: normalBind key (lib.nixvim.mkRaw action);
      leaderBind = key: action: normalBind "<leader>${key}" action;
      #leaderBindLua = key: action: normalBindLua "<leader>${key}" action;
      lspBind = key: action: normalBind "<space>${key}" action;
      lspBindLua = key: action: normalBindLua "<space>${key}" action;
      nopasteBind =
        key: action:
        normalBind key "<cmd>set paste<cr>m`${action}<esc>``<cmd>set nopaste<cr>"
        // {
          options.silent = true;
        };
    in
    [
      (nopasteBind "<c-j>" "o")
      (nopasteBind "<c-k>" "O")
      (nopasteBind "<space><space>" "i ")

      (leaderBind "n" "<cmd>NvimTreeToggle<cr>")
      (leaderBind "sp" "<cmd>setlocal invspell<cr>")

      (lspBindLua "a" "vim.lsp.buf.code_action")
      (lspBindLua "d" "vim.lsp.buf.definition")
      (lspBindLua "f" "vim.lsp.buf.format")
      (lspBindLua "m" "vim.lsp.buf.rename")
      (lspBindLua "r" "vim.lsp.buf.references")
      (lspBindLua "j" "vim.diagnostic.goto_prev")
      (lspBindLua "k" "vim.diagnostic.goto_next")

      (normalBindLua "K" ''
        function()
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
      '')

      # TODO: Bindings to edit my Nix configurations, see mappings.lua /ev

      # TODO: Overlength option used by my code options, currently erroring because not able to find CodeoptionsOverlength
      #(leaderBindLua "l1" "CodeoptionsOverlength(80)")
      #(leaderBindLua "l2" "CodeoptionsOverlength(120)")
      #(leaderBindLua "l3" "CodeoptionsOverlength(200)")
      #(leaderBindLua "lo" "CodeoptionsOverlength(nil)")

      (lspBind "c" "<cmd>RustLsp openCargo<cr>")
      (lspBind "x" "<cmd>RustLsp runnables<cr>")
      (normalBind "<C-M-j>" "<cmd>RustLsp moveItem down<cr>")
      (normalBind "<C-M-k>" "<cmd>RustLsp moveItem up<cr>")
    ];
}
