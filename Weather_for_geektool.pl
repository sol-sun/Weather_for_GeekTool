#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;
use Storable;
use File::Basename;


# You can edit this variable if you want to change the weather-icon-path.
my $WEATHER_ICON_PATH = '/tmp/weather.png';
my $WEATHER_ICON_COLOR = 'White'; #or 'Black'
#.

my (%weather_list, $cdir);

my $sh_script = q(curl --silent "http://xml.weather.yahoo.com/forecastrss?p=JAXX0085&u=c" | grep -E '(Current Conditions:|C<BR)' | sed -e 's/Current Conditions://' -e 's/<br \/>$//' -e 's/<b>//' -e 's/<\/b>//' -e 's/<BR \/>//' -e 's/<description>//' -e 's/<\/description>//');

my $curl = `$sh_script`;

unless($curl){
  print "Lost Connection.\nBe calm and study Physics.";
  exit(1);
}


my ($Today_weather, $Today_temperature);

if(trim($curl) =~ m/([^,]+),(.+)/i){
  $Today_weather = trim($1);
  $Today_temperature = trim($2);
}


if( exists($weather_list{"$Today_weather"}) ){

  print "$Today_weather, $Today_temperature";

  my $ICON_PATH = $cdir . '/Data/Weather_ICON/' . $WEATHER_ICON_COLOR .'/png/' . $weather_list{"$Today_weather"} . '.png';
  
  `cp $ICON_PATH  $WEATHER_ICON_PATH`;
  
}else{
  
  die "$Today_weather not founded in \%weather_list:Please Mail to me ";
  
}

##################
##  Subroutine  ##
##     and      ##
## Weather Code ##
##################

sub trim {
  my $val = shift;
  $val =~ s/^\s*(.*?)\s*$/$1/;
  return $val;
}


BEGIN{
  #  data pass ("$0" or "__FILE__" are this file name)
  $cdir = dirname($0);
  my $ndata = "$cdir".'/Data/MkBase/.Weather_List';
  #.
  
  ## Load Weather list
  eval{
    %weather_list = %{retrieve($ndata)};
  };
  if($@){
    die "[error]$@";
  }
  ##
};
