#!/usr/bin/perl -w

use 5.10.0;

use FindBin qw($Bin);
use lib "$Bin/ch10"; # в подкаталоге

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
use Date_ch10;

# File 10.2.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/

# Напишите программу, которая с помощью вашей библиотеки (см. упражнение 10.1.pl) и нижеследующего программного
# кода выводила бы сообщение (например, Сегодня дип, сен 15, 2011, означающее,
# что сегодня понедельник, 15 августа, 2011 года). Подсказка: функция localtime может возвращать номер дня недели,
# месяца и года совсем не так, как вы ожидаете, поэтому вы должны обратиться к соответствующей документации.

# my($sec, $min, $hour, $mday, $mon, $year, $wday) = localtime;
# @day = qw(арк дип уап сен поп сеп кир);
# @month = qw(диз под бод род сип уакс лин сен кун физ нап деп);

print ch10::Date_ch10::today()."\n";


=begin text

.ch10/Date.pm


use FindBin qw($Bin);
use lib "$Bin/ch10"; # в подкаталоге
use Date_ch10;

print ch10::Date_ch10::today()."\n";

=end text

#

=cut

