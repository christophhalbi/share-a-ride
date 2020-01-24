package PWA::Controller::Root;
use Moose;
use namespace::autoclean;

use PWA::BusinessLogic::Rides;
use PWA::Model;

has 'bl_rides' => (
    is      => 'ro',
    isa     => 'Object',
    lazy    => 1,
    default => sub {

        return PWA::BusinessLogic::Rides->new;
    }
);

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

sub index :Path('') :Args(0) {
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
        template   => 'ride.zpt',
        uri_action => $c->uri_for('post_ride'),
    });
}

=head2 jump_in

=cut

sub jump_in :Path('jump_in') :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash({
        template  => 'jump_in.zpt',
        uri_rides => $c->uri_for('get_rides'),
    });
}

=head2 get_rides

=cut

sub get_rides :Path('get_rides') :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash({
        results => [
            map { $_->as_json } $self->bl_rides->rides(PWA::Model->new( source => $c->session ))
        ]
    });

    $c->forward('View::JSON');
}

=head2 post_ride

=cut

sub post_ride :Path('post_ride') :Args(0) {
    my ( $self, $c ) = @_;

    my ($validation_result) = $self->bl_rides->validate($c->req->body_parameters);
    if ($validation_result->success) {

        my $valid = $validation_result->valid;

        $c->stash({
            validation_errors => {},
            saved             => $self->bl_rides->save_ride(PWA::Model->new( source => $c->session ), $valid),
        });
    }
    else {

        $c->stash->{validation_errors} = $validation_result->msgs;
    }

    $c->forward('View::JSON');
}

=head2 favicon

=cut

sub favicon :Path('favicon.ico') :Args(0) {
    my ( $self, $c ) = @_;

    $c->serve_static_file($c->config->{root} . '/static/images/favicon.ico');

    return;
}

=head2 manifest

=cut

sub manifest :Path('manifest.json') :Args(0) {
    my ( $self, $c ) = @_;

    $c->serve_static_file($c->config->{root} . '/static/manifest.json');

    return;
}

=head2 sw

=cut

sub sw :Path('sw.js') :Args(0) {
    my ( $self, $c ) = @_;

    $c->serve_static_file($c->config->{root} . '/static/sw.js');

    return;
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
