function go-outdated
	go list -u -m -f '{{ if and (not .Indirect) .Update }}{{.}}{{end}}' all
end
