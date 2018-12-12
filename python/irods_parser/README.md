# iRODS parser

The output of `ils -r` is fairly useless:

    $ ils /iplant/home/shared/imicrobe/projects/265/
    /iplant/home/shared/imicrobe/projects/265:
      C- /iplant/home/shared/imicrobe/projects/265/samples
    [cholla@~]$ ils -r /iplant/home/shared/imicrobe/projects/265/
    /iplant/home/shared/imicrobe/projects/265:
      C- /iplant/home/shared/imicrobe/projects/265/samples
    /iplant/home/shared/imicrobe/projects/265/samples:
      mock.fa
      C- /iplant/home/shared/imicrobe/projects/265/samples/5447

This program will turn combine the files with their directories:

    $ ils -r /iplant/home/shared/imicrobe/projects/265/ | ./irods_parser.py | head
    /iplant/home/shared/imicrobe/projects/265/samples/mock.fa
    /iplant/home/shared/imicrobe/projects/265/samples/5447/meta_mock1-2_c10M_single_454.fastq
    /iplant/home/shared/imicrobe/projects/265/samples/5447/meta_mock1-2_c10M_single_454.json
    /iplant/home/shared/imicrobe/projects/265/samples/5448/meta_mock1_c05M_single_454.fastq
    /iplant/home/shared/imicrobe/projects/265/samples/5448/meta_mock1_c05M_single_454.json
    /iplant/home/shared/imicrobe/projects/265/samples/5449/meta_mock1_c10M_single_454.fastq
    /iplant/home/shared/imicrobe/projects/265/samples/5449/meta_mock1_c10M_single_454.json
    /iplant/home/shared/imicrobe/projects/265/samples/5450/meta_mock1_c1M_single_454.fastq
    /iplant/home/shared/imicrobe/projects/265/samples/5450/meta_mock1_c1M_single_454.json
    /iplant/home/shared/imicrobe/projects/265/samples/5451/meta_mock1_c5M_single_454.fastq

You can also pipe `ils` to a file and parse that.
