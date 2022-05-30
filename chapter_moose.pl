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

use Horse;
use Sheep;
use Cow;
use Barn;
use Barn2;
use RaceHorse;
use Mouse;

my $m = Mouse->new;
my $color = $m->color;
say $m->color;
#$m->_private_set_color('green');
$m->color('green');   # DIES
say $m->color;


my $talking = Horse->new( name => "Mr. Ed" );
say $talking->name, ' is colored ', $talking->color;
$talking->color( "grey" ); # sets the color
say $talking->name, ' is colored ', $talking->color;
print "\n";
$talking->speak;

my $baab = Sheep->new(  name => 'Baab' );
$baab->speak;
say $baab->name, ' is colored by default ',$baab->color;

my $mickey = Mouse->new( name => 'Mickey' );
$mickey->speak;
say $mickey->default_color;

my $s = RaceHorse->new( name => 'Seattle Slew' );
$s->won;
$s->won;
$s->won;
$s->placed;
$s->lost;
print $s->standings, "\n"; # 3 wins, 1 places, 0 shows, 1 losses