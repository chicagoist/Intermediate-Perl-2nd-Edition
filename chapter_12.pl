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

print "\n\n\t# Объекты и данные \n\n";

# Мы научились описывать общий программный код в одном месте и разобрались с возможностью многократного
# использования одной и той же реализации с некоторыми изменениями и дополнениями. Все это составляет
# основу объектов, но каждый экземпляр того или иного объекта может иметь собственные данные, которые
# называются данными экземпляра, о чем мы с вами еще не говорили.
use Horse;
use Sheep;

# my $name = 'Mr.Ed';
# my $tv_horse = \$name;
# bless $tv_horse, 'Horse';


    my $tv_horse = Horse->named('Mr.Ed'); #
    #my $tv_horse = Horse::named('Horse', 'Mr.Ed');


my $noise = $tv_horse->sound;
print "$noise\n";
print Horse::sound()."\n";

print "\n\n# Доступ к данным экземпляра \n\n";

print $tv_horse->name, ": ", $tv_horse->sound, "\n";
#print Horse::name($tv_horse)."\n";
print $tv_horse->speak. "\n";

print Horse->name, "\n"; # выведет "Horse без имени\n"
#print Horse::name('Horse'), "\n"; # выведет "Horse без имени\n"
print $tv_horse->name, "\n"; # выведет "мистер Эд\n"

$tv_horse->eat('сено');
Sheep->eat('траву');

# Методу экземпляра с параметрами при вызове передается ссылка на экземпляр и вслед за ним список параметров.
# Таким образом, первый вызов выглядит так:

# Animal::eat($tv_horse, 'сено');

# Методы экземпляров формируют прикладной программный интерфейс объекта (Application Programming Interface – API).
# Большая часть усилий, затрачиваемых на проектирование класса, связана с проработкой интерфейса, поскольку именно
# прикладной интерфейс определяет способы использования и сопровождения объекта и порожденных от него классов.
# Не торопитесь зафиксировать интерфейс, пока не разберетесь до конца, как вы (или другие) будете
# использовать объект.

print "\n\n# Более сложные экземпляры \n\n";

# Попробуем создать овцу, которая будет иметь не только кличку, но ицвет:

my $lost = bless { Name => 'Бо', Color => 'белый' }, 'Sheep';
#$tv_horse = Horse->named('мистер Эд');
$tv_horse = Horse->named('мистер Эд')->set_color('серый')->set_age(4)->set_height('17 пядей');



print $tv_horse->color."\n";
$tv_horse->set_color('черный с белыми пятнами');

print $lost->{Name}."\n";
print $lost->name."\n";
print $lost->{Color}."\n";
print $tv_horse->default_color."\n";
print $tv_horse->color."\n";
print $tv_horse->{Color}."\n";
print $tv_horse->name."\n";
print $tv_horse->{Age}."\n";

print "\n\n# Что возвращать \n\n";


