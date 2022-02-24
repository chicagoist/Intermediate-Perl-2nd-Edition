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

# File 04.1.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# К скольким различным элементам обращаются следующие строки?

# $ginger >[2][1]
# ${$ginger[2]}[1]
# $ginger >[2] >[1]
# ${$ginger >[2]}[1]

my @first_arr = qw(a b c );
my @second_arr = qw(d e f);
my @third_arr = qw(g h i);

my @all_arr = (\@first_arr, \@second_arr, \@third_arr);
my $ginger = \@all_arr;
my @gingerR = (\@first_arr, \@second_arr, \@third_arr);

# print $ginger->[2][1];


print $ginger->[2][1] , "\n";

print ${$gingerR[2]}[1] , "\n"; # same
print @{$gingerR[2]}[1] , "\n"; # same
print $gingerR[2][1] , "\n"; # same

print $ginger->[2]->[1] , "\n";
print ${$ginger->[2]}[1] , "\n";


=begin text

  $ perl 04.1.pl
 h
 h
 h
 h
 h
 h

=end text



=cut

# Верный ответ из книги:

# Все они обращаются к одному и тому же элементу, за исключением второй строки,
# ${$ginger[2]}[1].
# Эту строку можно привести к виду $ginger[2][1]. Она обращается к массиву @ginger,
# а не к скалярной переменной $ginger.