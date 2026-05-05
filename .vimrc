"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" From https://github.com/amix/vimrc 
"
" Maintainer:
"       Amir Salihefendic - @amix3k
"
" Awesome_version:
"       Get this config, nice color schemes and lots of plugins!
"
"       Install the awesome version from:
"
"           https://github.com/amix/vimrc
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Vim improvements over Vi; must be first
set nocompatible

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * silent! checktime

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Add a bit extra margin to the left
set foldcolumn=1

" show line numbers
set number
set relativenumber              " relative numbers make j/k motion counts easy

" Highlight current line
set cursorline

" Enable mouse in all modes (useful in terminals that support it)
set mouse=a

" Performance: only redraw when needed; hint to terminal we're fast
set ttyfast

" Open splits to the right/below instead of left/above
set splitright
set splitbelow

" Security: disable modelines (can execute arbitrary code)
set nomodeline

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Set regular expression engine automatically
set regexpengine=0

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Enable true color support
if has("termguicolors")
    set termguicolors
endif

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" OLED colorscheme — pure black (#000000) background for OLED displays.
" Pixels off = zero power; full contrast with no grey wash.
"
" Palette:
"   bg        #000000   fg        #E0E0E0
"   comment   #5C6370   string    #C3E88D
"   keyword   #C792EA   number    #F78C6C
"   function  #82AAFF   type      #FFCB6B
"   operator  #89DDFF   error     #FF5370
highlight clear
if exists("syntax_on") | syntax reset | endif

" Syntax
highlight Normal        guifg=#E0E0E0  guibg=#000000  ctermfg=250  ctermbg=NONE
highlight Comment       guifg=#5C6370  guibg=NONE     ctermfg=241  cterm=italic   gui=italic
highlight Constant      guifg=#C792EA  guibg=NONE     ctermfg=177
highlight String        guifg=#C3E88D  guibg=NONE     ctermfg=150
highlight Character     guifg=#C3E88D  guibg=NONE     ctermfg=150
highlight Number        guifg=#F78C6C  guibg=NONE     ctermfg=209
highlight Boolean       guifg=#F78C6C  guibg=NONE     ctermfg=209
highlight Float         guifg=#F78C6C  guibg=NONE     ctermfg=209
highlight Identifier    guifg=#82AAFF  guibg=NONE     ctermfg=111
highlight Function      guifg=#82AAFF  guibg=NONE     ctermfg=111
highlight Statement     guifg=#C792EA  guibg=NONE     ctermfg=177  gui=bold       cterm=bold
highlight Keyword       guifg=#C792EA  guibg=NONE     ctermfg=177
highlight Conditional   guifg=#C792EA  guibg=NONE     ctermfg=177
highlight Repeat        guifg=#C792EA  guibg=NONE     ctermfg=177
highlight Label         guifg=#C792EA  guibg=NONE     ctermfg=177
highlight Operator      guifg=#89DDFF  guibg=NONE     ctermfg=117
highlight Exception     guifg=#FF5370  guibg=NONE     ctermfg=203
highlight PreProc       guifg=#FFCB6B  guibg=NONE     ctermfg=221
highlight Include       guifg=#FFCB6B  guibg=NONE     ctermfg=221
highlight Define        guifg=#FFCB6B  guibg=NONE     ctermfg=221
highlight Macro         guifg=#FFCB6B  guibg=NONE     ctermfg=221
highlight PreCondit     guifg=#FFCB6B  guibg=NONE     ctermfg=221
highlight Type          guifg=#FFCB6B  guibg=NONE     ctermfg=221
highlight StorageClass  guifg=#C792EA  guibg=NONE     ctermfg=177
highlight Structure     guifg=#FFCB6B  guibg=NONE     ctermfg=221
highlight Typedef       guifg=#FFCB6B  guibg=NONE     ctermfg=221
highlight Special       guifg=#89DDFF  guibg=NONE     ctermfg=117
highlight Underlined    guifg=#82AAFF  guibg=NONE     ctermfg=111  gui=underline  cterm=underline
highlight Error         guifg=#FF5370  guibg=NONE     ctermfg=203  gui=bold       cterm=bold
highlight Todo          guifg=#FFCB6B  guibg=NONE     ctermfg=221  gui=bold       cterm=bold

" Editor chrome
highlight LineNr        guifg=#3A3A3A  guibg=#000000  ctermfg=237  ctermbg=NONE
highlight CursorLineNr  guifg=#FFCB6B  guibg=#000000  ctermfg=221  gui=bold       cterm=bold
highlight CursorLine    guifg=NONE     guibg=#0D0D0D  ctermbg=232  cterm=NONE
highlight CursorColumn  guifg=NONE     guibg=#0D0D0D  ctermbg=232
highlight ColorColumn   guifg=NONE     guibg=#0D0D0D  ctermbg=232
highlight SignColumn    guifg=#3A3A3A  guibg=#000000  ctermfg=237  ctermbg=NONE
highlight FoldColumn    guifg=#3A3A3A  guibg=#000000  ctermfg=237  ctermbg=NONE
highlight Folded        guifg=#5C6370  guibg=#111111  ctermfg=241  ctermbg=233
highlight VertSplit     guifg=#1A1A1A  guibg=#000000  ctermfg=234  ctermbg=NONE

" Status / tab bar
highlight StatusLine    guifg=#E0E0E0  guibg=#111111  ctermfg=250  ctermbg=233   gui=NONE  cterm=NONE
highlight StatusLineNC  guifg=#5C6370  guibg=#0A0A0A  ctermfg=241  ctermbg=232   gui=NONE  cterm=NONE
highlight TabLine       guifg=#5C6370  guibg=#111111  ctermfg=241  ctermbg=233   gui=NONE  cterm=NONE
highlight TabLineSel    guifg=#E0E0E0  guibg=#000000  ctermfg=250  ctermbg=NONE  gui=bold  cterm=bold
highlight TabLineFill   guifg=NONE     guibg=#111111  ctermbg=233

" Popup menu
highlight Pmenu         guifg=#E0E0E0  guibg=#111111  ctermfg=250  ctermbg=233
highlight PmenuSel      guifg=#000000  guibg=#82AAFF  ctermfg=0    ctermbg=111
highlight PmenuSbar     guifg=NONE     guibg=#1A1A1A  ctermbg=234
highlight PmenuThumb    guifg=NONE     guibg=#5C6370  ctermbg=241

" Selection and search
highlight Visual        guifg=NONE     guibg=#1A1A2E  ctermbg=17   cterm=NONE
highlight VisualNOS     guifg=NONE     guibg=#1A1A2E  ctermbg=17
highlight Search        guifg=#000000  guibg=#FFCB6B  ctermfg=0    ctermbg=221
highlight IncSearch     guifg=#000000  guibg=#F78C6C  ctermfg=0    ctermbg=209
highlight MatchParen    guifg=#FFCB6B  guibg=NONE     ctermfg=221  gui=bold       cterm=bold

" Misc UI
highlight Directory     guifg=#82AAFF  guibg=NONE     ctermfg=111
highlight Title         guifg=#FFCB6B  guibg=NONE     ctermfg=221  gui=bold       cterm=bold
highlight ErrorMsg      guifg=#FF5370  guibg=NONE     ctermfg=203
highlight WarningMsg    guifg=#F78C6C  guibg=NONE     ctermfg=209
highlight MoreMsg       guifg=#C3E88D  guibg=NONE     ctermfg=150
highlight ModeMsg       guifg=#E0E0E0  guibg=NONE     ctermfg=250  gui=bold       cterm=bold
highlight Question      guifg=#C3E88D  guibg=NONE     ctermfg=150
highlight NonText       guifg=#1A1A1A  guibg=NONE     ctermfg=234
highlight SpecialKey    guifg=#1A1A1A  guibg=NONE     ctermfg=234

" Spell
highlight SpellBad      guifg=NONE     guibg=NONE     gui=undercurl  cterm=underline  guisp=#FF5370
highlight SpellCap      guifg=NONE     guibg=NONE     gui=undercurl  cterm=underline  guisp=#82AAFF
highlight SpellRare     guifg=NONE     guibg=NONE     gui=undercurl  cterm=underline  guisp=#C792EA
highlight SpellLocal    guifg=NONE     guibg=NONE     gui=undercurl  cterm=underline  guisp=#F78C6C

" Diff
highlight DiffAdd       guifg=#C3E88D  guibg=#0D1F0D  ctermfg=150  ctermbg=22
highlight DiffChange    guifg=#FFCB6B  guibg=#1F1A00  ctermfg=221  ctermbg=58
highlight DiffDelete    guifg=#FF5370  guibg=#1F0006  ctermfg=203  ctermbg=52
highlight DiffText      guifg=#FFCB6B  guibg=#2A2000  ctermfg=221  ctermbg=58    gui=bold  cterm=bold

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

" Persistent undo — survive across sessions without plugins
if has("persistent_undo")
    let s:undodir = expand('~/.vim/undodir')
    if !isdirectory(s:undodir)
        call mkdir(s:undodir, "p", 0700)
    endif
    let &undodir = s:undodir
    set undofile
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

" Define visible whitespace characters (toggle with :set list / :set nolist)
set listchars=tab:›\ ,trail:·,nbsp:+

" Show a visual ruler at column 80
set colorcolumn=80

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <C-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=escape(expand("%:p:h"), " ")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Make Y behave like D and C (yank to end of line)
nnoremap Y y$

" Prevent accidental Ex mode
nnoremap Q <Nop>

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
