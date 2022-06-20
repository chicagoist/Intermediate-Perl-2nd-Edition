#!/usr/bin/perl -w

use 5.10.0;

use FindBin qw($Bin);
use lib "$Bin/My-List-Util/lib/My/List"; # в подкаталоге
use lib "$Bin/Test-My-List-Util/lib"; # в подкаталоге
#use lib "$Bin/Horse/lib"; # в подкаталоге
#use lib "/home/legioner/Testing/share/perl/5.34.0";
#use lib "$Bin/Animal-Horse-Horse/lib"; # в подкаталоге

# use CGI;
use Encode qw(decode_utf8);
use Encode qw(decode encode);
#BEGIN{ $_ = map Encode::decode($_, 1) }
# BEGIN{@ARGV = map decode_utf8(#\$_, 1), @ARGV;}
use open qw(:std :encoding(UTF-8));
#use utf8::all 'GLOBAL';
#use Encode::Locale;
# use diagnostics;


use strict;
use warnings FATAL => 'all';
#use IPC::System::Simple;
#use autodie qw(:all);
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');

use Data::Dumper;
use Bundle::Camelcade; # for Intellij IDEA
use POSIX ();
use File::Spec;
use Cwd;

# File 18.2.pl
# https://github.com/chicagoist/Intermediate-Perl-2nd-Edition.git
# https://www.learning-perl.com/
# https://www.linkedin.com/in/legioneroff/

# Создайте дистрибутив модуля, написав предварительно набор тестов кнему.
# Главная цель – создать модуль My::List::Util, который будет экспортировать
# две подпрограммы: sum()  и shuffle().
# Подпрограмма sum() должна принимать список аргументов и возвращать числовую
# сумму их значений. Подпрограмма shuffle() должна принимать список аргументов,
# переупорядочивать его случайным образом (перетасовывать) и возвращать список
# с новым порядком следования элементов.
# Начните разработку с подпрограммы sum(). Сначала напишите тесты, а потом приступайте
# к созданию программного кода. Когда все тесты будут проходить без ошибок, разработку
# можно считать законченной. Затем создайте тесты для подпрограммы shuffle(), после
# чего приступайте к ее реализации. Можно заглянуть в perlfaq и подсмотреть реализацию
# подпрограммы там. По мере продвижения вперед обязательно вносите соответствующие изменения
# в документацию и в файл MANIFEST. Будет еще лучше, если над этим упражнением вы будете
# работать с кемнибудь в паре. Один из вас мог бы написать тесты к подпрограмме sum() и
# реализацию подпрограммы shuffle(), а другой наоборот – тесты к подпрограмме shuffle()  и
# реализацию подпрограммы sum(). Обменяйтесь файлами t/* и посмотрите, обнаружат ли тесты
# какиенибудь ошибки!

use Util;
use Test::My::List::Util;

my $foo = My::List::Util->new();

sum_ok($foo->sum(5, 6, 7),18);
sum_ok($foo->sum(5, 6, 7),19);
sum_ok($foo->sum(-1,1),0);
sum_ok($foo->sum(-0,0),0);
sum_ok($foo->sum(-2,1),-1);



=begin text





=end text

#

=cut

