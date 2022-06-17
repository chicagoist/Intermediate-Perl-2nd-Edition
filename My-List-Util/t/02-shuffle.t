#!perl
use 5.010;
use strict;
use warnings;
use Test::More 'no_plan';

#plan tests => 1;
use My::List::Util;

my $foo = My::List::Util->new();
isa_ok($foo,'My::List::Util');
my $tests = [qw(5 6 7)];
my $shuffled = $tests;
my @test_array;

can_ok($foo, $_) for qw(shuffle);
ok( @test_array = $foo->shuffle(@$shuffled), 'Возвращённое значение' ) || print "Bail out!\n";
my $same_count = 0;
foreach my $index ( 0 .. $#$tests ) {
    $same_count++ if $test_array[$index] eq $tests->[$index];
}
cmp_ok( $same_count, '<', $#$tests,'Различия обнаружены, по крайней мере, в двух позициях');


diag( "Testing My::List::Util $My::List::Util::VERSION, Perl $], $^X" );
