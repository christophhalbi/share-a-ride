package PWA::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=encoding utf-8

=head1 NAME

PWA::Controller::Root - Root Controller for PWA

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

=cut

sub index :Path('index') :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash({
        template => 'index.zpt',
    });
}

=head2 ride

=cut

sub ride :Path('ride') :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash({
        template => 'ride.zpt',
    });
}

=head2 jump_in

=cut

sub jump_in :Path('jump_in') :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash({
        template => 'jump_in.zpt',
    });
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 render

Attempt to render a view, if needed.

=cut

sub render :ActionClass('RenderView') {}

=head2 end

=cut

sub end :Private {
    my ( $self, $c ) = @_;

    $c->forward('render');
}

=head1 AUTHOR

Christoph Halbartschlager

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
