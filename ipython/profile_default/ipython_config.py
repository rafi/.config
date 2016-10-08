# IPython: an enhanced interactive Python shell
# ---

import os
from pygments.token import Token

def xdg_get(name, default=None):
    return os.environ.get(name, os.path.join(default))

HOME = os.path.expanduser('~')
XDG_CACHE_HOME = xdg_get('XDG_CACHE_HOME', [HOME, '.cache'])
XDG_CONFIG_HOME = xdg_get('XDG_CONFIG_HOME', [HOME, '.config'])
XDG_DATA_HOME = xdg_get('XDG_DATA_HOME', [HOME, '.local', 'share'])
XDG_RUNTIME_DIR = xdg_get('XDG_RUNTIME_DIR')

#c.InteractiveShellApp.code_to_run = ''

#c.InteractiveShellApp.exec_PYTHONSTARTUP = True

c.InteractiveShellApp.exec_lines = [
    'import sys, logging, json, time',
    'from datetime import datetime, timedelta',
    'from decimal import Decimal',
    'from pprint import pprint as pp',
    'logging.basicConfig(level=logging.DEBUG)',
]

## A list of dotted module names of IPython extensions to load.
#c.InteractiveShellApp.extensions = []

## dotted module name of an IPython extension to load.
#c.InteractiveShellApp.extra_extension = ''

## Should variables loaded at startup (by startup files, exec_lines, etc.) be
#  hidden from tools like %who?
#c.InteractiveShellApp.hide_initial_ns = True

## Path to file to use for SQLite history database.
c.HistoryAccessor.hist_file = \
    os.path.join(XDG_CACHE_HOME, 'ipython_hist.sqlite')

## Write to database every x commands (higher values save disk access & power).
#  Values of 1 or less effectively disable caching.
#c.HistoryManager.db_cache_size = 0

## Should the history database include output? (default: no)
#c.HistoryManager.db_log_output = False

# Application
#------------

## The date format used by logging formatters for %(asctime)s
#c.Application.log_datefmt = '%Y-%m-%d %H:%M:%S'

## The Logging format template
#c.Application.log_format = '[%(name)s]%(highlevel)s %(message)s'

## Set the log level by value or name.
#c.Application.log_level = 30

## Whether to create profile dir if it doesn't exist
#c.BaseIPythonApplication.auto_create = False

## Whether to install the default config files into the profile dir. If a new
#  profile is being created, and IPython contains config files for that profile,
#  then they will be staged into the new directory.  Otherwise, default config
#  files will be automatically generated.
c.BaseIPythonApplication.copy_config_files = True

## Path to an extra config file to load.
#
#  If specified, load this config file in addition to any other IPython config.
#c.BaseIPythonApplication.extra_config_file = ''

## The name of the IPython directory. This directory is used for logging
#  configuration (through profiles), history storage, etc. The default is usually
#  $HOME/.ipython. This option can also be specified through the environment
#  variable IPYTHONDIR.
#c.BaseIPythonApplication.ipython_dir = ''

## Whether to overwrite existing config files when copying
#c.BaseIPythonApplication.overwrite = False

## The IPython profile to use.
#c.BaseIPythonApplication.profile = 'default'

## Create a massive crash report when IPython encounters what may be an internal
#  error.  The default is to append a short message to the usual traceback
#c.BaseIPythonApplication.verbose_crash = False

# TerminalIPythonApp
#-------------------

## Whether to display a banner upon starting IPython.
c.TerminalIPythonApp.display_banner = False

## If a command or file is given via the command-line, e.g. 'ipython foo.py',
#  start an interactive shell after executing the file or command.
#c.TerminalIPythonApp.force_interact = False

## Start IPython quickly by skipping the loading of config files.
#c.TerminalIPythonApp.quick = False

# InteractiveShell
#-----------------

## An enhanced, interactive shell for Python.

## 'all', 'last', 'last_expr' or 'none', specifying which nodes should be run
#  interactively (displaying output from expressions).
#c.InteractiveShell.ast_node_interactivity = 'last_expr'

## A list of ast.NodeTransformer subclass instances, which will be applied to
#  user input before code is run.
#c.InteractiveShell.ast_transformers = []

## Make IPython automatically call any callable object even if you didn't type
#  explicit parentheses. For example, 'str 43' becomes 'str(43)' automatically.
#  The value can be '0' to disable the feature, '1' for 'smart' autocall, where
#  it is not applied if there are no more arguments on the line, and '2' for
#  'full' autocall, where all callable objects are automatically called (even if
#  no arguments are present).
#c.InteractiveShell.autocall = 0

## Autoindent IPython code entered interactively.
#c.InteractiveShell.autoindent = True

## Enable magic commands to be called without the leading %.
#c.InteractiveShell.automagic = True

## The part of the banner to be printed before the profile
#c.InteractiveShell.banner1 = ''

## The part of the banner to be printed after the profile
#c.InteractiveShell.banner2 = ''

## Set the size of the output cache.  The default is 1000, you can change it
#  permanently in your config file.  Setting it to 0 completely disables the
#  caching system, and the minimum value accepted is 20 (if you provide a value
#  less than 20, it is reset to 0 and a warning is issued).  This limit is
#  defined because otherwise you'll spend more time re-flushing a too small cache
#  than working
#c.InteractiveShell.cache_size = 1000

## Use colors for displaying information about objects. Because this information
#  is passed through a pager (like 'less'), and some pagers get confused with
#  color codes, this capability can be turned off.
#c.InteractiveShell.color_info = True

## Set the color scheme (NoColor, Neutral, Linux, or LightBG).
c.InteractiveShell.colors = 'Linux'

#c.InteractiveShell.debug = False

## Don't call post-execute functions that have failed in the past.
#c.InteractiveShell.disable_failing_post_execute = False

## If True, anything that would be passed to the pager will be displayed as
#  regular output instead.
#c.InteractiveShell.display_page = False

## (Provisional API) enables html representation in mime bundles sent to pagers.
#c.InteractiveShell.enable_html_pager = False

## Total length of command history
#c.InteractiveShell.history_length = 10000

## The number of saved history entries to be loaded into the history buffer at
#  startup.
#c.InteractiveShell.history_load_length = 1000

#c.InteractiveShell.object_info_string_level = 0

## Automatically call the pdb debugger after every exception.
#c.InteractiveShell.pdb = False

#c.InteractiveShell.quiet = False
#c.InteractiveShell.separate_in = '\n'
#c.InteractiveShell.separate_out = ''
#c.InteractiveShell.separate_out2 = ''
#c.InteractiveShell.show_rewritten_input = True
#c.InteractiveShell.wildcards_case_sensitive = True
#c.InteractiveShell.xmode = 'Context'

## Enables rich html representation of docstrings. (This requires the docrepr
#  module).
#c.InteractiveShell.sphinxify_docstring = False

# TerminalInteractiveShell
#-------------------------

## Set to confirm when you try to exit IPython with an EOF (Control-D in Unix,
#  Control-Z/Enter in Windows). By typing 'exit' or 'quit', you can force a
#  direct exit without any confirmation.
c.TerminalInteractiveShell.confirm_exit = False

## Options for displaying tab completions, 'column', 'multicolumn', and
#  'readlinelike'. These options are for `prompt_toolkit`, see `prompt_toolkit`
#  documentation for more information.
#c.TerminalInteractiveShell.display_completions = 'multicolumn'

## Shortcut style to use at the prompt. 'vi' or 'emacs'.
c.TerminalInteractiveShell.editing_mode = 'vi'

## Set the editor used by IPython (default to $EDITOR/vi/notepad).
c.TerminalInteractiveShell.editor = 'nvim'

## Highlight matching brackets .
#c.TerminalInteractiveShell.highlight_matching_brackets = True

## The name of a Pygments style to use for syntax highlighting:  trac, manni,
#  paraiso-light, lovelace, bw, default, emacs, pastie, fruity, algol_nu, vs,
#  paraiso-dark, murphy, rrt, tango, perldoc, igor, algol, xcode, borland,
#  colorful, autumn, friendly, vim, monokai, native
c.TerminalInteractiveShell.highlighting_style = 'default'

## Override highlighting format for specific tokens
c.TerminalInteractiveShell.highlighting_style_overrides = {
    Token.Text: '#C6C6C6',
    Token.Keyword: '#B086B0',
    Token.Number: '#D55D5B',
    Token.Operator: '#86AFAF',
    Token.String: '#AFB05A',
    Token.Literal: '#222222',
    Token.Name.Function: '#FFD881',
    Token.Name.Builtin: '#86AFAF',
    Token.Name.Class: '#FFD881',
    Token.Name.Namespace: '#86AFAF',

    Token.MatchingBracket.Cursor: '#D55D5B',
    Token.MatchingBracket.Other: 'bg:#444444 #dda578',
    Token.Prompt: '#B086B0',
    Token.PromptNum: '#FFD881',
    Token.OutPrompt: '#86AFAF',
    Token.OutPromptNum: '#dda578',

    Token.Menu.Completions.Completion.Current: 'bg:#ffffff #000000',
    Token.Menu.Completions.Completion: 'bg:#333333 #888888',
    Token.Menu.Completions.ProgressButton: 'bg:#333333',
    Token.Menu.Completions.ProgressBar: 'bg:#aaaaaa',

}

## Enable mouse support in the prompt
#c.TerminalInteractiveShell.mouse_support = False

## Use `raw_input` for the REPL, without completion, multiline input, and prompt
#  colors.
#
#  Useful when controlling IPython as a subprocess, and piping STDIN/OUT/ERR.
#  Known usage are: IPython own testing machinery, and emacs inferior-shell
#  integration through elpy.
#
#  This mode default to `True` if the `IPY_TEST_SIMPLE_PROMPT` environment
#  variable is set, or the current terminal is not a tty.
#c.TerminalInteractiveShell.simple_prompt = False

## Number of line at the bottom of the screen to reserve for the completion menu
#c.TerminalInteractiveShell.space_for_menu = 6

## Automatically set the terminal title
#c.TerminalInteractiveShell.term_title = True

## Use 24bit colors instead of 256 colors in prompt highlighting. If your
#  terminal supports true color, the following command should print 'TRUECOLOR'
#  in orange: printf "\x1b[38;2;255;100;0mTRUECOLOR\x1b[0m\n"
#c.TerminalInteractiveShell.true_color = False

#  vim: set ts=4 sw=4 tw=80 et :
