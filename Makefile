dats := $(patsubst %.xls,%.dat,$(wildcard *.xls))
dats += $(patsubst %.csv,%.dat,$(wildcard *.csv))
dats += $(patsubst %.xlsx,%.dat,$(wildcard *.xlsx))

all : $(dats)

LEDGER ?= "/home/tom/doc/ledger/ledger.dat"
B2LHKS ?= "/home/tom/doc/ledger/hooks.clj"
B2LJAR ?= "/home/tom/bin/banks2ledger-1.3.0-standalone.jar"

bp_%.dat: bp_%.csv
	java -jar $(B2LJAR) -l $(LEDGER) -f $< -sa 3 -sz 2 -D 'yyyy/MM/dd' \
	-r 3 -m 4 -t '%9!%1 %6 %7 %8' -a 'Assets:BB Folyószámla' -c HUF > $@

seb_esparkonto_%.dat: seb_esparkonto_%.csv
	java -jar $(B2LJAR) -l $(LEDGER) -f $< -sa 8 -m 2 -t '%1' \
	-a 'Assets:SEB Enkla sparkontot' > $@

seb_privatkonto_%.dat: seb_privatkonto_%.csv
	java -jar $(B2LJAR) -l $(LEDGER) -f $< -sa 8 -m 2 -t '%1' \
	-hf $(B2LHKS) -a 'Assets:SEB Privatkonto' > $@

ica_%.dat: ica_%.csv
	java -jar $(B2LJAR) -l $(LEDGER) -f $< -F ';' -sa 1 -m 4 -t '%1' \
	-ds ',' -gs ' ' -a 'Assets:ICA Adrienn' > $@

bp_%.csv: bp_%.xls
	ssconvert $< $@

seb_%.csv: seb_%.xlsx
	ssconvert $< $@
