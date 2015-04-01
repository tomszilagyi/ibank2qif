# convert tab-separated files to QIF for importing into GnuCash
# see http://en.wikipedia.org/wiki/QIF
#
# 1. download checking account history as CSV from K&H internetbank.
# 2. $ awk -f tab2qif_kh.awk < kh_ACCOUNT_YYYY_MM.csv > kh_ACCOUNT_YYYY_MM.qif
# 3. import result into GnuCash

BEGIN {
	print "!Type:Bank"
	FS="\t"
}

(NR > 1) {
	printf "D%s\n", $1
	printf "T%s\n", $8
	if ($2 != "") printf "N%s\n", $2
	if ($7 != "") printf "P%s\n", $7

	memo = 0;
	if ($3 != "") {
		do {} while (sub(/[ \t]{2,}/, " ", $3));
		printf "M%s", $3;
		memo=1;
	}
	if ($10 != "") {
		if (memo == 0) printf "M"; else printf " "
		do {} while (sub(/[ \t]{2,}/, " ", $10));
		printf "%s", $10;
		memo=1;
	}
	if (memo == 1) {
		printf "\n"
	}

	print "^"
}
