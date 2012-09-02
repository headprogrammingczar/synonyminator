#!/usr/bin/perl -W

use strict;
use warnings;

main();

sub main {
  while (<>) {
    s/\b(\w+)\b/&synonyminate($1)/eg;
    print;
  }

  print "\n";
}

sub synonyminate {
  my ($word) = @_;
  my (@lines, $line, @synonyms, $rand);

  @lines = `aiksaurus $word`;

  @synonyms = ();

  if ($lines[0] eq "*** No synonyms known. ***\n") {
    return $word;
  }

  foreach $line (@lines) {
    chomp $line;
    if ($line !~ /^===/ and $line ne '') {
      @synonyms = (@synonyms, split(/, /, $line));
    }
  }

  $rand = int(rand(scalar @synonyms));

  return $synonyms[$rand];
}

