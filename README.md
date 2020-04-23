# vim-ox

A vim plugin for automating my blogging workflow. This can also be used as a
plugin for the static site generator:
[oxalorg/genox](https://github.com/oxalorg/genox/)

Read my blog post about it here: https://oxal.org/blog/wip-my-first-vim-plugin/

This is currently work in progress. It will not work on your system yet.

## OxBlog

- Quick mapping for editing existing blog entries on my blog:
    [oxal.org](https://oxal.org/blog/)
- A shortcut to create a new blog post from within FZF popup.
    - Write a filename and Press `ctrl-o` to create a new post (a `.md`
        extension will automatically be added) in the blog directory.
- From within any existing blog file - rebuild blog and publish/deploy

Default Mapping is

```
nmap <leader>nn call :OxBlog<CR>
nmap <leader>np call :OxPublish<CR>
```

## Requirements

- `fzf` & `fzf.vim` need to be installed.

## Installation

Using Vim-Plug:

```
Plug 'oxalorg/vim-ox'
```
