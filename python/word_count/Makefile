.PHONY: clean 

SCANS = 7500

all: poems enpoems english poems_kmer enpoems_kmer english_kmer

clean:
	find . \( -name Rplots.pdf -o -name marginal-mixing.pdf -o -name posterior-densities.pdf -o -name \*.tex -o -name gbme.out -o -name Z \) -exec rm {} \;

poems: clean
	./word_count2.py ../data/poems/* > poems_matrix.txt
	./sna.r -f poems_matrix.txt -n $(SCANS) -t poems.pdf

enpoems: clean
	./word_count2.py ../data/poems/en-* > enpoems_matrix.txt
	./sna.r -f enpoems_matrix.txt -n $(SCANS) -t enpoems.pdf

english: clean
	./word_count2.py ../data/poems/en-* ../data/govt/* > en_matrix.txt
	./sna.r -f en_matrix.txt -n $(SCANS) -t english.pdf

poems_kmer: clean
	./kmer_count.py -k 5 ../data/poems/* > poems_matrix_kmer.txt
	./sna.r -f poems_matrix_kmer.txt -n $(SCANS) -t poems_kmer-5.pdf

enpoems_kmer: clean
	./kmer_count.py -k 4 ../data/poems/en-* > enpoems_matrix_kmer.txt
	./sna.r -f enpoems_matrix_kmer.txt -n $(SCANS) -t enpoems_kmer.pdf

english_kmer: clean
	./kmer_count.py -k 5 ../data/poems/en-* ../data/govt/* > en_matrix_kmer.txt
	./sna.r -f en_matrix_kmer.txt -n $(SCANS) -t english_kmer-5.pdf
