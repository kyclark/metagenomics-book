FASTA_DIR = "/rsgrps/bhurwitz/kyclark/human-gut/fasta"
OUT_DIR = "/rsgrps/bhurwitz/kyclark/human-gut"
BLAST_DB = "/rsgrps/bhurwitz/hurwitzlab/data/reference/patric_bacteria/1313.2945.fna"

run: clean
	./00-controller.sh -b $(BLAST_DB) -f $(FASTA_DIR) -o $(OUT_DIR) 

#	./00-controller.sh -b $(BLAST_DB) -f $(FASTA_DIR) -o $(OUT_DIR) -r 02-blast.sh

clean:
	find . \( -name \*.conf -o -name \*.OU \) -exec rm {} \;
