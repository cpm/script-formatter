Convert plaintext stage plays to HTML, for a limited subset of plaintext 
stage plays.

Software does nothing nice for titles or pages yet.

It assumes the following:
 * dialogue lines start with NAME IN CAPS followed by ":" or ".".
 * stage direction is wraps in parens.
 * other emphasized things are between /'s.
 * an actor's line can span multiple lines and is terminated by an empty line

Usage:
 $ cat my-script.txt | ruby script2html.rb > output.html

