# convert tab-separated files to QIF for importing into GnuCash
# see http://en.wikipedia.org/wiki/QIF
#
# 1. download checking account history as XLS from Budapest Bank internetbank.
# 2. convert with xls2csv.sh to UTF-8 encoded Tab separated file.
# 3. via cropfile.sh remove first 3 and last 3 lines of file
# 4. $ awk -f tab2qif.awk < bb_ACCOUNT_YYYY_MM.tab > bb_ACCOUNT_YYYY_MM.qif
# 5. import result into GnuCash

BEGIN {
	print "!Type:Bank"
	FS="\t"
}

{
	printf "D%s\n", $1
	printf "T%s\n", $5
	if ($4 != "") printf "N%s\n", $4
	if ($10 != "") printf "P%s\n", $10

	memo = 0;
	if ($2 != "") {
		do {} while (sub(/[ \t]{2,}/, " ", $2));
		printf "M%s", $2;
		memo=1;
	}
	if ($7 != "") {
		if (memo == 0) printf "M"; else printf " "
		do {} while (sub(/[ \t]{2,}/, " ", $7));
		printf "%s", $7;
		memo=1;
	}
	if ($8 != "" && $8 != $7) {
		if (memo == 0) printf "M"; else printf " "
		do {} while (sub(/[ \t]{2,}/, " ", $8));
		printf "%s", $8;
		memo=1;
	}
	if ($9 != "" && $9 != $8 && $9 != $7) {
		if (memo == 0) printf "M"; else printf " "
		do {} while (sub(/[ \t]{2,}/, " ", $9));
		printf "%s", $9;
		memo=1;
	}
	if (memo == 1) {
		printf "\n"
	}

	print "^"
}
