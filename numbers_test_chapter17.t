#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 4; # релиз модуля
#use Test::More "no_plan";       # на время разработки

is(1 + 2, 3, '1 + 2 == 3');
ok(2 * 4 == 8, '2 * 4 == 8');
my $divide = 5 / 3;
print $divide."\n";
ok(abs($divide - 1.666667) > 0.001, '5 / 3 == (примерно) 1.666667');
my $subtract = -3 + 3;
ok(($subtract eq '0' or $subtract eq '-0'), '-3 + 3 == 0');

done_testing();

