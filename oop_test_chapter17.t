#!/usr/bin/perl
use strict;
use warnings;
#use Test::More tests => 4; # релиз модуля
use Test::More "no_plan";       # на время разработки

use Horse;

my $trigger = Horse->new(name => 'Триггер');
isa_ok($trigger, 'Horse');
isa_ok($trigger, 'Animal');
isa_ok($trigger, 'Human');
can_ok($trigger, $_) for qw(eat color);


done_testing();

