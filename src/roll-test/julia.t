#!/usr/bin/perl -w
# julia roll installation test.  Usage:
# julia.t [nodetype]
#   where nodetype is one of "Compute", "Dbnode", "Frontend" or "Login"
#   if not specified, the test assumes either Compute or Frontend

use Test::More qw(no_plan);

my $appliance = $#ARGV >= 0 ? $ARGV[0] :
                -d '/export/rocks/install' ? 'Frontend' : 'Compute';
my $installedOnAppliancesPattern = '.';
my $isInstalled = -d '/opt/julia';
my $output;

my $TESTFILE = 'tmpjulia';

if($appliance =~ /$installedOnAppliancesPattern/) {
  ok($isInstalled, 'julia installed');
} else {
  ok(! $isInstalled, 'julia not installed');
}
SKIP: {

  skip 'julia not installed', 4 if ! $isInstalled;
  SKIP: {
    skip 'no julia run test written', 1;
  }
  `/bin/ls /opt/modulefiles/applications/julia/[0-9]* 2>&1`;
  ok($? == 0, 'julia module installed');
  `/bin/ls /opt/modulefiles/applications/julia/.version.[0-9]* 2>&1`;
  ok($? == 0, 'julia version module installed');
  ok(-l '/opt/modulefiles/applications/julia/.version',
     'julia version module link created');
}
$packageHome = '/opt/julia';
SKIP: {
  skip 'julia not installed', 1 if ! -d $packageHome;
  `pwd=\`pwd\`;module load julia; cd /opt/julia/test; bash testit> \$pwd/$TESTFILE 2>&1`;
  ok(`grep -c "SUCCESS" $TESTFILE` == 54, 'julia works');
  `rm -f $TESTFILE`;
}

`rm -fr $TESTFILE*`;
