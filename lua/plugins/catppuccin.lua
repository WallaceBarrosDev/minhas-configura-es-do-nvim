return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,       -- carrega na inicialização
    priority = 1000,    -- carrega antes dos outros plugins
    config = function()
      require("catppuccin").setup({
        flavour = "frappe", -- pode ser "latte", "frappe", "macchiato" ou "mocha"
        transparent_background = true,
        term_colors = true,
        styles = {
          comments = { "italic" },
          functions = { "bold" },
        },
        custom_highlights = {
          -- C/C++ Treesitter highlights
          ["@keyword.c"] = { fg = "#cba6f7" },       -- keywords (if, else, while, for, return)
          ["@keyword.return.c"] = { fg = "#f38ba8" }, -- return em vermelho
          ["@keyword.type.c"] = { fg = "#fab387" },   -- struct, enum, union
          ["@keyword.modifier.c"] = { fg = "#cba6f7" }, -- const, static, volatile
          ["@type.c"] = { fg = "#f9e2af" },           -- int, char, float, double, void
          ["@type.builtin.c"] = { fg = "#f9e2af" },   -- tipos built-in
          ["@type.definition.c"] = { fg = "#f9e2af" }, -- typedef
          ["@variable.c"] = { fg = "#cdd6f4" },       -- variáveis locais
          ["@variable.parameter.c"] = { fg = "#89dceb" }, -- parâmetros de função
          ["@variable.member.c"] = { fg = "#89dceb" },    -- membros de struct
          ["@constant.c"] = { fg = "#fab387" },        -- constantes
          ["@constant.macro.c"] = { fg = "#f38ba8" },  -- macros (#define)
          ["@function.c"] = { fg = "#89b4fa" },        -- chamadas de função
          ["@function.declaration.c"] = { fg = "#89b4fa", bold = true }, -- declaração de função
          ["@function.macro.c"] = { fg = "#f38ba8" },  -- funções macro
          ["@comment.c"] = { fg = "#6c7086", italic = true }, -- comentários
          ["@string.c"] = { fg = "#a6e3a1" },          -- strings
          ["@number.c"] = { fg = "#fab387" },          -- números
          ["@operator.c"] = { fg = "#89dceb" },        -- operadores
          ["@punctuation.bracket.c"] = { fg = "#cdd6f4" }, -- chaves, colchetes
          ["@punctuation.delimiter.c"] = { fg = "#6c7086" }, -- vírgulas, ponto-e-vírgula
          ["@label.c"] = { fg = "#cba6f7" },           -- labels (case, goto)
          ["@attribute.c"] = { fg = "#f9e2af" },       -- __attribute__
          ["@keyword.directive.c"] = { fg = "#f38ba8" }, -- #include, #define
          ["@keyword.directive.define.c"] = { fg = "#f38ba8" }, -- #define

          -- C++ extras
          ["@keyword.cpp"] = { fg = "#cba6f7" },
          ["@keyword.type.cpp"] = { fg = "#fab387" },
          ["@type.cpp"] = { fg = "#f9e2af" },
          ["@type.builtin.cpp"] = { fg = "#f9e2af" },
          ["@namespace.cpp"] = { fg = "#cba6f7" },     -- namespaces
          ["@constructor.cpp"] = { fg = "#89b4fa" },   -- construtores

          -- Python
          ["@keyword.python"] = { fg = "#cba6f7" },       -- def, class, if, else, for, while
          ["@keyword.return.python"] = { fg = "#f38ba8" }, -- return
          ["@keyword.import.python"] = { fg = "#f9e2af" }, -- import, from
          ["@type.python"] = { fg = "#fab387" },           -- type hints
          ["@type.builtin.python"] = { fg = "#fab387" },   -- str, int, list, dict
          ["@variable.python"] = { fg = "#cdd6f4" },       -- variáveis
          ["@variable.parameter.python"] = { fg = "#89dceb" }, -- parâmetros
          ["@constant.python"] = { fg = "#fab387" },       -- True, False, None
          ["@constant.builtin.python"] = { fg = "#f38ba8" }, -- __name__, __main__
          ["@function.python"] = { fg = "#89b4fa" },       -- chamadas
          ["@function.declaration.python"] = { fg = "#89b4fa", bold = true }, -- def
          ["@function.builtin.python"] = { fg = "#f38ba8" }, -- print, len, etc
          ["@comment.python"] = { fg = "#6c7086", italic = true }, -- comentários
          ["@string.python"] = { fg = "#a6e3a1" },         -- strings
          ["@number.python"] = { fg = "#fab387" },         -- números
          ["@operator.python"] = { fg = "#89dceb" },       -- operadores
          ["@punctuation.bracket.python"] = { fg = "#cdd6f4" }, -- [ ] ( ) { }
          ["@punctuation.delimiter.python"] = { fg = "#6c7086" }, -- , : .
          ["@decorator.python"] = { fg = "#cba6f7" },      -- @decorator

          -- Kotlin (generic captures from Treesitter -- work for .kt and .kts)
          ["@keyword"] = { fg = "#cba6f7" },               -- fun, class, if, else, when, for, while
          ["@keyword.return"] = { fg = "#f38ba8" },         -- return
          ["@keyword.import"] = { fg = "#f9e2af" },         -- import
          ["@keyword.modifier"] = { fg = "#cba6f7" },       -- val, var, const, lateinit
          ["@keyword.type"] = { fg = "#fab387" },           -- type, class, interface
          ["@keyword.coroutine"] = { fg = "#cba6f7" },      -- suspend, async, await
          ["@keyword.operator"] = { fg = "#89dceb" },       -- is, as, in, .., ?. ?:
          ["@keyword.function"] = { fg = "#cba6f7" },       -- fun
          ["@type"] = { fg = "#fab387" },                   -- tipos
          ["@type.builtin"] = { fg = "#fab387" },           -- Int, String, List, Map
          ["@type.definition"] = { fg = "#f9e2af" },        -- class/interface definitions
          ["@type.parameter"] = { fg = "#fab387", italic = true }, -- generics <T>
          ["@variable"] = { fg = "#cdd6f4" },               -- variáveis
          ["@variable.parameter"] = { fg = "#89dceb" },     -- parâmetros
          ["@variable.member"] = { fg = "#89dceb" },        -- obj.property
          ["@constant"] = { fg = "#fab387" },               -- true, false, null
          ["@constant.builtin"] = { fg = "#f38ba8" },       -- this, it
          ["@function"] = { fg = "#89b4fa" },               -- chamadas
          ["@function.declaration"] = { fg = "#89b4fa", bold = true }, -- fun nome()
          ["@function.builtin"] = { fg = "#f38ba8", bold = true }, -- println, require, TODO
          ["@function.call"] = { fg = "#89b4fa" },          -- chamadas normais
          ["@function.macro"] = { fg = "#f38ba8" },         -- inline functions
          ["@function.method"] = { fg = "#89b4fa" },        -- obj.method()
          ["@function.method.declaration"] = { fg = "#89b4fa", bold = true }, -- fun Class.method()
          ["@property"] = { fg = "#89dceb" },               -- properties
          ["@property.declaration"] = { fg = "#89dceb", italic = true }, -- val/var declarations
          ["@comment"] = { fg = "#6c7086", italic = true }, -- comentários
          ["@string"] = { fg = "#a6e3a1" },                 -- strings
          ["@number"] = { fg = "#fab387" },                 -- números
          ["@operator"] = { fg = "#89dceb" },               -- operadores
          ["@punctuation.bracket"] = { fg = "#cdd6f4" },    -- [ ] ( ) { }
          ["@punctuation.delimiter"] = { fg = "#6c7086" },  -- , : .
          ["@annotation"] = { fg = "#cba6f7" },             -- @Annotation
          ["@attribute"] = { fg = "#cba6f7" },              -- attributes

          -- Keep Kotlin-specific overrides too (in case nvim-treesitter adds suffix)
          ["@keyword.kotlin"] = { fg = "#cba6f7" },
          ["@keyword.return.kotlin"] = { fg = "#f38ba8" },
          ["@keyword.import.kotlin"] = { fg = "#f9e2af" },
          ["@keyword.modifier.kotlin"] = { fg = "#cba6f7" },
          ["@type.kotlin"] = { fg = "#fab387" },
          ["@type.builtin.kotlin"] = { fg = "#fab387" },
          ["@variable.kotlin"] = { fg = "#cdd6f4" },
          ["@variable.parameter.kotlin"] = { fg = "#89dceb" },
          ["@constant.kotlin"] = { fg = "#fab387" },
          ["@constant.builtin.kotlin"] = { fg = "#f38ba8" },
          ["@function.kotlin"] = { fg = "#89b4fa" },
          ["@function.declaration.kotlin"] = { fg = "#89b4fa", bold = true },
          ["@function.builtin.kotlin"] = { fg = "#f38ba8", bold = true },
          ["@comment.kotlin"] = { fg = "#6c7086", italic = true },
          ["@string.kotlin"] = { fg = "#a6e3a1" },
          ["@number.kotlin"] = { fg = "#fab387" },
          ["@operator.kotlin"] = { fg = "#89dceb" },
          ["@punctuation.bracket.kotlin"] = { fg = "#cdd6f4" },
          ["@punctuation.delimiter.kotlin"] = { fg = "#6c7086" },
          ["@annotation.kotlin"] = { fg = "#cba6f7" },
          ["@property.kotlin"] = { fg = "#89dceb" },
          ["@function.method.kotlin"] = { fg = "#89b4fa" },
          ["@function.method.declaration.kotlin"] = { fg = "#89b4fa", bold = true },
          ["@function.call.kotlin"] = { fg = "#89b4fa" },
          ["@function.macro.kotlin"] = { fg = "#f38ba8" },
          ["@property.declaration.kotlin"] = { fg = "#89dceb", italic = true },
          ["@property.access.kotlin"] = { fg = "#89dceb" },
          ["@type.parameter.kotlin"] = { fg = "#fab387", italic = true },
          ["@keyword.operator.kotlin"] = { fg = "#89dceb" },
          ["@keyword.coroutine.kotlin"] = { fg = "#cba6f7" },
        },
        integrations = {
          treesitter = true,
          cmp = true,
          gitsigns = true,
          -- adicione mais integrações que você usa
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
