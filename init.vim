set nocompatible
" vim-plug $HOME/.local/share/nvim/site/autoload/
call plug#begin()
  Plug 'preservim/nerdtree'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'mxw/vim-jsx'
  Plug 'easymotion/vim-easymotion'
  Plug 'mg979/vim-visual-multi'
  Plug 'tpope/vim-surround'
  Plug 'vim-airline/vim-airline'
  Plug 'mileszs/ack.vim'
  Plug 'dart-lang/dart-vim-plugin'
  Plug 'udalov/kotlin-vim'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'
  Plug 'uarun/vim-protobuf'
  " ale 会导致 ts 文件报很多错误
  " Plug 'dense-analysis/ale'
  " Plug 'Neevash/awesome-flutter-snippets'
  Plug 'chemzqm/wxapp.vim'
  Plug 'voldikss/vim-translator'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
  Plug 'editorconfig/editorconfig-vim'
  " call minpac#add('wlangstroth/vim-racket')
  " 可以把 vim 内容发送到tmux session
  " call minpac#add('sjl/tslime.vim')

  " rust
  Plug 'rust-lang/rust.vim'
  Plug 'cespare/vim-toml'

  Plug 'Exafunction/codeium.vim'
  Plug 'posva/vim-vue'

  " LSP
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  " Plug 'nvim-lua/completion-nvim'
call plug#end()

" 设置leader键
let mapleader = " "
let g:mapleader =  " "

source ~/.config/nvim/settings.vim
source ~/.config/nvim/mappings.vim

runtime macros/matchit.vim

lua require('completion')
lua require('lsp')
lua require('command')

" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']
let g:vsnip_snippet_dir = expand('~/.vim/vsnip-snippets/vsnips')


" map <leader>s :shell<cr>


" Specify the behavior when switching between buffers
" try
"   set switchbuf=useopen,usetab,newtab
"   set stal=2
" catch
" endtry

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""

":autocmd FileType javascript xxx
:autocmd filetype lisp,scheme,art setlocal equalprg=scmindent.rkt

" NERDTree
nmap <C-w>; :NERDTreeToggle<CR>
let NERDTreeShowHidden = 1
let NERDTreeIgnore = [
  \'\.DS_Store$',
  \'\.bundle$',
  \'\.capistrano$',
  \'\.git$',
  \'\.gitkeep$',
  \'\.keep$',
  \'\.routes$',
  \'\.sass-cache$',
  \'\.swo$',
  \'\.swp$',
  \'\.pyc$',
  \'tags$'
  \]
" Open the existing NERDTree on each new tab
" autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirro | endif
nnoremap <C-w>w :NERDTreeFocus<CR>
nnoremap <C-w>f :NERDTreeFind<CR>

let g:ctrlp_working_path_mode = 'a'

" let g:ctrlp_cmd = 'CtrlPMRU'
" nmap <C-o> :CtrlPMRU<CR>
"
" 跳转到上一个光标位置
" <C-o>
" 跳转到下一个光标位置
" <C-i>

" ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn|miniprogram)|node_modules|jspm_modules|dist|build)$',
  \ 'file': '\v\.(exe|so|dll|pyc)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" easymotion
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
" map <leader>f /
" omap <leader>f /

let g:niji_dark_colors = [
  \ [ '81', '#5fd7ff'],
  \ [ '99', '#875fff'],
  \ [ '1',  '#dc322f'],
  \ [ '76', '#5fd700'],
  \ [ '3',  '#b58900'],
  \ [ '2',  '#859900'],
  \ [ '6',  '#2aa198'],
  \ [ '4',  '#268bd2'],
  \ ]

"tslime {{{
let g:tslime_ensure_trailing_newlines = 1
let g:tslime_normal_mapping = '<c-t>t'
let g:tslime_visual_mapping = '<c-t>t'
let g:tslime_vars_mapping = '<c-t>T'
" }}}


" Use deoplete.
" let g:deoplete#enable_at_startup = 1

" ag.vim
" let g:ag_working_path_mode="r"
" let g:ag_highlight=1
" let g:ag_apply_qmappings=0
" nnoremap <leader>s :Ag 

"ocaml merlin
"let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
"execute "set rtp+=" . g:opamshare . "/merlin/vim"

if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
  endif
  let g:ycm_semantic_triggers['typescript'] = ['.']

function! ConceallevelToggle()
    if(&conceallevel == 0)
        set conceallevel=2
    else
        set conceallevel=0
    endif
endfunc

" autocmd FileType json call ConceallevelToggle()
autocmd FileType json syntax match Comment +\/\/.\+$+

au BufNewFile,BufRead *.js, *.html, *.css, *.dart *.ts *.tsx *.jsx
  \ set tabstop=2 |
  \ set softtabstop=2 |
  \ set shiftwidth=2 |
  \ set textwidth=60

au BufNewFile,BufRead *.py
  \ set tabstop=4 |
  \ set softtabstop=4 |
  \ set shiftwidth=4 |
  \ set textwidth=79 |
  \ set expandtab |
  \ set autoindent |
  \ set fileformat=unix

"dart-vim-plugin
let g:dart_style_guide = 2
let dart_html_in_string=v:true
setlocal cinoptions-=(2s
setlocal cinoptions+=(s
" let g:dart_format_on_save = 1

autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc

" vim-traslator
""" Configuration example
" Echo translation in the cmdline
nmap <silent> <leader>t <Plug>Translate
vmap <silent> <leader>t <Plug>TranslateV
" Display translation in a window
nmap <silent> <leader>T <Plug>TranslateW
vmap <silent> <leader>T <Plug>TranslateWV

" VIM 宏

" qaJjq
" q 表示开始录制宏，qa 表示把宏保存到寄存器a中
" Jj 表示操作的内容
" q 结束宏的录制
"
" @a 播发寄存器a里面的宏
" :reg(全名:registers) 查看所有寄存器的内容 ( 宏就是保存在寄存器里面的操作序列)
" "ap 粘贴命令 "a表示寄存器a中内容
"
"
"
command Todo Ack! 'TODO'

if has("autocmd")
  " Highlight TODO, FIXME, NOTE, etc.
  if v:version > 701
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|BUG\|HACK\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\)')
  endif
endif

" 清理所有非当前的buffer
function! ClearBuffersExceptCurrent()
  %bd|e#
endfunc
command ClearBuffersExceptCurrent call ClearBuffersExceptCurrent()
