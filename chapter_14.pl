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
use Animal;


# my @tv_horses = map Horse->named($_), ('Триггер', 'мистер Эд');
# $_->eat('яблоко') for @tv_horses;# их последний прием пищи

my $racer = Horse->named('Billy Boy');