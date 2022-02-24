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

chdir; # переход в домашний каталог
# while( 1 ) {
#     print "Введите регулярное выражение > ";
#     chomp( my $regex = <STDIN> );
#     last unless( defined $regex && length $regex );
#     print map { "    $_\n" } grep { eval{ /$regex/ } }glob( ".* *" );
# }

my $ref_to_gilligan_info = {
    name     => 'Джиллиган',
    hat      => 'Белый',
    shirt    => 'Красный',
    position => 'Первый помощник капитана',
};

my $ref_skipper_info = {
    name     => 'Шкипер',
    hat      => 'Черный',
    shirt    => 'Голубой',
    position => 'Капитан',
};

my @crew = ($ref_to_gilligan_info, $ref_skipper_info);

print $crew[0]{name};
