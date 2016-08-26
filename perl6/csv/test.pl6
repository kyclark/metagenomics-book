#!/usr/bin/env perl6

use v6;
use File::Temp;
use Test;

plan 6;

# --------------------------------------------------

my ($tmpfile, $tmpfh) = tempfile();
$tmpfh.close;
shell "./parser1.pl6 causes.csv | sort | uniq -c > $tmpfile";
my $out1 = $tmpfile.IO.slurp;
$tmpfile.IO.unlink;

my $expected = q:to/END/;
 772 2007
 760 2008
 752 2009
 772 2010
 784 2011
   1 Year
END

is $out1, $expected;

# --------------------------------------------------

my $out2 = runner './parser2.pl6', '--limit=1', 'causes.csv';
is $out2, '[{Cause of Death => HUMAN IMMUNODEFICIENCY VIRUS DISEASE, Count => 297, Ethnicity => NON-HISPANIC BLACK, Percent => 5, Sex => MALE, Year => 2010} {Cause of Death => INFLUENZA AND PNEUMONIA, Count => 201, Ethnicity => NON-HISPANIC BLACK, Percent => 3, Sex => MALE, Year => 2010}]';

# --------------------------------------------------

my $out3 = runner './parser3.pl6', '--limit=1', 'causes.csv';
is $out3, '[(Year => 2010 Ethnicity => NON-HISPANIC BLACK Sex => MALE Cause of Death => HUMAN IMMUNODEFICIENCY VIRUS DISEASE Count => 297 Percent => 5) (Year => 2010 Ethnicity => NON-HISPANIC BLACK Sex => MALE Cause of Death => INFLUENZA AND PNEUMONIA Count => 201 Percent => 3)]';

# --------------------------------------------------

my $out4 = runner './parser3.pl6', '--limit=1', 'causes.csv';
is $out4, '[(Year => 2010 Ethnicity => NON-HISPANIC BLACK Sex => MALE Cause of Death => HUMAN IMMUNODEFICIENCY VIRUS DISEASE Count => 297 Percent => 5) (Year => 2010 Ethnicity => NON-HISPANIC BLACK Sex => MALE Cause of Death => INFLUENZA AND PNEUMONIA Count => 201 Percent => 3)]';

# --------------------------------------------------

my $out5 = runner './parser3.pl6', '--comment=#', 'causes2.csv';
is $out5, '[(Year => 2010 Ethnicity => NON-HISPANIC BLACK Sex => MALE Cause of Death => HUMAN IMMUNODEFICIENCY VIRUS DISEASE Count => 297 Percent => 5) (Year => 2010 Ethnicity => NON-HISPANIC BLACK Sex => MALE Cause of Death => INFLUENZA AND PNEUMONIA Count => 201 Percent => 3) (Year => 2010 Ethnicity => NON-HISPANIC BLACK Sex => MALE Cause of Death => INTENTIONAL SELF-HARM (SUICIDE) Count => 64 Percent => 1) (Year => 2010 Ethnicity => NON-HISPANIC BLACK Sex => MALE Cause of Death => MALIGNANT NEOPLASMS Count => 1540 Percent => 23) (Year => 2010 Ethnicity => NON-HISPANIC BLACK Sex => MALE Cause of Death => MENTAL DISORDERS DUE TO USE OF ALCOHOL Count => 50 Percent => 1) (Year => 2010 Ethnicity => NON-HISPANIC BLACK Sex => MALE Cause of Death => "NEPHRITIS Count =>  NEPHROTIC SYNDROME AND NEPHROSIS" Percent => 70) (Year => 2010 Ethnicity => NON-HISPANIC BLACK Sex => MALE Cause of Death => PEPTIC ULCER Count => 13 Percent => 0) (Year => 2010 Ethnicity => NON-HISPANIC BLACK Sex => MALE Cause of Death => PSYCH. SUBSTANCE USE & ACCIDENTAL DRUG POISONING Count => 111 Percent => 2) (Year => 2010 Ethnicity => NON-HISPANIC BLACK Sex => MALE Cause of Death => SEPTICEMIA Count => 36 Percent => 1)]';

# --------------------------------------------------

my $out6 = runner './parser3.pl6', '--comment=//', '--sep=\t', 'causes3.tab';
is $out6, '[(Year => 2010 Ethnicity => NON-HISPANIC BLACK Sex => MALE Cause of Death => HUMAN IMMUNODEFICIENCY VIRUS DISEASE Count => 297 Percent => 5) (Year => 2010 Ethnicity => NON-HISPANIC BLACK Sex => MALE Cause of Death => INFLUENZA AND PNEUMONIA Count => 201 Percent => 3) (Year => 2010 Ethnicity => NON-HISPANIC BLACK Sex => MALE Cause of Death => INTENTIONAL SELF-HARM (SUICIDE) Count => 64 Percent => 1) (Year => 2010 Ethnicity => NON-HISPANIC BLACK Sex => MALE Cause of Death => MALIGNANT NEOPLASMS Count => 1540 Percent => 23) (Year => 2010 Ethnicity => NON-HISPANIC BLACK Sex => MALE Cause of Death => MENTAL DISORDERS DUE TO USE OF ALCOHOL Count => 50 Percent => 1) (Year => 2010 Ethnicity => NON-HISPANIC BLACK Sex => MALE Cause of Death => "NEPHRITIS Count =>  NEPHROTIC SYNDROME AND NEPHROSIS" Percent => 70) (Year => 2010 Ethnicity => NON-HISPANIC BLACK Sex => MALE Cause of Death => PEPTIC ULCER Count => 13 Percent => 0) (Year => 2010 Ethnicity => NON-HISPANIC BLACK Sex => MALE Cause of Death => PSYCH. SUBSTANCE USE & ACCIDENTAL DRUG POISONING Count => 111 Percent => 2) (Year => 2010 Ethnicity => NON-HISPANIC BLACK Sex => MALE Cause of Death => SEPTICEMIA Count => 36 Percent => 1)]';

# --------------------------------------------------
sub runner(Str $script!, *@args) {
    my $proc = run $script, @args, :out;
    $proc.out.slurp-rest.chomp;
}
