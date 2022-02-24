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

# File 02.2.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Напишите программу, которая просила бы пользователя ввести шаблон (регулярное выражение).
# Строка должна вводиться с клавиатуры, а не приниматься в виде аргумента командной строки.
# Из заранее определенного каталога (например, /etc или c: \\windows) выведите список файлов,
# чьи имена совпадают с введенным шаблоном.

# Программа должна продолжать работу до тех пор,
# пока пользователь не введет в качестве шаблона пустую строку. Пользователь не должен вводить
# символы слэша, которые в Perl традиционно служат для разграничения шаблонов. Вводимые шаблоны
# должны разделяться символом перевода строки. Постарайтесь обеспечить устойчивость программы
# к ошибкам в шаблонах, таким как отсутствие парных скобок.

my @matching_lines;
my $index = 0;

my $dir;
# Account for / and \ on Win32 and non-Win32 systems
($^O =~ /Win32/) ? ($dir = getcwd) =~ s/\//\\/g : ($dir = getcwd);
print "Enter your template: "; # template

chomp(my $template = <STDIN>)
    or die "Not correct template. Stop the app";
if (!$template) { # die if template is empty
    exit;
    # die "Empty template. Stop the app";
}else {

    while ($template) {

        opendir my $open_dir, $dir
            or die "Cannot open $dir: $!";

            foreach (readdir $open_dir) { # loop for array with lines
                if ($_ =~ /$template/ig) {
                    print "$_\n";
                }
            }
            print "Enter your template: "; # template
            chomp($template = <STDIN>)
                or die "Not correct template. Stop the app";
            if (!$template) { # die if template is empty
                exit;
                # die "Empty template. Stop the app";
            }
        closedir $open_dir;
        }

    }



=begin text

  $ perl 02.2.pl
   Enter your template: .*
    .
    ..
    .git
    .idea
    02.1.pl
    02.2.pl
    chapter_02.pl
    IntermediatePerlDownloads
    IntermediatePerlDownloads.zip
    Intermediate_Perl_Second_Edition_signed_page.pdf
    README.md

    Enter your template:

=end text

=cut


# Верный ответ из книги:

# По умолчанию в качестве заранее определенного каталога программа использует
# домашний каталог. Когда подпрограмма chdir вызывается без аргумента, она
# выполняет переход в домашний каталог (это одна из немногих функций Perl,
# которая не использует переменную $_  по умолчанию). Бесконечный цикл while
# продолжает работу до тех пор, пока не будет выполнено условие в операторе
# last, прерывающем цикл. Взглянем на условие поближе: здесь не просто проверяется
# значение «истина». Мы проверяем, определено ли регулярное выражение и имеет ли
# оно ненулевую длину. Таким образом, цикл будет прерван в случае получения undef
# (конец ввода) или пустой строки (которая получится в результате нажатия клавиши Enter).
# После того как регулярное выражение будет прочитано, мы выполняем те же действия, что
# и в ответе на предыдущее упражнение. Правда, на сей раз в качестве исходного списка
# оператора grep  выступает результат работы функции glob. Шаблон оборачивается в блок
# eval{}– на тот случай, если он не сможет быть скомпилирован (например, когда в его
# составе имеются непарные скобки).
# chdir; # переход в домашний каталог
# while( 1 ) {
#     print "Введите регулярное выражение > ";
#     chomp( my $regex = <STDIN> );
#     last unless( defined $regex && length $regex );
#     print map { "    $_\n" } grep { eval{ /$regex/ } }glob( ".* *" );
# }