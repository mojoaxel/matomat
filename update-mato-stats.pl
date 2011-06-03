#!/usr/bin/perl

use strict;

my $dbfile = "/var/matomat/matomat.db";
my $statsfile = "/var/www/data.csv";

        my $user = $_[0];

open DB, "<", $dbfile or die $!;
my @lines = <DB>;
close DB;

my $n=@lines;
my $i=0;

open STAT, ">", $statsfile or die $!;
print STAT "Categories,Credits,Gesamt,Mate,Beer\n";
foreach my $line (@lines) {
	$i++;
	chomp($line);
	if ($line =~ m/^#/) {
		next;
	} else {
        	my ($user, $credit, $beer, $mate) = split(/:/, $line, 4);
                my $all=$beer+$mate;

		if ($i == $n) {
			my $update = $user.",".$credit.",".$all.",".$mate.",".$beer;
			print STAT $update;
		} else {
                	my $update = $user.",".$credit.",".$all.",".$mate.",".$beer."\n";
                	print STAT $update;
		}
        }
}
close STAT;


