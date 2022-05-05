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

# File 11.1.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/

# Напишите определения классов Cow, Horse, Sheep и Mouse так, чтобы они могли работать в режиме use strict.
# Для этого, если вы работаете с современной версией Perl, воспользуйтесь спецификатором our.
# Ваша программа должна запрашивать у пользователя название одного или более животных, создавать пастбище с
# этими животными, а затем заставлять каждое из них подать голос.

print "Name of day: ".ch10::Date_ch10::number_to_day_name(7)."\n";
print "Name of month: ".ch10::Date_ch10::number_to_mon_name(1)."\n";


print ch10::Date_ch10::date_10();

=begin text

.ch10/Date.pm

use FindBin qw($Bin);
use lib "$Bin/ch10"; # в подкаталоге
use Date_ch10;

print "Name of day: ".ch10::Date_ch10::number_to_day_name(7)."\n";
print "Name of month: ".ch10::Date_ch10::number_to_mon_name(1)."\n";

=end text

#

=cut

