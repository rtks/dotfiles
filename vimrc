call plug#begin('~/.vim/plugged')
Plug 'powerline/powerline', { 'rtp' : 'powerline/bindings/vim'}
Plug 'powerline/fontpatcher', { 'branch' : 'develop' }
Plug 'altercation/vim-colors-solarized'
"Plug 'Shougo/neosnippet.vim'
"Plug 'Shougo/neosnippet-snippets'
"Plug 'tpope/vim-fugitive'
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'flazz/vim-colorschemes'
" Then reload .vimrc and :PlugInstall to install plugins.
call plug#end()

" vim-plugでpluginがインストールされている確認する関数
let s:plug = { "plugs": get(g:, 'plugs', {}) }
function! s:plug.is_installed(name)
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction


syntax on
set background =light
set laststatus=2

if s:plug.is_installed("vim-colors-solarized")
  if exists('$SSH_CONNECTION')
  else
    colorscheme solarized
  endif
endif

if s:plug.is_installed("powerline")
  let g:Powerline_symbols ='fancy'
  set noshowmode
endif
