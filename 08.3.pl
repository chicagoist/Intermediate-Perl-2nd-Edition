#!/usr/bin/perl -w

use 5.10.0;
# use CGI;
use Encode qw(decode_utf8);
use Encode qw(decode encode);
BEGIN{$_ = map Encode::decode(\$_, 1)}
# BEGIN{@ARGV = map decode_utf8(#\$_, 1), @ARGV;}
use open qw(:std :encoding(UTF-8));
use utf8::all 'GLOBAL';
use Encode::Locale;
# use diagnostics;


use strict;
use warnings FATAL => 'all';
use IPC::System::Simple;
use autodie qw(:all);
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');

use Data::Dumper;
use Bundle::Camelcade;# for Intellij IDEA
use POSIX ();
use File::Spec;
use Cwd;

# File 08.3.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Напишите программу, которая принимала бы из командной строки имена нескольких
# каталогов и выводила бы их содержимое. Используйте функцию, которая принимает
# в качестве аргумента ссылку на дескриптор каталога, созданную с помощью IO::Dir.


use File::Find;
use Time::Local;
use IO::Dir;

print "Which directory you want to connect ?  exmp.[ /home/user OR ../dir ] : ";
chomp(my $my_dir = <STDIN>);

my $dir_fh = IO::Dir->new( $my_dir ) or die "Невозможно открыть каталог: $!\n";

while (my $file = $dir_fh->read){
    say $file;
}

$dir_fh->close();
=begin text


 $ perl 08.3.pl




=end text

#

=cut

# Верный ответ из книги:

