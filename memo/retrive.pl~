#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;
use Storable;
use File::Basename;

my %weather_list;

print $weather_list{'Fair'};
print "\n";



BEGIN{
  #
  my $cdir = dirname($0);
  
  my $ndata = "$cdir".'/.Weather_List';

  eval{
    %weather_list = %{retrieve($ndata)};
  };
  #.
#  if($@){
#    die "[error]$@";
#  }
};

