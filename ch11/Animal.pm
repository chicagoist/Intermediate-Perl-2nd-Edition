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
        ref $either ? $either->{Name}                # it's an instance, return name
            : "$either без имени";           # it's a class, return generic
    }

    sub named {
        my $class = shift;
        my $name = shift;
        my $self = { Name => $name, Color => $class->default_color };
        bless $self, $class;
    }

    sub speak {
        my $either = shift;
        #say $either->sound;
        $either->name. ' goes '. $either->sound;
    }

    sub eat {
        my $either = shift;
        my $food = shift;
        print $either->name, " ест $food.\n";
    }

    sub sound {
        die "all Animals should define a sound";
    }

    ## в классе Animal
    sub default_color {
        'коричневый';
    }

    ## в классе Animal
    sub color {
        my $self = shift;
       ref $self ? $self->{Color} : $self->default_color;
    }

    sub set_color {
        my $self = shift;
        $self->{Color} = shift;
        $self;
    }

    sub set_age {
        my $self = shift;
        $self->{Age} = shift;
        $self;
    }

    sub set_height {
        my $self = shift;
        $self->{Height} = shift;
        $self;
    }




    1;
}