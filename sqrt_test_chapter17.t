#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 6;

is(sqrt(0), 0, 'Корень квадратный из 0 = 0');
is(sqrt(1), 1, 'Корень квадратный из 1 = 1');
is(sqrt(49), 7, 'Корень квадратный из 49 = 7');
is(sqrt(100), 10, 'Корень квадратный из 100 = 10');

is(sqrt(0.25), 0.5, 'Корень квадратный из 0.25 = 0.5');

my $product = sqrt(7) * sqrt(7);

ok( $product > 6.999 && $product < 7.001,
     "Произведение [$product] приблизительно равно 7");



done_testing();

