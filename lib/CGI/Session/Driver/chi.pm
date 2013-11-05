package CGI::Session::Driver::chi;
use strict;
use CHI;
use base qw( CGI::Session::Driver CGI::Session::ErrorHandler );

our $VERSION = '1.0.0';

sub init {
    my ($self) = @_;
    my %args = %$self;
    my $chi_class = delete $args{chi_class} || "CHI";
    my $chi = $chi_class->new(%args);
    $self->{CHI} = $chi;
    use Data::Dumper;print Dumper($chi);
}

sub store {
    my ($self, $sid, $datastr) = @_;
    return $self->{CHI}->set($sid, $datastr);
}

sub retrieve {
    my ($self, $sid) = @_;
    return $self->{CHI}->get($sid);
}

sub remove {
    my ($self, $sid) = @_;
    return $self->{CHI}->remove($sid);
}

sub traverse {
    my ($self, $coderef) = @_;
    foreach my $key ($self->{CHI}->get_keys) {
        $coderef->( $key )
    }
}

1;
