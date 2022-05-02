#!/usr/bin/perl -w


use 5.10.0;
# use CGI;
# use POSIX;
# use Encode qw(decode_utf8);
# use Encode qw(decode encode);
#= BEGIN{@ARGV=map Encode::decode(#\$_,1),@ARGV;}
# BEGIN{@ARGV = map decode_utf8(#\$_, 1), @ARGV;}
# use open qw(:std :encoding(UTF-8));
use utf8::all 'GLOBAL';
# use Encode::Locale;
# use Encode;
# use diagnostics;
#BEGIN { unshift @INC, '/home/legioner/perl_lib'; };
use lib qw(/home/legioner/perl_lib);

use strict;
use warnings FATAL => 'all';
use autodie qw(:all);
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use Data::Dumper;
use Bundle::Camelcade;# for Intellij IDEA
use YAML;
use DDP;

print "\n\n\t# Разработка больших программ\n\n";

# В этой главе рассказано, как поделить программу на отдельные блоки, а также о некоторых трудностях,
# возникающих при объединении частей в одну программу, например когда отдельные блоки создаются разными
# разработчиками.

print join("\n", @INC), "\n";

# sub Cow::speak
# {
#     print "Корова: му у у у!\n";
# }
#
# sub Horse::speak
# {
#     print "Лошадь: иго го!\n";
# }
#
# sub Sheep::speak
# {
#     print "Овца: бе е е е!\n";
# }

my @pasture = qw(Cow Cow Horse Sheep Sheep);

my %animal;
foreach my $beast (@pasture)
{
    #no strict 'refs';
    #&{$beast . "::speak"};# символическая ссылка на подпрограмму
    $animal{$beast} = "->speak($beast)";

}

print "\n\n";

# foreach (keys %animal) {
#
#    eval {$_->speak;}
# }

# Class

sub Cow::speak
{
    my $class = shift;
    print "$class: му у у!\n";
}

sub Horse::speak
{
    my $class = shift;
    print "$class: иго го!\n";
}

sub Sheep::speak
{
    my $class = shift;
    print "$class: бе е е е!\n";
}

foreach (keys %animal)
{

    eval { $_->speak($_); }
}

{ package Cow;
sub sound
{ 'му у у у' };
sub speaks
{

    my $class = shift;
    print "$class: ", $class->sound, "!\n";
}

Cow->speaks;
}
Cow->speaks;
Cow->speak;

