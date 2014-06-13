package Word::Segmenter::Chinese::Lite;

use 5.008008;
use strict;
use warnings;

use Encode;
use Word::Segmenter::Chinese::Lite::Dict qw(wscl_get_dict_default);

require Exporter;
our @ISA     = qw(Exporter);
our @EXPORT  = qw(wscl_seg wscl_set_mode);
our $VERSION = '0.02';

our $WSCL_MODE = 'dict';

sub wscl_set_mode {
    my $mode = shift;
    if ( $mode eq 'dict' or $mode eq 'o-bigram' ) {
        $WSCL_MODE = $mode;
    }
    return 0;
}

sub wscl_seg {
    my $str = shift;
    if ( $WSCL_MODE eq 'dict' ) {
        return wscl_seg_dict($str);
    }
    return 0;
}

sub wscl_seg_dict {
    my $string          = shift;
    my $real_max_length = 9;
    my %dict            = wscl_get_dict_default();

    my $line = decode( 'utf8', $string );
    my $len = length($line);
    return 0 if !$len or $len <= 0;

    my @result;
    my @eng = $line =~ /[A-Za-z0-9\-\_\:\.]+/g;
    unshift @result, @eng;

    while ( length($line) >= 1 ) {
        for ( 0 .. $real_max_length - 1 ) {
            my $len = $real_max_length - $_;
            my $w = substr( $line, $_ - $real_max_length );
            if ( defined $dict{$len}{$w} ) {
                unshift @result, $w;
                $line =
                  substr( $line, 0, length($line) - ( $real_max_length - $_ ) );
                last;
            }

            if ( $_ == $real_max_length - 1 ) {
                $line = substr( $line, 0, length($line) - 1 );
            }
        }
    }
    return @result;
}

1;
__END__

=head1 NAME

Word::Segmenter::Chinese::Lite - Split Chinese into words

=head1 SYNOPSIS

  use Word::Segmenter::Chinese::Lite qw(wscl_seg);
  my @result = wscl_seg("中华人民共和国成立了oyeah");
  print @result;

=head1 DESCRIPTION

Support UTF8 string input only.


=head1 TODOS

1. Optimize dictionary loading speed.

2. Support for custom dictionary.

3. Add overlapping-bigram,bigram,1gram algorithm.

4. Support for specify the maximum word length.

=head2 METHODS

=head1 wscl_seg()

Main methods.

Input a utf8 string which want to de splited.

Output a list.

=head2 EXPORT

no method will be exported by default.

=head1 AUTHOR

Chen Gang, E<lt>yikuyiku.com@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2014 by Chen Gang

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.16.2 or,
at your option, any later version of Perl 5 you may have available.


=cut
