BEGIN {
	OFS = "\t";
	target_tag = "2";
}

{
	id = $1;
	cnt = $3;

	split($2, tags, ",");
	for (idx in tags) {
	    if (target_tag == tags[idx]) {
			cnts[id] += cnt;
			next;
		}
    }
}

END {
	for (id in cnts) {
		print id,cnts[id]
	}
}
