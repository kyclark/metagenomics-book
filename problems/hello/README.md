# Hello (bash)

For this exercise you will write three bash scripts:

# hello.sh

Write a script called "hello.sh" that prints "Hello, World!"

    $ ./hello.sh
    Hello, World!

# hello-arg.sh

Write a script called "hello-arg.sh" that takes a name from the command line and prints "Hello, <name>!".  E.g.:

    $ ./hello-arg.sh Bowzer
    Hello, Bowzer!

If there is no argument, print a usage statement, e.g.:

    $ ./hello-arg.sh 
    Usage: hello.sh name

# hello-arg2.sh

Write a script called "hello-arg2.sh" that takes two arguments from the command line (greeting, name) and prints "<greeting>, <name>!", e.g.:

    $ ./hello-arg2.sh "Good Boy" Bowzer
    Good Boy, Bowzer!

If there are not two arguments, print a usage statement, e.g.:

    $ ./hello-arg2.sh 
    Usage: hello-arg2.sh greeting name
