# convert CSV file to Ledger transactions

BEGIN {
        Skip = 5
        Currency = "SEK"
}

(NR > Skip) {
        Date = $1
        Date2 = $2
        Code = $3
        do {} while (sub(/[ \t]{2,}/, "", $4)); Payee = $4
        Amount = $5

        printf "; %s\n", $0
        cmd = sprintf("ledger -f ../ledger/ledger.dat xact %s %s %s%s", Date, Payee, Currency, Amount)
        system(cmd)
        printf "\n"
}
