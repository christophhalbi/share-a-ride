package PWA::Configuration;

use common::sense;

use Moose;

use Config::Any;

use FindBin qw($RealBin);

has bin => (
    is      => 'ro',
    isa     => 'Str',
    lazy    => 1,
    default => sub {

        return "$RealBin/../";
    },
);

has files => (
    is      => 'ro',
    isa     => 'ArrayRef[Str]',
    lazy    => 1,
    default => sub { [qw(pwa_local pwa)] },
);

has configurations => (
    is      => 'ro',
    isa     => 'HashRef',
    lazy    => 1,
    default => sub {
        my ($self) = @_;

        my $bin = $self->bin;

        my %configurations;
        foreach my $file (@{ $self->files }) {

            my $config = Config::Any->load_files({
                files           => ["$bin/$file.yml"],
                use_ext         => 1,
                flatten_to_hash => 1,
            });

            # we want handy hash keys instead of paths and filenames
            $configurations{$file} = (values %$config)[0];
        }

        return \%configurations;
    },
);

sub get {
    my ($self, @keys) = @_;

    my $last = pop @keys;

    FILES: foreach my $file ( @{ $self->files } ) {
        my $hash = $self->configurations->{$file};

        foreach (@keys) {
            next FILES unless exists $hash->{$_};
            $hash = $hash->{$_};
        }

        return $hash->{$last} if exists $hash->{$last};
    }

    die "@keys $last not found in configuration";
}

1;
