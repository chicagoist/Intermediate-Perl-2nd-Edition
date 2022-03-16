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

# File 09.1.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Элементарная сортировка элементов каталога /bin по их размерам может быть выполнена с
# помощью оператора glob:
# my @sorted = sort {  s $a <=>  s $b } glob "/bin/*";
# Перепишите этот пример с применением преобразования Шварца.

use File::Find;
use Time::Local;
use DDP;

my @sorted =
map [$_->[0],$_->[1]],
sort { $a->[1] <=> $b->[1] }
map [ $_, -s $_ ],
glob "~/*";

p @sorted;

=begin text


 $ perl 09.1.pl


=end text

#

=cut

# Верный ответ из книги:

# my @sorted =
# map   $_−>[0],
# sort { $a−>[1] <=> $b−>[1] }
# map  [$_, −s $_],
# glob '~/*';

