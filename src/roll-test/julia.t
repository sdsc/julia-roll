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

my @NON_TESTS = ('ccall', 'runtests', 'test_sourcepath');
# The arpack test predictably blows out w/a segfault in MKL.  Skip it rather
# that reporting an error in the installation.
push(@NON_TESTS, 'arpack');

if($appliance =~ /$installedOnAppliancesPattern/) {
  ok($isInstalled, 'julia installed');
} else {
  ok(! $isInstalled, 'julia not installed');
}

SKIP: {

  my @tests = `/bin/ls /opt/julia/test/*.jl 2>&1`;
  skip 'julia not installed', 3 + int(@tests) if ! $isInstalled;
  foreach my $test(@tests) {
    chomp($test);
    $test =~ s#.*/##;
    $test =~ s#\.jl##;
    next if grep(/$test/, @NON_TESTS);
    $output = `module load julia; cd /opt/julia/test; julia --check-bounds=yes -f ./runtests.jl $test 2>&1`;
    like($output, qr/SUCCESS/, "julia $test test");
  }
  `/bin/ls /opt/modulefiles/compilers/julia/[0-9]* 2>&1`;
  ok($? == 0, 'julia module installed');
  `/bin/ls /opt/modulefiles/compilers/julia/.version.[0-9]* 2>&1`;
  ok($? == 0, 'julia version module installed');
  ok(-l '/opt/modulefiles/compilers/julia/.version',
     'julia version module link created');
}

`rm -fr $TESTFILE*`;
