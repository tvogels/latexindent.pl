package LatexIndent::Element;
use strict;
use warnings;
use feature qw(say);

sub explain {
    my ($self, $level) = @_;
    ($self->{Command} 
      || $self->{KeyEqualsValuesBraces}
      || $self->{Environment} 
      || $self->{NamedGroupingBracesBrackets} 
      || $self->{Special}
      || $self->{IfElseFi}
      || $self->{Literal}
      || $self->{TrailingComment}
      || $self->{BlankLine}
    )->explain($level);
    return;
}

sub indent {
    my $self = shift;
    my $body = ($self->{Command} 
                || $self->{KeyEqualsValuesBraces}
                || $self->{Environment}
                || $self->{NamedGroupingBracesBrackets} 
                || $self->{Special}
                || $self->{IfElseFi}
                || $self->{Literal}
                || $self->{TrailingComment}
                || $self->{BlankLine}
              )->indent;
    return $body;
}
 
1;
