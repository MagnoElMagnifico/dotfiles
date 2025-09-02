return {
  -- FORMATTERS
  --    :ConformInfo    Information about formatters
  {
    'stevearc/conform.nvim',
    cmd = 'ConformInfo',
    keys = {
      {
        '<leader>F',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = { 'n', 'v' },
        desc = 'Format buffer'
      }
    },

    opts = {
      notify_on_error = false,

      formatters = {
        -- https://clang.llvm.org/docs/ClangFormatStyleOptions.html
        -- BasedOnStyle: LLVM
        -- PointerAlignment: Left
        -- ReferenceAlignment: Left
        -- AlignAfterOpenBracket: BlockIndent
        -- BinPackArguments: false
        -- BinPackParameters: false
        -- AllowShortIfStatementsOnASingleLine: Never
        -- IndentCaseBlocks: false
        -- IndentCaseLabels: true
        -- IndentPPDirectives: AfterHash
        -- PPIndentWidth: 2
        -- AlignConsecutiveMacros: AcrossEmptyLinesAndComments
        clang_format = {
          -- prepend_args = {'-style=file', '-fallback-style=LLVM'}
        },

        odinfmt = {
          command = "odinfmt",
          args = { "-stdin" },
          stdin = true,
        },
      },

      formatters_by_ft = {
        python = { 'black' },
        c = { 'clang-format' },
        cpp = { 'clang-format' },
        rust = { 'rustfmt' },
        -- odin = { 'odinfmt' },
      },
    } -- opts
  } -- conform
} -- return
