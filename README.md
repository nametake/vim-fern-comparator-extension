# vim-fern-comparator-extension

[![fern plugin](https://img.shields.io/badge/🌿%20fern-plugin-yellowgreen)](https://github.com/lambdalisue/fern.vim)

| Before | After |
| --- | --- |
| ![before](https://github.com/nametake/vim-fern-comparator-extension/assets/4082108/fa8fb36b-3e63-4a88-b8cf-0ae58b7b9c28) | ![after](https://github.com/nametake/vim-fern-comparator-extension/assets/4082108/373592c1-15cd-429a-9994-9c37961402de) |

## Usage

```vim
Plug 'nametake/vim-fern-comparator-extension'
let g:fern#comparator = 'extension'
```

## Options

```vim
" disable compare extension. default: 0
let g:fern_comparator_extension#disable_compare_extension = 1
" Grouping go test files. default: 0
let g:fern_comparator_extension#enable_go_test_grouping = 1 " default: 0
```
