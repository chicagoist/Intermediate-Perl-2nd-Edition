#!/usr/bin/perl -w


use 5.10.0;
# use CGI;
# use POSIX;
# use Encode qw(decode_utf8);
# use Encode qw(decode encode);
#= BEGIN{@ARGV=map Encode::decode(#\$_,1),@ARGV;}
# BEGIN{@ARGV = map decode_utf8(#\$_, 1), @ARGV;}
# use open qw(:std :encoding(UTF-8));
# use utf8::all 'GLOBAL';
# use Encode::Locale;
# use Encode;
# use diagnostics;


use strict;
use warnings FATAL => 'all';
use autodie qw(:all);
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use DDP;
use Data::Dumper;
use Bundle::Camelcade; # for Intellij IDEA

# sub check_required_items {
#     my $who = shift;
#     my $items = shift;
#     my @required = qw(солнечные_очки крем фляжка_с_водой накидка);
#     my @missing = ();
#
#     for my $item (@required) {
#         unless (grep $item eq $_, @$items) {# нет в списке?
#             print "$who: отсутствует $item.\n";
#             push @missing, $item;
#         }
#     }
#     if (@missing) {
#         print "Добавлены @missing в саквояж @$items пассажира $who.\n";
#         push @$items, @missing;
#     }
# }
#
# 1;

my %gilligan_info = (
    name => 'Джиллиган',
    hat => 'Белый',
    shirt => 'Красный',
    position => 'Первый помощник капитана', );

my %skipper_info = (
    name => 'Шкипер',
    hat => 'Черный',
    shirt => 'Голубой',
    position => 'Капитан', );

my @crew = (\%gilligan_info, \%skipper_info);

my $hash_ref = \%gilligan_info;

print join(" ", %gilligan_info) , "\n";
print join(" ", sort keys %{$hash_ref}) , "\n";

print $crew[1]{name} , "\n";
print @{$crew[1]}{name} , "\n";

my $ref_arr = \$crew[0];
print ${\%gilligan_info}{name} , "\n";
print ${${$ref_arr}}{name} , "\n";
print ${$ref_arr}->{name} , "\n";

