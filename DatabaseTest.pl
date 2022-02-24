#!/usr/bin/perl -w

use 5.10.0;

#use CGI;
#use POSIX;
use Encode qw(decode_utf8);
#use Encode;
use Encode qw(decode encode);
#= BEGIN{@ARGV=map Encode::decode(#\$_,1),@ARGV;}
# BEGIN{@ARGV = map decode_utf8(#\$_, 1), @ARGV;}
use open qw(:std :encoding(UTF-8));
use utf8::all 'GLOBAL';
use Encode::Locale;
# use diagnostics;
use File::Basename qw(dirname);
use lib dirname(__FILE__);
use DBC::DBC;

use strict;
use warnings FATAL => 'all';
use utf8;
use DBI;

binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use DDP;
use Data::Dumper;
use Bundle::Camelcade;# for Intellij IDEA


say "Perl MySQL Connect Demo";
# MySQL database configuration
my $dsn = "DBI:mysql:perlmysqldb";
my $username = "user";
my $password = 'APassword2022';

# get user's input links
# my @links = get_links();


# connect to MySQL database
my %attr = (PrintError => 0,# turn off error reporting via warn()
    RaiseError         => 1,# turn on error reporting via die()
    AutoCommit         => 1);# transaction enabled

my $dbh = DBI->connect($dsn, $username, $password, \%attr) or
    die("Error connecting to the database: $DBI::errstr\n");

say "Connected to the MySQL database.";

# create table statements
my @ddl = (
    # create tags table
    "CREATE TABLE tags (
			tag_id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
			tag varchar(255) NOT NULL
	        ) ENGINE=InnoDB;",
    # create links table
    "CREATE TABLE links (
		  link_id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
		  title varchar(255) NOT NULL,
		  url varchar(255) NOT NULL,
		  target varchar(45) NOT NULL
		) ENGINE=InnoDB;",
    # create link_tags table
    "CREATE TABLE link_tags (
		  link_id int(11) NOT NULL,
		  tag_id int(11) NOT NULL,
		  PRIMARY KEY (link_id,tag_id),
		  KEY fk_link_idx (link_id),
		  KEY fk_tag_idx (tag_id),
		  CONSTRAINT fk_tag FOREIGN KEY (tag_id)
		     REFERENCES tags (tag_id),
		  CONSTRAINT fk_link FOREIGN KEY (link_id)
			 REFERENCES links (link_id)
		) ENGINE=InnoDB"
);
# # execute all create table statements
# foreach my $sql ( @ddl ){
#     $dbh->do($sql);
# }
# say "All tables created successfully!";

my @drop_all = (
    # drop tags table
    "DROP TABLE tags",

    # drop links table
    "DROP TABLE links",

    # drop link_tags table
    "DROP TABLE link_tags"
);
# execute all drop table statements
# foreach my $sql_drop ( @drop_all ){
#     $dbh->do($sql_drop) or die "No tables more: S!";
# }


# insert data into the links table
# my $sql_insert = "INSERT INTO links(title,url,target) VALUES(?,?,?)";
# my $stmt = $dbh->prepare($sql_insert);

# execute the query
# foreach my $link(@links){
#     if($stmt->execute($link->{title}, $link->{url}, $link->{target})){
#         say "link $link->{url} inserted successfully";
#     }
# }
# $stmt->finish();
#
# sub get_links{
#     my $cmd = '';
#     my @links_sub;
#     # get links from the command line
#     my($title,$url,$target);
#
#     # repeatedly ask for link data from command line
#     do{
#         say "title:";
#         chomp($title = <STDIN>);
#
#         say "url:";
#         chomp($url = <STDIN>);
#
#         say "target:";
#         chomp($target = <STDIN>);
#
#         my %link = (title=> $title, url=> $url, target=> $target);
#
#         push(@links_sub,\%link);
#
#         print("\nDo you want to insert another link? (Y/N)?");
#         chomp($cmd = <STDIN>);
#         $cmd = uc($cmd);
#     }until($cmd eq 'N');
#
#     return @links_sub;
# }


# eval {
#     # insert a new link
#     my $sql_transac = "INSERT INTO links(title,url,target) VALUES(?,?,?)";
#     my $sth_transac = $dbh->prepare($sql_transac);
#     $sth_transac->execute("Comprehensive Perl Archive Network","http://www.cpan.org/","_blank");
#     # get last insert id of the link
#     my $link_id_transac = $dbh->{q{mysql_insertid}};
#
#     # insert a new tag
#     $sql_transac = "INSERT INTO tags(tag) VALUES(?)";
#     $sth_transac = $dbh->prepare($sql_transac);
#     $sth_transac->execute('Perl');
#
#     # get last insert id of the tag
#     my $tag_id_transac = $dbh->{q{mysql_insertid}};
#
#     # insert a new link and tag relationship
#     $sql_transac = "INSERT INTO link_tags(link_id,tag_id) VALUES(?,?)";
#     $sth_transac = $dbh->prepare($sql_transac);
#     $sth_transac->execute($link_id_transac,$tag_id_transac);
#
#     # if everything is OK, commit to the database
#     #$dbh->commit();
#     say "Link and tag have been inserted and associated successfully!" if $dbh->commit();
#     $sth_transac->finish();
# };
#
# if($@){
#     say "Error inserting the link and tag: $@";
#     $dbh->rollback();
#
#     1;
# };
#


eval {
    use DBC::DBC;

    # query data from the links table
    DBC::DBC::query_links($dbh);
};


DBC::DBC::query_links_by_target($dbh, '_site');

# query from the links table by target
print "Update Query\n";
# update statement
#DBC::DBC::update_query($dbh, 1);

#print "Delete one row from table\n" if
#DBC::DBC::delete_one_row($dbh, 10);
    # delete one row from table
    # $dbh: database handle
    # $link_id: id of the link that need to delete

#print "Delete all row from table\n" if
#DBC::DBC::delete_all_rows($dbh);
    # delete all rows in the clinks table

my $sql = "SHOW TABLES LIKE 'linksS'";
my $sth = $dbh->prepare($sql);
if($sth->execute() != 1) {
    print "Table Don't exist in database\n";
}

# disconnect from the MySQL database
#$dbh->disconnect();
