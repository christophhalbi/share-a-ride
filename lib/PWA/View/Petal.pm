package PWA::View::Petal;

use strict;
use base 'Catalyst::View::Petal';

use Petal::Utils qw/ :all /;

=head1 NAME

Atikon::MobileApp::View::Petal - Petal View Component

=head1 SYNOPSIS

    $c->stash({
        template     => 'foo.zpt',
        template_var => [],
    })

=head1 DESCRIPTION

Petal for catalyst

=head1 AUTHOR

Christoph Halbartschlager

=head1 LICENSE

This library is free software . You can redistribute it and/or modify it under
the same terms as perl itself.

=cut

__PACKAGE__->config(input => 'XHTML', output => 'XHTML');

=head2 process

=cut

sub process {
    my ($self, $c) = @_;

    $self->config( base_dir => [ $c->config->{root} . '/templates/' ] );

    $c->stash({
        uri_static => $c->uri_for('/static'),
    });

    $self->SUPER::process($c);
}

1;
