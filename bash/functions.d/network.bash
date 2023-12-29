# Network functions
# https://github.com/rafi/.config

function lseth() {
	# Query lshw for network info, and fix JSON output.
	echo "[ $(lshw -numeric -class network -json | sed 's/}\ *{/}, {/g') ]" \
		| jq -r '
			# Prepare the header.
			(
				["NAME", "DRIVER", "FIRMWARE", "PRODUCT", "VENDOR", "BUS"]
				# Draw dashes for the length of each column.
				| (., map(length*"-"))
			),
			# Prepare body rows as array of arrays for @tsv to work.
			(
				.[] | [
					.logicalname, .configuration.driver, .configuration.firmware,
					.product, .vendor, .businfo
				]
			) | @tsv' \
		| column -ts$'\t'
}
