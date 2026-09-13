// Themes
// ---

// api.Hints.style('font-size: 13pt; font-weight: normal;');
// api.Hints.style('font-size: 13pt; font-weight: normal;', "text");

settings.theme = `
/* Edit these variables for easy theme making */
:root {
	/* Font */
	/* --font: 'Source Code Pro', Ubuntu, sans; */
	--font: 'Source Code Pro', 'Input Sans Condensed', Charcoal, sans-serif;
	--font-size: 17px;
	--font-size-search: 23px;
	--font-size-status: 24px;
	--font-size-find: 21px;
	--font-weight: normal;

	/* -------------- */
	/* --- THEMES --- */
	/* -------------- */

	/* -------------------- */
	/* -- Tomorrow Night -- */
	/* -------------------- */
	// --fg: #C5C8C6;
	// --bg: #282A2E;
	// --bg-dark: #1D1F21;
	// --border: #373b41;
	// --main-fg: #81A2BE;
	// --accent-fg: #52C196;
	// --info-fg: #AC7BBA;
	// --select: #585858;

	/* Unused Alternate Colors */
	/* --cyan: #4CB3BC; */
	/* --orange: #DE935F; */
	/* --red: #CC6666; */
	/* --yellow: #CBCA77; */

	/* -------------------- */
	/* --      NORD      -- */
	/* -------------------- */
	--fg: #E5E9F0;
	--bg: #3B4252;
	--bg-dark: #2E3440;
	--border: #4C566A;
	--main-fg: #88C0D0;
	--accent-fg: #A3BE8C;
	--info-fg: #5E81AC;
	--select: #4C566A;

	/* Unused Alternate Colors */
	/* --orange: #D08770; */
	/* --red: #BF616A; */
	/* --yellow: #EBCB8B; */

	/* -------------------- */
	/* --    DOOM ONE    -- */
	/* -------------------- */
	// --fg: #51AFEF;
	// --bg: #2E3440;
	// --bg-dark: #21242B;
	// --border: #2257A0;
	// --main-fg: #51AFEF;
	// --accent-fg: #98be65;
	// --info-fg: #C678DD;
	// --select: #4C566A;

	/* Unused Alternate Colors */
	/* --border-alt: #282C34; */
	/* --cyan: #46D9FF; */
	/* --orange: #DA8548; */
	/* --red: #FF6C6B; */
	/* --yellow: #ECBE7B; */

	/* -------------------- */
	/* --    MONOKAI    -- */
	/* -------------------- */
	// --fg: #F8F8F2;
	// --bg: #272822;
	// --bg-dark: #1D1E19;
	// --border: #2D2E2E;
	// --main-fg: #F92660;
	// --accent-fg: #E6DB74;
	// --info-fg: #A6E22E;
	// --select: #556172;

	/* Unused Alternate Colors */
	/* --red: #E74C3C; */
	/* --orange: #FD971F; */
	/* --blue: #268BD2; */
	/* --violet: #9C91E4; */
	/* --cyan: #66D9EF; */
}

/* ---------- Generic ---------- */
.sk_theme {
background: var(--bg);
color: var(--fg);
	background-color: var(--bg);
	border-color: var(--border);
	font-family: var(--font);
	font-size: var(--font-size);
	font-weight: var(--font-weight);
}

input {
	font-family: var(--font);
	font-weight: var(--font-weight);
}

.sk_theme tbody {
	color: var(--fg);
}

.sk_theme input {
	color: var(--fg);
}

/* Hints */
#sk_hints .begin {
	color: var(--accent-fg) !important;
}

#sk_tabs .sk_tab {
	background: var(--bg-dark);
	border: 1px solid var(--border);
}

#sk_tabs .sk_tab_title {
	color: var(--fg);
}

#sk_tabs .sk_tab_url {
	color: var(--main-fg);
}

#sk_tabs .sk_tab_hint {
	background: var(--bg);
	border: 1px solid var(--border);
	color: var(--accent-fg);
}

.sk_theme #sk_frame {
	background: var(--bg);
	opacity: 0.2;
	color: var(--accent-fg);
}

/* ---------- Omnibar ---------- */
.sk_theme#sk_omnibar {
	bottom: 20px;
}

.sk_theme .title {
	color: var(--accent-fg);
}

.sk_theme .url {
	color: var(--main-fg);
}

.sk_theme .annotation {
	color: var(--accent-fg);
}

.sk_theme .omnibar_highlight {
	color: var(--accent-fg);
}

.sk_theme .omnibar_timestamp {
	color: var(--info-fg);
}

.sk_theme .omnibar_visitcount {
	color: var(--accent-fg);
}

.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
	background: var(--bg-dark);
}

.sk_theme #sk_omnibarSearchResult ul li.focused {
	background: var(--border);
}

.sk_theme #sk_omnibarSearchResult ul li div.url {
	font-weight: normal;
}

.sk_theme #sk_omnibarSearchArea {
	border-top-color: var(--border);
	border-bottom-color: var(--border);
}

.sk_theme #sk_omnibarSearchArea input,
.sk_theme #sk_omnibarSearchArea span {
	font-size: var(--font-size-search);
}

.sk_theme .separator {
	color: var(--accent-fg);
}

/* ---------- Popup Notification Banner ---------- */
#sk_banner {
	font-family: var(--font);
	font-size: var(--font-size);
	font-weight: var(--font-weight);
	background: var(--bg);
	border-color: var(--border);
	color: var(--fg);
	opacity: 0.9;
}

/* ---------- Popup Keys ---------- */
#sk_keystroke {
	background-color: var(--bg);
}

.sk_theme kbd .candidates {
	color: var(--info-fg);
}

.sk_theme span.annotation {
	color: var(--accent-fg);
}

/* ---------- Popup Translation Bubble ---------- */
#sk_bubble {
	background-color: var(--bg) !important;
	color: var(--fg) !important;
	border-color: var(--border) !important;
}

#sk_bubble * {
	color: var(--fg) !important;
}

#sk_bubble div.sk_arrow div:nth-of-type(1) {
	border-top-color: var(--border) !important;
	border-bottom-color: var(--border) !important;
}

#sk_bubble div.sk_arrow div:nth-of-type(2) {
	border-top-color: var(--bg) !important;
	border-bottom-color: var(--bg) !important;
}

/* ---------- Search ---------- */
#sk_status {
	font-size: var(--font-size-status);
	border-color: var(--border);
}
#sk_find {
	font-size: var(--font-size-find);
	border-color: var(--border);
}

.sk_theme kbd {
	background: var(--bg-dark);
	border-color: var(--border);
	box-shadow: none;
	color: var(--fg);
}

.sk_theme .feature_name span {
	color: var(--main-fg);
}

/* ---------- ACE Editor ---------- */
#sk_editor {
	background: var(--bg-dark) !important;
	height: 50% !important;
	/* Remove this to restore the default editor size */
}

.ace_dialog-bottom {
	border-top: 1px solid var(--bg) !important;
}

.ace-chrome .ace_print-margin,
.ace_gutter,
.ace_gutter-cell,
.ace_dialog {
	background: var(--bg) !important;
}

.ace-chrome {
	color: var(--fg) !important;
}

.ace_gutter,
.ace_dialog {
	color: var(--fg) !important;
}

.ace_cursor {
	color: var(--fg) !important;
}

.normal-mode .ace_cursor {
	background-color: var(--fg) !important;
	border: var(--fg) !important;
	opacity: 0.7 !important;
}

.ace_marker-layer .ace_selection {
	background: var(--select) !important;
}

.ace_editor,
.ace_dialog span,
.ace_dialog input {
	font-family: var(--font);
	font-size: var(--font-size);
	font-weight: var(--font-weight);
}
`;
