#!perl

use YAML;
use JSON;

unlink "log.json" if -e "log.json";

$logs = `gitting.cmd $ARGV[0]`;

my @ids;
my $data;
while( $logs =~ /commit (.*?)\s/g ) {
	push( @ids, $1 );
}

foreach $id ( @ids ) {
	$text = `git_show.cmd $ARGV[0] $id`;

	( $author, $email ) = $text =~ /Author\:\s(.*)?\<(.*?)\>/s;
	( $date, $comment ) = $text =~ /Date\:\s+(.*)?\+\d+(.*)/s;
	
	$author =~ s/^\s+|\s+$//g;
	$email =~ s/^\s+|\s+$//g;
	$date =~ s/^\s+|\s+$//g;
	$comment =~ s/^[\r\n]+//;
	$comment =~ s/^\s+|\s+$//g;
	$comment =~ s/\n\s+/\n/s;

	#print "---\n$comment\n---\n";
	
	if ( $comment =~ /task#(\d+)/is ) {
		$data->{$id}{task_id} = $1;
		$data->{$id}{email} = $email;
		$data->{$id}{author} = $author;
		$data->{$id}{date} = $date;
		$data->{$id}{comment} = $comment;
	}
}

$json_text = encode_json ($data );
open FH, ">log.json";
print FH $json_text . "\n";
close FH;
#print YAML::Dump( $data );