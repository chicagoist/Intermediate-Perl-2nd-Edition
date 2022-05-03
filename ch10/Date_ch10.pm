package ch10::Date_ch10;

use v5.10;

# use CGI;
# use POSIX;
# use Encode qw(decode_utf8);
# use Encode qw(decode encode);
#= BEGIN{@ARGV=map Encode::decode(#\$_,1),@ARGV;}
# BEGIN{@ARGV = map decode_utf8(#\$_, 1), @ARGV;}
# use open qw(:std :encoding(UTF-8));
use utf8::all 'GLOBAL';
# use Encode::Locale;
# use Encode;
# use diagnostics;
use strict;
use warnings FATAL => 'all';
use autodie qw(:all);
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use Data::Dumper;
use Bundle::Camelcade;# for Intellij IDEA
use YAML;
use DDP;

my @day = qw(арк дип уап сен поп сеп кир);
my @month = qw(диз под бод род сип уакс лин сен кун физ нап деп);

# This subroutine will be accessible as ch10::Date_ch10::number_to_day_name
sub number_to_day_name {
    my $num = shift;
    $num -= 1;
    if ($num >= 0 && $num <= 6) {
        return $day[$num];
    }
    else {
        print "Invalid number";
        exit;
    }

}

# This subroutine will be accessible as ch10::Date_ch10::number_to_mon_name
sub number_to_mon_name {
    my $num = shift;
    $num -= 1;
    die $num + 1, " is not a valid month number" unless $num >= 0 and $num <= 11;
    return $month[$num];
}



my $date_today = localtime()."\n";
sub date_10 {
    return $date_today;
}

1;

=begin :text

Мы назовем этот файл Date.pm в каталоге ch10 в одном из каталогов, указанных в нашей переменной @INC,
например в текущем каталоге с помощью:

use FindBin qw($Bin);
use lib "$Bin/ch10"; # в подкаталоге
use Date_ch10;

print "Name of day: ".ch10::Date_ch10::number_to_day_name(7)."\n";
print "Name of month: ".ch10::Date_ch10::number_to_mon_name(1)."\n";

=end :text

=cut
