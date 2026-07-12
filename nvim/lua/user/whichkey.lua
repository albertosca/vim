-- which-key.nvim — mesmos grupos do vim-which-key (configs.vim), mais o
-- prefixo <leader>f (Telescope/LSP), que só existe no Neovim.
require('which-key').setup({})

require('which-key').add({
  { '<leader>e', desc = 'edit configs.vim' },
  { '<leader>l', desc = 'next buffer' },
  { '<leader>h', desc = 'previous buffer' },
  { '<leader>u', desc = 'undotree toggle' },
  { '<leader>z', desc = 'goyo (zen mode)' },
  { '<leader>d', desc = 'gitsigns toggle signs' },
  { '<leader>dc', desc = 'DAP continue' },
  { '<leader>dt', desc = 'DAP toggle breakpoint' },
  { '<leader>do', desc = 'DAP step over' },
  { '<leader>di', desc = 'DAP step into' },
  { '<leader>dO', desc = 'DAP step out' },
  { '<leader>hs', desc = 'toggle hlsearch' },
  { '<leader>pv', desc = 'select python venv' },
  { '<leader>yn', desc = 'yank history: next' },
  { '<leader>yp', desc = 'yank history: prev' },
  { '<leader>q', desc = 'scratch buffer (~/buffer)' },
  { '<leader>x', desc = 'scratch markdown (~/buffer.md)' },
  { '<leader>cd', desc = 'cd to file dir' },
  { '<leader>pp', desc = 'toggle paste mode' },
  { '<leader>os', desc = 'Obsession (session record)' },
  { '<leader>rg', desc = 'Rg search' },
  { '<leader>gv', desc = 'GV log' },

  { '<leader>b', group = 'buffer/tab' },
  { '<leader>bd', desc = 'close buffer + tab' },
  { '<leader>ba', desc = 'close all buffers' },
  { '<leader>bl', desc = 'BLines (fzf)' },

  { '<leader>t', group = 'tab' },
  { '<leader>tn', desc = 'new tab' },
  { '<leader>to', desc = 'tab only' },
  { '<leader>tc', desc = 'close tab' },
  { '<leader>tm', desc = 'move tab' },
  { '<leader>te', desc = 'tabedit here' },

  { '<leader>s', group = 'spell' },
  { '<leader>ss', desc = 'toggle spell' },
  { '<leader>sn', desc = 'next misspelling' },
  { '<leader>sp', desc = 'prev misspelling' },
  { '<leader>sa', desc = 'add to dict' },

  { '<leader>n', group = 'nerdtree' },
  { '<leader>nn', desc = 'toggle' },
  { '<leader>nb', desc = 'from bookmark' },
  { '<leader>nf', desc = 'find current file' },

  { '<leader>g', group = 'git/fzf' },
  { '<leader>gf', desc = 'GFiles' },

  { '<leader>db', group = 'dadbod-ui' },
  { '<leader>dba', desc = 'add connection' },
  { '<leader>dbf', desc = 'find buffer' },
  { '<leader>dbr', desc = 'rename buffer' },

  { '<leader>v', group = 'vimux' },
  { '<leader>vp', desc = 'prompt command' },
  { '<leader>vl', desc = 'run last command' },
  { '<leader>vq', desc = 'close runner' },
  { '<leader>vx', desc = 'interrupt runner' },

  { '<leader>rn', desc = 'LSP rename' },
  { '<leader>ca', desc = 'LSP code action' },
  { '<leader>fo', desc = 'format buffer (conform)' },

  { '<leader>f', group = 'telescope/LSP' },
  { '<leader>fs', desc = 'document symbols' },
  { '<leader>fw', desc = 'workspace symbols' },
  { '<leader>fr', desc = 'references' },
  { '<leader>fd', desc = 'diagnostics' },
})
