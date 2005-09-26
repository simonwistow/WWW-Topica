#!perl -w

use Test::More tests => 8;


use_ok('WWW::Topica');
use_ok('Email::Simple');


my %opts = ( 
                list       => 'bogus', 
                email      => 'something@examples.com', 
                password   => 'foo',
                local      => 1,
                debug      => 0,
                
            );

my $topica;
my @mails;
ok($topica = WWW::Topica->new(%opts), "create new topica");

while (my $mail = $topica->mail) {
	push @mails, $mail;
}
is(scalar @mails, 300, "Got 300 mails");

my $email;

ok( $email = Email::Simple->new($mails[0]), "Created new Email::Simple");
is( $email->header('subject'), 'Re: Yahoo down?', 'Got correct subject');
is( $email->header('date'), 'Tue, 5 Mar 2002 13:42:00 +0000', 'Got correct date');
is( $email->header('from'), 'Clive Barker <light-@example.com>', 'Got correct from');


