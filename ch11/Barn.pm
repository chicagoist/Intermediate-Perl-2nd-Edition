use v5.10;


{ package Barn;
our $VERSION = '0.01';
#use parent qw(LivingCreature);

use utf8::all 'GLOBAL';
use strict;
use warnings FATAL => 'all';
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use Bundle::Camelcade;# for Intellij IDEA
use DDP;

sub new { bless [], shift };
sub add {
    push @{+shift}, shift;

};

sub contents { @{+shift} };
sub DESTROY {
    my $self = shift;
    print "уничтожается объект @$self...\n";

    for ($self->contents) {
        print '  ', $_->name, " стала бездомной.\n";
    }
}

# Задавались ли вы вопросом, зачем здесь стоит знак «плюс» (+)? Дело в том, что если бы мы просто указали @{shift},
# то из-за того, что в фигурных скобках слово shift  не имеет специальной приставки, оно интерпретировалось бы
# как символическая ссылка @{"shift"}. В языке Perl унарный плюс (символ плюса в начале строки) определен как
# пустая операция (даже не преобразует следующую за ним строку в число); именно таким способом можно отличить
# случаи, аналогичные данному.



1;
}