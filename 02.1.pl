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
use POSIX;

# File 02.1.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Напишите программу, которая принимала бы из командной строки список
# файлов и отбирала бы с помощью оператора grep те из них, размер которых
# не превышает 1000 байт. Воспользуйтесь оператором map, чтобы перед
# каждым полученным в результате именем файла вставить четыре пробела и
# символ перевода строки после имени. Выведите получившийся список.


my $dir;
# Account for / and \ on Win32 and non-Win32 systems
($^O =~ /Win32/) ? ($dir = getcwd) =~ s/\//\\/g : ($dir = getcwd);

while (<@ARGV>) {
    chomp;
    my $size_in_k = -s $_;
    if ($size_in_k <= 1000) {
        #print "$_ = $size_in_k\n"; # or like this
        printf("\t%s = %d\n", $_,$size_in_k );
    }
}



=begin text

  $ perl 02.1.pl *
        02.1.pl = 1731
        chapter_02.pl = 10770
        IntermediatePerlDownloads = 4096
        README.md = 915

=end text

=cut


# Верный ответ из книги:

# Ниже приводится один из возможных вариантов решения.
# Аргументы командной строки программа получает в виде массива @ARGV,
# поэтому мы можем взять его в качестве исходного списка. Оператор
# проверки файлов  s по умолчанию работает с переменной $_, а это,
# как известно, текущий элемент, проверяемый оператором grep.
# Имена всех файлов с размером менее 1000 байтов помещаются в массив
# @smaller_than_1000. Этот массив становится исходным списком для
# оператора map, который извлекает каждый элемент и возвращает его,
# добавив к нему пробелы в начале и символ перевода строки в конце.

# my @smaller_than_1000 = grep {  s $_ < 1000 } @ARGV;
# print map { " $_\n" } @smaller_than_1000;

# Как правило, мы стараемся обойтись без промежуточного массива.
# print map { " $_\n" } grep {  s < 1000 } @ARGV;