#!/usr/bin/perl -w
use 5.10.0;
use strict;
use warnings FATAL => 'all';
use utf8;

print "\n\n\t# The intersection of these arrays\n\n";
my @A = (0 ... 10);
my @B = (3 ... 25);
my @AA = ("a" ... "g");
my @BB = ("f" ... "z");

print "\nOne way\n";
sub one_way
{

    my (@array_one) = @{$_[0]};
    my (@array_two) = @{$_[1]};

    my %in_file = map {$_ => 1} @array_one;

    foreach (@array_two)
    {
        if (exists $in_file{$_})
        {
            print "$_ ";
        }
    }
}
one_way(\@A, \@B);

print "\n\nThere is one more way.\n";
sub another_way
{

    my (@array_one) = @{$_[0]};
    my (@array_two) = @{$_[1]};

    for my $i (@array_one)
    {
        if (grep {$i eq $_} @array_two)
        {
            print "$i ";
        }
    }
}
another_way(\@AA, \@BB);
print "\n\n";
print "\@A : @A\n";
print "\@B : @B\n";
print "\@AA : @AA\n";
print "\@BB : @BB\n";


