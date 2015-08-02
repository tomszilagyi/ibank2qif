qifs := $(patsubst %.xls,%.qif,$(wildcard *.xls))
qifs += $(patsubst %.csv,%.qif,$(wildcard *.csv))
qifs += $(patsubst %.xlsx,%.qif,$(wildcard *.xlsx))

all : $(qifs)

bp_%.qif: bp_%.csv
	awk -f tab2qif_bb.awk < $< > $@

bp_%.csv: bp_%.xls
	sh ./xls2csv_bb.sh < $< > $@
	sh ./cropfile.sh $@ 3 3

kh_%.qif: kh_%.csv
	awk -f tab2qif_kh.awk < $< > $@

seb_%.qif: seb_%.csv
	awk -f tab2qif_seb.awk < $< > $@

seb_%.csv: seb_%.xlsx
	ssconvert $< $@
	sh ./cropfile.sh $@ 6 0
