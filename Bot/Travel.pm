#!/usr/bin/perl -w
package Bot::Travel;

use 5.10.0;
# use CGI;
# use POSIX;
# use Encode qw(decode_utf8);
# use Encode qw(decode encode);
#= BEGIN{@ARGV=map Encode::decode(#\$_,1),@ARGV;}
# BEGIN{@ARGV = map decode_utf8(#\$_, 1), @ARGV;}
# use open qw(:std :encoding(UTF-8));
# use utf8::all 'GLOBAL';
# use Encode::Locale;
# use Encode;
# use diagnostics;


use strict;
use warnings FATAL => 'all';
use autodie qw(:all);
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use DDP;
use Data::Dumper;
use Bundle::Camelcade; # for Intellij IDEA


sub check_required_items {
    my $who = shift;
    my $items = shift;
    my @required = qw(солнечные_очки крем фляжка_с_водой накидка);
    my @missing = ();

    for my $item (@required) {
        unless (grep $item eq $_, @$items) {# нет в списке?
            print "$who: отсутствует $item.\n";
            push @missing, $item;
        }
    }
    if (@missing) {
        print "Добавлены: @missing в саквояж c @$items. Пассажира $who.\n\n";
        push @$items, @missing;
    }
}

# Ключевой является последняя строка подпрограммы. Здесь мы разыменовали ссылку
# на оригинальный массив $items и добавили в него содержимое массива @missing.
# При отсутствии ссылки на массив мы смогли бы изменить только локальную копию данных,
# что никак не повлияло бы на сам массив. Кроме того, запись @$items (и более
# универсальная форма @{$items}) может применяться внутри строк, заключенных в
# двойные кавычки. Между символом @ и остальной частью ссылки нельзя вставлять пробелы,
# зато внутри фигурных скобок они вполне допустимы, как в обычном программном коде Perl.



1;