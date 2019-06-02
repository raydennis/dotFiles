" filetype support
set nocompatible
filetype plugin indent on
syntax on
colorscheme solarized

" allows jumping between matches like if and end with %
runtime macros/matchit.vim

" various settings
set tabstop=4
let &softtabstop = &tabstop
set expandtab
set shiftwidth=4
let mapleader = " "                     " Leader - ( Space bar )
set autoindent
set backspace=indent,eol,start
set complete+=d
set directory^=$HOME/.vim/swapfiles//   " Where to save swap files
set foldlevelstart=1
set grepprg=LC_ALL=C\ grep\ -nrsH
set hidden                              " When ON a buffer becomes hidden when it is |abandon|ed. 
set hlsearch                            " When there is a previous search pattern, highlight all its matches.
set smartcase                           " Case insensitive search if your search is all lowercase, sensitive if you use any CAPS.
set incsearch                           " While typing a search command, show where pattern, as it was typed
set mouse=a
set noswapfile
set path& | let &path .= "**"
set showcmd                             " Display incomplete command
set showmatch                           " When a bracket is inserted, briefly jump to the matching one.
set splitbelow                          " Open new split panes to right
set splitright                          " Open new split panes to the bottom
set tags=./tags;,tags;
set tagcase=smart                       " limit the number of responses we get for case matching
set undodir=$HOME/.vim/undo             " Where to save undo histories (THIS folder MUST be created manually or it doesn't work.  This is great for portability in that it doesn't create the history files unless you specifically create the folder.
set undofile                            " Save undos after file closes
set visualbell                          " Switch from sound on error to flash
set wildcharm=<C-z>
set wildmenu                            " When 'wildmenu' is on, command-line completion operates in an enhanced mode
set wildmode=list:longest,full

" Foldmethod based on syntax
autocmd FileType py setlocal foldmethod=indent
autocmd FileType markdown setlocal foldmethod=syntax

" easier beginning and ending of line
map H ^
map L $

" opem terminal
nnoremap <leader>' :terminal<cr>

" Use tab to switch between current and last buffer
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>


" move to the split in the direction shown, or create a new split
nnoremap <C-w>h :call WinMove('h')<cr>
nnoremap <C-w>j :call WinMove('j')<cr>
nnoremap <C-w>k :call WinMove('k')<cr>
nnoremap <C-w>l :call WinMove('l')<cr>

function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr())
    if (match(a:key,'[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction

" create a new buffer (save it with :w ./path/to/FILENAME)
nnoremap <leader>be :enew<cr>
" close current buffer
nnoremap <leader>bd :bp <bar> bd! #<cr>
" close all open buffers
nnoremap <leader>bq :bufdo bd!<cr>

" remove blank lines in current visual selection
vnoremap <leader>rml :v/./d

" Spell check for previous misspelled word, accept first choice.
nnoremap <leader>z [s1z=]

" Stop highlight after searching
nnoremap <silent> <leader>, :noh<cr>

" change directory to current file's directory
nnoremap <leader>cd :cd %:h<cr>

" Quicker clipboard control
nnoremap <Leader>y "+y
nnoremap <Leader>d "+d
vnoremap <Leader>y "+y
vnoremap <Leader>d "+d 
nnoremap <Leader>p :set paste<CR>"+p:set nopaste<CR>
nnoremap <Leader>P :set paste<CR>"+P:set nopaste<CR>
vnoremap <Leader>p :set paste<CR>"+p:set nopaste<CR>
vnoremap <Leader>P :set paste<CR>"+P:set nopaste<CR>

" Move lines around
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

nnoremap <C-h> <<
nnoremap <C-l> >>
inoremap <C-h> <<
inoremap <C-l> >>
vnoremap <C-l> >>
vnoremap <C-h> <<

" Insert current date
nnoremap <C-d> a<C-R>=strftime("%y%m%d ")<CR><Esc>
inoremap <C-d> <C-R>=strftime("%y%m%d")<CR>
cnoremap <C-d> <C-R>=strftime("%y%m%d")<CR>
nnoremap <leader>d a<C-R>=strftime("%m/\%d/\%y ")<CR><Esc>


" Resize panes with arrow keys
nnoremap <silent> <Left> :vertical resize -5<cr>
nnoremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Up> :resize +5<cr>
nnoremap <silent> <Down> :resize -5<cr>

" SpaceMacs Org-Mode style bindings
nnoremap <leader>td :.s/TODO/DONE/<CR> ea [<C-R>=strftime("%y%m%d")<CR>]<Esc><C-O>
nnoremap <leader>tw :.s/TODO/WAITING/<CR> ea [<C-R>=strftime("%y%m%d")<CR>
nnoremap <leader>dd :.s/* /* TODO /<CR><C-O>
nnoremap <leader>th :.s/* /* HTODO /<CR><C-O>
nnoremap <leader>at :grep "* TODO" *<cr>
nnoremap <leader>ah :grep HTODO *<cr>
nnoremap <leader>aw :grep WAITING *<cr>
nnoremap <leader>ad :grep DONE *<cr>


" Vimwiki style bindings
nnoremap <leader>ww :e ~/Documents/gitHub/notes/todo.md<CR> 

" Import task list
nnoremap <leader>t :read ! php ~/Documents/gitHub/notes/code/my-myit/rd-myit-001.php<CR>

" Run the current line as if it were a command. Often more convenient than q: when experimenting.
nnoremap <leader>e :exe getline(line('.'))<cr> 
" various autocommands
augroup minivimrc
	autocmd!
	" automatic location/quickfix window
	autocmd QuickFixCmdPost [^l]* cwindow
	autocmd QuickFixCmdPost    l* lwindow
	autocmd VimEnter            * cwindow
	" Git-specific settings
	autocmd FileType gitcommit nnoremap <buffer> { ?^@@<CR>|nnoremap <buffer> } /^@@<CR>|setlocal iskeyword+=-
	" When editing a file, always jump to the last known cursor position.
	" Don't do it for commit messages, when the position is invalid, or when
	" inside an event handler (happens when dropping a file on gvim).
	autocmd BufReadPost *
	 \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
	 \   exe "normal g`\"" |
	 \ endif
	" Automatically rebalance windows on vim resize
	autocmd VimResized * :wincmd = 
augroup END

" augroup remember_folds
"   autocmd!
"   au BufWinLeave ?* mkview 1
"   au BufWinEnter ?* silent! loadview 1
" augroup END

augroup md
  autocmd!
  au BufNewFile,BufRead *.md syntax keyword todo TODO
  au BufNewFile,BufRead *.md inoremap <buffer> ;` ```<cr><cr>```<Up><Up>
augroup END


" OS Specific Commands
if has("unix")
  " *nix
  set list listchars=tab:»·,trail:·       " Display tabs as '-' and trailing white space as '.'
  " *nix subsets
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    " macOS
    set guifont=FiraMonoForPowerline-Regular:h12 
  else 
    " Linux/WSL
  endif
else
    " Windows
endif
                                          " Start Plugins 
set rtp+=~/.vim/bundle/Vundle.vim/        " To install Vundle:  git clone https://github.com/VundleVim/Vundle.vim.git 
call vundle#begin()                       " Set the runtime path to include Vundle and initialize
Plugin 'VundleVim/Vundle.vim'             " Let Vundle manage Vundle, required

Plugin 'airblade/vim-gitgutter'           " Adds signs in the gutter if there are changes to the current workspace 
Plugin 'dhruvasagar/vim-table-mode'       " Tables
Plugin 'jkramer/vim-checkbox'             " Simple plugin that toggles text checkboxes in Vim. Works great if you're using a markdown file for notes and todo lists.
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'                 " Fuzzy finding 
Plugin 'mbbill/undotree'                  " Visual representation of undo tree
Plugin 'plasticboy/vim-markdown'          " Needed for markdown folding
Plugin 'tommcdo/vim-lion'                 " Align based on a character ex: glip(char)
Plugin 'tpope/vim-commentary'             " Comment out code with gcc
Plugin 'tpope/vim-fugitive'               " Adds git functionality to vim ex: :Gdiff
Plugin 'tpope/vim-surround'               " provides mappings to easily delete, change and add such surroundings in pairs
Plugin 'vim-scripts/VisIncr'              " Allows incrementation of numbers in a line.  Visually select then press :I

call vundle#end()                         " Required, All of the Plugins must be added before this line
filetype plugin indent on                 " Required

" Setup FZF
map <leader><Space> :FZF <CR>

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Mapping selecting mappings
nmap <c-x><c-n> <plug>(fzf-maps-n)
xmap <c-x><c-x> <plug>(fzf-maps-x)
omap <c-x><c-o> <plug>(fzf-maps-o)

" Setup Undotree
nnoremap <leader>u :UndotreeToggle<CR>

" Setup netwr
let g:netrw_liststyle=3                   " Tree View
let g:netrw_winsize=80                    " Make split 20 (100-80) characters wide
let g:netrw_banner=0                      " Remove Banner 
let g:netrw_altv=1                        " Open Splits to the right 
let g:netwr_browse_split=4                " Open in prior window 
