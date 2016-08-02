"" http://vimdoc.sourceforge.net/htmldoc/options.html

"" ***** VIM OPTIONS *****
syntax   on
filetype plugin indent on              " load plugins based on filetype from ~/.vim/ftplugin/<filetype>.vim
autocmd  BufWinEnter * filetype detect " reload definitions on window switch
"set verbose=3

colorscheme darkblue
set nocompatible     " don't emulate borked features from vi
set number           " Show line numbers
set shell=bash
set visualbell t_vb= " don't beep, just flash
"set guioptions-=T   " Don't include toolbar
"set ttyfast         " yes I'm using a fast terminal
"set ttyscroll=0     " don't scroll TTY - its faster
set diffopt=iwhite,filler,context:1000


"" ***** FILE OPTIONS *****
"" http://vimdoc.sourceforge.net/htmldoc/usr_21.html#21.3 - 'files, :commandlines, @inputlines, %bufferlist, <registers, /search
set viminfo=%,!,'1000,f1,<500,:1000,@1000,/1000,h,n~/.viminfo
"set backupdir=/home/james/vimbackup
"set backup         " been having issues with vim deleting files randomly - so be paranoid
"set writebackup

au! BufWritePost .vimrc source %  " sources .vimrc on write


"" ***** STATUS BAR OPTIONS ******
set showmode        " This option is used to show the actual mode of the editor that you are in.
set showmatch       " When a bracket is inserted, briefly jump to the matching one.
set showcmd         " show the commands being entered
set showfulltag
set wildmenu        " command tab complextion in status bar
set laststatus=2    " when is status bar shown:  0=never, 1=only if mutliple windows, 2=always
set showtabline=2   " when is tabline shown:     0=never, 1=only if mutliple tabs,    2=always
set statusline=[%n]\ %<%f\ %h%w%m%r%=%10l,%-10(%c%V%)%P


"" **** MOVEMENT OPTIONS *****
set scrolloff=2                " number of lines to keep above/below cursor
set virtualedit=all            " allow cursor where there is no char
set backspace=indent,eol,start " backspace can join lines
set iskeyword=$,@,48-57,192-255,_,-
"set matchpairs+=<:>            " allow % to jump between extra <> tags


"" ***** SEARCH OPTIONS *****
set wrapscan   " if the word is not found at the bottom of the file, it will try to search for it at the beginning.
set incsearch  " incremental search
set ignorecase " case insensitive search
set smartcase  " case sensive IF search contains uppercase chars
set gdefault   " default replace all matches  s///g  on search/replace
set magic      " treat . * ^ $ as regex symbols without escaping
"set hls       " highlight search results


"" ***** TAB / INDENT OPTIONS *****
"set cindent      " indent using C standards
"set autoindent   " base indent on previous line
"set smartindent  " autoindent on a new line - set by indent files
set tabstop=4     " size of a tab char
set softtabstop=4 " insert a mix of tabs and spaces
set shiftwidth=4  " number of spaces to use for autoindent
set expandtab     " don't Auto expand tabs to spaces
set textwidth=0   " linewidth to endless
set nowrap        " do not wrap lines

"" ***** STARTUP OPTIONS *****
set autoread                               " reload file when its changed remotely
"set viewdir=~/.vim/views                  " save current editing position
"autocmd BufWinLeave *.js mkview           " save current editing position on exit
"autocmd BufWinEnter *.js silent loadview  " reload last editing position


map                <C-l>            <ESC>:Jsl<CR>

cabbr    splitt            tabnew
cabbr    splittab          tabnew
cabbr    Wq                wq
cabbr    Wqa               wqa

command! Stripwhitespace   %s/[ \t]\+$//
command! RunScript         !./%
command! Jsl               !jsl -conf /etc/jsl.conf -process %