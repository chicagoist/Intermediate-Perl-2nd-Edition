#!/usr/bin/perl -w

use 5.10.0;

use FindBin qw($Bin);
use lib "$Bin/ch15"; # в подкаталоге

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

# File 15.1.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/

# Возьмите библиотеку Oogaboogoo, созданную вами в упражнении 1 главы 10,
# и превратите ее в модуль, который можно будет подключать с помощью директивы use.
# Измените программный код, обращающийся к библиотеке, таким образом, чтобы он мог
# использовать импортированные подпрограммы (без указания полного имени подпрограмм,
# включающих имя модуля) и проверьте его.

use Date_ch15 qw(:all);

my $date_ch15 = Date_ch15->new();

print "Name of day: ",number_to_day_name(5),"\n";
print "Name of month: ",number_to_mon_name(6),"\n";
print today()."\n";

print date_10();

=begin text

$ perl 15.1.pl



=end text

#

=cut

