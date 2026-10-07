-- lua/plugins/kotlin.lua
return {
  {
    "AlexandrosAlexiou/kotlin.nvim",
    ft = { "kotlin" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "stevearc/oil.nvim",
      "folke/trouble.nvim",
    },
    config = function()
      require("kotlin").setup({
        -- Root markers para projetos multi-módulo
        root_markers = {
          "gradlew",
          ".git",
          "mvnw",
          "settings.gradle",
          "settings.gradle.kts",
          "build.gradle",
          "build.gradle.kts",
          "pom.xml",
        },

        -- JRE para rodar o kotlin-lsp server
        -- nil = usa JRE embutido no Mason (recomendado v262+)
        jre_path = nil,

        -- JDK para resolução de símbolos (analisa seu código Kotlin)
        -- Deve corresponder ao JDK alvo do seu projeto
        jdk_for_symbol_resolution = vim.fn.expand("~/.sdkman/candidates/java/21.0.2-tem"),

        -- JVM args para o servidor kotlin-lsp
        jvm_args = {
          "-Xmx4g",
        },

        -- Inlay hints (requer kotlin-lsp v261+)
        inlay_hints = {
          enabled = true,
          parameters = true,
          parameters_compiled = true,
          parameters_excluded = false,
          types_property = true,
          types_variable = true,
          function_return = true,
          function_parameter = true,
          lambda_return = true,
          lambda_receivers_parameters = true,
          value_ranges = true,
          kotlin_time = true,
        },

        -- LSP-driven folding (requer kotlin-lsp v262.4739.0+)
        folding = { enabled = true },

        -- Build tool preference (nil = auto-detect)
        -- build_tool = "gradle",

        -- File templates (v262.4739.0+)
        -- file_templates = { enabled = true },
      })
    end,
  },
}