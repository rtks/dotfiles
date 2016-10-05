if &shell =~# 'fish$'
  set shell=bash
endif

call plug#begin('~/.vim/plugged')
Plug 'powerline/powerline', { 'rtp' : 'powerline/bindings/vim'}
Plug 'powerline/fontpatcher', { 'branch' : 'develop' }
Plug 'altercation/vim-colors-solarized'
Plug 'vim-scripts/restore_view.vim'
Plug 'dag/vim-fish'
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

syntax enable
filetype plugin indent on

set background=light
set laststatus=2

set encoding=utf-8
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8

" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif

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

hi DiffAdd    ctermfg=black ctermbg=2
hi DiffChange ctermfg=black ctermbg=3
hi DiffDelete ctermfg=black ctermbg=6
hi DiffText   ctermfg=black ctermbg=7

