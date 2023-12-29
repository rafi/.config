s/\(DIANA_SECRET_TOKEN=\).*/\1{{ DIANA_TOKEN }}/
s/\(rpc-secret=\).*/\1{{ ARIA2_TOKEN }}/
s/\(api_key: \).*/\1{{ LASTFM_TOKEN }}/
s/^\(password = \).*/\1{{ LASTFM_PASS }}/
s/\(apikey: \).*/\1{{ ECHONEST_TOKEN }}/
s/^\(	email = \).*\(;[[:blank:]]*work\)$/\1{{ GIT_WORK_EMAIL }} \2/
s/^\(	email = \).*\(;[[:blank:]]*personal\)$/\1{{ GIT_EMAIL }} \2/
s/^\(	name = \).*$/\1{{ GIT_NAME }}/
s/^\(jira\.base_uri =\).*/\1 {{ JIRA_URL }}/
s/^\(jira\.username =\).*/\1 {{ JIRA_USER }}/
s/^\(jira\.password =\).*/\1 {{ JIRA_PASS }}/
s/^\(jira\.password =\).*/\1 {{ JIRA_PASS }}/
s/^\(forecast-api-key=\).*$/\1{{ FORECASTIO_TOKEN }}/
s/\(GITHUB_TOKEN="\).*\("\)$/\1{{ GITHUB_TOKEN }}\2/
s/\(HOMEBREW_GITHUB_API_TOKEN="\).*\("\)$/\1{{ HOMEBREW_GITHUB_API_TOKEN }}\2/
s/\(GITLAB_TOKEN="\).*\("\)$/\1{{ GITLAB_TOKEN }}\2/
s/\(OPENAI_API_KEY="\).*\("\)$/\1{{ OPENAI_API_KEY }}\2/
s/\(DICTIONARY_API_KEY=\).*/\1{{ DICTIONARY_API_KEY }}/
s/\(TMUX_SPOTIFY_API_KEY="\).*\("\)$/\1{{ TMUX_SPOTIFY_API_KEY }}\2/
