nnoremap <leader>w :w!<cr>
nnoremap <leader>q :q<cr>
" nnoremap <leader><leader>s :source ~/.vimrc<cr>
" nnoremap <Leader>y "+y
" nnoremap <Leader>p "+p

"nnoremap <CR> G
"奇怪的语法 把 C-Space 映射为 Esc
"inoremap <NUL> <Esc>
"vnoremap <NUL> <Esc>
"cnoremap <NUL> <Esc>
"nnoremap <NUL> a
nnoremap H 0
nnoremap L $
"map <C-space> <C-c>

" mark
" nmap <leader>mm `

"nmap <leader>; :
" vim  映射模式
" nore 非递归
" n 普通模式
" v 可视模式
" i 插入模式
" c 命令行模式
"

" quickfix
" nnoremap <c-l> :cn<cr>
" nnoremap <c-h> :cp<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 折叠
" :nnoremap <C-l> za


"let g:onedark_termcolors=256

" 参考 https://jdhao.github.io/2019/03/28/nifty_nvim_techniques_s1/ 的一些配置
" set selection=exclusive
map $ g_

" 禁用 C-b 默认行为
map <C-b> <Nop>

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

map <C-w>L :vertical resize +50<cr>
map <C-w>H :vertical resize -50<cr>
map <C-w>K :resize +20<cr>
map <C-w>J :resize -20<cr>

" buffer navigation
map <C-b>l :bnext<cr>
map <C-b>h :bprevious<cr>
map <C-b>L :blast<cr>
map <C-b>H :bfirst<cr>
map <C-b>d :bd<cr>
map <C-b>; :ls<cr>
nnoremap <leader>g <C-^>

nnoremap ' ,
nnoremap T %
" nnoremap ; `

" tab navigation
map <C-t>l :tabn<cr>
map <C-t>h :tabp<cr>
map <C-t>n :tabedit %<cr>
map <C-t>; :tabs<cr>
map <C-t>g :tabm
map <C-t>L :tablast<cr>
map <C-t>H :tabfirst<cr>

" insert mode
inoremap <C-w> <C-[>diwi
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
" inoremap <C-n> <Down>
" inoremap <C-p> <Up>
" 实现 (、[、{、"、'  输入后自动补全右边部分，光标也会位于中间位置
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap < <><ESC>i
" inoremap " ""<ESC>i
" inoremap ' ''<ESC>i

" 选中缩进
" vmap < <gv
" vmap > >gv


" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
" map 0 ^

"设置 %% 获取当前文件所在路径
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
cnoremap <expr> %p getcmdtype() == ':' ? expand('%:p').'/' : '%p'
" 设置 %f 获取当前文件
cnoremap <expr> %h getcmdtype() == ':' ? expand('%') : '%h'

" 设置 %b 查看当前行 git blame
cnoremap <expr> %b "! git blame -L" . line('.') . ' ' . expand('%')


cnoremap <expr> %s 'source ~/.vimrc'
" nnoremap <leader><leader>s :source ~/.vimrc<cr>

" set conceallevel=0
" 设置json conceallevel
nnoremap <leader>j :call ConceallevelToggle()<cr>

nnoremap <leader>p :echo join(split(&runtimepath, ','), "\n")<CR>

command! -bang  MAP map<bang>
