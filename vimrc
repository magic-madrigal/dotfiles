" -= Vim Configurations =-
syntax enable           " enable syntax processing
set tabstop=2           " number of visual spaces per TAB
set softtabstop=2       " number of spaces in tab when editing
set number              " show line numbers
set cursorline          " highlight current line
set wildmenu            " visual autocomplete for command menu
set showmatch           " highlight matching [{()}]
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set foldenable          " enable folding

" -= Vim Custom Hot Keys =-
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" -= Plug Vim Plugins =- // For more check this out. https://vimawesome.com/
call plug#begin()
:filetype plugin on
Plug 'chrisbra/csv.vim'         " Auto formats CSVs
Plug 'tpope/vim-sensible'       " Syntax Highlighting
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " Access to file structure
Plug 'python-mode/python-mode'  " Python specific 
Plug 'airblade/vim-gitgutter'   " Adds Git changes +/- to the gutter
Plug 'mhinz/vim-signify'
Plug 'vim-airline/vim-airline'  " Vim themeing
Plug 'vim-airline/vim-airline-themes' " Airline Themes
Plug 'vim-syntastic/syntastic'  " Sytax highighting
Plug 'jreybert/vimagit'				  " Adding Git Commands
Plug 'tpope/vim-surround'			 
Plug 'scrooloose/nerdcommenter' " Commenting Tools
Plug 'pangloss/vim-javascript'  " Javascript Specific settings
Plug 'sjl/gundo.vim'						" undo tool, let's you see a tree of your changes
Plug 'mbbill/undotree'					" undo tool, let's you see a tree of your changes
Plug 'edkolev/tmuxline.vim'			" Tags of what function you are working in.
Plug 'mklabs/jscs.vim', { 'do': 'npm i jscs -g' } " JSCS for vim
Plug 'tpope/vim-fugitive'													" 0_o

" -= Plugin Settings =-
let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'unicode'

call plug#end()

