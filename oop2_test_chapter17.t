#!/usr/bin/perl
use strict;
use warnings;
#use Test::More tests => 4; # релиз модуля
use Test::More "no_plan";       # на время разработки
BEGIN{ use_ok('Horse') }

#use Horse;

my $trigger = Horse->new(name => 'Триггер');
isa_ok($trigger, 'Horse');

my $tv_trigger = Horse->new(name => 'Мистер Эд');
#print $tv_trigger->name."\n";
isa_ok($tv_trigger, 'Horse');

TODO: {
    local $TODO = 'horse can not yet talk';
    can_ok($tv_trigger, 'talk'); # она умеет говорить!
}
is($tv_trigger->name,'Мистер Эд', 'Я мистер Эд');

SKIP: {
    skip 'Module Mac::Speech not responsible ', 1 unless eval {require 'Horse'};
    ok($tv_trigger->say_it_aloud('Я мистер Эд'));
}

# Не повлияло ли создание второй лошади на кличку первой?
is($trigger->name, 'Триггер', 'правильное имя – Триггер');
is($tv_trigger->name, 'Мистер Эд', 'правильное имя – Мистер Эд');

is($tv_trigger->named, 'horse without name');

done_testing();

