// SurfingKeys key-mappings
// ---

const { map, mapkey, unmap, iunmap, RUNTIME } = api;

map('F', 'gf'); unmap('gf'); // Open a link in non-active new tab
// map('F', 'gf'); unmap('gf'); // Open a link in non-active new tab
map('H', 'S');  unmap('S');  // Go back in history
map('L', 'D');  unmap('D');  // Go forward in history

map(';;', ':');

// Tabs
map('gl', '<Ctrl-6>'); // Goto last tab
map('st', 'on'); unmap('on');
map('gt', 'R');  unmap('R');
map('gT', 'E');  unmap('E');

// Dictionary
map('q', 'Q');

map('cp', '<Alt-p>'); unmap('<Alt-p>'); // Toggle pin
map('cm', '<Alt-m>'); unmap('<Alt-m>'); // Toggle mute

// Move tabs with one press
map('>', '>>');
map('<', '<<');

// map('o', 'go');  // Open a URL in current tab
// map('O', ';U');  // Edit current URL, and open in same tab

// map('<Meta-j>', 'gt'); // Move tab right
mapkey('<Meta-k>', 'Previous Tab', function() {
	RUNTIME('nextTab');
})

// Next/Prev Page
map('K', '[[');
map('J', ']]');

map('p', 'cc'); unmap('cc') // Open clipboard URL in current tab
mapkey('P', 'Open clipboard URL in new tab', () => {
	api.Clipboard.read((response) => { window.location.href = response.data })
});

// Proxy Stuff
unmap(';pa');
unmap(';pb');
unmap(';pc');
unmap(';pd');
unmap(';ps');
unmap(';cp');
unmap(';ap');

// Disable mappings
unmap(';pf'); // yf?
unmap(';ph');
unmap(';pj');
unmap(';dh');
unmap('<Ctrl-e>');
unmap('<Ctrl-i>');
unmap('ga');
unmap('gc');
unmap('gr');
unmap('oe');
unmap('og');
unmap('oy');

// Disable vim (use firenvim)
unmap('<Ctrl-Alt-i>');
unmap(';v');
iunmap('<Ctrl-i>');
iunmap('<Ctrl-Alt-i>');

// Disable mappings in sites
// ---

const importantKeys = [
	'gg', 'gt', 'gT', 'G', 'd', 'u',
	'F', 'f', 'i', 'n', 'N', 'on', 'r',
	'H', 'L', 'J', 'K',
	'ya', 'yf', 'yp', 'yq', 'ys', 'yt', 'yv', 'yy',
	'<', '>', '<<', '>>', '<Meta-k>',
	// ',', '.',
	// '/', '?',
]

// GitHub https://docs.github.com/en/get-started/accessibility/keyboard-shortcuts
// GitLab https://docs.gitlab.com/ee/user/shortcuts.html
let gitSiteKeys = [
	'x', 'i',
	'j', 'k',
	'e', 'w',
]
gitSiteKeys = gitSiteKeys.concat(importantKeys)

// Gmail https://support.google.com/mail/answer/6594
// 'x', 'j', 'k' - reserved for gmail select.
let googleKeys = [
	'w',
]
googleKeys = googleKeys.concat(importantKeys)

// Atlassian
let atlassianKeys = [
	'w', 'j', 'k',
]
atlassianKeys = atlassianKeys.concat(importantKeys)

// https://www.tradingview.com/charting-library-docs/latest/getting_started/Shortcuts
let tradingViewKeys = [
	'h', 'j', 'k', 'l',
	'f', 'd',
	'u', 'v', 'i', '*',
]

api.unmapAllExcept(gitSiteKeys, /git(lab|hub)\.com/);
api.unmapAllExcept(gitSiteKeys, /git(lab|hub)\.com/);
api.unmapAllExcept(googleKeys, /(mail|docs|drive)\.google\.com/);
api.unmapAllExcept(atlassianKeys, /.*\.atlassian.net/);
api.unmapAllExcept(tradingViewKeys, /www\.tradingview\.com/);

// Modals
// ---

// Doesn't work?
mapkey('<C-y>', 'List all tabs addresses', function() {
	RUNTIME('getTabs', null, function (response) {
		const extension = 'chrome-extension://';
		const theGreatSuspender = 'klbibkeccnjlkjkiokjodocebajanakg';
		const list = [window.location.href].concat(response.tabs.map(tab => {
			if (tab.url.includes(`${extension}${theGreatSuspender}`)) {
				return new URLSearchParams(tab.url).get('uri');
			} else {
				return tab.url;
			}
		}));
		api.Front.showPopup(`<p>${list.length} tabs</p>
			<textarea rows=25 style="width: 100%">${list.join('\n')}</textarea>`);
	});
});
