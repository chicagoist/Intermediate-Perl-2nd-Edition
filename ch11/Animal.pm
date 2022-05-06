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
    use DDP;

    # sub speak {
    #     my $class = shift;
    #     #p $class;
    #     die "animals can't talk!" if @_;
    #     $class->SUPER::speak;
    #}

    # sub speak {
    #     my $either = shift;
    #     print $either->name, ' goes ', $either->sound, "\n";
    # }

    sub name {
        my $either = shift;
        ref $either ? $$either                # it's an instance, return name
            : "$either без имени";           # it's a class, return generic
    }

    sub named {
        my $class = shift;
        my $name = shift;
        bless \$name, $class;
    }

    sub speak {
        my $either = shift;
        print $either->name, ' goes ', $either->sound, "\n";
    }

    sub eat {
        my $either = shift;
        my $food = shift;
        print $either->name, " ест $food.\n";
    }

    sub sound {
        die "all Animals should define a sound";
    }


    1;
}