#!perl
use 5.010;
use strict;
use warnings;
use Test::More 'no_plan';

#plan tests => 1;
use My::List::Util;

my $foo = My::List::Util->new();
isa_ok($foo,'My::List::Util');
my @tests = ();
can_ok($foo, $_) for qw(shuffle);
ok( $foo->shuffle(5,6,7),'Возвращённое значение' ) || print "Bail out!\n";

diag( "Testing My::List::Util $My::List::Util::VERSION, Perl $], $^X" );
