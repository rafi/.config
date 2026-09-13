// github provider
// ---

type GithubCompResult = {
	items: {
		full_name: string;
		stargazers_count?: number;
		html_url: string;
	}[];
};

export default {
	searchUrl: "https://github.com/search?q=%s",
	faviconUrl: "https://github.com/favicon.ico",
	compUrl:
		"https://api.github.com/search/repositories?sort=stars&order=desc&q=%s",
	compFn: (res: { text: string }) =>
		(JSON.parse(res.text) as GithubCompResult).items.map((item) => {
			let title = "";
			if (item.stargazers_count) {
				title += `${item.stargazers_count}⭐ `;
			}
			title += item.full_name;

			const html = `
				<div>
					<div style="font-weight: bold">${title}</div>
					<div style="opacity: 0.7; line-height: 1.3em">${item.html_url}</div>
				</div>`;

			return { html, props: { url: item.html_url } };
		}),
};
