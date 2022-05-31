#!/usr/bin/perl -w

use 5.10.0;

use FindBin qw($Bin);
use lib "$Bin/ch14"; # в подкаталоге

# use CGI;
use Encode qw(decode_utf8);
use Encode qw(decode encode);
BEGIN{ $_ = map Encode::decode(\$_, 1) }
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

#require 'Date_10.pm';
use MyDate;

# File 14.1.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/

# Напишите модуль с именем MyDate, который использовал бы метод AUTOLOAD для обслуживания
# обращений к методам day, month и year, возвращая соответствующее значение. В случае
# обращения к неопределенным методам AUTOLOAD должен вызывать подпрограмму carp, чтобы сообщить
# пользователю о вызове несуществующего метода. Напишите сценарий, который, основываясь на
# модуле MyDate, выводил бы день, месяц и год.

my $date = MyDate->new();
say "Сегодня дата: ",$date->day;
say "Сейчас месяц: ",$date->month;
say "Сейчас год: ",$date->year;


=begin text

$ perl 14.1.pl

 Сегодня дата: 31
 Сейчас месяц: 5
 Сейчас год: 2022



=end text

#

=cut

