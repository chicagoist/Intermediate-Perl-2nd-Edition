#!/usr/bin/perl -w


use 5.10.0;
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

print "\n\n\t# ПРАКТИЧЕСКИЕ ПРИЕМЫ РАБОТЫ СО ССЫЛКАМИ\n\n";

my @A = (0 ... 10);
my @B = (3 ... 25);
my @AA = ("a" ... "g");
my @BB = ("f" ... "z");


print "\nOne way\n";
sub one_way
{

    my (@array_one) = @{$_[0]};
    my (@array_two) = @{$_[1]};

    my %in_file = map {$_ => 1} @array_one;

    foreach (@array_two)
    {
        if (exists $in_file{$_})
        {
            print "$_ ";
        }
    }
}

one_way(\@A, \@B);

print "\nThere is one more way.\n";

sub another_way
{

    my (@array_one) = @{$_[0]};
    my (@array_two) = @{$_[1]};

    for my $i (@array_one)
    {
        if (grep {$i eq $_} @array_two)
        {
            print "$i ";
        }
    }
}

another_way(\@AA, \@BB);

print "\n\n";
print "\@A : @A\n";
print "\@B : @B\n";
print "\@AA : @AA\n";
print "\@BB : @BB\n\n";


#my @input = qw(Джиллиган Шкипер Профессор Джинджер Мэри_Энн);
my @input = qw(Джиллиган Торстон Шкипер Профессор Ловей Джинджер Мэри_Энн);
my @sorted_positions = sort { $input[$a] cmp $input[$b] } (0..$#input);
my @ranks;
@ranks[@sorted_positions] = (0..$#sorted_positions);
#@ranks[@sorted_positions] = (1..@sorted_positions);

# for (0..$#ranks) {
#     print "Имя $input[$_] переместится в позицию $ranks[$_]\n";
# }

print '<@sorted_positions> = ' . "@sorted_positions\n";
print '<@input> = ' . "@input\n";

print "\@input:\n";
p @input;

print "\@sorted_positions:\n";
p @sorted_positions;


my @test_rank = (1..@sorted_positions);
print '@test_rank'."\n";
p @test_rank;


print '\@ranks[@sorted_positions] 1:'."\n";
p @ranks[@sorted_positions];

print '\@ranks[@sorted_positions] 2:'."\n";
p @ranks[@sorted_positions];

print'@ranks'."\n";
p @ranks;

print '<@ranks[@sorted_positions]> = '. "@ranks[@sorted_positions]\n";
print '<@ranks> = '. "@ranks\n\n";

print  sort { $a <=> $b } 1, 2, 4, 8, 16, 32;
say"\n";
my @castaways = qw(Джиллиган Шкипер Профессор Джинджер Мэри_Энн Торстон Ловей);

sub ask_monkey_about {
    my($name) = shift @_;
    for (0..$#castaways) {
        if ($castaways[$_] eq $name ) {
            return $_;
        }
    }
}

my @names_and_pineapples = map {[ $_, ask_monkey_about($_) ]} @castaways;
p @names_and_pineapples;

my @sorted_names_and_pineapples = sort {$b->[1] <=> $a->[1];} @names_and_pineapples;
p @sorted_names_and_pineapples;

my @names = map $_->[0], @sorted_names_and_pineapples;
p @names;

print "\n\n\t# Преобразование Шварца\n\n";

# Мы можем упростить решение задачи, объединив все шаги:
my @names1 =
    map $_->[0],
        sort { $b->[1] <=> $a->[1] }
            map [$_, ask_monkey_about($_)], @castaways;
p @names1;

# Поскольку операторы map и sort выполняются справа налево, мы должны читать эту конструкцию снизу вверх.
# Если это преобразование покажется вам сложным для запоминания или вы хотите понять основные его принципы,
# вам поможет следующая схема, в которой мы выделили постоянные и изменяемые части:
# my @output_data =
#     map $_->[0],
#     sort { СРАВНЕНИЕ ПАР ЭЛЕМЕНТОВ $a->[1] И $b->[1] }
#     map [$_, ВЫЗОВ ДОРОГОСТОЯЩЕЙ ФУНКЦИИ ОТ $_],
#     @input_data;
my @output_data =
    map $_->[0],
    sort { $a->[1] cmp $b->[1] }
    map [ $_, "\U$_" ],
    @castaways;
p @output_data;

print "\n\n\t# Многоуровневая сортировка на основе преобразования Шварца \n\n";

# Если необходимо отсортировать данные в соответствии с несколькими критериями одновременно,
# мы можем воспользоваться преобразованием Шварца.
# my @output_data =
#     map $_ > [0],
#         sort { СРАВНЕНИЕ ПАР ЭЛЕМЕНТОВ $a-> [1] И $b-> [1] or
#                 СРАВНЕНИЕ ПАР ЭЛЕМЕНТОВ $a-> [2] И $b-> [2] ПО ДРУГОМУ КРИТЕРИЮ or
#                 СРАВНЕНИЕ ПАР ЭЛЕМЕНТОВ $a-> [2] И $b-> [2] ПО ТРЕТЬЕМУ КРИТЕРИЮ }
#                 map [$_, НЕКОТОРАЯ ФУНКЦИЯ ОТ $_, ЕЩЕ ОДНА ФУНКЦИЯ, И ЕЩЕ ОДНА],
#                 @input_data;


print "\n\n\t# Данные с рекурсивной организацией\n\n";

# For example, a recursive subroutine handling the factorial function, which is one of the simplest
# recursive functions, might look like:
sub factorial
{
    my $n = shift;
    if ($n <= 1)
    {
        return 1;
    }
    else
    {
        return $n * factorial($n - 1);
    }
}

print factorial(5);

sub data_for_path {
    my $path = shift;
if (-f $path or -l $path) {  # files or symbolic links
    return undef;
}
    if (-d $path)
    {
        my %directory;
        opendir PATH, $path or die "Cannot opendir $path: $!";
        my @names2 = readdir PATH;
        closedir PATH;
        for my $name (@names2)
        {
            next if $name eq '.' or $name eq '..';
            $directory{$name} = data_for_path("$path/$name");
        }
        return \%directory;
    }
    warn "$path is neither a file nor a directory\n";
    return undef;
}

print Dumper (data_for_path('.'));

print "\n\n\t# Отображение данных с рекурсивной организацией\n\n";

sub dump_data_for_path
{
    my $path = shift;
    my $data = shift;

    if (not defined $data)
    {
        # plain file
        print "$path\n";
        return;
    }

    my %directory = %$data;

    foreach (sort keys %{$data})
    {
        dump_data_for_path("$path/$_", $directory{$_});
    }
}
dump_data_for_path('.', data_for_path('.'));
