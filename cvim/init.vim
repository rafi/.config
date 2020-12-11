" cVim config
" ---

"let configpath = '/Users/rafi/.config/cvim/init.vim'
"set localconfig

" General settings
" ---
set nohud
set noautofocus
set smoothscroll
set typelinkhints
set sortlinkhints

set linkanimations
set cncpcompletion

" Interface
" ---
let barposition = 'bottom'
let typelinkhintsdelay = '0'
let hintcharacters = 'fdsawerjkiop'
let searchlimit = 30
let scrollstep = 70
let blacklists = ["http://play.golang.org/*","https://groups.google.com/*","http://jenkins/*"]

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
map st :tabnew
map sg :open$<Space>
map sv :open$<Space>
map D :duplicate&<CR>

map <C-d> scrollPageDown
map <C-u> scrollPageUp
map <C-h> :set hud!<CR>
map <C-i> :set numerichints!<CR>
" map <C-o> goBack
" map <C-i> goForward

imap <C-w> deleteWord

map <C-n> nextTab
map <C-p> previousTab

" map ; openCommandBar
map <leader>b :buffer<Space>
map <leader>d :tabnew google define<Space>

" map <leader>r :tabnew google reddit<Space>
map <leader>h :history<Space>
map <Leader>l reloadTabUncached
map <Leader>x :restore<Space>
map <leader>g :google<space>
map <leader>i :instapaper<space>
map <leader>p :pinboard<space>

" Create a variable that can be used/referenced in the command bar
let @@reddit_prog = 'http://www.reddit.com/r/programming'
let @@top_all = 'top?sort=top&t=all'
let @@top_day = 'top?sort=top&t=day'

" TA binding opens 'http://www.reddit.com/r/programming/top?sort=top&t=all' in a new tab
map TA :tabnew @@reddit_prog/@@top_all<CR>
map TD :tabnew @@reddit_prog/@@top_day<CR>

" Displays your public IP address in the status bar
getIP() -> {{
httpRequest({url: 'http://api.ipify.org/?format=json', json: true},
	function(res) { Status.setMessage('IP: ' + res.ip); });
}}
map ci :call getIP<CR>

" Script hints
echo(link) -> {{
	alert(link.href);
}}
map <C-f> createScriptHint(echo)

" Find next search occurrence and center it on screen
map n :call nextSearchResultToCenter<CR>
nextSearchResultToCenter -> {{
	Mappings.actions.nextSearchResult(1);
	Mappings.actions.centerMatchH();
}}

" Find previous search occurrence and center it on screen
map N :call previousSearchResultToCenter<CR>
previousSearchResultToCenter -> {{
	Mappings.actions.previousSearchResult(1);
	Mappings.actions.centerMatchH();
}}

" Reload local cVim configuration
map <Leader>r :call sourceLocalFile<CR>
sourceLocalFile -> {{
	RUNTIME('loadLocalConfig');
	Status.setMessage('Source is done', 1);
	//HUD.display(' -- DONE -- ', 1);
}}

" Search Engines
" ---
let completionengines = ['pinboard', 'google', 'github', 'imdb', 'wikipedia', 'duckduckgo']

"let searchengine google = 'https://www.google.com/search?q=%s'
let searchengine gmail = 'https://mail.google.com/mail/u/0/#search/%s'
let searchengine git = "https://github.com/search?q=%s"

let searchengine instapaper = "https://www.instapaper.com/search?q=%s"

let searchengine pinboard = 'https://pinboard.in/search/u:rafi?query=%s'
let searchengine pinboardTags = 'https://pinboard.in/u:rafi/t:%s'

let searchengine torrentz = 'https://www.torrentz2.eu/search?q=%s'
let searchengine addic7ed = 'https://www.addic7ed.com/search.php?search=%s'

let searchengine wikipedia = 'http://en.wikipedia.org/w/index.php?search=%s&title=Special%3ASearch'
let searchengine piratebay = "http://thepiratebay.org/search/%s"

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

site "https://feedly.com/*" {
	unmapAll
	iunmapAll
	map <C-p> previousTab
	map <C-n> nextTab
	map f createHint
	map F createTabbedHint
	map : openCommandBar
	map t :tabnew<Space>
	map d closeTab
	map r reloadTab
	map gp pinTab
}

site "https://mail.google.com/*" {
	unmapAll
	iunmapAll
	map <C-p> previousTab
	map <C-n> nextTab
	map f createHint
	map F createTabbedHint
	map : openCommandBar
	map t :tabnew<Space>
	map d closeTab
	map r reloadTab
	map gp pinTab
}
