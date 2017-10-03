.PHONY: run william ee

run:
	./bacryonym.py NASA

shakespeare: shakespeare.txt
	./bacryonym.py -w shakespeare.txt NASA

cummings: cummings.txt
	./bacryonym.py -w cummings.txt NASA

shakespeare.txt:
	wget ftp://ftp.imicrobe.us/tmp/shakespeare.txt

cummings.txt:
	wget ftp://ftp.imicrobe.us/tmp/cummings.txt
