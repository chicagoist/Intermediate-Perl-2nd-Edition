package Horse {
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
    # our @EXPORT = qw(sound default_color);
    # our @EXPORT_OK = qw(
    # );
    #
    # our %EXPORT_TAGS = (
    #     all => [ @EXPORT, @EXPORT_OK ],
    #     sound => [ qw( sound ) ],
    #     color => [ qw(default_color) ],
    # );

    use Moose;
    use namespace::autoclean;

    with 'Animal';

    sub sound { 'neigh' }
    sub default_color { 'brown' }

    __PACKAGE__->meta->make_immutable;
}
1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Horse - Perl модуль для решения упражнения главы 16

=head1 SYNOPSIS

  use FindBin qw($Bin);
  use lib "$Bin{your path}/Horse/lib"; # в подкаталоге

  use Horse;

=head1 DESCRIPTION

Документация к модулю Horse, созданного с помощью h2xs.
Этот модуль определяет класс Horse. Для работы модуля необходим ролевой
Animal. Модуль Horse использует ООП модуля Moose. Достаточно и необходимо объявить
модуль Horse через use Horse;

Модуль содержит функции 'sound' и 'default_color'.
Функция 'sound' возвращает значение, подходящее для определения звука данного класса.
Функция 'default_color' возвращает значение цвета по умолчанию.


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
