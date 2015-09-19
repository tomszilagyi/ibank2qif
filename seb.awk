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

        #print Date, Code, Payee, Amount
        cmd = sprintf("ledger -f ledger.dat xact %s %s %s%s", Date, Payee, Currency, Amount)
        #print cmd
        system(cmd)
        printf "\n"
}
