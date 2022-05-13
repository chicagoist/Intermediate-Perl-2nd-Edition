#!/usr/bin/perl -w

use 5.10.0;

use FindBin qw($Bin);
use lib "$Bin/ch11"; # в подкаталоге

# use CGI;
use Encode qw(decode_utf8);
use Encode qw(decode encode);
BEGIN{ $_ = map Encode::decode(\$_, 1) }
# BEGIN{@ARGV = map decode_utf8(#\$_, 1), @ARGV;}
use open qw(:std :encoding(UTF-8));
use utf8::all 'GLOBAL';
use Encode::Locale;
# use diagnostics;


use strict;
use warnings FATAL => 'all';
use IPC::System::Simple;
use autodie qw(:all);
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');

use Data::Dumper;
use Bundle::Camelcade;# for Intellij IDEA
use POSIX ();
use File::Spec;
use Cwd;

#require 'Date_10.pm';
use Horse;
use Sheep;

# File 12.1.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/

# Добавьте в класс Animal возможность чтения и записи клички и цвета животного.
# Вы должны обеспечить  работоспособность программного кода в режиме use strict.
# Кроме того, методы чтения должны иметь возможность работать как с экземпляром класса,
# так и с именем класса. Проверьте работоспособность с помощью следующего отрывка:

my $tv_horse = Horse->named('Эд');
$tv_horse->set_name('мистер Ed');
$tv_horse->set_color('серый');
print $tv_horse->name, ' окрашен в ', $tv_horse->color, " цвет\n";
print Sheep->name, ' окрашена в ', Sheep->color, ' цвет и издает звук ', Sheep->sound, "\n";


=begin text

$ perl chapter_12.pl

 мистер Ed окрашен в серый цвет
 Sheep без имени окрашена в белый цвет и издает звук бе е е е!!


=end text

#

=cut

