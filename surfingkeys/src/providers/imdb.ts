// imdb provider
// ---

type ImdbCompResult = {
	d: {
		i: {
			height: number;
			imageUrl: string;
			width: number;
		};
		id: string;
		l: string;
		rank: number;
		s: string;
		y?: number;
	}[];
};

export default {
	searchUrl: "https://www.imdb.com/find?q=%s",
	faviconUrl: "https://www.imdb.com/favicon.ico",
	compUrl: "https://v3.sg.media-imdb.com/suggestion/x/%s.json?includeVideos=0",
	compFn: (res: { text: string }) =>
		(JSON.parse(res.text) as ImdbCompResult).d.map((item) => {
			let title = item.l;
			if (item.y !== undefined) title += ` (${item.y})`;

			const url = `https://imdb.com/title/${item.id}/`;

			const html = `
				<div style="display: flex; flex-direction: row">
					<img
						style="max-width: 160px; height: 90px; margin-right: 0.8em"
						alt="thumbnail"
						src="${item.i.imageUrl}">
					<div>
						<div class="title">${title}</div>
						<div>
							<div>${item.s}</div>
							<div class="url">${url}</div>
						</div>
					</div>
				</div>`;

			return { html, props: { url } };
		}),
};
