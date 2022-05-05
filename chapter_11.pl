#!/usr/bin/perl -w


use 5.10.0;

use FindBin qw($Bin);
use lib "$Bin/ch11";# в подкаталоге

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

print "\n\n\t# Введение в объекты \n\n";

use Cow;
use Sheep;
use Horse;
use Mouse;
use Person;


# &Cow::speak('Cow');
# Horse::speak("Horse");
# &Sheep::speak("Sheep");
# Mouse::speak("Mouse");

#print "\n\t PASTURE\n";
#my @pasture = qw(Cow Cow Horse Sheep Sheep);
# foreach my $beast (@pasture) {
#     no strict 'refs';
#     eval &{$beast."::speak($beast)"};# символическая ссылка на подпрограмму
# }

# print "\n\t Вызов метода с помощью оператора «стрелка» \n";
#
# Cow->speak;
# Horse->speak;
# Sheep->speak;
# Mouse->speak;

print "\n\t PASTURE «стрелка»\n";
my @pasture = qw(Cow Cow Horse Sheep Sheep);
foreach my $beast (@pasture) {
    no strict 'refs';
    $beast->speak;# символическая ссылка на подпрограмму
}

my @house = qw(Mouse);
print "\n\t HOUSE «стрелка»\n";
foreach my $beast (@house) {
    no strict 'refs';
    $beast->speak;# символическая ссылка на подпрограмму
}

my @barnyard = ();
{
    print "\nenter an animal (empty to finish): ";
    chomp(my $animal = <STDIN>);
    $animal = ucfirst lc $animal;
    last unless $animal =~ /^(Cow|Horse|Sheep|Mouse)$/;
    push @barnyard, $animal;
    redo;
}

print "\nExercises 1\n";
foreach my $beast (@barnyard) {
    $beast->speak;
}

Person->speak;
Person->speak("Hello, world!");