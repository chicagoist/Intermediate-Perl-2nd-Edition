package Animal {
    use v5.10;
    use FindBin qw($Bin);
    use lib "$Bin"; # в подкаталоге
    our $VERSION = '0.03';
    # use CGI;
    # use POSIX;
    # use Encode qw(decode_utf8);
    # use Encode qw(decode encode);
    #= BEGIN{@ARGV=map Encode::decode(#\$_,1),@ARGV;}
    # BEGIN{@ARGV = map decode_utf8(#\$_, 1), @ARGV;}
    # use open qw(:std :encoding(UTF-8));
    #use utf8::all 'GLOBAL';
    # use Encode::Locale;
    # use Encode;
    # use diagnostics;
    use strict;
    use warnings FATAL => 'all';
    use autodie qw(:all);
    use utf8;
    binmode(STDIN, ':utf8');
    binmode(STDOUT, ':utf8');
    #use Data::Dumper;
    #use Bundle::Camelcade; # for Intellij IDEA
    #use YAML;
    #use DDP;

    # use Exporter qw(import);
    # our @EXPORT = qw(name color speak_print);
    # our @EXPORT_OK = qw(
    # );
    #
    # our %EXPORT_TAGS = (
    #     all => [ @EXPORT, @EXPORT_OK ],
    #     name => [ qw(name ) ],
    #     speak => [ qw(speak_print) ],
    # );

    use Moose::Role;
    use Moose::Util::TypeConstraints;
    use namespace::autoclean;

    requires qw(sound default_color);

    enum 'ColorStr' => [qw( white brown black grey spotted)];

    has 'name' => (is => 'rw');
    has 'color' => (
        is => 'ro',
        isa => 'ColorStr',
        writer => '_private_set_color',
        default => sub { shift->default_color }
    );

    sub speak_print {
        my $self = shift;
        print $self->name, " goes ", $self->sound, "\n";
    }


    # __PACKAGE__->meta->make_immutable;
}
1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Animal - Perl модуль для решения упражнения главы 16

=head1 SYNOPSIS

  use FindBin qw($Bin);
  use lib "$Bin{your path}/Horse/lib"; # в подкаталоге

  use Horse;

=head1 DESCRIPTION

Документация к модулю Animal, созданного с помощью h2xs.
Этот модуль определяет класс Animal для работы другого модуля
Horse. Модуль Animal использует ООП модуля Moose и предоставляет
ролевые функции в модуле Horse, поэтому модуль Animal не нужно объявлять
в рабочем скрипте через use Animal. Достаточно и необходимо объявить
модуль Horse через use Horse;

Модуль содержит элементы объекта класса 'name' и 'color'.
Элемент 'color' имеет доступ только для чтения и для изменения значения
требуется приватная функция _private_set_color, которая определена в свойствах
этого элемента. Допустимые значения элемента 'color' определены в коллекции
enum 'ColorStr'. По умолчанию, значение определяется функцией дочернего класса
default_color.

Функция speak_print выводит на экран значение 'name' и возвращаемое значение функции 'sound'
дочернего класса.



=head2 EXPORT

  use FindBin qw($Bin);
  use lib "$Bin{your path}/Horse/lib"; # в подкаталоге

  use Horse;



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

https://metacpan.org/pod/Moose

https://metacpan.org/pod/Moose::Role

=head1 AUTHOR

A. U. Thor, E<lt>legioner@E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2022 by A. U. Thor

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.34.0 or,
at your option, any later version of Perl 5 you may have available.


=cut
