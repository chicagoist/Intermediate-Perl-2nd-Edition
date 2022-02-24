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

{
    print "\n\n\t# ОПЕРАТОРЫ СПИСКОВ\n\n";
    # Для работы со списками предназначен еще целый ряд операторов, о которых
    # вы уже узнали из книги «Learning Perl».

    # Оператор sort  упорядочивает входной список в алфавитном порядке.
    my @castaways = sort qw(Джиллиган Шкипер Джинджер Профессор Мери Энн);

    # Оператор reverse возвращает список в обратном порядке.
    my @castrevese = reverse qw(Джиллиган Шкипер Джинджер Профессор Мери Энн);

    print "@castaways\n";
    print "@castrevese\n";

}

{
    print "\n\n\t# ФИЛЬТРАЦИЯ СПИСКОВ С ПОМОЩЬЮ grep \n\n";
    # Оператор grep  принимает список значений и «условное выражение».
    # Он извлекает из списка одно значение за другим и помещает их в переменную $_.
    # После этого производится вычисление условного выражения в скалярном контексте.
    # Если в результате получается «истина», grep передает значение $_ в выходной список.

    # my @lunch_choices = grep &is_edible($_), @gilligans_posessions.

    # В списочном контексте оператор grep возвращает список всех прошедших проверку элементов,
    # а в скалярном – количество отобранных элементов.

    # my @results = grep EXPR, @input_list;
    # my $count = grep EXPR, @input_list;

    # В данном случае EXPR  означает любое скалярное выражение, которое должно выполнить
    # проверку значения переменной $_ (явно или неявно). Например, чтобы отыскать все числа
    # больше 10, в условном выражении можно сравнить переменную $_ со значением 10.
    eval {print "\1$_ = $_\n";};

    my @input_numbers = (1, 2, 4, 8, 16, 32, 64);
    my @bigger_than_10 = grep $_ > 10, @input_numbers;
    my $count_bigger_than_10 = grep $_ > 10, @input_numbers;

    print "\@input_numbers => @input_numbers\n";
    print "\@bigger_than_10 => @bigger_than_10\n";
    print "\$count_bigger_than_10 => $count_bigger_than_10\n";

    eval {print "\2$_ = $_\n";};

    # В следующем примере показано косвенное обращение к переменной $_
    # из оператора поиска по шаблону:

    my @end_in_4 = grep /4$/, @input_numbers;
    print "\@end_in_4 => @end_in_4\n"; # @end_in_4 => 4 64

    eval {print "\3$_ = $_\n";};

    # Оператор grep запоминает оригинальное значение переменной $_ и восстанавливает его по окончании работы.

    # Если условное выражение достаточно сложное, его можно оформить в виде подпрограммы:
    my @odd_digit_sum = grep digit_sum_is_odd($_), @input_numbers;

    sub digit_sum_is_odd {
        my $input = shift;
        my @digits = split //, $input; # Предполагается, что элемент списка содержит только цифровые символы
        my $sum;
        $sum += $_ for @digits;
        return $sum % 2;
    }
    print "\n\@odd_digit_sum => @odd_digit_sum\n";

    # Перепишем предыдущий пример, придерживаясь блочного синтаксиса:
    my @odd_digit_sum_block = grep {
    my $input = $_;
    my @digits = split //, $input; # Предполагается, что элемент списка
                                    # содержит только цифровые символы

    my $sum;
    $sum += $_ for @digits;
    $sum % 2;
    } @input_numbers;

    print "\n\@odd_digit_sum_block => @odd_digit_sum_block\n";

    # Разумеется, мы можем оптимизировать этот блок, отказавшись от промежуточных
    # переменных:

    my @odd_digit_sum_block_optim = grep {
    my $sum;
    $sum += $_ for split //;
    $sum % 2;
    } @input_numbers;

    print"\n\@odd_digit_sum_block_optim => @odd_digit_sum_block_optim\n";

}

{ print "\n\n\t# ПРЕОБРАЗОВАНИЕ СПИСКА С ПОМОЩЬЮ ОПЕРАТОРА map\n\n";
    # Оператор map  обладает похожим синтаксисом, и во многом его действия
    # напоминают оператор grep. Например, он временно помещает элементы
    # списка друг за другом в переменную $_ и допускает две формы записи:
    # в форме выражения и в форме блока.

    # Начнем с простого примера:
    my @input_numbers = (1, 2, 4, 8, 16, 32, 64);
    my @result = map $_ + 100, @input_numbers;
    my $result_scalar = map $_ + 100, @input_numbers;
    my @result_many = map { $_, 3 * $_ } @input_numbers;
    my %hash = map { $_, 3 * $_ } @input_numbers;

    print"\n\@result => @result\n";
    print"\n\@result_scalar => $result_scalar\n";
    print"\n\@result_many => @result_many\n";
    foreach (sort keys %hash) {
        print "$_ => ", $hash{$_}, "\n";
    } print "\n";

    # При этом для каждого входного элемента число выходных элементов может быть и разным.
    # Посмотрим, что произойдет, если мы попытаемся разбить числа на отдельные цифры:
    my @result_split = map { split //, $_ } @input_numbers;
    print "\@input_numbers => @input_numbers\n"; # @input_numbers => 1 2 4 8 16 32 64
    print "\@result_split => @result_split\n\n"; #    @result_split => 1 2 4 8 1 6 3 2 6 4

    # Допустим, что нам надо отобрать только отделенные (см. выше) цифры, если последняя из них 4:
    my @result_last_4 = map {
    my @digits = split //, $_;
    if ($digits[-1] == 4) {
        $digits[-1];
    } else {
    ( );
    }
    } @input_numbers;

    print "\@result_split => @result_split\n";
    print "\@result_last_4 => @result_last_4\n\n";

}

{ print "\n\n\t# ОРГАНИЗАЦИЯ ЛОВУШЕК ОШИБОК С ПОМОЩЬЮ eval \n\n";
    # незапланированный ход событий вовсе не означает, что надо смириться с аварийным
    # завершением программы. Для вылавливания разного рода ошибок Perl предоставляет оператор eval.

    my ($average, $total, $count);
    eval { $average = $total / $count; } ;
    print "Продолжение после ошибки: $@" if $@;

    $average = eval { $total / $count; } ;
    eval { print "\$average = $average\n";};
}

{ print "\n\n\t# ИСПОЛНЕНИЕ ПРОГРАММНОГО КОДА, СОЗДАННОГО ДИНАМИЧЕСКИ \n\n";
    # Существует еще одна форма обращения к оператору eval, когда в качестве параметра
    # выступает не блок кода, а строка. В этом случае компиляция и исполнение строки
    # производятся уже во время исполнения программы.  Такая возможность выглядит очень
    # удобной и полезной, но она чрезвычайно опасна, если в строку могут попасть данные,
    # полученные из ненадежного источника. Мы не рекомендуем вычислять строковые выражения
    # с помощью оператора eval, разве что в исключительных случаях. Мы рассмотрим эту
    # возможность чуть позже, и, кроме того, вы наверняка встретите такую форму записи
    # оператора eval  в чужих программах, поэтому мы покажем, как она применяется на практике:

    my $sum;
    eval '$sum = 2 + 2';
    print "Сумма = $sum\n";

    # Результатом оператора eval  является результат вычисления последнего выражения,
    # поэтому совершенно необязательно вставлять весь блок операторов в строку eval.
    foreach my $operator ( qw(+ - * /) ) {
    my $result = eval "2 $operator 0";
        print "Продолжение после ошибки: $@" if $@;
    eval {print "2 $operator 0 = $result\n";};
        print "Продолжение после ошибки: $@" if $@;
    }

    # Если eval  не сможет скомпилировать и исполнить программный код строки, которая
    # ему была передана, мы получим точно такое же значение переменной $@, как и в
    # случае использования eval  в блочной форме. В следующем примере мы хотели перехватить
    # ошибку деления на ноль, но в результате не смогли разделить число на «ничто»
    # (еще одна разновидность ошибки).
    print 'Частное: ', eval '5 /', "\n";
    warn $@ if $@;
}