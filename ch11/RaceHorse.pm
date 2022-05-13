use v5.10;

package RaceHorse {
    our $VERSION = '0.01';
    use parent qw(Horse);
    use utf8::all 'GLOBAL';
    use strict;
    use warnings FATAL => 'all';
    use utf8;
    binmode(STDIN, ':utf8');
    binmode(STDOUT, ':utf8');
    use Bundle::Camelcade;# for Intellij IDEA
    use AnyDBM_File;



    our %STANDINGS;
    dbmopen (%STANDINGS, "standings", 0644)or die "Cannot access standings dbm: $!";
    ## extend parent constructor:
    our %REGISTRY;
    sub named {
        my $self = shift->SUPER::named(@_);
        my $name = $self->name;
        my @standings = split ' ', $STANDINGS{$name} || "0 0 0 0";
        @$self{qw(wins places shows losses)} = @standings;
        $self;
        # my $class = shift;
        # my $args = shift;
        # my $self = $class->SUPER::named($args);
        # #my $self = shift->SUPER::named(@_);
        #
        # $self->{$_} = 0 for qw(wins places shows losses);
        # $REGISTRY{$self} = $self;
        # $self;
    }



    sub won { shift->{wins}++; }
    sub placed { shift->{places}++; }
    sub showed { shift->{shows}++; }
    sub lost { shift->{losses}++; }

    sub standings {
        my $self = shift;
        join ", ", map "$self->{$_} $_", qw(wins places shows losses);
    }

    # sub registered {
    #     no strict 'refs';
    #     my $self = shift;
    #     #p %REGISTRY;
    #     return map { 'экземпляр '.ref($_)." с именем ".$_->name }  values %REGISTRY;
    # }

    sub DESTROY { # instance method, automatically invokedmy
        my $self = shift;
        $STANDINGS{$self->name} = "@$self{qw(wins places shows losses)}";
        $self->SUPER::DESTROY if $self->can( 'SUPER::DESTROY' );
        }

    1;
}