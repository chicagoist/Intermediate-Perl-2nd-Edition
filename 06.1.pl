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
use IPC::System::Simple;
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

# File 06.1.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/


# Программа из упражнения 2 главы 5 при каждом запуске читает файл журнала целиком.
# Однако Профессор получает новый файл журнала каждый день и не желает хранить весь
# объем данных в одном большом файле, анализ которого с каждым  днем будет занимать
# все больше и больше времени. Перепишите программу таким образом, чтобы информацию
# о трафике, полученную ранее, она сохраняла в отдельном файле. Тогда Профессор сможет
# запускать программу ежедневно, передавая ей очередную порцию данных, и получать
# обновленные сведения о трафике.
use Storable;

my %total_bytes;
my $all_bytes_of_all_computers = "to all other computers : ";
my ($source, $destination, $bytes);

while (<>) {
    next if s/^\s*$/#/;

    if (/^#/) {
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

store \%total_bytes, 'source_destination_bytes_' . $time_of_file;

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

print "Start execute data of traffic now ? [yes/no] : ";
chomp(my $answer = <STDIN>);

if ($answer =~ /[yes|y]/i) {

    opendir my $dh_stored, $dir or die "Cannot open $dir: $!";

    while (my $name_stored = readdir $dh_stored) {
        next if $name_stored =~ /^\./;# Пропустить файлы, начинающиеся с точки
        $name_stored = "$dir/$name_stored";# Добавить путь

        if ($name_stored =~ /\.*\/source_destination_bytes\.*/) {
            #next unless -f $name_stored and -r $name_stored;# Только файлы с доступом для чтения...
            say "\$name_if_stored = $name_stored";
            my $result = retrieve($name_stored);
            unlink $name_stored;

            %total_bytes = %{$result};

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
    }

    closedir($dh_stored);
} else {
    print "STOP\n";
    exit;
}


=begin text


 $ perl 06.1.pl traffic_next_day.txt
  $name = /home/user/Perl_Projects/Intermediate_Perl/source_destination_bytes_Sat_Feb_5_14:38:44_2022
  Start execute data of traffic now ? [yes/no] : n
  STOP

 $ perl 06.1.pl IntermediatePerlDownloads/5.References.And.Scoping/coconet.dat
  $name = /home/user/Perl_Projects/Intermediate_Perl/source_destination_bytes_Sat_Feb_5_14:38:44_2022
  $name = /home/user/Perl_Projects/Intermediate_Perl/source_destination_bytes_Sat_Feb_5_14:39:31_2022
  Start execute data of traffic now ? [yes/no] : y
  $name_if_stored = /home/user/Perl_Projects/Intermediate_Perl/source_destination_bytes_Sat_Feb_5_14:38:44_2022
  professor.hut: всего передано_stored 1234 байтов
      professor.hut => laser3.copyroom.hut: 924 байтов
      professor.hut => gilligan.crew.hut: 250 байтов
      professor.hut => lovey.howell.hut: 60 байтов

  thurston.howell.hut: всего передано_stored 250 байтов
      thurston.howell.hut => lovey.howell.hut: 250 байтов

  ginger.girl.hut: всего передано_stored 227 байтов
      ginger.girl.hut => professor.hut: 218 байтов
      ginger.girl.hut => maryann.girl.hut: 9 байтов

  $name_if_stored = /home/user/Perl_Projects/Intermediate_Perl/source_destination_bytes_Sat_Feb_5_14:39:31_2022
  professor.hut: всего передано_stored 7382830 байтов
      professor.hut => maryann.girl.hut: 1122947 байтов
      professor.hut => professor.hut: 1114174 байтов
      professor.hut => skipper.crew.hut: 1075693 байтов
      professor.hut => gilligan.crew.hut: 1073557 байтов
      professor.hut => ginger.girl.hut: 1047250 байтов
      professor.hut => laser3.copyroom.hut: 1018295 байтов
      professor.hut => fileserver.copyroom.hut: 930914 байтов

  gilligan.crew.hut: всего передано_stored 7237638 байтов
      gilligan.crew.hut => maryann.girl.hut: 1276577 байтов
      gilligan.crew.hut => laser3.copyroom.hut: 1027800 байтов
      gilligan.crew.hut => professor.hut: 1013622 байтов
      gilligan.crew.hut => ginger.girl.hut: 1012723 байтов
      gilligan.crew.hut => fileserver.copyroom.hut: 1006399 байтов
      gilligan.crew.hut => skipper.crew.hut: 966660 байтов
      gilligan.crew.hut => gilligan.crew.hut: 933857 байтов

  maryann.girl.hut: всего передано_stored 7235878 байтов
      maryann.girl.hut => fileserver.copyroom.hut: 1140533 байтов
      maryann.girl.hut => gilligan.crew.hut: 1122049 байтов
      maryann.girl.hut => ginger.girl.hut: 1065580 байтов
      maryann.girl.hut => skipper.crew.hut: 1001870 байтов
      maryann.girl.hut => laser3.copyroom.hut: 986229 байтов
      maryann.girl.hut => maryann.girl.hut: 965243 байтов
      maryann.girl.hut => professor.hut: 954374 байтов

  ginger.girl.hut: всего передано_stored 7225624 байтов
      ginger.girl.hut => ginger.girl.hut: 1152020 байтов
      ginger.girl.hut => skipper.crew.hut: 1119766 байтов
      ginger.girl.hut => laser3.copyroom.hut: 1078150 байтов
      ginger.girl.hut => maryann.girl.hut: 1018548 байтов
      ginger.girl.hut => gilligan.crew.hut: 993241 байтов
      ginger.girl.hut => fileserver.copyroom.hut: 949221 байтов
      ginger.girl.hut => professor.hut: 914678 байтов

  fileserver.copyroom.hut: всего передано_stored 7175028 байтов
      fileserver.copyroom.hut => gilligan.crew.hut: 1151354 байтов
      fileserver.copyroom.hut => laser3.copyroom.hut: 1092608 байтов
      fileserver.copyroom.hut => fileserver.copyroom.hut: 1026030 байтов
      fileserver.copyroom.hut => professor.hut: 1002371 байтов
      fileserver.copyroom.hut => maryann.girl.hut: 989869 байтов
      fileserver.copyroom.hut => ginger.girl.hut: 956638 байтов
      fileserver.copyroom.hut => skipper.crew.hut: 956158 байтов

  skipper.crew.hut: всего передано_stored 7104065 байтов
      skipper.crew.hut => gilligan.crew.hut: 1097882 байтов
      skipper.crew.hut => laser3.copyroom.hut: 1050796 байтов
      skipper.crew.hut => ginger.girl.hut: 1041603 байтов
      skipper.crew.hut => fileserver.copyroom.hut: 1010486 байтов
      skipper.crew.hut => maryann.girl.hut: 984691 байтов
      skipper.crew.hut => skipper.crew.hut: 964162 байтов
      skipper.crew.hut => professor.hut: 954445 байтов

  laser3.copyroom.hut: всего передано_stored 6948515 байтов
      laser3.copyroom.hut => laser3.copyroom.hut: 1044817 байтов
      laser3.copyroom.hut => skipper.crew.hut: 1037091 байтов
      laser3.copyroom.hut => gilligan.crew.hut: 1029793 байтов
      laser3.copyroom.hut => fileserver.copyroom.hut: 1007034 байтов
      laser3.copyroom.hut => professor.hut: 954483 байтов
      laser3.copyroom.hut => ginger.girl.hut: 952001 байтов
      laser3.copyroom.hut => maryann.girl.hut: 923296 байтов






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

