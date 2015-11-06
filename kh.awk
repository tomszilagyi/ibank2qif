# convert CSV file to Ledger transactions

BEGIN {
        Skip = 1
        Currency = "HUF"
}

(NR > Skip) {
        Date = $1
        Code = $2
        do {} while (sub(/[ \t]{2,}/, "", $7)); Payee = $7
        Amount = $8

	if ($3 != "") {
		do {} while (sub(/[ \t]{2,}/, " ", $3));
		Payee = sprintf("%s %s", Payee, $3);
	}

	if ($10 != "") {
		do {} while (sub(/[ \t]{2,}/, " ", $10));
		Payee = sprintf("%s %s", Payee, $10);
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
