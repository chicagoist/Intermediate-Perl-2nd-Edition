#!/usr/bin/perl -w

use 5.10.0;

use FindBin qw($Bin);
#use lib "$Bin/RaceHorse/lib"; # в подкаталоге
#use lib "$Bin/Horse/lib"; # в подкаталоге
#use lib "/home/legioner/Testing/share/perl/5.34.0";
#use lib "$Bin/Animal-Horse-Horse/lib"; # в подкаталоге

# use CGI;
use Encode qw(decode_utf8);
use Encode qw(decode encode);
#BEGIN{ $_ = map Encode::decode($_, 1) }
# BEGIN{@ARGV = map decode_utf8(#\$_, 1), @ARGV;}
use open qw(:std :encoding(UTF-8));
#use utf8::all 'GLOBAL';
#use Encode::Locale;
# use diagnostics;


use strict;
use warnings FATAL => 'all';
#use IPC::System::Simple;
#use autodie qw(:all);
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');

use Data::Dumper;
use Bundle::Camelcade;# for Intellij IDEA
use POSIX ();
use File::Spec;
use Cwd;

# File 16.2.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/

# С помощью модуля BUILD, а не make
# Создайте дистрибутивы классов Animal  и Horse  из главы 12. Добавьте к ним
# соответствующие описания подпрограмм в формате POD. Протестируйте модуль,
# установите его локально и соберите файл дистрибутива. Если найдете еще немного
# свободного времени, распакуйте модуль в другой каталог, определите новое значение
# параметра PREFIX и установите модуль еще раз, чтобы убедиться, что в файле
# дистрибутива имеется все необходимое.

#use Animal::Animal;
use RaceHorse::RaceHorse;
#use RaceHorse;


my $horse = RaceHorse->new(name => "Mr. Ed");
$horse->speak_print;
say $horse->color;
$horse->_private_set_color("grey");
say $horse->color;
$horse->won;
$horse->won;
$horse->won;
$horse->lost;
$horse->placed;
say $horse->standings;


=begin text





=end text

#

=cut

