qifs := $(patsubst %.xls,%.qif,$(wildcard *.xls))
qifs += $(patsubst %.csv,%.qif,$(wildcard *.csv))

all : $(qifs)

bp_%.qif: bp_%.csv
	awk -f tab2qif_bb.awk < $< > $@

bp_%.csv: bp_%.xls
	sh ./xls2csv_bb.sh < $< > $@
	sh ./cropfile.sh $@ 3 3
