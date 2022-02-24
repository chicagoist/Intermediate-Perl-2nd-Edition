#!/usr/bin/perl -w

use 5.10.0;
# use CGI;
use Encode qw(decode_utf8);
use Encode qw(decode encode);
BEGIN{$_ = map Encode::decode(\$_, 1)}
# BEGIN{@ARGV = map decode_utf8(#\$_, 1), @ARGV;}
use open qw(:std :encoding(UTF-8));
use utf8::all 'GLOBAL';
use Encode::Locale;
# use diagnostics;


use strict;
use warnings FATAL => 'all';
use IPC::System::Simple;
use autodie qw(:all);
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');

use Data::Dumper;
use Bundle::Camelcade;# for Intellij IDEA
use POSIX ();
use File::Spec;
use Cwd;

# File 08.2.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Профессору надо прочитать файл журнала, который выглядит следующим образом:

# Джиллиган: 1 кокос
# Шкипер: 3 кокоса
# Джиллиган: 1 банан
# Джинжер: 2 папайи
# Профессор: 3 кокоса
# МэриЭнн: 2 папайи
# ...

# Он хочет создать несколько файлов с именами Джиллиган.info, Мэри Энн.info и т. д.
# В каждый из этих файлов из журнала должны переписываться строки, начинающиеся с
# имени персонажа. (Имена всегда отделяются от оставшейся части строки символом двоеточия.)
# Например, файл Джиллиган.info должен начинаться со строк:

# Джиллиган: 1 кокос
# Джиллиган: 1 банан

# Сейчас файл журнала достаточно велик, а компьютер на кокосовом процессоре не отличается
# высокой скоростью, поэтому Профессор хотел бы, чтобы программа выполняла всего один
# проход журнала и выводила бы информацию во все файлы параллельно.

# Подсказка: используйте хеш, ключами которого были бы имена потерпевших кораблекрушение,
# а значениями – объекты IO::File, которые могут создаваться по мере необходимости.


use File::Find;
use Time::Local;

open my $fh_text, "<", "IntermediatePerlDownloads/8.Filehandle.References/8.2-data-file.txt"
    or die "Couldn't open file: $!";

while (<$fh_text>)
{

    next unless /^\w?.*\D:\s/;
    (my $name = $_) =~ s/^(\w?.*\D):.*/$1/;
    chomp($name);
    $name =~ s/^(\w*\.)\s?(\w*)$/$1$2/;

    open my $fh_name, ">>", "$name.info" or die "Couldn't open file $name" . 'info', "$!";
    print {$fh_name} "$_";
    close($fh_name);

}

close($fh_text);
=begin text


 $ perl 08.2.pl




=end text

#

=cut

# Верный ответ из книги:

