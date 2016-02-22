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
  # NOTE: the arpack test predictably blows out w/a segfault in MKL, so avoid
  # using it as a representative test.
  $output = `module load julia; cd /opt/julia/test; julia --check-bounds=yes -f ./runtests.jl core 2>&1`;
  like($output, qr/SUCCESS/, "julia core test");
  `/bin/ls /opt/modulefiles/compilers/julia/[0-9]* 2>&1`;
  ok($? == 0, 'julia module installed');
  `/bin/ls /opt/modulefiles/compilers/julia/.version.[0-9]* 2>&1`;
  ok($? == 0, 'julia version module installed');
  ok(-l '/opt/modulefiles/compilers/julia/.version',
     'julia version module link created');
}

`rm -fr $TESTFILE*`;
