#!/usr/bin/perl -w

use 5.10.0;

use strict;
use warnings FATAL => 'all';
use autodie qw(:all);
use utf8;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
use DDP;
use Data::Dumper;
use Bundle::Camelcade; # for Intellij IDEA
use LWP::UserAgent;
use HTTP::Request;
# use JSON::MaybeXS qw(encode_json);
use JSON::XS;



print "Это версия библиотеки libwww-perl-$LWP::VERSION\n\n";


#
# {
#     my $ua = LWP::UserAgent->new;
#     $ua->agent("Perl API Client/1.0");
#     # my $server_endpoint = "http://jsonplaceholder.typicode.com/posts/1";
#     my $server_endpoint = "http://jsonplaceholder.typicode.com/posts/?userId=1&id=2";
#     my $req = HTTP::Request->new(GET => $server_endpoint);
#
#     my $resp = $ua->request($req);
#     if ($resp->is_success) {
#         my $message = $resp->decoded_content;
#         print "Received reply: $message", "\n\n";
#     }
#     else {
#         print "HTTP GET error code: ", $resp->code, "\n";
#         print "HTTP GET error message: ", $resp->message, "\n\n";
#     }
# }
#
#
# {
#     my $ua_post = LWP::UserAgent->new;
#     # my $server_endpoint_post = 'https://reqres.in/api/users/?name=morpheus&job=leader';
#     my $server_endpoint_post = 'https://api.sandbox.movylo.com/v3/Authentication/';
#     my $req_post = HTTP::Request->new(POST => $server_endpoint_post);
#
#     my $resp_post = $ua_post->request($req_post);
#     if ($resp_post->is_success) {
#         my $message_p = $resp_post->decoded_content;
#         print "Received reply: $message_p", "\n\n";
#     }
#     else {
#         print "HTTP POST error code: ", $resp_post->code, "\n";
#         print "HTTP POST error message: ", $resp_post->message, "\n\n";
#     }
# }
#
# {
#
#     my $ua_2 = LWP::UserAgent->new;
#     my $req_2 = HTTP::Request->new(GET => 'http://jsonplaceholder.typicode.com/posts/?userId=1&id=2');
#     print "GET : ", $ua_2->request($req_2)->as_string, "\n\n";
#
# }
#
# {
#     use REST::Client;
#
#     my $id_created_user;
#
#     my $server_endpoint_post_1 = 'https://reqres.in/api/users/?name=morpheus&job=leader';
#     #The basic use case
#     my $client = REST::Client->new();
#     $client->POST('https://reqres.in/api/users?delay=3');
#     print "From REST::Client POST create user : \n" . $client->responseContent(), "\n";
#
#     # print $client->responseContent() , "\n\n";
#
#     foreach ($client->responseContent()) {
#
#         if (/^{"id":"(\d+)"\.*/) {
#             s/^{"id":"(\d+)".*$/$1/;
#             $id_created_user = $_;
#         }
#     }
#
#     print "\$id_created_user = >$id_created_user<\n\n";
#
# }

{
    my %request;
    my $content_value = \'match=www&errors=0&client_id=deluxe-movylo-api&client_secret=A9430AB0099ECD5C4F3C60A791AE20DCEC506D293612926518038E4947B24561&grant_type=client_credentials&partner_code=deluxe_p1va';

    my $ua_3 = LWP::UserAgent->new;
    my $req_3 = HTTP::Request->new(POST => 'https://api.sandbox.movylo.com/v3/Authentication/');
    $req_3->content_type('application/x-www-form-urlencoded');
    # $req_3->content('match=www&errors=0&client_id=deluxe-movylo-api&client_secret=A9430AB0099ECD5C4F3C60A791AE20DCEC506D293612926518038E4947B24561&grant_type=client_credentials&partner_code=deluxe_p1va');
    $req_3->content(${$content_value});
    my $res_3 = $ua_3->request($req_3);
    # print $res_3->as_string;

    if ($res_3->is_success)
    {
        print $res_3->content, "\n\n";
        %request = %{$ua_3->request($req_3)};
    }
    else
    {
        print "POST : ", $res_3->content, "\n";
        print "На этот раз Вас постигла неудача\n\n";
    }
    print "\$res_3->as_string = ";
    print $res_3->as_string, "\n\n";

    say '\print Dumper $ua_3->request($req_3) :';
    print Dumper %request;
    print "\n\n";

    say '\sort keys %request = ', "\n";
    foreach (sort keys %request)
    {
        print "$_ => $request{$_}\n";
    }

}

#
# use HTTP::Request::Common qw(POST);
# my $ua_7 = LWP::UserAgent->new;
# # my $req_7 = POST 'http://www.perl.com/cgi-bin/BugGlimpse',
# my $req_7 = POST 'https://api.sandbox.movylo.com/v3/Authentication/',
#     # [ search => 'www', errors => 0 , ];
#     [ search => 'www', errors => 0 , client_id => 'deluxe-movylo-api', client_secret => 'A9430AB0099ECD5C4F3C60A791AE20DCEC506D293612926518038E4947B24561',
#         grant_type => 'client_credentials', partner_code => 'deluxe_p1va'];
# # print grep{s/\:/ => /g } $ua_7->request($req_7)->as_string;
# # print  grep{ s/{?"([\w | \d]*)":"?([\d | \w]*)"?,?}?/$1=>$2 /g } $ua_7->request($req_7)->as_string;
# my %request = %{$ua_7->request($req_7)};
#
# say '\print Dumper $ua_7->request($req_7) :';
# print Dumper %request;
#
# say '\print Dumper %request = ', "\n";
# foreach (sort keys %request) {
#     print "$_ => $request{$_}\n";
# }



#
# {
#     # my $url = 'https://reqres.in/api/users';
#     my $url = 'https://reqres.in/api/login';
#     my $header = [ 'Content-Type' => 'application/json; charset=UTF-8' ];
#     # my $data = {email => 'eve.holt@reqres.in', password => 'cityslicka'};
#     my $data = { email => 'eve.holt@reqres.in' };
#     my $encoded_data = encode_json($data);
#
#     my $r = HTTP::Request->new('POST', $url, $header, $encoded_data);
#     # at this point, we could send it via LWP::UserAgent
#     my $ua_4 = LWP::UserAgent->new();
#     my $res_4 = $ua_4->request($r);
#
#     print keys %{$res_4}, "\n";
#     print Dumper $res_4;
#     print "\n\n";
# }
#
# {
#     use HTTP::Request ();
#     use JSON::MaybeXS qw(encode_json);
#
#     my $url = 'http://jsonplaceholder.typicode.com/comments?postId=1';
#     my $header = [ 'Content-Type' => 'application/json; charset=UTF-8' ];
#     my $data = { postId => '1' };
#     my $encoded_data = encode_json($data);
#
#     my $r = HTTP::Request->new('GET', $url, $header, $encoded_data);
#     # at this point, we could send it via LWP::UserAgent
#     my $ua_6 = LWP::UserAgent->new();
#     my $res = $ua_6->request($r);
#
#     print %{$res}, "\n\n";
#
# }
#




{ # Check Tor settings

   use LWP::UserAgent;
    my $ua_proxy = LWP::UserAgent->new;
    $ua_proxy->proxy(['socks'] => 'http://127.0.0.1:9050');
    my $req_proxy = HTTP::Request->new('GET',"https://check.torproject.org/api/ip");
    # $req->proxy_authorization_basic("proxy_user", "proxy_password");
    my $res_proxy = $ua_proxy->request($req_proxy);
    print "\nPROXY\n";
    print  $res_proxy->content if $res_proxy->is_success; # {"IsTor":true,"IP":"185.220.101.78"}
    print "\n";

}

{
    #DBI

     use LWP::UserAgent;
     my $ua = LWP::UserAgent->new;
    # my $req = HTTP::Request->new(GET => 'https://www.helsinki.fi/');
    # my $res = $ua->request($req);
    # if ($res->is_success)
    # {
    #     print $res->as_string;
    # }
    # else
    # {
    #     print "Failed: ", $res->status_line, "\n";
    # }



}