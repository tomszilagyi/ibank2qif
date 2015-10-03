dats := $(patsubst %.xls,%.dat,$(wildcard *.xls))
dats += $(patsubst %.csv,%.dat,$(wildcard *.csv))
dats += $(patsubst %.xlsx,%.dat,$(wildcard *.xlsx))

all : $(dats)

bp_%.dat: bp_%.csv
	awk -F '\t' -f bb.awk < $< > $@

bp_%.csv: bp_%.xls
	sh ./xls2csv_bb.sh < $< > $@
	sh ./cropfile.sh $@ 3 3

kh_%.dat: kh_%.csv
	awk -F '\t' -f kh.awk < $< > $@

seb_%.dat: seb_%.csv
	awk -F ',' -f seb.awk < $< > $@

seb_%.csv: seb_%.xlsx
	ssconvert $< $@

ica_%.dat: ica_%.csv
	awk -F ';' -f ica.awk < $< > $@
