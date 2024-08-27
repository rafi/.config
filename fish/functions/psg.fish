function psg --description 'Quickly grep a process'
	ps auxww | grep -i --color=always "$argv" | grep -v "grep.*$argv"
end
