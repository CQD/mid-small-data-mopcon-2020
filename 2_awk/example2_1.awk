BEGIN {
	OFS = "\t"
}

{
	id = $1;
	cnt = $3;
	cnts[id] += cnt
}

END {
	for (id in cnts) {
		print id,cnts[id]
	}
}
