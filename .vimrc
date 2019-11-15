set clipboard=unnamed
set number

set splitright
set splitbelow

set ignorecase
set smartcase

set expandtab
set tabstop=4
set shiftwidth=4
set shiftround

set noswapfile
set hidden
set mouse=a
set formatoptions-=cro                             "disable auto comments on new lines

" allow saving of files as sudo
cmap w!! w !sudo tee > /dev/null %

highlight LineNr ctermfg=grey

" Leader keys
let mapleader=","
nnoremap <leader><space> :nohlsearch<CR>
nmap <leader>w :w!<CR>
nmap <leader>q :q<CR>
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>
nnoremap <leader>S :setlocal spell! spell?<CR>
nnoremap <leader>. :e $MYVIMRC<CR>

au FileType python nnoremap <buffer> <leader>r :w<CR> :exec '!python3' shellescape(@%, 1)<CR>

" Center the screen
nnoremap <space> zz

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

inoremap jk <esc>l

inoremap <C-a> <esc>I
inoremap <C-e> <esc>A

inoremap <C-f> <Right>
inoremap <C-b> <Left>

tnoremap <Esc> <C-\><C-n>

" Better split switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" {{{ Autocommands
" Automatically source .vimrc on save
augroup Vimrc
  autocmd! bufwritepost .vimrc source $MYVIMRC
augroup END
" }}}

au FocusLost * :wa              " Set vim to save the file on focus out.

" Automatic toggling between line number modes
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END


" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \	exe "normal! g`\"" |
        \ endif


"-- FOLDING --
set foldmethod=indent
set foldlevelstart=99 "start file with all folds opened
nnoremap <Tab> za


" Toggle 'default' terminal
nnoremap <M-`> :call ChooseTerm("term-slider", 1)<CR>
" Start terminal in current pane
nnoremap <M-CR> :call ChooseTerm("term-pane", 0)<CR>

function! ChooseTerm(termname, slider)
    let pane = bufwinnr(a:termname)
    let buf = bufexists(a:termname)
    if pane > 0
        " pane is visible
        if a:slider > 0
            :exe pane . "wincmd c"
        else
            :exe "e #"
        endif
    elseif buf > 0
        " buffer is not in pane
        if a:slider
            :exe "topleft split"
        endif
        :exe "buffer " . a:termname
    else
        " buffer is not loaded, create
        if a:slider
            :exe "topleft split"
        endif
        :terminal
        :exe "f " a:termname
    endif
endfunction


" ==================== FZF ====================
if has("macunix")
    set rtp+=/usr/local/opt/fzf
else
    set rtp+=/usr/share/doc/fzf/examples
endif
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler nonumber norelativenumber
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
nnoremap <C-p> :FZF<CR>


" ==================== netrw ====================
let g:netrw_banner=0
let g:netrw_winsize=20
let g:netrw_liststyle=3
let g:netrw_localrmdir='rm -r'
nnoremap <C-n> :Lexplore<CR>
