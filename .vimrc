" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" put this line first in ~/.vimrc
set nocompatible | filetype indent plugin on | syn on

" Vim addon manager
" Need this only behind the proxy that blocks git://
let g:vim_addon_manager = {'scms': {'git': {}}}
fun! MyGitCheckout(repository, targetDir)
 let a:repository.url = substitute(a:repository.url, '^git://github', 'https://github', '')
 return vam#utils#RunShell('git clone --depth=1 $.url $p', a:repository, a:targetDir)
endfun
let g:vim_addon_manager.scms.git.clone=['MyGitCheckout']

fun! SetupVAM()
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'

  " Force your ~/.vim/after directory to be last in &rtp always:
  " let g:vim_addon_manager.rtp_list_hook = 'vam#ForceUsersAfterDirectoriesToBeLast'

  " most used options you may want to use:
  " let c.log_to_buf = 1
  " let c.auto_install = 0
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
        \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif

  " This provides the VAMActivate command, you could be passing plugin names, too
  call vam#ActivateAddons([], {})
endfun
call SetupVAM()

" ACTIVATING PLUGINS

" OPTION 1, use VAMActivate
VAMActivate fugitive vimwiki github:itchyny/calendar.vim khuno YouCompleteMe Syntastic vim-airline github:vim-airline/vim-airline-themes
    \ github:flazz/vim-colorschemes github:luochen1990/rainbow ScrollColors github:scrooloose/nerdtree
    \ obsession surround

" OPTION 2: use call vam#ActivateAddons
"call vam#ActivateAddons([PLUGIN_NAME], {})
" use <c-x><c-p> to complete plugin names

" OPTION 3: Create a file ~/.vim-scripts putting a PLUGIN_NAME into each line (# for comments)
" See lazy loading plugins section in README.md for details
"call vam#Scripts('~/.vim-scripts', {'tag_regex': '.*'})


" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		    " Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
"set hidden		    " Hide buffers when they are abandoned
set mouse=a		    " Enable mouse usage (all modes)

set linebreak
set splitbelow
set splitright
"set smartindent
set autoindent
set smarttab
set tabstop=4
set shiftwidth=4
set wildmode=longest,list
set expandtab
set number
"set nohlsearch
set termguicolors
"set autochdir
set ruler


" Hybrid line numbers
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END


" Prepends system clipboards.
" Unnamed is selection clipboard, unnamedplus - copy-paste
set clipboard^=unnamed,unnamedplus


" Better undo
set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo


" Nice colorschemes
"colorscheme desert
"colorscheme jellybeans
"colorscheme distinguished
"colorscheme molokai
"colorscheme badwolf
"colorscheme blackboard
"colorscheme vividchalk
"colorscheme abbott
colorscheme gruvbox
let g:gruvbox_contrast_dark = "medium"
let g:airline_theme='wombat'


" Set default browser
let g:netrw_browsex_viewer = "firefox"


" Save as sudo
cmap w!! w !sudo tee > /dev/null %


" Remove trailing whitespace
nnoremap <F5> :%s/\s\+$//e <CR>


" Syntasitc
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_loc_list_height = 4
let g:syntastic_python_pyflakes_exe = 'python3 -m pyflakes'
let g:syntastic_python_python_exec = '/usr/bin/python3'
"let g:syntastic_ignore_files = ['\.py$']
let g:syntastic_python_checkers = ['flake8']


" Airline
" let g:airline_powerline_fonts = 1


" Rainbow
let g:rainbow_active = 1


" PyMode
"let g:pymode_python = 'python3'
"let g:pymode_run_bind = '<leader>r'
"let g:pymode_breakpoint_bind = '<leader>b'
"let g:pymode_rope_show_doc_bind = '<leader>pd'
"let g:pymode_rope_goto_definition_bind = '<leader>pg'
"let g:pymode_rope_goto_definition_cmd = 'new'
"let g:pymode_rope_rename_bind = '<leader>pr'
""let g:pymode_rope_module_to_package_bind = '<leader>p1p'
"let g:pymode_rope_extract_method_bind = '<leader>pm'
"let g:pymode_rope_extract_variable_bind = '<leader>pl'
"let g:pymode_rope_use_function_bind = '<leader>pu'
"let g:pymode_rope_move_bind = '<leader>pv'
"let g:pymode_rope_change_signature_bind = '<leader>ps'
"let g:pymode_rope_completion_bind = '<C-n>'
"let g:pymode_options_max_line_length=120

"let g:pymode_rope = 1
"let g:pymode_lint = 1 " to not confilct with syntastic
"let g:pymode_indent = 1

" To show red line
autocmd FileType python set colorcolumn=120

" To put .sw? files in the same directory with neovim
set directory=.

" Use F4 to toggle paste mode
" Has opposite result with current .vimrc
"nnoremap <F4> :set invpaste paste?<CR>
"set pastetoggle=<F4>
"set showmode


" NERDTree
map <F2> :NERDTreeToggle<CR>
let NERDTreeShowHidden = 1
"autocmd vimenter * NERDTree  " to open it on startup

" Reload vimrc
"map <F5> :source ~/.vimrc<CR>

" To navigate between splits with ctrl-j instead of ctrl-w j
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" YouCompleteMe bindings
nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap <leader>r :YcmCompleter GoToReferences<CR>
nnoremap <leader>d :rightbelow YcmCompleter GetDoc<CR>
nnoremap <leader>t :YcmCompleter GetType<CR>
let g:ycm_goto_buffer_command = 'same-buffer'
