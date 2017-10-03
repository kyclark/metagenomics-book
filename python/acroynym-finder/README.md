# Acronym Finder

Inspired by https://www.acronymfinder.com/, this program attempts to find 
silly definitions ("back-cronyms," if you will) of a given acronym.  By
default, it will read the common system dictionary for a list of words, but 
you can "train" it on another text, e.g., do "make shakespeare" to download
and use a text of Shakespeare's works or "make cummings" to get some works 
by e.e. cummings (who probably definitely wouldn't want his works used for
explaining CAPITAL WORDS).

```
$ make
./bacryonym.py NASA
NASA =
 - Nimbosity Anthracotheriidae Stepuncle Angiolipoma
 - Normanizer Abetment Suboval Ambay
 - Nuchal Agalawood Snippy Antitrochanter
 - Novemdigitate Assubjugate Southlander Ak
 - Nucha Armenic Starveacre Acre
$ make shakespeare
./bacryonym.py -w shakespeare.txt NASA
NASA =
 - Nourished Agued Stinkingly Among
 - Nutmeg Actions Surrey Applies
 - North Atonements Scorch Antechamber
 - Neoptolemus Ardour Snowy Article
 - Nourisheth Audible Shotfree Austerity
$ make cummings
./bacryonym.py -w cummings.txt NASA
NASA =
 - Neither Alighting Simple Amrique
 - Nobodyll Adoring Stay Allowed
 - Nil Armies Street Anybody
 - Near Againjittle Simple Anyone
 - Nil After Stinkbrag According
```
