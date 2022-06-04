package RaceHorse {
    use v5.10;
    use FindBin qw($Bin);
    use lib "$Bin"; # в подкаталоге
    our $VERSION = '0.04';
    # use CGI;
    # use POSIX;
    # use Encode qw(decode_utf8);
    # use Encode qw(decode encode);
    #= BEGIN{@ARGV=map Encode::decode(#\$_,1),@ARGV;}
    # BEGIN{@ARGV = map decode_utf8(#\$_, 1), @ARGV;}
    # use open qw(:std :encoding(UTF-8));
    use utf8::all 'GLOBAL';
    # use Encode::Locale;
    # use Encode;
    # use diagnostics;
    use strict;
    use warnings FATAL => 'all';
    use autodie qw(:all);
    use utf8;
    binmode(STDIN, ':utf8');
    binmode(STDOUT, ':utf8');
    use Data::Dumper;
    use Bundle::Camelcade; # for Intellij IDEA
    use YAML;
    use DDP;

    use Moose;
    use Moose::Util;
    use namespace::autoclean;

    extends 'Horse';
    with 'RaceHorse::Racer';

    __PACKAGE__->meta->make_immutable;
}
1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

RaceHorse - Perl модуль для решения упражнения главы 16 (через Build.PL)

=head1 SYNOPSIS

  use FindBin qw($Bin);
  use lib "$Bin{your path}/RaceHorse/lib"; # в подкаталоге

  use RaceHorse::RaceHorse;

  my $horse = RaceHorse->new(name => "Mr. Ed");
  $horse->speak_print;
  say $horse->color;
  $horse->_private_set_color("grey");
  say $horse->color;
  $horse->won;
  $horse->won;
  $horse->won;
  $horse->lost;
  $horse->placed;
  say $horse->standings; # 3 wins, 1 places, 0 shows, 1 losses


=head1 DESCRIPTION

Документация к модулю RaceHorse, созданного с помощью Build.PL.
Этот модуль наследует родительский класс Horse. Для работы модуля необходим ролевой
Animal. Модуль RaceHorse использует ООП модуля Moose. Достаточно и необходимо объявить
модуль RaceHorse через use RaceHorse;

=head2 EXPORT

  use FindBin qw($Bin);
  use lib "$Bin{your path}/RaceHorse/lib"; # в подкаталоге

  use RaceHorse::RaceHorse;

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
