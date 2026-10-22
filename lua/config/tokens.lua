-- Destaques customizados de estruturas especiais por filetype.
-- Ex.: {{ }} do Jinja/Handlebars dentro de HTML recebe cor própria,
-- mesmo sem um parser treesitter para o motor de templates.
--
-- Para adicionar outra estrutura: insere { padrao_vimregex, "GrupoHL" }
-- na lista do filetype e define a cor em M.groups.

-- filetype -> lista de { padrao, grupo } (padrao em regex do vim, modo \v)
-- estruturas de template usadas no C (html gerado em strings) e em .html
local template_rules = {
  { [[\v\{\{.{-}\}\}]], "TemplateExpr" }, -- {{ ... }}
  { [[\v\{[%%].{-}[%%]\}]], "TemplateStmt" }, -- {% ... %} ([%%] = escape de % na regex)
}
local M = {}

-- filetype -> lista de { padrao, grupo } (padrao em regex do vim, modo \v)
M.rules = {}
for _, ft in ipairs({ "html", "c", "cpp", "h", "hpp" }) do
  M.rules[ft] = template_rules
end


-- estilo dos grupos (reaplicado ao trocar de colorscheme)
M.groups = {
  TemplateExpr = { fg = "#e561ff", bold = true }, -- magenta
  TemplateStmt = { fg = "#f2c866", bold = true }, -- dourado suave
}

local function define_groups()
  for name, attrs in pairs(M.groups) do
    vim.api.nvim_set_hl(0, name, attrs)
  end
end

local function apply(buf)
  local winids = vim.fn.win_findbuf(buf)
  local rules = M.rules[vim.bo[buf].filetype]
  if vim.tbl_isempty(winids) then return end
  for _, winid in ipairs(winids) do
    pcall(vim.fn.clearmatches, winid)
  end
  if not rules then return end
  for _, winid in ipairs(winids) do
    for _, rule in ipairs(rules) do
      pcall(vim.fn.matchadd, rule[2], rule[1], 20, -1, { window = winid })
    end
  end
end

local aug = vim.api.nvim_create_augroup("custom_token_highlights", { clear = true })
define_groups()
vim.api.nvim_create_autocmd("ColorScheme", { group = aug, callback = define_groups })
vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
  group = aug,
  callback = function(args) apply(args.buf) end,
})
