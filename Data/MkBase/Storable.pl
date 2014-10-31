#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;
use JSON;
use Storable;

open my $file, "<", "Weather.json";

my $flag = 0;
my $json = '';
my %hash;


while(my $line = <$file>){
  chomp($line);

  if($line =~ m/^{/){
    $flag = 1;
    next;
  }

  if($flag == 1 ){
    $line =~ s/(\d*)\.[^\"]+/$1/;
    $json .= $line;
  }

  if($flag == 1 && $line =~ /\}/){
    last;
  }

}
my $json_m = JSON->new->allow_nonref;
my $perl_scalar = $json_m->decode($json);

while(my ($key, $value) = each($perl_scalar) ){

  for(@{$value}){
    $hash{"$_"} = $key;
  }
  
}

eval{
  store (\%hash, ".Weather_List");
};


