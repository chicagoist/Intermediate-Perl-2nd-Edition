package DBC::DBC;
use 5.10.0;
use Exporter;
use strict;
use warnings FATAL => 'all';
use DBI;


#our (@EXPORT_OK) = (".");
sub query_links{
    # query from the links table

    my ($dbh) = @_;
    my $sql = "SELECT title,
                    url
             FROM perlmysqldb.links";
    my $sth = $dbh->prepare($sql);

    # execute the query
    $sth->execute();

    while(my @row = $sth->fetchrow_array()){
        printf("%s\t%s\n",$row[0],$row[1]);
    }
    $sth->finish();
}

sub query_links_by_target{
    # query from the links table by target

    my ($dbh,$target) = @_;
    my $sql = "SELECT title,url,target FROM links WHERE target = ?";
    my $sth = $dbh->prepare($sql);

    # execute the query
    $sth->execute($target);
#print($sth->fetchrow_array());
    while(my @row = $sth->fetchrow_array()){
        printf("%s\t%s\t%s\n",$row[0],$row[1],$row[2]);
    }
    $sth->finish();

}

sub update_query {

    my ($dbh,$id) = @_;
    # update statement
    my $sql = "UPDATE perlmysqldb.links
           SET title = ?,
               url = ?,
               target = ?
	   WHERE link_id = ?";

    my $sth = $dbh->prepare($sql);

    #my $id = 2;
    my $title = "Mail.ru";
    my $url = "https://www.mail.ru/";
    my $target = "_blanc";

    # bind the corresponding parameter
    $sth->bind_param(1,$title);
    $sth->bind_param(2,$url);
    $sth->bind_param(3,$target);
    $sth->bind_param(4,$id);

    # execute the query
    $sth->execute();

    say "The record has been updated successfully!";

    return $sth->finish();

}

sub delete_one_row {
    # delete one row from table
    # $dbh: database handle
    # $link_id: id of the link that need to delete
    my($dbh,$link_id)  = @_;
    my $sql = "DELETE FROM clinks WHERE link_id = ?";
    my $sth = $dbh->prepare($sql);

    # bind the corresponding parameter
    $sth->bind_param(1,$link_id);

    $sth->execute();
}

sub delete_all_rows {
    # delete all rows in the clinks table
    my($dbh) = @_;
    my $sql = "TRUNCATE TABLE clinks";
    my $sth = $dbh->prepare($sql);

    #$sth->execute();

    return $sth->execute();
}

1;