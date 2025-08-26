if &shell =~# 'fish$'
  set shell=bash
endif

if has('nvim')
  let s:plug_path = expand('~/.local/share/nvim/site/autoload/plug.vim')
else
  let s:plug_path = expand('~/.vim/autoload/plug.vim')
endif

if filereadable(s:plug_path)
call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/restore_view.vim'
Plug 'dag/vim-fish'
"Plug 'Shougo/neosnippet.vim'
"Plug 'Shougo/neosnippet-snippets'
"Plug 'tpope/vim-fugitive'
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'flazz/vim-colorschemes'
call plug#end()
endif

" vim-plugでpluginがインストールされている確認する関数
let s:plug = { "plugs": get(g:, 'plugs', {}) }
function! s:plug.is_installed(name)
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction

filetype plugin indent on

set background=light
syntax enable

set laststatus=2
set backspace=2

set tabstop=4
set autoindent
set expandtab
set shiftwidth=4

set mouse=

set encoding=utf-8
if has('mac')
  set fileencodings=utf-8
else
  set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8
endif

" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif

if s:plug.is_installed("vim-airline")
  let g:airline_theme = 'solarized'
  let g:airline_skip_empty_sections = 1
  let g:airline_powerline_fonts = 1
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  let g:airline_symbols.maxlinenr = ','
  let g:airline_symbols.colnr = ''
  set noshowmode
endif

hi Normal guibg=NONE ctermbg=NONE
hi DiffAdd    ctermfg=black ctermbg=2
hi DiffChange ctermfg=black ctermbg=3
hi DiffDelete ctermfg=black ctermbg=6
hi DiffText   ctermfg=black ctermbg=7

