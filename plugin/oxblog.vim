let s:genox_root_dir = "/www/oxal.org"
let s:genox_blog_dir = "/www/oxal.org/src/blog"
let g:genox_venv = "~/.virtualenvs/oxal.org"
let g:genox_venv_activate = g:genox_venv . '/bin/activate'
let g:genox_make = printf("source %s && cd %s && make synconly", g:genox_venv_activate, s:genox_root_dir)

let s:debug = 0

function s:checkIfInsideGenoxRoot(file_path)
    if a:file_path !~ '^' . s:genox_root_dir
        return 0
    endif
    return 1
endfunction

function! s:genox_handler(lines)
    let query = a:lines[0]
    let key_pressed = a:lines[1]
    let note_name = a:lines[2:]

    if s:debug
        echom "query = " . query
        echom "key_pressed = " . key_pressed
        echom "note_name = " . join(note_name)
    endif

    let note_path = ''
    if key_pressed ==? "ctrl-o"
        let note_path = fnameescape(printf('%s/%s.md', s:genox_blog_dir, query))
    else
        let note_path = fnameescape(printf('%s/%s', s:genox_blog_dir, join(note_name)))
    endif

    execute printf('%s %s', 'edit', note_path)
endfunction

function! s:oxblog()
    try
        call fzf#run(fzf#wrap({
            \ 'source': 'find ' . s:genox_blog_dir . ' -type f -printf "%P\n"',
            \ 'sink*': function('s:genox_handler'),
            \ 'options': '--expect=ctrl-o --print-query',
        \}))
    catch
        echohl WarningMsg
        echom v:exception
        echohl None
    endtry
endfunction

function! s:oxbakeAndServe()
    echom 'Running: ' . g:genox_make
    let l:output = system(g:genox_make)
    echom 'Done.'
endfunction

function! s:oxpublish()
    " Check if the current file belongs inside our blog directory
    let l:curr_path = expand('%')
    let ok = call s:checkIfInsideGenoxRoot(l:curr_path)
    if ok == 0
        echom "This file is not inside the blog directory"
        return
    endif

    call s:oxbakeAndServe()
endfunction

function! s:oxdelete()
    " Check if the current file belongs inside our blog directory
    let l:curr_path = expand('%')
    let ok = call s:checkIfInsideGenoxRoot(l:curr_path)
    if ok == 0
        echom "This file is not inside the blog directory"
        return
    endif

    echom "Deleting current blog post."
    call delete(l:curr_path)

    call s:oxbakeAndServe()
    execute 'bdelete!'
endfunction

command! -nargs=* -bang OxBlog call s:oxblog()
command! -nargs=0 -bang OxPublish call s:oxpublish()
command! -nargs=0 -bang OxDelete call s:oxdelete()

nnoremap <leader>nn :OxBlog<CR>
nnoremap <leader>np :OxPublish<CR>
