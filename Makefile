dats := $(patsubst %.xls,%.dat,$(wildcard *.xls))
dats += $(patsubst %.csv,%.dat,$(wildcard *.csv))
dats += $(patsubst %.xlsx,%.dat,$(wildcard *.xlsx))

all : $(dats)

LEDGER ?= "/home/tom/doc/ledger/ledger.dat"
B2LJAR ?= "/home/tom/bin/banks2ledger-1.0.0-standalone.jar"

bp_%.dat: bp_%.csv
	java -jar $(B2LJAR) -l $(LEDGER) -f $< -sa 3 -sz 2 -D 'yyyy/MM/dd' \
	-r 3 -m 4 -t '%9!%1 %6 %7 %8' -a 'Assets:BB Folyószámla' -c HUF > $@

seb_%.dat: seb_%.csv
	java -jar $(B2LJAR) -l $(LEDGER) -f $< -sa 5 -r 2 -m 4 -t '%3' \
	-a 'Assets:SEB Privatkonto' > $@

ica_%.dat: ica_%.csv
	java -jar $(B2LJAR) -l $(LEDGER) -f $< -F ';' -sa 1 -m 4 -t '%1' \
	-a 'Assets:ICA Adrienn' > $@

bp_%.csv: bp_%.xls
	ssconvert $< $@

seb_%.csv: seb_%.xlsx
	ssconvert $< $@
