return {
  'wojciech-kulik/xcodebuild.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'folke/snacks.nvim',

    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-tree.lua',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('xcodebuild').setup {}

    vim.keymap.set('n', '<leader>X', '<cmd>XcodebuildPicker<cr>', { desc = 'Xcodebuild: Show Xcodebuild Actions' })
    vim.keymap.set('n', '<leader>xf', '<cmd>XcodebuildProjectManager<cr>', { desc = 'Xcodebuild: Show Project Manager Actions' })

    vim.keymap.set('n', '<leader>xb', '<cmd>XcodebuildBuild<cr>', { desc = 'Xcodebuild: Build Project' })
    vim.keymap.set('n', '<leader>xB', '<cmd>XcodebuildBuildForTesting<cr>', { desc = 'Xcodebuild: Build For Testing' })
    vim.keymap.set('n', '<leader>xr', '<cmd>XcodebuildBuildRun<cr>', { desc = 'Xcodebuild: Build & Run Project' })

    vim.keymap.set('n', '<leader>xt', '<cmd>XcodebuildTest<cr>', { desc = 'Xcodebuild: Run Tests' })
    vim.keymap.set('v', '<leader>xt', '<cmd>XcodebuildTestSelected<cr>', { desc = 'Xcodebuild: Run Selected Tests' })
    vim.keymap.set('n', '<leader>xT', '<cmd>XcodebuildTestClass<cr>', { desc = 'Xcodebuild: Run Current Test Class' })
    vim.keymap.set('n', '<leader>x.', '<cmd>XcodebuildTestRepeat<cr>', { desc = 'Xcodebuild: Repeat Last Test Run' })

    vim.keymap.set('n', '<leader>xl', '<cmd>XcodebuildToggleLogs<cr>', { desc = 'Xcodebuild: Toggle Xcodebuild Logs' })
    vim.keymap.set('n', '<leader>xc', '<cmd>XcodebuildToggleCodeCoverage<cr>', { desc = 'Xcodebuild: Toggle Code Coverage' })
    vim.keymap.set('n', '<leader>xC', '<cmd>XcodebuildShowCodeCoverageReport<cr>', { desc = 'Xcodebuild: Show Code Coverage Report' })
    vim.keymap.set('n', '<leader>xe', '<cmd>XcodebuildTestExplorerToggle<cr>', { desc = 'Xcodebuild: Toggle Test Explorer' })
    vim.keymap.set('n', '<leader>xs', '<cmd>XcodebuildFailingSnapshots<cr>', { desc = 'Xcodebuild: Show Failing Snapshots' })

    vim.keymap.set('n', '<leader>xp', '<cmd>XcodebuildPreviewGenerateAndShow<cr>', { desc = 'Xcodebuild: Generate Preview' })
    vim.keymap.set('n', '<leader>x<cr>', '<cmd>XcodebuildPreviewToggle<cr>', { desc = 'Xcodebuild: Toggle Preview' })

    vim.keymap.set('n', '<leader>xd', '<cmd>XcodebuildSelectDevice<cr>', { desc = 'Xcodebuild: Select Device' })
    vim.keymap.set('n', '<leader>xq', '<cmd>Telescope quickfix<cr>', { desc = 'Xcodebuild: Show QuickFix List' })

    vim.keymap.set('n', '<leader>xx', '<cmd>XcodebuildQuickfixLine<cr>', { desc = 'Xcodebuild: Quickfix Line' })
    vim.keymap.set('n', '<leader>xa', '<cmd>XcodebuildCodeActions<cr>', { desc = 'Xcodebuild: Show Code Actions' })
  end,
}
