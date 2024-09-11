" set rtp+=~/.vim/bundle/Vundle.vim

set conceallevel=0

" Sets how many lines of history VIM has to remember
set history=500
" 显示行号
set number

"高亮当前行
set cursorline

"使用鼠标(resize panel)
set mouse=a

let g:onedark_termcolors=256
" comment_grey: { gui: #5C6370, cterm: 59, cterm16: 7 },
" 注释颜色太暗了，调亮一点
let g:onedark_color_overrides = {
\ "comment_grey": {"gui": "#5C6370", "cterm": "246", "cterm16": "11" },
\}
" Enable syntax highlighting
syntax enable
set background=dark
colorscheme onedark


" 高亮查找
" set hls

"高亮当前列
" set cursorcolumn

" Set to auto read when a file is changed from the outside
set autoread

set nowrap

set clipboard=unnamed
if !has('nvim')
  set ttymouse=xterm2
  set esckeys
endif


" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Ignore compiled files
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store


"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
"set mat=2

" Add a bit extra margin to the left
set foldcolumn=1
set foldnestmax=2
set foldlevel=2
set foldmethod=indent
set nofoldenable
" set backupcopy=yes

" set hlsearch
 
" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

set nobackup
set nowb
set noswapfile
set modifiable


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Always show the status line
set laststatus=2

" Ack 搜索时 quickfix 点击 o 会打开一个新的 tab
" https://github.com/mileszs/ack.vim/issues/213
set switchbuf=useopen,usetab,newtab

" coc.nvim

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Rescript
" Hooking up the ReScript autocomplete function
set omnifunc=rescript#Complete

" When preview is enabled, omnicomplete will display additional
" information for a selected item
set completeopt+=preview
