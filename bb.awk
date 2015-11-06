# convert CSV file to Ledger transactions

BEGIN {
        Skip = 0
        Currency = "HUF"
}

(NR > Skip) {
        Date = $1
        Code = $4
        do {} while (sub(/[ \t]{2,}/, "", $10)); Payee = $10
        Amount = $5

	if ($2 != "") {
		do {} while (sub(/[ \t]{2,}/, " ", $2));
		Payee = sprintf("%s %s", Payee, $2);
	}

        printf "; %s\n", $0
        printf "; Date: %s\n", Date
        printf "; Code: %s\n", Code
        printf "; Payee: %s\n", Payee
        printf "; Amount: %s\n", Amount
        cmd = sprintf("ledger -f %s xact %s \"%s\" %s%s", LEDGER, Date, Payee, Currency, Amount)
        printf "; %s\n", cmd
        system(cmd)
        printf "\n"
}
