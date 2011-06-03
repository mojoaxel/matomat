#!/usr/bin/perl
# ----------------------------------------------------------------------------
# "THE BEER-WARE LICENSE" (Revision 42):
# lofi schrieb diese Datei. Solange Sie diesen Vermerk nicht entfernen,
# können Sie mit der Datei machen, was Sie möchten. 
# Wenn wir uns eines Tages treffen und Sie denken, die Datei ist es wert, 
# können Sie mir dafür ein Bier bzw. eine Mate ausgeben.
# ----------------------------------------------------------------------------

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


