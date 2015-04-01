qifs := $(patsubst %.xls,%.qif,$(wildcard *.xls))

all : $(qifs)

%.qif: %.csv
	awk -f tab2qif.awk < $< > $@

%.csv: %.xls
	sh ./xls2csv.sh < $< > $@
	sh ./cropfile.sh $@ 3 3
