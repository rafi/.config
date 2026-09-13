// Search Engines
// ---

import imdb from "./providers/imdb";
import github from "./providers/github";
import google from "./providers/google";
import wikipedia from "./providers/wikipedia";
import youtube from "./providers/youtube";

api.unmap('sG');
api.unmap('sg');
// removeSearchAlias('h', 's');
// removeSearchAlias('s', 's');
api.removeSearchAlias('e');
api.removeSearchAlias('y');
api.removeSearchAlias('s');
api.removeSearchAlias('g');
api.removeSearchAlias('b');
api.removeSearchAlias('d');
api.removeSearchAlias('w');

api.addSearchAlias(
	"g",
	"google",
	google.searchUrl,
	"s",
	google.compUrl,
	google.compFn,
	"o",
	{ faviconUrl: google.faviconUrl, skipMaps: true }
);

api.addSearchAlias(
	"y",
	"youtube",
	youtube.searchUrl,
	"s",
	youtube.compUrl,
	youtube.compFn,
	"o",
	{ faviconUrl: youtube.faviconUrl, skipMaps: true }
);

api.addSearchAlias(
	"wiki",
	"wikipedia",
	wikipedia.searchUrl,
	"s",
	wikipedia.compUrl,
	wikipedia.compFn,
	"o",
	{ faviconUrl: wikipedia.faviconUrl, skipMaps: true }
);

api.addSearchAlias(
	"gh",
	"github",
	github.searchUrl,
	"s",
	github.compUrl,
	github.compFn,
	"o",
	{ faviconUrl: github.faviconUrl, skipMaps: true }
);

api.addSearchAlias(
	"i",
	"imdb",
	imdb.searchUrl,
	"s",
	imdb.compUrl,
	imdb.compFn,
	"o",
	{ faviconUrl: imdb.faviconUrl, skipMaps: true }
);

api.addSearchAlias(
	'p',
	'Pinboard',
	'https://pinboard.in/search/u:rafi?query=',
	's',
	null,
	null,
	'o',
	{ faviconUrl: 'https://pinboard.in/favicon.ico', skipMaps: true}
);
// api.addSearchAlias('ama', 'amazon', 'https://www.amazon.com/s?k=', 's');
// api.addSearchAlias('ap', 'arch pkg', 'https://www.archlinux.org/packages/?sort=&q=', 's');
// api.addSearchAlias('aur', 'aur', 'https://aur.archlinux.org/packages/?O=0&SeB=nd&K=', 's');
// api.addSearchAlias('aw', 'arch wiki', 'https://wiki.archlinux.org/index.php?title=Special:Search&search=', 's');
// api.addSearchAlias('dh', 'docker', 'https://hub.docker.com/search?type=image&q=', 's');
// api.addSearchAlias('r', 'reddit', 'https://libreddit.spike.codes/r/', 's');

// api.addSearchAlias(
//   'ut',
//   'Github Topics',
//   'https://github.com/search?q={0}&type=topics',
//   's',
// );
// api.addSearchAlias(
//   'ur',
//   'Github Repos',
//   'https://github.com/search?q={0}&type=repositories',
//   's',
// );
// api.addSearchAlias(
//   'ut',
//   'Github Topics',
//   'https://github.com/search?q={0}&type=topics',
//   's',
// );
// api.addSearchAlias(
//   'ia',
//   'Internet Archive',
//   'https://archive.org/search.php?query=',
//   's',
// );
// api.addSearchAlias(
//   'gg',
//   'Google',
//   'https://www.google.com/search?q=',
//   's',
//   'https://www.google.com/complete/search?client=chrome-omni&gs_ri=chrome-ext&oit=1&cp=1&pgcl=7&q=',
//   googleSuggestion,
// );
// api.addSearchAlias(
//   'gi',
//   'Google Images',
//   'https://www.google.com/search?q={0}&tbm=isch',
//   's',
//   'https://www.google.com/complete/search?client=chrome-omni&gs_ri=chrome-ext&oit=1&cp=1&pgcl=7&q=',
//   googleSuggestion,
// );
// api.addSearchAlias(
//   'dd',
//   'MDN Docs',
//   'https://developer.mozilla.org/en-US/search?q=',
//   's',
//   'https://www.google.com/complete/search?client=chrome-omni&gs_ri=chrome-ext&oit=1&cp=1&pgcl=7&q=',
//   googleSuggestion,
// );
// api.addSearchAlias(
//   'dg',
//   'Google Developer',
//   'https://www.google.com/search?q=site%3Adeveloper.chrome.com+',
//   's',
// );
// api.addSearchAlias(
//   'dnd',
//   'Node Docs',
//   'https://www.google.com/search?q=site%3Anodejs.org+',
//   's',
// );
// api.addSearchAlias(
//   'a',
//   'Ansible Docs',
//   'https://www.google.com/search?q=site%3Adocs.ansible.com/ansible/latest+',
//   's',
// );
// api.addSearchAlias(
//   'dt',
//   'TS Docs',
//   'https://www.google.com/search?q=site%3Awww.typescriptlang.org+',
//   's',
// );
// api.addSearchAlias(
//   'dma',
//   'Man Pages',
//   'https://man.archlinux.org/search?q={0}&go=Go',
//   's',
// );
// api.addSearchAlias(
//   'c',
//   'Cambridge Dicitonary',
//   'https://dictionary.cambridge.org/dictionary/english/',
//   's',
// );
// api.addSearchAlias(
//   'wd',
//   'Wiktionary',
//   'https://en.wiktionary.org/w/index.php?search=',
//   's',
// );
// api.addSearchAlias('sc', 'searchcode', 'https://searchcode.com/?q=', 's');
// api.addSearchAlias(
//   'n',
//   'Google Dictionary',
//   'https://www.google.com/search?q={0}%20meaning',
//   's',
// );
// api.addSearchAlias(
//   'di',
//   'Google Dicitonary',
//   'https://www.google.com/search?q=meaning%20',
//   's',
// );
// api.addSearchAlias(
//   'yp',
//   'Youtube playlist',
//   'https://www.youtube.com/results?search_query={0}&sp=EgIQAw%253D%253D',
//   's',
// );
// api.addSearchAlias(
//   'yc',
//   'Youtube channel',
//   'https://www.youtube.com/results?search_query={0}&sp=EgIQAg%253D%253D',
//   's',
// );
// api.addSearchAlias(
//   'yd',
//   'Youtube sorted by date',
//   'https://www.youtube.com/results?search_query={0}&sp=CAI%253D',
//   's',
// );
// api.addSearchAlias(
//   'ys',
//   'Youtube',
//   'https://www.youtube.com/results?search_query=',
//   's',
//   'https://clients1.google.com/complete/search?client=youtube&ds=yt&callback=cb&q=',
//   handleYoutubeSuggestions,
// );
// api.addSearchAlias(
//   'yt',
//   'Youtube',
//   'https://www.youtube.com/hashtag/',
//   's',
//   'https://clients1.google.com/complete/search?client=youtube&ds=yt&callback=cb&q=',
//   handleYoutubeSuggestions,
// );
// api.addSearchAlias(
//   'py',
//   'Python Docs',
//   'https://docs.python.org/3/search.html?q={0}&check_keywords=yes&area=default',
//   's',
// );
// api.addSearchAlias(
//   '..',
//   'Same Site Search',
//   'https://www.google.com/search?q=site%3a' + location.host + '+',
//   's',
// );
// api.addSearchAlias(
//   '.h',
//   'Same HREF Search',
//   'https://www.google.com/search?q=site%3a' + location.href + '+',
//   's',
// );
// api.addSearchAlias(
//   '.m',
//   'Same Site Search Last Month',
//   'https://www.google.com/search?q=site%3a' + location.host + '+{0}&tbs=qdr:m',
//   's',
// );
// api.addSearchAlias(
//   '.y',
//   'Same Site Search Last Year',
//   'https://www.google.com/search?q=site%3a' + location.host + '+{0}&tbs=qdr:y',
//   's',
// );
// api.addSearchAlias(
//   '/',
//   'Search in Current Page/Folder',
//   'https://www.google.com/search?q=site%3a' +
//     location.origin + location.pathname + '+',
//   's',
// );
// api.addSearchAlias(
//   'ex',
//   'Search for Chrome extensions',
//   'https://www.google.com/search?q=chrome+extension+',
//   's',
// );
// api.addSearchAlias(
//   'dne',
//   'NextJS Search',
//   'https://www.google.com/search?q=site%3Ahttps://nextjs.org/docs+',
//   's',
// );
// api.addSearchAlias(
//   'dl',
//   'Lua Search',
//   'https://www.google.com/search?q=site%3Ahttps://www.lua.org/manual/5.4/+',
//   's',
// );
// api.addSearchAlias(
//   'dnp',
//   'NPM Search',
//   'https://www.npmjs.com/search?q={0}&page=1&perPage=20',
//   's',
// );
