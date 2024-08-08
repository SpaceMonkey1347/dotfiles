
local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()
local cmp_select = { behavior = cmp.SelectBehavior.Select }

-- TODO: write some snippets
require("luasnip.loaders.from_vscode").lazy_load()
-- require("luasnip.loaders.from_vscode").load({ paths = vim.fn.stdpath "config" .. "\\snippets\\" })

-- NOTE: alt to: require("cmp").setup({})
local options = {
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = {
    { name = "luasnip", option = { show_autosnippets = true } },
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "buffer" },
    { name = "path" },
  },
  snippet = {
    expand = function(args)
      require "luasnip".lsp_expand(args.body)
    end
  },
  formatting = lsp_zero.cmp_format(),

  -- NOTE: edit
  preselect = "item",
  completion = {
    completeopt = "menu,menuone,noinsert"
  },

  mapping = cmp.mapping.preset.insert({
    -- Navigate between snippets
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),

    -- Scroll up and down in the completion documentation
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),

    -- Ctrl+Space to trigger completion menu
    ["<C-Space>"] = cmp.mapping.complete(),
    -- abort completion
    ['<C-e>'] = cmp.mapping.abort(),
    -- `Enter` key to confirm completion
    ["<CR>"] = cmp.mapping.confirm({ select = true }),

    -- Navigate between snippet placeholder (insert mode)
    ["<C-b>"] = cmp_action.luasnip_jump_backward(),
    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
  }),
}

  -- mapping = {
  --   ["<C-p>"] = cmp.mapping.select_prev_item(),
  --   ["<C-n>"] = cmp.mapping.select_next_item(),
  --   ["<C-d>"] = cmp.mapping.scroll_docs(-4),
  --   ["<C-f>"] = cmp.mapping.scroll_docs(4),
  --   ["<C-Space>"] = cmp.mapping.complete(),
  --   ["<C-e>"] = cmp.mapping.close(),
  --   ["<CR>"] = cmp.mapping.confirm {
  --     behavior = cmp.ConfirmBehavior.Insert,
  --     select = true,
  --   },
  --   ["<Tab>"] = cmp.mapping(function(fallback)
  --     if cmp.visible() then
  --       cmp.select_next_item()
  --     elseif require("luasnip").expand_or_jumpable() then
  --       vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
  --     else
  --       fallback()
  --     end
  --   end, {
  --     "i",
  --     "s",
  --   }),
  --   ["<S-Tab>"] = cmp.mapping(function(fallback)
  --     if cmp.visible() then
  --       cmp.select_prev_item()
  --     elseif require("luasnip").jumpable(-1) then
  --       vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
  --     else
  --       fallback()
  --     end
  --   end, {
  --     "i",
  --     "s",
  --   }),
  -- },

return options

