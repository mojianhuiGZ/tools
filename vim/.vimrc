set nocompatible    " 必须是第一行

" 插件定义 {
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    Plugin 'gmarik/Vundle.vim'

    Plugin 'altercation/vim-colors-solarized'
    Plugin 'tomasr/molokai'
    Plugin 'klen/python-mode'
    Plugin 'majutsushi/tagbar'
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'Yggdroot/LeaderF'

    call vundle#end()
" }

" 插件配置 {

    let mapleader="\\"

    if !has('gui_running')
        set t_Co=256                    " 使终端支持256色
    endif

	" solarized {
        " 使用:h solarized查看帮助
		let g:solarized_termcolors=256
        let g:solarized_termtrans=0     " 使用终端的透明背景
	" }

    "set background=light                " 背景色(dark或者light)
    "colorscheme molokai                 " 颜色主题(solarized、molokai)

    " pymode {
        " :h pymode
        let g:pymode = 1
        let g:pymode_warnings = 1
        let g:pymode_options = 1
        let g:pymode_python = 'python3'           " python版本(python、python3)
        let g:pymode_indent = 1
        let g:pymode_lint = 1
        let g:pymode_lint_ignore = ["E501"]       " 忽略行长度超过80的错误
        let g:pymode_motion = 0
        let g:pymode_doc = 0
        let g:pymode_virtualenv = 1
        let g:pymode_run = 1
        let g:pymode_run_bind = 'rr'
        let g:pymode_breakpoint = 0
        let g:pymode_rope = 1
        let g:pymode_rope_lookup_project = 1
        let g:pymode_rope_show_doc_bind = ''
        let g:pymode_rope_regenerate_on_write = 0
        let g:pymode_rope_completion = 0
        let g:pymode_rope_complete_on_dot = 0
        let g:pymode_breakpoint = 0
        let g:pymode_rope_autoimport = 1
        let g:pymode_rope_autoimport_modules = ['os', 'shutil', 'datetime']
        let g:pymode_rope_rename_bind = '<leader>r'
        let g:pymode_rope_goto_definition_bind = '<leader>i'
        let g:pymode_rope_goto_definition_cmd = 'new'
        let g:pymode_rope_organize_imports_bind = '<leader>oi'
        let g:pymode_rope_autoimport_bind = '<leader>ai'
        let g:pymode_syntax = 1
        let g:pymode_syntax_all = 1
    " }

    " YouCompleteMe {
        " :h youcompleteme
        let g:ycm_show_diagnostics_ui = 0 " 关闭YCM语法检查
        nmap <leader>r :YcmCompleter GoToReferences<CR>
        nmap <leader>d :YcmCompleter GetDoc<CR>
    " }

    nmap <leader>t :TagbarToggle<CR>

    " LeaderF {
        let g:Lf_ShortcutF = '<leader>f'
        let g:Lf_ShortcutB = '<leader>b'
        let g:Lf_WindowHeight = 0.3
        let g:Lf_WildIgnore = {
            \ 'dir': ['.svn','.git','.hg'],
            \ 'file': ['*.sw?','~$*','*.exe','*.o','*.so','*.py[co]']
            \}
        let g:Lf_MruFileExclude = ['*.so']
	" }
    " }

" }

"　基本配置　{
	filetype plugin indent on                        " 自动根据文件类型加载插件和缩进
	syntax on                                        " 打开语法高亮
	set shortmess=atI                                " 启动时不显示援助索马里儿童的提示
	set mouse=a                                      " 使能鼠标操作
	set mousehide                                    " 按键时隐藏鼠标
	set enc=utf-8                                    " VIM内部字符编码
	set fenc=utf-8                                   " 设置文件的字符编码
	scriptencoding utf-8                             " 设置脚本文件的字符编码
	set fencs=utf-8,gb18030,gbk,gb2312               " 设置打开文件时可识别的字符编码
	"set autowrite                                   " 自动保存文件
	set linespace=1                                  " 行间距，单位像素
	set nu                                           " 显示行号
	set showmatch                                    " 显示匹配的括号
    set incsearch                                    " 渐增式查找
	set hlsearch                                     " 高亮查找结果
	set winminheight=0                               " 窗口可以是零高度，用于标签栏
	"set ignorecase                                   " 大小写不敏感的搜索
	"set smartcase                                    " 如果有大写字母则使用大小写敏感的搜索
	set list                                         " 显示空白符
	set listchars=tab:›\ ,trail:•,extends:#,nbsp:.   " 空白符的显示方法
	set history=1000                                 " 历史记录最大记录个数
	set nobackup                                     " 不备份文件
	set noswapfile                                   " 关闭交换文件
	set tabpagemax=9                                 " 最大标签页个数
	set showmode                                     " 显示当前操作模式
	set cursorline                                   " 高亮光标所在行
	set laststatus=2                                 " 总是显示状态行

    function SwitchColorScheme()
        if g:next_colorscheme == 0
            set background=light
            colorscheme molokai
        elseif g:next_colorscheme == 1
            set background=dark
            colorscheme solarized
        elseif g:next_colorscheme == 2
            set background=light
            colorscheme solarized
        endif
        let g:next_colorscheme = (g:next_colorscheme + 1) % 3
    endfunction
    let g:next_colorscheme = 1
    call SwitchColorScheme()
    nmap cs :call SwitchColorScheme()<CR>

    function SwitchStatusLine()
        if g:next_statusline_mode == 0
            set statusline=%<%f%m%r%h%w\ [%Y]\ [%{getcwd()}]\ [rr\ 运行Python]\ [cs\ 切换颜色方案]\ [%{mapleader}r\ 名称重构]%=(%l,%c)\ %p%%
        elseif g:next_statusline_mode == 1
            set statusline=%<%f%m%r%h%w\ [%Y]\ [%{getcwd()}]\ [%{mapleader}i\ 跳到定义]\ [%{mapleader}oi\ 重排import]\ [%{mapleader}ai\ 补全import]%=(%l,%c)\ %p%%
        elseif g:next_statusline_mode == 2
            set statusline=%<%f%m%r%h%w\ [%Y]\ [%{getcwd()}]\ [%{mapleader}f\ 跳到参考]\ [%{mapleader}d\ 打开文档]%=(%l,%c)\ %p%%
        endif
        let g:next_statusline_mode = (g:next_statusline_mode + 1) % 3
    endfunction
    let g:next_statusline_mode=0
    call SwitchStatusLine()
    nmap <leader>st :call SwitchStatusLine()<CR>

	set nowrap                                       " 不使用多行显示长的行
	set shiftwidth=4                                 " 每次缩进的空白字符数
	set tabstop=4                                    " TAB键显示的空白字符数
	set softtabstop=4                                " 插入时TAB键显示的空白字符数
	set expandtab                                    " 是否展开TAB键为空格
	set splitright                                   " 将水平划分的新窗口放置到右边
	set splitbelow                                   " 将垂直划分的新窗口放置到底部
	set modeline                                     "
    set backspace=indent,eol,start

	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " 不自动为新行插入注释


	" 取消光标后插入
	nmap a A
	" 取消光标前插入新行
	nmap O o
    " 切换粘贴模式
    nmap ps :set paste!<CR>
    " 切换行号
    nmap ln :set nu!<CR>
    " 注释和取消注释
    vmap <leader>/ :s/^\(\s*\)\(.\+\)$/\1#\2/g<CR>
    vmap <silent>? :s/\(\s*\)#\(.*\)/\1\2/g<CR>

" 使用<w+数字>跳转到指定的标签页
    nmap w1 1gt
    nmap w2 2gt
    nmap w3 3gt
    nmap w4 4gt
    nmap w5 5gt
    nmap w6 6gt
    nmap W1 1gt
    nmap W2 2gt
    nmap W3 3gt
    nmap W4 4gt
    nmap W5 5gt
    nmap W6 6gt
"  }
