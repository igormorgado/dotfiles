c = get_config()

c.InteractiveShellApp.extensions = ['autoreload']
c.InteractiveShellApp.extensions.append('Cython')
c.InteractiveShellApp.exec_lines = ['%autoreload 2']

c.TerminalIPythonApp.display_banner = False
c.InteractiveShellApp.log_level = 0

c.InteractiveShellApp.exec_lines = [
    'import numpy',
    'import scipy',
    'import pandas',
    'np = numpy',
    'sp = scipy',
    'pd = pandas'
]

c.InteractiveShell.autoindent = True
c.InteractiveShell.colors = 'Linux'
c.InteractiveShell.confirm_exit = False
c.InteractiveShell.deep_reload = True
c.InteractiveShell.editor = 'vim'
c.InteractiveShell.xmode = 'Context'

c.TerminalInteractiveShell.prompts_class.in_template  = 'In [\#]: '
c.TerminalInteractiveShell.prompts_class.in2_template = '   .\D.: '
c.TerminalInteractiveShell.prompts_class.out_template = 'Out[\#]: '
c.TerminalInteractiveShell.prompts_class.justify = True

c.PrefilterManager.multi_line_specials = True

c.AliasManager.user_aliases = [
 ('la', 'ls -al')
]

