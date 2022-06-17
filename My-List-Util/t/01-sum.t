#!perl
use 5.010;
use strict;
use warnings;
use Test::More 'no_plan';

#plan tests => 3;

use My::List::Util;

my $foo = My::List::Util->new();
isa_ok($foo,'My::List::Util');
can_ok($foo, $_) for qw(sum);
ok( $foo->sum(5,6,7) == 18,'Сумма верна 18' ) || print "Bail out!\n";
ok( $foo->sum(5,6,-7) == 4,'Сумма верна 4' ) || print "Bail out!\n";
ok( $foo->sum(1) == 1,'Сумма верна 1' ) || print "Bail out!\n";
ok( $foo->sum(-1) == -1,'Сумма верна -1' ) || print "Bail out!\n";
ok( $foo->sum(-0) == 0,'Сумма верна 0' ) || print "Bail out!\n";
ok( $foo->sum() == 0,'Сумма верна 0' ) || print "Bail out!\n";

diag( "Testing My::List::Util $My::List::Util::VERSION, Perl $], $^X" );
