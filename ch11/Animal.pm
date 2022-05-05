use v5.10;

package Animal {
    our $VERSION = '0.01';
    use parent qw(LivingCreature);

    use utf8::all 'GLOBAL';
    use strict;
    use warnings FATAL => 'all';
    use utf8;
    binmode(STDIN, ':utf8');
    binmode(STDOUT, ':utf8');
    use Bundle::Camelcade;# for Intellij IDEA

    sub speak {
        my $class = shift;
        die "animals can't talk!" if @_;
        $class->SUPER::speak;
    }

    sub sound {
        die "all Animals should define a sound";
    }


    1;
}