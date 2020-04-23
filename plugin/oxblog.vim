let s:debug = 0
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
