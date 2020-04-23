# vim-ox

A vim plugin for automating my blogging workflow. This can also be used as a
plugin for the static site generator:
[oxalorg/genox](https://github.com/oxalorg/genox/)

Read my blog post about it here: https://oxal.org/blog/wip-my-first-vim-plugin/

This is currently work in progress. It will not work on your system yet.

## Operations

### Edit existing blog posts

From any vim session anywhere in the system, simply type `:OxBlog`

This will open up an FZF window of all blog posts. Search and click enter to
open it in a buffer.

### Creating new blog posts

From any vim session anywhere, simply type `:OxBlog`

This will open up an FZF window where you can type any name and press `ctrl+o`,
which will create a new blog post in the appropriate directory.

Then with `UltiSnips` configured you can quickly fill the yaml metadata.

*(Check my dotfiles: [oxalorg/dotfiles](https://github.com/oxalorg/dotfiles/))*

### Publish Changes

From any blog open in vim, simply call `:OxPublish` the site will rebuild and changes will be deployed live.

### Delete a blog post

Delete / Unpublish the currently open blog post. To do that run `:OxDelete`

## Default Mappings are

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
