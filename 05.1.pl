#!/usr/bin/perl -w

use 5.10.0;
# use CGI;
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
use POSIX();
use File::Spec;
use Cwd;

# File 05.1.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Сможете ли вы найти ошибку в следующем отрывке программы, не запуская его?
# Если ошибку не удастся обнаружить за одну-две минуты, попробуйте отыскать ее,
# запустив отрывок.

# my %passenger_1 = {
#     name       => 'Ginger',
#     age        => 22,
#     occupation => 'Movie Star',
#     real_age   => 35,
#     hat        => undef,
# };
#
# my %passenger_2 = {
#     name          => 'Mary Ann',
#     age           => 19,
#     hat           => 'bonnet',
#     favorite_food => 'corn',
# };
#
# my @passengers = (\%passenger_1, \%passenger_2);

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

print $crew[0]{name}, "\n\n";


my $passenger_1 = {
    name       => 'Ginger',
    age        => 22,
    occupation => 'Movie Star',
    real_age   => 35,
    hat        => undef,
};

my $passenger_2 = {
    name          => 'Mary Ann',
    age           => 19,
    hat           => 'bonnet',
    favorite_food => 'corn',
};

my @passengers = ($passenger_1, $passenger_2);

print $passengers[0]{name}, "\n";
print $passengers[1]->{favorite_food}, "\n";





=begin text

  $ perl 05.1.pl

 Джиллиган

 Ginger
 corn

=end text



=cut

# Верный ответ из книги:

