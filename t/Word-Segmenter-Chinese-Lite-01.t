use strict;
use warnings;

use Test::More tests => 4;
use Word::Segmenter::Chinese::Lite qw(wscl_seg);

my @r1 = wscl_seg("abc cbd ddd 123456");
my @r1_expect = qw(abc cbd ddd 123456);
is_deeply(\@r1, \@r1_expect);

my @r2 = wscl_seg("中华人民共和国成立了");
my @r2_expect = (
  "\x{4E2D}\x{534E}\x{4EBA}\x{6C11}\x{5171}\x{548C}\x{56FD}",
  "\x{6210}\x{7ACB}",
  "\x{4E86}",
);
is_deeply(\@r2, \@r2_expect);

my @r3 = wscl_seg("oyeah中华人民共和国成立了");
my @r3_expect = (
  "\x{4E2D}\x{534E}\x{4EBA}\x{6C11}\x{5171}\x{548C}\x{56FD}",
  "\x{6210}\x{7ACB}",
  "\x{4E86}",
  "oyeah",
);
is_deeply(\@r3, \@r3_expect);

my @r4 = wscl_seg("小明明天还要去上课学习语文和数学呢");
my @r4_expect = (
  "\x{5C0F}\x{660E}",
  "\x{660E}\x{5929}",
  "\x{8FD8}\x{8981}",
  "\x{53BB}",
  "\x{4E0A}\x{8BFE}",
  "\x{5B66}\x{4E60}",
  "\x{8BED}\x{6587}",
  "\x{548C}",
  "\x{6570}\x{5B66}",
  "\x{5462}",
);
is_deeply(\@r4, \@r4_expect);



