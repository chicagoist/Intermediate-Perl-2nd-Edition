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

# File 03.1.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Прочитайте список файлов в текущем каталоге и преобразуйте полученные имена
# в их спецификации, содержащие полные пути к файлам. При этом нельзя
# обращаться к возможностям командной оболочки или каки-либо внешних программ.
# Допускается использовать модули File::Spec и Cwd, входящие в состав Perl.
# При выводе списка спецификаций перед каждой из них должны выводиться четыре
# пробела, а после каждой из них – символ перевода строки (точно так же, как
# это делалось в упражнении 1 из главы 2). Сможете ли вы задействовать программный
# код, написанный ранее?

my $dir =  cwd();
my $path_file;
# Account for / and \ on Win32 and non-Win32 systems
# ($^O =~ /Win32/) ? ($dir = getcwd) =~ s/\//\\/g : ($dir = getcwd); # for with pragma use POSIX;

while (<@ARGV>) {
    chomp;
    if (defined $_) {
        $path_file = File::Spec->catfile($dir, $_);
        printf("\t%s \n", $path_file);
    }
}

=begin text

  $ perl 03.1.pl *
        /home/user/Perl_Projects/Intermediate_Perl/02.1.pl 
        /home/user/Perl_Projects/Intermediate_Perl/02.2.pl 
        /home/user/Perl_Projects/Intermediate_Perl/03.1.pl 
        /home/user/Perl_Projects/Intermediate_Perl/chapter_02.pl 
        /home/user/Perl_Projects/Intermediate_Perl/chapter_03.pl 
        /home/user/Perl_Projects/Intermediate_Perl/IntermediatePerlDownloads 
        /home/user/Perl_Projects/Intermediate_Perl/IntermediatePerlDownloads.zip 
        /home/user/Perl_Projects/Intermediate_Perl/Intermediate_Perl_Second_Edition_signed_page.pdf 
        /home/user/Perl_Projects/Intermediate_Perl/OTHER.pl 
        /home/user/Perl_Projects/Intermediate_Perl/README.md 



=end text

=cut


# Верный ответ из книги:

# Вся хитрость этого упражнения заключается в том,
# чтобы поручить черную работу модулю. Это прекрасный
# пример работы с модулями! Модуль Cwd  (cwd – это аббревиатура
# от английского «current working directory», что в переводе
# на русский  язык означает «текущий рабочий каталог») автоматически
# импортирует функцию getcwd. Нам не надо задумываться над тем,
# как она работает, достаточно знать, что она справляется со своими
# обязанностями на большинстве основных платформ. После того как путь
# к текущему каталогу будет записан в переменную $cwd, ее можно будет
# использовать в качестве первого аргумента метода catfile класса File::Spec.
# Второй аргумент метода выбирается из исходного списка оператором map и
# переносится в переменную $_.

# use Cwd;
# use File::Spec;
# my $cwd = getcwd;

# print map { "    " . File::Spec >catfile( $cwd, $_ ) . "\n" } glob( ".* *" );