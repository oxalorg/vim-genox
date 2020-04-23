let s:debug = 0

let s:blog_root_dir = "/www/oxal.org"
let s:blog_dir = "/www/oxal.org/src/blog"

function! s:oxblog_handler(lines)
    let query = a:lines[0]
    " let key_command = get(s:key_mapping, key_pressed, 'e')
    let key_pressed = a:lines[1]
    let note_name = a:lines[2:]

    if s:debug
        echom "query = " . query
        echom "key_pressed = " . key_pressed
        echom "note_name = " . join(note_name)
    endif

    let note_path = ''
    if key_pressed ==? "ctrl-o"
        let note_path = fnameescape(printf('%s/%s.md', s:blog_dir, query))
    else
        let note_path = fnameescape(printf('%s/%s', s:blog_dir, join(note_name)))
    endif

    execute printf('%s %s', 'edit', note_path)
endfunction

function! s:oxblog()
    try
        call fzf#run(fzf#wrap({
            \ 'source': 'find ' . s:blog_dir . ' -type f -printf "%P\n"',
            \ 'sink*': function('s:oxblog_handler'),
            \ 'options': '--expect=ctrl-o --print-query',
        \}))
    catch
        echohl WarningMsg
        echom v:exception
        echohl None
    endtry
endfunction

command! -nargs=* -bang OxBlog call s:oxblog()

nnoremap <leader>nn :OxBlog<CR>

let g:oxblog_venv = "~/.virtualenvs/oxal.org"
let g:oxblog_venv_activate = g:oxblog_venv . '/bin/activate'
let g:oxblog_make = printf("source %s && cd %s && make synconly", g:oxblog_venv_activate, s:blog_root_dir)

function! s:oxbakeAndServe()
    echom 'Running: ' . g:oxblog_make
    let l:output = system(g:oxblog_make)
    echom 'Done.'
endfunction

function! s:oxpublish()
    " Check if the current file belongs inside our blog directory
    let l:curr_path = expand('%')
    if l:curr_path !~ '^' . s:blog_root_dir
        echom "This file is not inside the blog directory"
        return
    endif

    call s:oxbakeAndServe()
endfunction

command! -nargs=0 -bang OxPublish call s:oxpublish()

nnoremap <leader>np :OxPublish<CR>

function! s:oxdelete()
    " Check if the current file belongs inside our blog directory
    let l:curr_path = expand('%')
    if l:curr_path !~ '^' . s:blog_root_dir
        echom "This file is not inside the blog directory"
        return
    endif

    echom "Deleting current blog post."
    call delete(l:curr_path)

    call s:oxbakeAndServe()
    execute 'bdelete!'
endfunction

command! -nargs=0 -bang OxDelete call s:oxdelete()
