# convert CSV files to QIF for importing into GnuCash
# see http://en.wikipedia.org/wiki/QIF
#
# 1. download checking account history as xlsx from SEB internetbank.
# 2. $ awk -f tab2qif_seb.awk < seb_ACCOUNT_YYYY_MM.csv > seb_ACCOUNT_YYYY_MM.qif
# 3. import result into GnuCash

BEGIN {
	print "!Type:Bank"
	FS=","
}

{
	printf "D%s\n", $1
	printf "T%s\n", $5
	if ($3 != "") {
                gsub("\"", "", $3)
                printf "N%s\n", $3
        }
	if ($4 != "") {
                gsub("\"", "", $4)
                printf "P%s\n", $4
        }
	print "^"
}
