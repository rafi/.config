s/\(rpc-secret=\).*/\1{{ ARIA2_TOKEN }}/
s/\(DIANA_SECRET_TOKEN=\).*/\1{{ DIANA_TOKEN }}/
s/^\(username = \).*/\1{{ LASTFM_USER }}/
s/^\(password = \).*/\1{{ LASTFM_PASS }}/
s/\(user: \).*/\1{{ LASTFM_USER }}/
s/\(api_key: \).*/\1{{ LASTFM_TOKEN }}/
s/\(apikey: \).*/\1{{ ECHONEST_TOKEN }}/
s/change_db\=.+/change_db=/
s/^\(jira\.base_uri = \).*/\1{{ JIRA_URL }}/
s/^\(jira\.username = \).*/\1{{ JIRA_USER }}/
s/^\(jira\.password = \).*/\1{{ JIRA_PASS }}/
