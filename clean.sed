s/change_db \=.*/change_db =/
/^set geometry(/d
s/\(rpc-secret=\).*/\1{{ ARIA2_TOKEN }}/
s/\(DIANA_SECRET_TOKEN=\).*/\1{{ DIANA_TOKEN }}/
s/^\(username = \).*/\1{{ LASTFM_USER }}/
s/^\(password = \).*/\1{{ LASTFM_PASS }}/
s/\(user: \).*/\1{{ LASTFM_USER }}/
s/\(api_key: \).*/\1{{ LASTFM_TOKEN }}/
s/\(	user "\).*\("\)/\1{{ SPOTIFY_USER }}\2/
s/\(	password "\).*\("\)/\1{{ SPOTIFY_PASS }}\2/
s/\(apikey: \).*/\1{{ ECHONEST_TOKEN }}/
s/^\(jira\.base_uri = \).*/\1{{ JIRA_URL }}/
s/^\(jira\.username = \).*/\1{{ JIRA_USER }}/
s/^\(jira\.password = \).*/\1{{ JIRA_PASS }}/
s/^\(jira\.password = \).*/\1{{ JIRA_PASS }}/
s/^\(	email = \).*\# \(.*\)$/\1{{ GIT_\2_EMAIL }}/
s/^\(	name = \).*\# \(.*\)$/\1{{ GIT_\2_NAME }}/
s/^\(	user = \).*\# \(.*\)$/\1{{ GIT_\2_USER }}/
s/^\(wwo-api-key=\).*$/\1{{ WEATHER_TOKEN }}/
s/\(GITHUB_TOKEN="\).*\("\)$/\1{{ GITHUB_TOKEN }}\2/
s/\(HOMEBREW_GITHUB_API_TOKEN="\).*\("\)$/\1{{ HOMEBREW_GITHUB_API_TOKEN }}\2/
s/\(TMUX_SPOTIFY_API_KEY="\).*\("\)$/\1{{ TMUX_SPOTIFY_API_KEY }}\2/
