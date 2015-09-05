# convert CSV files to QIF for importing into GnuCash
# see http://en.wikipedia.org/wiki/QIF
#
# 1. download checking account history as csv from ICA Bankens internetbank.
# 2. $ awk -f tab2qif_ica.awk < ica_ACCOUNT_YYYY_MM.csv > ica_ACCOUNT_YYYY_MM.qif
# 3. import result into GnuCash

BEGIN {
        print "!Type:Bank"
        FS=";"
}

(NR > 1) {
        printf "D%s\n", $1
        gsub(" kr", "", $5)
        gsub(" ", "", $5)
        printf "T%s\n", $5
        if ($2 != "") {
                gsub("\"", "", $2)
                printf "P%s\n", $2
        }
        print "^"
}
