#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 9;

sub test_sub {'10000'}

is($@, '', 'изначально $@ ничего не содержит'); # $@ переменная глобальной ошибки
{
    my $n = -1;
    eval {sqrt($n)};
    ok($@, 'после sqrt(-1) в $@ появилось сообщение');
}

eval {sqrt(1)};
is($@, '', 'после sqrt(1) в $@ ничего нет');

{
    my $n = -100;
    eval {sqrt($n)};
    ok($@, 'после sqrt(-100) в $@ появилось сообщение');
}

is(sqrt(test_sub()), 100, 'Строковые значения цифр допустимы в sqrt()');

eval{sqrt(undef)};
is($@, '', 'после sqrt(undef) в $@ ничего нет');

is(sqrt, 0, 'по-умолчанию sqrt() работает с $_ (undefined)');

$_ = 100;
is(sqrt, 10, 'по-умолчанию sqrt() работает с $_');

is(sqrt(10 ** 100), 10**50, 'sqrt() справилась с числом гугол');



done_testing();

