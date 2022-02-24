#!/usr/bin/perl -w

use 5.10.0;
# use CGI;
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
use POSIX();
use File::Spec;
use Cwd;

# File 04.2.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Опираясь на последнюю версию подпрограммы check_required_items,
# напишите подпрограмму check_items_for_all, которая принимала бы
# ссылку на хеш в качестве единственного аргумента и выводила бы
# список пассажиров, взошедших на борт «Minnow», и список предметов,
# поднятых ими на борт. Хеш ссылок можно сконструировать примерно
# следующим образом:

# my @gilligan = ... вещи, принадлежащие Джиллигану ...;
# my @skipper = ... вещи, принадлежащие Шкиперу ...;
# my @professor = ... вещи, принадлежащие Профессору ...;
# my %all = (Gilligan => \@gilligan,Skipper => \@skipper,Professor => \@professor);
# check_items_for_all(\%all);

# Созданная подпрограмма должна обращаться к check_required_items для проверки каждого
# из пассажиров и членов экипажа и дополнения списка необходимыми предметами.

sub check_items_for_all {
    my $data = shift;
    # print Dumper(keys %$data);

    for my $names (sort keys %{$data}) {
        check_required_items($names, $data->{$names});
    }
}


sub check_required_items {
    my $who = shift;
    my $items = shift;
    my @required = qw(солнечные_очки крем фляжка_с_водой накидка);
    my @missing = ();

    for my $item (@required) {
        unless (grep $item eq $_, @$items) {
            # нет в списке?
            print "$who: отсутствует $item.\n";
            push @missing, $item;
        }
    }

    if (@missing) {
        print "Добавлены @missing в саквояж @$items пассажира $who.\n\n";
        push @$items, @missing;
    }
}

my @skipper = qw(голубая_рубашка шляпа накидка солнечные_очки крем);
# my @skipper_with_name = ('Шкипер', \@skipper);
my @professor = qw(крем фляжка_с_водой рулетка батарейки радиоприемник);
# my @professor_with_name = ('Профессор', \@professor);
my @gilligan = qw(красная_рубашка шляпа счастливые_носки фляжка_с_водой);
# my @gilligan_with_name = ('Джиллиган', \@gilligan);

my %all = (Gilligan => \@gilligan,Skipper => \@skipper,Professor => \@professor);
check_items_for_all(\%all);





=begin text

  $ perl 04.2.pl

 Gilligan: отсутствует солнечные_очки.
 Gilligan: отсутствует крем.
 Gilligan: отсутствует накидка.
 Добавлены солнечные_очки крем накидка в саквояж красная_рубашка шляпа счастливые_носки фляжка_с_водой пассажира Gilligan.

 Professor: отсутствует солнечные_очки.
 Professor: отсутствует накидка.
 Добавлены солнечные_очки накидка в саквояж крем фляжка_с_водой рулетка батарейки радиоприемник пассажира Professor.

 Skipper: отсутствует фляжка_с_водой.
 Добавлены фляжка_с_водой в саквояж голубая_рубашка шляпа накидка солнечные_очки крем пассажира Skipper.


=end text



=cut

# Верный ответ из книги:

