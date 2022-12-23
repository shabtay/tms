#!perl

use YAML;

$logs = `cd C:\tmp\repos\dancesearch\ & git log --name-status`;

#@log = split( $logs, "\n" );
my @ids;
my $data;
while( $logs =~ /commit (.*?)\s/g ) {
#	print $1."\n";
	push( @ids, $1 );
}

foreach $id ( @ids ) {
	$text = `git show $id --no-patch`;

	( $author, $email ) = $text =~ /Author\:\s(.*)?\<(.*?)\>/s;
	( $date, $comment ) = $text =~ /Date\:\s+(.*)?\+\d+(.*)/s;
	#( $comment ) = $text =~ /^\\n(.*)/;
	
#	print $comment . "\n";
	
	$author =~ s/^\s+|\s+$//g;
	$email =~ s/^\s+|\s+$//g;
	$date =~ s/^\s+|\s+$//g;
	$comment =~ s/^[\r\n]+//;

	$data->{$id}{email} = $email;
	$data->{$id}{author} = $author;
	$data->{$id}{date} = $date;
	$data->{$id}{comment} = $comment;
}

print YAML::Dump( $data );