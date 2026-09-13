// Original: https://github.com/wthueb/surfingkeys-cfg/blob/main/src/surfingkeys.d.ts
type Keys = string;
type VimModes = "normal" | "insert" | "visual";
type AceKeymap =
| { keys: Keys; type: "keyToKey"; toKeys: Keys; context?: VimModes }
| {
	keys: Keys;
	type: "action";
	action: string;
	context?: VimModes;
	isEdit?: boolean;
	actionArgs?: object;
};

declare const api: {
	mapkey: (
		keys: Keys,
		annotation: string,
		jscode: (() => void) | ((key: string) => void),
		options?: { domain?: RegExp; repeatIgnore?: boolean }
	) => void;
	vmapkey: (
		keys: Keys,
		annotation: string,
		jscode: (() => void) | ((key: string) => void),
		options?: { domain?: RegExp; repeatIgnore?: boolean }
	) => void;
	imapkey: (
		keys: Keys,
		annotation: string,
		jscode: (() => void) | ((key: string) => void),
		options?: { domain?: RegExp; repeatIgnore?: boolean }
	) => void;
	map: (
		newKeystroke: Keys,
		oldKeystroke: Keys,
		domain?: RegExp,
		newAnnotation?: string
	) => void;
	unmap: (keystroke: Keys, domain?: RegExp) => void;
	unmapAllExcept: (keystrokes: Keys[], domain?: RegExp) => void;
	imap: (
		newKeystroke: Keys,
		oldKeystroke: Keys,
		domain?: RegExp,
		newAnnotation?: string
	) => void;
	iunmap: (keystroke: Keys, domain?: RegExp) => void;
	cmap: (
		newKeystroke: Keys,
		oldKeystroke: Keys,
		domain?: RegExp,
		newAnnotation?: string
	) => void;
	vmap: (
		newKeystroke: Keys,
		oldKeystroke: Keys,
		domain?: RegExp,
		newAnnotation?: string
	) => void;
	vunmap: (keystroke: Keys, domain?: RegExp) => void;
	lmap: (
		newKeystroke: Keys,
		oldKeystroke: Keys,
		domain?: RegExp,
		newAnnotation?: string
	) => void;
	aceVimMap: (lhs: Keys, rhs: Keys, ctx: VimModes) => void;
	addVimMapKey: (...objects: AceKeymap) => void;
	addSearchAlias: (
		alias: string,
		prompt: string,
		searchUrl: string,
		searchLeaderKey: Keys = "s",
		suggestionUrl?: string,
		callbackToParseSuggestion?: (
			response: { text: string },
			request: { query: string; url: string }
		) => void,
		onlyThisSiteKey: Keys = "o",
		options?: { faviconUrl: string; skipMaps: boolean }
	) => void;
	removeSearchAlias: (
		alias: string,
		searchLeaderKey: Keys = "s",
		onlyThisSiteKey: Keys = "o"
	) => void;
	searchSelectedWith: (
		se: string,
		onlyThisSite: boolean = false,
		interactive: boolean = false,
		alias: string = ""
	) => void;
	Clipboard: {
		read: (onReady: (response: string) => void) => void;
		write: (text: string) => void;
	};
	Hints: {
		setNumeric: () => void;
		setCharacters: (characters: string) => void;
		click: (links: string | HTMLElement[], force: boolean = false) => void;
		create: (
			cssSelector: string | HTMLElement[],
			onHintKey: (element: HTMLElement) => void,
			attrs?: { active?: boolean; tabbed?: boolean; multipleHits?: boolean }
		) => boolean;
		dispatchMouseClick: (element: HTMLElement) => void;
		style: (css: string, mode?: "text") => void;
	};
	Normal: {
		passThrough: (timeout?: number) => void;
		scroll: (
			type:
			| "down"
			| "up"
			| "pageDown"
			| "fullPageDown"
			| "pageUp"
			| "fullPageUp"
			| "top"
			| "bottom"
			| "left"
			| "right"
			| "leftmost"
			| "rightmost"
			| "byRatio"
		) => void;
		feedkeys: (keys: Keys) => void;
		jumpVIMark: (mark: string) => void;
	};
	Visual: {
		style: (element: "marks" | "cursor", style: string) => void;
	};
	Front: {
		showEditor: (
			element: HTMLElement | string,
			onWrite?: (data: string) => void,
			type?: string,
			useNeovim: boolean = false
		) => void;
		openOmnibar: (
			args: {
				type:
				| "Bookmarks"
				| "AddBookmark"
				| "History"
				| "URLs"
				| "RecentlyClosed"
				| "TabURLs"
				| "Tabs"
				| "Windows"
				| "VIMarks"
				| "SearchEngine"
				| "Commands"
				| "OmniQuery"
				| "UserURLs";
				tabbed?: boolean;
			},
			extra?: any
		) => void;
		registerInlineQuery: (args: {
			url: string | (() => string);
			parseResult: (result: any) => string;
			headers?: object;
		}) => void;
		getBrowserName: () => "Chrome" | "Firefox" | "Safari";
		showBanner: (msg: string, timeout: number = 1600) => void;
		showPopup: (msg: string) => void;
	};
	isElementPartiallyInViewport: (
		el: Element,
		ignoreSize: boolean = false
	) => boolean;
	getClickableElements: (selectorString: string, pattern: RegExp) => Element[];
	tabOpenLink: (str: string, simultaneousness: number = 5) => void;
	insertJS: (code: (() => void) | string, onload: () => void) => void;
	RUNTIME: (
		action: string,
		args?: object,
		callback?: (result: any) => void
	) => void;
};

declare const settings: {
	showModeStatus: boolean = false;
showProxyInStatusBar: boolean = false;
richHintsForKeystroke: number = 500;
useLocalMarkdownAPI: boolean = true;
focusOnSaved: boolean = true;
omnibarMaxResults: number = 10;
omnibarHistoryCacheSize: number = 100;
omnibarPosition: "middle" | "bottom" = "middle";
omnibarSuggestion: boolean = false;
omnibarSuggestionTimeout: number = 200;
focusFirstCandidate: boolean = false;
tabsThreshold: number = 100;
clickableSelector: string = "";
clickablePat: RegExp = new RegExp("/(https?|thunder|magnet)://S+/ig");
editableSelector: string = "div.CodeMirror-scroll,div.ace_content";
smoothScroll: boolean = true;
modeAfterYank: "" | "Caret" | "Normal" = "";
scrollStepSize: number = 70;
scrollFriction: number = 0;
nextLinkRegex: RegExp = /((>>|next)+)/i;
prevLinkRegex: RegExp = /((<<|prev(ious)?)+)/i;
hintAlign: "left" | "center" | "right" = "center";
hintExplicit: boolean = false;
hintShiftNonActive: boolean = false;
defaultSearchEngine: string = "g";
blocklistPattern: RegExp = undefined;
focusAfterClosed: "left" | "right" | "last" = "right";
repeatThreshold: number = 99;
tabsMRUOrder: boolean = true;
historyMUOrder: boolean = true;
newTabPosition: "left" | "right" | "first" | "last" | "default" = "default";
interceptedErrors: string[] = [];
enableEmojiInsertion: boolean = false;
startToShowEmoji: number = 2;
language: string = undefined;
stealFocusOnLoad: boolean = true;
enableAutoFocus: boolean = true;
theme: string = undefined;
caseSensitive: boolean = false;
smartCase: boolean = true;
cursorAtEndOfInput: boolean = true;
digitForRepeat: boolean = true;
editableBodyCare: boolean = true;
ignoredFrameHosts: string[] = ["https://tpc.googlesyndication.com"];
aceKeybindings: "vim" | "emacs" = "vim";
caretViewport: [number, number, number, number] = null;
mouseSelectToQuery: any[] = [];
autoSpeakOnInlineQuery: boolean = false;
};
