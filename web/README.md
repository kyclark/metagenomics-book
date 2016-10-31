# Web Development with Perl 5

This is the code to go along with 
https://kyclark.gitbooks.io/metagenomics/content/web_development_with_perl_5.html.

# Perl modules

To install needed Perl modules:

```
$ cpan -i App::cpanminus
$ cpanm --installdeps .
```

NB, you may have to install DBD::mysql as unprivileged user.

# Database (MySQL)

Edit "lib/Compass/Config.pm" to point to your "default_filename" (e.g., 
"/home/u20/kyclark/work/metagenomics-book/web/lib/conf/compass.yaml").

Then edit that file to reflect your user/password/dbname.

To create and populate the db:

```
$ mysqladmin create compass
$ gunzip -c dump/compass.sql.gz | mysql compass 
$ export PERL5LIB="$(pwd)/lib:$PERL5LIB"
```

# Mojo

To start Mojolicious:

```
$ cd mojo
$ morbo -l "http://*:3000" script/compass
```

Then look at "localhost:3000" to see the site.
