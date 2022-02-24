#!/usr/bin/perl -w


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
use YAML;


{
    print "\n\n\t# УПРАВЛЕНИЕ СЛОЖНЫМИ СТРУКТУРАМИ ДАННЫХ\n\n";

    print "# Использование отладчика для просмотра данных со сложной структурой\n\n";

    # {
    #     my %total_bytes;
    #     while (<>) {
    #         my ($source, $destination, $bytes) = split;
    #         $total_bytes{$source}{$destination} += $bytes;
    #     }
    #     for my $source (sort keys %total_bytes) {
    #         for my $destination (sort keys %{$total_bytes{$source}}) {
    #             print "$source => $destination:", " $total_bytes{$source}{$destination} bytes\n";
    #         }
    #         print "\n\n";
    #     }
    #     print "# Просмотр данных со сложной структурой с помощью модуля Data::Dumper \n";
    #     print Dumper \%total_bytes;
    #
    #     print "\n\n";
    #     print "# YAML (Yet Another Markup Language – еще один язык размет) \n\n";
    #
    #     use YAML;
    #     print Dump(\%total_bytes);
    #
    #     1;
    # }

    print "\n\n";

}

print "# включить возможность работы # с перекрестными ссылками \n\n";

$Data::Dumper::Purity = 1; #

my @data1 = qw(one won);
my @data2 = qw(two too to);
push @data2, \@data1;
push @data1, \@data2;
print Dumper(\@data1, \@data2);


print "\n\n# Сохранение данных со сложной структурой с помощью модуля Storable  \n\n";

use Storable;
store [\@data1, \@data2], 'some_file';

my $result = retrieve 'some_file';
$Data::Dumper::Purity = 1; # включить возможность работы с перекрестными ссылками

print Dumper($result), "\n\n";
print Dumper(@$result);


{print "\n\n# Операторы grep и map \n\n";
     # По мере роста степени сложности структур данных все большее значение
    # начинают приобретать конструкции высокого уровня, позволяющие решать
    # задачи по извлечению  и преобразованию данных. В этом отношении операторы
    # языка Perl grep и map обладают непревзойденными возможностями.


    print "# Обходное решение  \n";

    my @input_numbers = (1, 2, 4, 8, 16, 32, 64);
    my @indices_of_odd_digit_sums = grep {
        my $number = $input_numbers[$_];
        my $sum;
        # $sum += $_ for split //, $number;
        $sum += $_ foreach split //, $number;
        #say  foreach split //, $number;
        $sum % 2;
    } 0..$#input_numbers;

    print join(" ", @input_numbers[ @indices_of_odd_digit_sums ]), "\n\n";

    my @x = (0..int(rand(10)));
    my @y = (0..int(rand(8)));

    print "\@x = @x\n";
    print "\@y = @y\n";

    my @bigger_indices = grep {
        if ($_ > $#y or $x[$_] > $y[$_]) {
            $_; # да, выбрать
        }
        else {
            0; # нет, не выбирать
        }
    } 0 .. $#x;
    my @bigger = @x[@bigger_indices];

    print "@bigger\n";

    my @bigger_indices_2 = grep {
        $_ > $#y or $x[$_] > $y[$_];
    } 0 .. $#x;
    my @bigger_2 = @x[@bigger_indices_2];

    print "@bigger_2\n";

    my @bigger_3 = map {
        if ($_ > $#y or $x[$_] > $y[$_]) {
            $x[$_];
        }
        else {
            ();
        }
    } 0 .. $#x;
    print "@bigger_3\n";


}

{print "\n# Выбор и модификация данных со сложной структурой  \n\n";

    my %provisions = (
        'Шкипер'    => [ qw(голубая_рубашка шляпа накидка солнечные_очки ) ],
        'Профессор' => [ qw(солнечные_очки фляжка_с_водой рулетка батарейки радиоприемник) ],
        'Джиллиган' => [ qw(красная_рубашка шляпа счастливые_носки фляжка_с_водой) ],
    );

    # Попробуем ответить на некоторые вопросы, касающиеся этих данных. Вопрос первый: кто взял с
    # собой меньше пяти предметов?
    my @packed_light = grep @{ $provisions{$_} } < 5, keys %provisions;

    print "\@packed_light = @packed_light\n";

    # Следующий вопрос чуть сложнее. Кто взял с собой фляжку с водой?
    my @all_wet = grep {
        my @items = @{$provisions{$_}};
        grep $_ eq 'фляжка_с_водой', @items;
    } keys %provisions;

    print "\@all_wet = @all_wet\n";

    # Первый элемент – это имя персонажа, а второй – ссылка на  массив с предметами экипировки,
    # принадлежащими данному персонажу:
    my @remapped_list = map {
        [ $_ => $provisions{$_} ];
    } sort keys %provisions;

    print  $remapped_list[0]->[0], ": ";
    print $remapped_list[0]->[1][0], "\n";
    print Dump $remapped_list[0][1]; print "\n\n";

    print  $remapped_list[1]->[0], ": ";
    print $remapped_list[1]->[1][0], "\n";
    print Dump $remapped_list[1][1]; print "\n\n";

    # Превратим хеш в серию ссылок на массивы. Каждый массив будет содержать имя персонажа
    # и один из предметов экипировки, принадлежащий ему:
    my @person_item_pairs = map {
        my $person = $_;
        my @items = @{$provisions{$person}};
        map [ $person => $_ ], @items;
    } sort keys %provisions;
    print $person_item_pairs[0][0], "\n";
    print $person_item_pairs[1][0], "\n";
    print $person_item_pairs[2][0], "\n";
    print $person_item_pairs[3][0], "\n";
    print $person_item_pairs[4][0], "\n";
    print $person_item_pairs[1][1], "\n";


}