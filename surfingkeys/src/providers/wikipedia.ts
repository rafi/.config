// wikipedia provider
// ---

type WikipediaCompResult = {
	query: {
		pages: {
			[id: number]: {
				title: string;
				index: number;
				fullurl: string;
				thumbnail?: { source: string };
				description?: string;
			};
		};
	};
};

const defaultImageSvg =
	"data:image/svg+xml,%3C%3Fxml%20version%3D%221.0%22%20encoding%3D%22utf-8%22%3F%3E%0A%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%2056%2056%22%20enable-background%3D%22new%200%200%2056%2056%22%3E%0A%20%20%20%20%3Cpath%20fill%3D%22%23eee%22%20d%3D%22M0%200h56v56h-56z%22%2F%3E%0A%20%20%20%20%3Cpath%20fill%3D%22%23999%22%20d%3D%22M36.4%2013.5h-18.6v24.9c0%201.4.9%202.3%202.3%202.3h18.7v-25c.1-1.4-1-2.2-2.4-2.2zm-6.2%203.5h5.1v6.4h-5.1v-6.4zm-8.8%200h6v1.8h-6v-1.8zm0%204.6h6v1.8h-6v-1.8zm0%2015.5v-1.8h13.8v1.8h-13.8zm13.8-4.5h-13.8v-1.8h13.8v1.8zm0-4.7h-13.8v-1.8h13.8v1.8z%22%2F%3E%0A%3C%2Fsvg%3E%0A";

export default {
	searchUrl: "https://en.wikipedia.org/wiki/Special:Search?search=%s",
	faviconUrl: "https://en.wikipedia.org/favicon.ico",
	compUrl:
		"https://en.wikipedia.org/w/api.php?action=query&format=json&generator=prefixsearch&prop=info|pageprops|pageimages|description&redirects=&ppprop=displaytitle&piprop=thumbnail&pithumbsize=100&pilimit=6&inprop=url&gpssearch=%s",
	compFn: (res: { text: string }) =>
		Object.values((JSON.parse(res.text) as WikipediaCompResult).query.pages)
			.sort((a, b) => a.index - b.index)
			.map((page) => {
				const img = page.thumbnail?.source ?? defaultImageSvg;

				const descriptionElem = page.description
					? `<div>${page.description}</div>`
					: "";

				const html = `
					<div style="display: flex; flex-direction: row">
						<img
							style="max-width: 160px; height: 90px; margin-right: 0.8em"
							alt="thumbnail"
							src="${img}">
						<div>
							<div class="title">${page.title}</div>
							<div>
								${descriptionElem}
								<div class="url">${page.fullurl}</div>
							</div>
						</div>
					</div>`;

				return { html, props: { url: page.fullurl } };
			}),
};
