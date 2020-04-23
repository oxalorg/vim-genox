# vim-ox

This is currently work in progress. It will not work on your system.

## OxBlog

Quick mapping for editing existing blog entries on my blog:
[oxal.org](https://oxal.org/blog/)

A shortcut to create a new blog post from within FZF popup.

Write a filename and Press `ctrl-o` to create a new post (a `.md` extension
will automatically be added) in the blog directory.

Default Mapping is

```
nmap <leader>nn call :OxBlog<CR>
```

## Requirements

- `fzf` & `fzf.vim` need to be installed.

## Installation

Using Vim-Plug:

```
Plug 'oxalorg/vim-ox'
```
