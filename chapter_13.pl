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

print "\n\n# Уничтожение объектов\n\n";
#
# ## добавить классы животных из предыдущей главы...
# sub feed_a_cow_named {
#     my $name = shift;
#     my $cow = Cow->named($name);
#     $cow->eat('траву');
#     print "Возврат из подпрограммы.\n";# в этой точке объект $cow  будет уничтожен
# }

print "\n\n# Уничтожение вложенных объектов\n\n";
# Если объект содержит в себе другие объекты (например, в виде элементов массива или значений элементов хеша),
# Perl вызовет метод DESTROY объекта-контейнера еще до того, как начнется процесс уничтожения вложенных объектов.
# Это вполне разумно, поскольку объект-контейнер может использовать вложенные объекты для корректного завершения
# своей работы. Чтобы продемонстрировать это на конкретном примере, попробуем построить «коровник» и затем
# разрушить его. А чтобы сделать пример более интересным, создадим объект не в виде ссылки на хеш, а в виде
# ссылки на массив.

# print "Начало программы.\n";
# my $outer_cow = Cow->named('Бесси');
# print "Появилась корова по кличке ", $outer_cow->name, ".\n";
# feed_a_cow_named('Гвен');
# print "После возврата из подпрограммы.\n";


# my $barn = Barn->new;
# $barn->add(Cow->named('Бесси'));
# $barn->add(Cow->named('Гвен'));
# print "Коровник сгорел:\n";
# $barn = undef;
# print "Конец программы.\n\n";
#
# $barn = Barn->new;
# my @cows = (Cow->named('Бесси'), Cow->named('Гвен'));
# $barn->add($_) for @cows;
# print "Коровник сгорел:\n";
# $barn = undef;
# print "Пропали коровы:\n";
# @cows = ( );
# print "Конец программы.\n\n";
#
# $barn = Barn2->new;
# $barn->add(Cow->named('Бесси'));
# $barn->add(Cow->named('Гвен'));
# print "Коровник сгорел:\n";
# $barn = undef;
# print "Конец программы.\n\n";


print "\n\n# Вторичная переработка\n\n";
#
# my @tv_horses = map Horse->named($_), ('Триггер', 'мистер Эд');
# $_->eat('яблоко') for @tv_horses;# их последний прием пищи
# print "Конец программы.\n\n";
#
# my @race_horses = map RaceHorse->named($_), ('Триггер', 'мистер Эд');
# $_->won for @race_horses;# их последний прием пищи
# print map { $_->name, ' has standings of: ', $_->standings, ".\n" } @race_horses;
#
# print "Конец программы.\n\n";
#
# my $racer = RaceHorse->named('Billy Boy');
# # record the outcomes: 3 wins, 1 show, 1 loss
# $racer->won;
# $racer->won;
# $racer->won;
# $racer->showed;
# $racer->lost;
# print $racer->name, ' занял мест ', $racer->standings, ".\n\n";
#
# {
#     my @cows = map Cow->named($_), qw(Бесси Гвен);
#     my @horses = map Horse->named($_), ('Триггер', 'мистер Эд');
#     my @racehorses = RaceHorse->named('Билли Бой');
# }
# print "Список животных:\n", map(" $_\n", Animal->registered);
# print "Конец программы.\n";
#
# my @horses = map Horse->named($_), qw(Триггер мистер-Эд);
# print "Список животных перед входом в блок:\n", map(" $_\n", Animal->registered);
# {
#     my @cows = map Cow->named($_), qw(Бесси Гвен);
#     my @racehorses = RaceHorse->named('Билли Бой');
#     print "Список животных внутри блока:\n", map(" $_\n", Animal->registered);
# }
# print Animal->registered;
# print "Список животных, оставшихся в живых по выходе из блока:\n", map(" $_\n", Animal->registered);
# print "Конец программы.\n";
my $runner = RaceHorse->new(name => 'Billy');
$runner->won;
$runner->won;
$runner->won;
$runner->placed;
$runner->lost;

print $runner->name, ' занял мест ', $runner->standings, ".\n";