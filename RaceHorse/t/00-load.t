#!perl
use 5.010;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'RaceHorse::RaceHorse' ) || print "Bail out!\n";
}

diag( "Testing RaceHorse::RaceHorse $RaceHorse::RaceHorse::VERSION, Perl $], $^X" );
