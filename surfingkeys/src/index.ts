// Surfingkeys configuration
// ---

// References:
// - https://github.com/b0o/surfingkeys-conf

// API: https://github.com/brookhong/Surfingkeys/blob/master/docs/API.md

// import "./providers"
// import "./queries"

import "./keymaps.js"
import "./themes/rose-pine.js"

settings.defaultSearchEngine = 'g';
settings.hintAlign = 'left';
settings.focusFirstCandidate = false;
settings.focusAfterClosed = 'last';
settings.scrollStepSize = 200;
settings.tabsThreshold = 0;
settings.modeAfterYank = 'Normal';
settings.newTabPosition = 'right';
// settings.useNeovim = false;
settings.omnibarPosition = 'middle';
settings.omnibarSuggestion = true
settings.omnibarMaxResults = 25;

settings.hintShiftNonActive = true;

// Disable built-in pdf viewer
// chrome.storage.local.set({ noPdfViewer: 1 })

// api.Hints.setCharacters('asdfgyuiopqwertnmzxcvb');
