" cVim config
" ---

let configpath = '/Users/rafi/.config/cvim/init.vim'
set localconfig

" General settings
" ---
set hud
set noautofocus
set smoothscroll
set typelinkhints
set sortlinkhints

" Interface
" ---
let barposition = 'bottom'
let typelinkhintsdelay = '0'
let hintcharacters = 'fdsawerjkiop'
let searchlimit = 30
let scrollstep = 70
let blacklists = ['http://www.10bis.co.il/*', 'http://localhost/*', 'https://*.google.com/mail/u/0/*']

" Open all of these in a tab with `gnb` or open one of these with <N>goa where <N>
let qmark a = ['http://www.reddit.com/r/learnjavascript/new', 'http://www.reddit.com/r/learnprogramming/new']
let qmark b = ['http://www.reddit.com/', 'https://github.com/', 'https://mail.google.com/mail/u/0/?shva=1#inbox', 'https://news.ycombinator.com/']

" Commands
" ---
command google tabnew google
command github tabnew github
command instapaper tabnew instapaper
command pinboard tabnew pinboard

" Bindings
" ---
let mapleader = '<Space>'
map gb :buffer<Space>
map gr previousTab
map st :tabnew<Space>
map sg :open$<Space>
map sv :open$<Space>

map <C-d> scrollPageDown
map <C-u> scrollPageUp
map <C-h> :set hud!<CR>
map <C-i> :set numerichints!<CR>
map <C-o> goBack
map <C-i> goForward

map ; openCommandBar
map <leader>b :buffer<Space>
map <leader>d :tabnew google define<Space>
map <leader>r :tabnew google reddit<Space>
map <leader>h :history<Space>
map <Leader>l reloadTabUncached
map <Leader>x :restore<Space>
map <leader>g :google<space>
map <leader>i :instapaper<space>
map <leader>p :pinboard<space>


" Displays your public IP address in the status bar
getIP() -> {{
httpRequest({url: 'http://api.ipify.org/?format=json', json: true},
	function(res) { Status.setMessage('IP: ' + res.ip); });
}}
map ci :call getIP<CR>

" Search Engines
" ---
let completionengines = ['pinboard', 'google', 'github', 'imdb', 'wikipedia']

"let searchengine google = 'https://www.google.com/search?q=%s'
let searchengine gmail = 'https://mail.google.com/mail/u/0/#search/%s'

let searchengine instapaper = "https://www.instapaper.com/search?q=%s"

let searchengine pinboard = 'https://pinboard.in/search/u:rafi?query=%s'
let searchengine pinboardTags = 'https://pinboard.in/u:rafi/t:%s'

let searchengine torrentz = 'https://www.torrentz2.eu/search?q=%s'
let searchengine addic7ed = 'https://www.addic7ed.com/search.php?search=%s'

let searchengine wikipedia = 'http://en.wikipedia.org/w/index.php?search=%s&title=Special%3ASearch'

let searchalias mail = 'gmail'
let searchalias maps = 'google-maps'

let searchalias s = 'stackoverflow'
let searchalias paper = 'instapaper'
let searchalias g = 'github'

let searchalias pintag = 'pinboardTags'
let searchalias pin = 'pinboard'

let searchalias wiki = 'Wikipedia'
let searchalias torrent = 'torrentz'
let searchalias sub = 'addic7ed'

" vim: set ts=2 sw=2 tw=80 noet :
