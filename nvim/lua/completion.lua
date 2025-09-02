return {
  {
    'saghen/blink.cmp',
    version = '1.*',

    opts = {
      cmdline = { enabled = true },
      signature = { enabled = true },
      sources = { default = { 'lsp', 'buffer', 'path', 'snippets' } },
      completion = { menu = { border = 'none' } },

      keymap = {
        preset = 'none',

        ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<Tab>'] = { 'select_and_accept', 'fallback' },

        ['<C-c>'] = { 'cancel' },

        ['<C-p>'] = { 'select_prev' },
        ['<C-n>'] = { 'select_next' },

        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },

        ['<C-j>'] = { 'snippet_forward' },
        ['<C-k>'] = { 'snippet_backward' },

        ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
      },
    },
  }, -- blink.cmp
} -- return
