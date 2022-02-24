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

# File 05.2.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/



# Файл Профессора с данными о трафике (coconet.dat, который упоминался выше)
# можно загрузить с веб-сайта O’Reilly. В этом файле имеются комментарии, начинающиеся
# с символа решетки (#).

# Перепишите пример анализа файла таким образом, чтобы программа
# корректно распознавала строки комментариев и пропускала их. (Подсказку вы найдете в
# самом комментарии, если прочитаете его!)

# Видоизмените пример таким образом, чтобы при
# выводе группы списка с одним и тем же именем узла-отправителя в заголовке группы
# отображалось общее количество байтов, отправленных этим узлом. Отсортируйте список по
# числу отправленных байтов в порядке убывания. Каждую отдельную группу списка с
# узлами-получателями отсортируйте по числу принятых байтов  от заданного узла-отправителя
# в порядке убывания. В результате должен получиться список, в котором на первом месте должен
# стоять узел сети, отправивший больше всего байтов, а первым узлом-получателем в группе должен
# быть узел, получивший наибольшее количество байтов от данного узла-отправителя. После этого
# Профессор сможет воспользоваться полученными результатами для перестройки сети с целью
# повышения ее эффективности.


my %total_bytes;
my $all_bytes_of_all_computers = "to all other computers : ";

while (<>) {
    next if s/^\s*$/#/;

    if (/^#/) {
        next;
    }else {
       my ($source, $destination, $bytes) = split;
        $total_bytes{$source}->{$destination} += $bytes;
        $total_bytes{$source}->{$all_bytes_of_all_computers} += $bytes;
    }
}

my @sources = sort { $total_bytes{$b}{$all_bytes_of_all_computers} <=> $total_bytes{$a}{$all_bytes_of_all_computers} }
    keys %total_bytes;

for my $source (@sources) {
    my @destinations = sort {$total_bytes{$source}{$b} <=> $total_bytes{$source}{$a}}
        keys %{$total_bytes{$source}};
    print "$source: всего передано $total_bytes{$source}{$all_bytes_of_all_computers} байтов\n";

    for my $destination (@destinations) {
        next if $destination eq $all_bytes_of_all_computers;
        print "    $source => $destination:", " $total_bytes{$source}{$destination} байтов\n";
    }
    print "\n";
}


foreach (@sources) {
    say $_ . " => " . $total_bytes{$_}->{$all_bytes_of_all_computers} . " bytes";
}






# say "\$bytes => $bytes";
# say "$total_bytes{$source}->{$all_bytes_of_all_computers} => $total_bytes{$source}->{$all_bytes_of_all_computers}";
# say "$total_bytes{$source}->{$destination} => $total_bytes{$source}->{$destination}";



=begin text

  $ perl 05.2.pl IntermediatePerlDownloads/5.References.And.Scoping/coconet.dat
  nu pizdec...

=end text



=cut

# Верный ответ из книги:

