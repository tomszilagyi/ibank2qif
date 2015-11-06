# convert CSV file to Ledger transactions

BEGIN {
        Skip = 1
        Currency = "SEK"
}

(NR > Skip) {
        Date = $1
        do {} while (sub(/[ \t]{2,}/, "", $2));
        Payee = $2
        gsub(" kr", "", $5)
        gsub(" ", "", $5)
        Amount = $5

        printf "; %s\n", $0
        cmd = sprintf("ledger -f %s xact %s \"%s\" %s%s", LEDGER, Date, Payee, Currency, Amount)
        system(cmd)
        printf "\n"
}
