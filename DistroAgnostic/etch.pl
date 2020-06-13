#!/usr/bin/env perl


my $src = $ARGV[0];
my $dst = '/dev/mmcblk0';

if (not defined $src) {
  print "First argument should be the source file. Aborting!\n";
  exit(1);
}

if (not -e $src) {
  print "Source file $src does not exist. Aborting!\n";
  exit(1);
}

if (not -e $dst) {
  print "Destination $dst doesn't seem to exist. Please insert your memory card and try again!\n";
  exit(1);
}


my $cmd = "sudo dd if=$src of=$dst bs=16M conv=noerror,sync status=progress";

print "Running command '$cmd'\n";

system($cmd);

