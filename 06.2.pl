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
use Bundle::Camelcade;# for Intellij IDEA
use POSIX ();
use File::Spec;
use Cwd;

# File 06.2.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Перепишите пример анализа файла таким образом, чтобы программа корректно
# распознавала строки комментариев и пропускала их. (Подсказку вы найдете в
# самом комментарии, если прочитаете его!) Видоизмените пример таким образом,
# чтобы при выводе группы списка с одним и тем же именем узла-отправителя
# в заголовке группы отображалось общее количество байтов, отправленных этим
# узлом. Отсортируйте список по числу отправленных байтов в порядке убывания.
# Каждую отдельную группу списка с узлами-получателями отсортируйте по числу
# принятых байтов  от заданного узла-отправителя в порядке убывания. В результате
# должен получиться список, в котором на первом месте должен стоять узел сети,
# отправивший больше всего байтов, а первым узлом-получателем в группе должен быть
# узел, получивший наибольшее количество байтов от данного узла-отправителя.
# После этого Профессор сможет воспользоваться полученными результатами для
# перестройки сети с целью повышения ее эффективности.

use Storable;

my %total_bytes;
my $all_bytes_of_all_computers = "to all other computers : ";
my ($source, $destination, $bytes);

while (<>) {
    next if s/^\s*$/#/;
    next if /^#\.*$/;

    if ( /^#/ ) {
        next;
    } else {
        ($source, $destination, $bytes) = split;
        $total_bytes{$source}->{$destination} += $bytes;
        $total_bytes{$source}->{$all_bytes_of_all_computers} += $bytes;
    }
}

my $time_of_file;
grep {
    chomp;
    s/\s+/_/g;
    $time_of_file = $_;
} localtime() . "\n";

my $dir = getcwd();
opendir my $dh, $dir or die "Cannot open $dir: $!";

while (my $name = readdir $dh) {
    next if $name =~ /^\./;# Пропустить файлы, начинающиеся с точки
    if ($name =~ /^source_destination_bytes/) {
        $name = "$dir/$name";# Добавить путь
        next unless -f $name and -r $name;# Только файлы с доступом для чтения...
        say "\$name = $name";
    }
}
closedir($dh);

    opendir my $dh_stored, $dir or die "Cannot open $dir: $!";

    while (my $name_stored = readdir $dh_stored) {
        next if $name_stored =~ /^\./;# Пропустить файлы, начинающиеся с точки
        $name_stored = "$dir/$name_stored";# Добавить путь

            my @sources = sort {$total_bytes{$b}{$all_bytes_of_all_computers} <=> $total_bytes{$a}{$all_bytes_of_all_computers}}
                keys %total_bytes;

            for my $source_stored (@sources) {
                my @destinations = sort {$total_bytes{$source_stored}{$b} <=> $total_bytes{$source_stored}{$a}}
                    keys %{$total_bytes{$source_stored}};

                print "$source_stored: всего передано_stored $total_bytes{$source_stored}{$all_bytes_of_all_computers} байтов\n";

                for my $destination_stored (@destinations) {
                    next if $destination_stored eq $all_bytes_of_all_computers;
                    print "    $source_stored => $destination_stored:", " $total_bytes{$source_stored}{$destination_stored} байтов\n";
                }
                print "\n";
            }
        }


    closedir($dh_stored);



=begin text


 $ perl 06.2.pl traffic_next_day.txt


 $ perl 06.2.pl IntermediatePerlDownloads/5.References.And.Scoping/coconet.dat







=end text

# Решение этого упражнения очень похоже на решение второго упражнения из главы 5,
но на этот раз мы воспользуемся модулем Storable.

use Storable;
my $all       = "**all machines**";
my $data_file = "total_bytes.data";

my %total_bytes; if ( e $data_file) {

my $data = retrieve $data_file;
%total_bytes = %$data;
}

while (<>) {
next if /^#/;
my ($source, $destination, $bytes)   = split;
$total_bytes{$source}{$destination} += $bytes;$total_bytes{$source}{$all}         += $bytes;
}

store \%total_bytes, $data_file;

### остальная часть программы осталась без изменений В самом начале программы мы записываем
в переменную имя файла, где будут храниться сведения о трафике за прошедшие дни. Затем из него
извлекаются данные, но только  в том случае, если файл уже существует. После чтения данных из
нового файла журнала полученная информация о трафике снова записывается в файл данных. Если
вы предпочтете записывать данные из хеша в файл в своем собственном формате, сделать это будет
очень непросто. Проще говоря, чтобы решить это упражнение таким способом, нужно либо обладать
необычайным талантом, либо потратить достаточно много времени, при этом почти наверняка ваши
подпрограммы сериализации данных будут содержать ошибки.

=cut

# Верный ответ из книги:

