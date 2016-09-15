.PHONY: all fasta features test clean

all: clean fasta genome chr-count chr-size features gene-count verified-genes uncharacterized-genes gene-types palinsreg terminated-genes

clean:
	find . \( -name \*gene\* -o -name chr-\* \) -exec rm {} \;

fasta:
	echo OK

genome: fasta
	echo OK

chr-count: genome
	echo OK

chr-size: genome
	echo OK

features:
	echo OK

gene-count: features
	echo OK

verified-genes: features
	echo OK

uncharacterized-genes: features
	echo OK

gene-types: features
	echo OK

palinsreg:
	echo OK

terminated-genes: palinsreg
	echo OK

test:
	./test.pl6
