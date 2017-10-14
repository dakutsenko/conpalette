#!/usr/bin/env perl

package App::ConPalette;
BEGIN {
  $App::ConPalette::AUTHORITY = 'cpan:HINRIK';
}
{
  $App::ConPalette::VERSION = '0.1.7';
}

use strict;
use warnings FATAL => 'all';
use Getopt::Long qw(:config auto_help);
use Pod::Usage;

my %palettes = (
	# CMYCK color theme
	# http://smyck.net/
	'smyck' => [
		'000000',
		'C75646',
		'8EB33B',
		'D0B03C',
		'72B3CC',
		'C8A0D1',
		'218693',
		'B0B0B0',

		'5D5D5D',
		'E09690',
		'CDEE69',
		'FFE377',
		'9CD9F0',
		'FBB1F9',
		'77DFD8',
		'F7F7F7',
	],
	# https://terminal.sexy/
	'sexy' => [
		'1D1F21',
		'A54242',
		'8C9440',
		'DE935F',
		'5F819D',
		'85678F',
		'5E8D87',
		'707880',

		'373B41',
		'CC6666',
		'B5BD68',
		'F0C674',
		'81A2BE',
		'B294BB',
		'8ABEB7',
		'C5C8C6',
	],
	# CGA RGBI color theme
	# http://www.shikadi.net/moddingwiki/EGA_Palette
	'cga' => [
        '000000',
        'AA0000',
        '00AA00',
        'AA5500',
        '0000AA',
        'AA00AA',
        '00AAAA',
        'AAAAAA',

        '555555',
        'FF5555',
        '55FF55',
        'FFFF55',
        '5555FF',
        'FF55FF',
        '55FFFF',
        'FFFFFF',
    ],
    # KDE Konsole's default theme
    'konsole' => [
        '000000',
        'B21818',
        '18B218',
        'B26818',
        '1818B2',
        'B218B2',
        '18B2B2',
        'B2B2B2',

        '686868',
        'FF5454',
        '54FF54',
        'FFFF54',
        '5454FF',
        'FF54FF',
        '54FFFF',
        'FFFFFF',
    ],
    # rxvt's default theme
    'rxvt' => [
        '000000',
        'CD0000',
        '00CD00',
        'CDCD00',
        '0000CD',
        'CD00CD',
        '00CDCD',
        'FAEBD7',

        '404040',
        'FF0000',
        '00FF00',
        'FFFF00',
        '0000FF',
        'FF00FF',
        '00FFFF',
        'FFFFFF',
    ],
    # http://en.wikipedia.org/wiki/List_of_8-bit_computer_hardware_palettes#ZX_Spectrum
    # The original palette has black listed twice so I replaced one with a
    # dark grey color, which it was missing.
    'sinclair' => [
        '000000',
        'CA0000',
        '00CA00',
        'CACA00',
        '0000AA',
        'CA00CA',
        '00CACA',
        'CACACA',

        '555555',
        'FF0000',
        '00FF00',
        'FFFF00',
        '0000FF',
        'FF00FF',
        '00FFFF',
        'FFFFFF',
    ],
    # gnome-terminal's Tango theme
    'tango-light' => [
        '2E3436',
        'CC0000',
        '4E9A06',
        'C4A000',
        '3465A4',
        '75507B',
        '06989A',

        'D3D7CF',
        '555753',
        'EF2929',
        '8AE234',
        'FCE94F',
        '729FCF',
        'AD7FA8',
        '34E2E2',
        'EEEEEC',
    ],
    # A dark version I made using the Tango palette.
    'tango-dark' => [
        '000000',
        'CC0000',
        '4E9A06',
        'C4A000',
        '3465A4',
        '75507B',
        '06989A',
        'AAAAAA',

        '555753',
        'EF2929',
        '8AE234',
        'FCE94F',
        '729FCF',
        'AD7FA8',
        '34E2E2',
        'D3D7CF',
    ],
    # xterm's default theme
    'xterm' => [
        '000000',
        'CD0000',
        '00CD00',
        'CDCD00',
        '1E90FF',
        'CD00CD',
        '00CDCD',
        'E5E5E5',

        '4C4C4C',
        'FF0000',
        '00FF00',
        'FFFF00',
        '4682B4',
        'FF00FF',
        '00FFFF',
        'FFFFFF',
    ],
    # http://slinky.imukuppi.org/zenburnpage/
    # Zenburn is a 256-color theme, but I used the 16-color port found here:
    # https://github.com/lloeki/linux-console-themes
    'zenburn' => [
        '1E2320',
        '705050',
		'60B48A',
        'DFAF8F',
        '506070',
        'DC8CC3',
        '8CD0D3',
        'DCDCCC',

		'709080',
        'DCA3A3',
        'C3BF9F',
        'F0DFAF',
        '94BFF3',
        'EC93D3',
        '93E0E3',
        'FFFFFF',
    ],
    # http://ethanschoonover.com/solarized
    'solarized-dark' => [
        '073642',
        'DC322F',
        '719E07',
        'B58900',
        '268BD2',
        'D33682',
        '2AA198',
        'EEE8D5',

        '002B36',
        'CB4B16',
        '568E75',
        '657B83',
        '839496',
        '6C71C4',
        '93A1A1',
        'FDF6E3',
    ],
    'solarized-dark-highcontrast' => [
        '073642',
        'DC322F',
        '719E07',
        'B58900',
        '268BD2',
        'D33682',
        '2AA198',
        'FDF6E3',

        '002B36',
        'CB4B16',
        '657B83',
        '839496',
        '93A1A1',
        '6C71C4',
        'EEE8D5',
        'FDF6E3',
    ],
    'solarized-light' => [
        'EEE8D5',
        'DC322F',
        '719E07',
        'B58900',
        '268BD2',
        'D33682',
        '2AA198',
        '073642',

        'FDF6E3',
        'CB4B16',
        '93A1A1',
        '839496',
        '657B83',
        '6C71C4',
        '586E75',
        '002B36',
    ],
	'green' => [
		'004224',
		'AA0000',
		'00E47B',
		'00BE67',
		'00502B',
		'007A42',
		'00F484',
		'21FF99',

		'00AA5C',
		'FF2323',
		'69FFBA',
		'A5FFD6',
		'00BE67',
		'00F484',
		'7FFFC4',
		'B9FFDF',
	],
	# http://iterm2colorschemes.com/
	'adventure_time' => [
		'341858',
		'CF0000',
		'21CF22',
		'EE8C00',
		'4617D3',
		'815BA4',
		'7AB6A8',
		'F3E0C4',

		'697ECC',
		'FF6964',
		'8FFF7F',
		'ECDB00',
		'219FD3',
		'F782BA',
		'AFFAF5',
		'F5F2F9',
	],
	'tartan' => [
		'2E3436',
		'CC0000',
		'4E9A06',
		'C4A000',
		'3465A4',
		'75507B',
		'06989A',
		'D3D7CF',

		'555753',
		'EF2929',
		'8AE234',
		'FCE94F',
		'729FCF',
		'AD7FA8',
		'34E2E2',
		'EEEEEC',
	],
	'ciapre' => [
		'181818',
		'810009',
		'48513B',
		'CC8B3F',
		'576D8C',
		'724D7C',
		'5C4F4B',
		'AEA47F',

		'555555',
		'AC3835',
		'A6A75D',
		'DCDF7C',
		'3097C6',
		'D33061',
		'F3DBB2',
		'F4F4F4',
	],
	#http://terminal.sexy/
	#intensive colors swapped with normal
	'sweet_love' => [
		'1F1F1F',
		'AC5D2F',
		'647035',
		'8F6840',
		'444B4B',
		'614445',
		'585C49',
		'978965',

		'4A3637',
		'D17B49',
		'7B8748',
		'AF865A',
		'535C5C',
		'775759',
		'6D715E',
		'C0B18B',
	],
	'hybrid' => [
		'282A2E',
		'A54242',
		'8C9440',
		'DE935F',
		'5F819D',
		'85678F',
		'5E8D87',
		'707880',

		'373B41',
		'CC6666',
		'B5BD68',
		'F0C674',
		'81A2BE',
		'B294BB',
		'8ABEB7',
		'C5C8C6',
	],
	'invisibone' => [
		'303030',
		'D370A3',
		'6D9E3F',
		'B58858',
		'6095C5',
		'AC7BDE',
		'3BA275',
		'CFCFCF',

		'686868',
		'FFA7DA',
		'A3D572',
		'EFBD8B',
		'98CBFE',
		'E5B0FF',
		'75DAA9',
		'FFFFFF',
	],
	'visiblue' => [
		'000000',
		'9999FF',
		'00CCFF',
		'6699FF',
		'0099CC',
		'0099FF',
		'66CCCC',
		'CCFFFF',

	    '333366',
		'6666CC',
		'0099CC',
		'3366CC',
		'006699',
		'0066FF',
		'669999',
		'99CCCC',
    ],
    'material' => [
		'263238',
		'FFA74D',
		'9CCC65',
		'FFA000',
		'03A9F4',
		'AD1457',
		'009688',
		'CFD8DC',

		'37474F',
		'FF9800',
		'8BC34A',
		'FFC107',
		'81D4FA',
		'E91E63',
		'26A69A',
		'ECEFF1',
    ],
    'monokai' => [
		'272822',
		'DC2566',
		'8FC029',
		'D4C96E',
		'55BCCE',
		'9358FE',
		'56B7A5',
		'ACADA1',

		'48483E',
		'FA2772',
		'A7E22E',
		'E7DB75',
		'66D9EE',
		'AE82FF',
		'66EFD5',
		'F1EBEB',
	],
	'navy_and_ivory' => [
		'021B21',
		'C2454E',
		'7CBF9E',
		'8A7A63',
		'2E3340',
		'FF5879',
		'44B5B1',
		'F2F1B9',

		'065F73',
		'EF5847',
		'A2D9B1',
		'BEB090',
		'61778D',
		'FF99A1',
		'9ED9D8',
		'F6F6C9',
	],
	'trim_yer_beard' => [
		'0F0E0D', #191716
		'845336',
		'57553C',
		'A17E3E',
		'43454F',
		'604848',
		'5C6652',
		'A18B62',

		'383332',
		'8C4F4A',
		'898471',
		'C8B491',
		'65788F',
		'755E4A',
		'718062',
		'DABA8B',
    ],
    '3024_night' => [
		'090300',
		'DB2D20',
		'01A252',
		'FDED02',
		'01A0E4',
		'A16A94',
		'B5E4F4',
		'A5A2A2',

		'5C5855',
		'E8BBD0',
		'3A3432',
		'4A4543',
		'807D7C',
		'D6D5D4',
		'CDAB53',
		'F7F7F7',
    ],
    'ryb' => [
        '000000',
        'A60000',
        '008500',
        'A6A600',
        '06266F',
        '48036F',
        'A66F00',
        'AAAAAA',

        '555555',
        'FF0000',
        '00CC00',
        'FFFF00',
        '1240AB',
        '7109AA',
        'FFAA00',
        'FFFFFF',
	],

	'matrix' => [
		'000000',
		'223A25',
		'00974A',
		'22D16F',
		'001D34',
		'225759',
		'00B47E',
		'22EEA3',

		'117752',
		'33B177',
		'20FF98',
		'7CFFAD',
		'119486',
		'33CEAB',
		'3DFFC4',
		'99FFDA',
	],

	'simple' => [
		'000000',
		'BE1D07',
		'39A90B',
		'B99001',
		'261A8B',
		'94057E',
		'0A936F',
		'AAAAAA',

		'555555',
		'FF5247',
		'9BF84C',
		'FFDE3E',
		'5F66D4',
		'E043AF',
		'55CFBC',
		'FFFFFF',
	],

	'sunrise' => [
		'000000',
		'5C2D00',
		'757C00',
		'D1A900',
		'1D1622',
		'794322',
		'929222',
		'EEBF22',

		'775F11',
		'D38C11',
		'DDD311',
		'FFE111',
		'947633',
		'F0A333',
		'DDDA33',
		'FFE733',
	],

	'dawn_bringer' => [
		'140C1C',
		'854C30',
		'346524',
		'D27D2C',
		'30346D',
		'442434',
		'8595A1',
		'757161',

		'4E4A4E',
		'D04648',
		'6DAA2C',
		'DAD45E',
		'597DCE',
		'D2AA99',
		'6DC2CA',
		'DEEED6',
	],

    'ryb2' => [
		'000000',
		'D23B0E',
		'72A916',
		'C87502',
		'4C336C',
		'7E0A53',
		'147B33',
		'AAAAAA',

		'555555',
		'FF4E3A',
		'E0F244',
		'FFBC27',
		'6977A9',
		'C1315E',
		'549F78',
		'FFFFFF',
	],
	'jmbi' => [
		'1E1E1E', #5A7260
		'8F423C',
		'BBBB88',
		'F9D25B',
		'E0BA69',
		'709289',
		'D13516',
		'EFE2E0',

		'5A7260', #8DA691
		'EEAA88',
		'CCC68D',
		'EEDD99',
		'C9B957',
		'FFCBAB',
		'C25431',
		'F9F1ED',
	],
	'flat' => [
		'2C3E50',
		'C0392B',
		'27AE60',
		'F39C12',
		'2980B9',
		'8E44AD',
		'16A085',
		'BDC3C7',

		'7F8C8D',  #(34495E 95A5A6)
		'E74C3C',
		'2ECC71',
		'F1C40F',
		'3498DB',
		'9B59B6',
		'1ABC9C',
		'ECF0F1',
	],
	'methilviolet' => [
		'270F2E',
		'9D2866',
		'604F53',
		'C07239',
		'5A197A',
		'AA32A8',
		'6D5C5A',
		'C0A47D',

		'7A4368',
		'C76754',
		'B3B13B',
		'E4DE6B',
		'905A97',
		'D39383',
		'C3CFA6',
		'ECEECF',
	],
	'old_tv' => [
		'1F1F1F',
		'9C2B2B',
		'38784B',
		'B78643',
		'42256F',
		'9E35B1',
		'3E8C77',
		'9F9F9F',

		'5F5F5F',
		'C0755C',
		'89BA4D',
		'D8D178',
		'5671BA',
		'C6859B',
		'98C2D2',
		'DFDFDF',
	],
	'sepia' => [
		'291F14',
		'5A422B',
		'8C6743',
		'B38B64',
		'413120',
		'725437',
		'A4794F',
		'C09E7D',

		'7F5E3E',
		'AE8257',
		'C6A789',
		'DDCCBA',
		'987049',
		'B99470',
		'D1B9A2',
		'E9DFD4',
	],
	'phosphor' => [
		'000000',
		'00492E',
		'00925C',
		'00DB8A',
		'002417',
		'006D45',
		'00B673',
		'00FFA2',

		'008051',
		'00C87F',
		'12FFA8',
		'5BFFC3',
		'00A468',
		'00ED96',
		'37FFB6',
		'80FFD0',
	],
	'fall' => [
		'2A162A',
		'8D273B',
		'5A6556',
		'BF7854',
		'491E64',
		'973397',
		'667775',
		'B78E93',

		'705162',
		'C16A64',
		'ACA35C',
		'F1C782',
		'7262A1',
		'CD7A90',
		'BEB1B9',
		'FDDCCC',
	],
	'fire' => [
		#'000000',
		#'600000',
		#'BE0D04',
		#'EC6E36',
		#'300000',
		#'900000',
		#'DF3513',
		#'FEA556',

		#'AA0000',
		#'E65224',
		#'FDC36F',
		#'FDFCCF',
		#'CF220B',
		#'F68744',
		#'FDEA9F',
		#'F9F6D4',


		'000000',
		'8C0000',
		'FF1300',
		'FF6300',
		'460000',
		'D20000',
		'FF3F00',
		'FF8200',
		'F50000',
		'FF5200',
		'FF9020',
		'FFBF89',
		'FF2A00',
		'FF7300',
		'FFA95C',
		'FFD3AF',
	],
	'phosphor2' => [
		'000000',
		'008755',
		'00C17A',
		'00FB9F',
		'006A43',
		'00A468',
		'00DE8D',
		'1AFFAB',
		'00B371',
		'00ED96',
		'28FFB0',
		'62FFC6',
		'00D084',
		'0BFFA6',
		'45FFBB',
		'80FFD0',
	],
	'inferno' => [
		'26003E',
		'6E0F77',
		'AD2374',
		'DF4139',
		'47055D',
		'8D1D7C',
		'CE2656',
		'EB8153',

		'9C227B',
		'D92D46',
		'F09D60',
		'FCE49C',
		'BC2669',
		'E56345',
		'F7C87D',
		'FFF8BF',
	],
	'radar' => [
		'000000',
		'482C00',
		'925900',
		'DC8600',
		'241600',
		'6C4200',
		'B87000',
		'FF9D03',

		'804E00',
		'CA7B00',
		'FFA415',
		'FFC05D',
		'A46400',
		'EE9100',
		'FFB239',
		'FFD085',
	],

	'orange' => [
		'000000',
		'493800',
		'927000',
		'DBA800',
		'241C00',
		'6D5400',
		'B68C00',
		'FFC400',
		'806200',
		'C89A00',
		'FFC800',
		'FFD900',
		'A47E00',
		'EDB600',
		'FFD100',
		'FFE200',
	],

	'green_crt' => [
		'000000',
		'00310F',
		'006120',
		'009233',
		'001807',
		'004918',
		'007929',
		'00AA3C',

		'00551C',
		'00862E',
		'00B641',
		'00E757',
		'006D25',
		'009E38',
		'00CE4C',
		'00FF62',
	],
	'amber' => [
		'000000',
		'311300',
		'613400',
		'926300',
		'180800',
		'492200',
		'794A00',
		'AA8000',

		'552B00',
		'865600',
		'B68F00',
		'E7D600',
		'6D3E00',
		'9E7100',
		'CEB100',
		'FFFF00',
	],

	'darkroom' => [
		'000000',
		'300000',
		'610000',
		'910000',
		'180000',
		'480000',
		'790000',
		'AA0000',

		'550000',
		'850000',
		'B60000',
		'E60000',
		'6D0000',
		'9D0000',
		'CE0000',
		'FF0000',
	],
	'bnw' => [
		'000000',
		'303030',
		'616161',
		'919191',
		'181818',
		'484848',
		'797979',
		'AAAAAA',

		'555555',
		'858585',
		'B6B6B6',
		'E6E6E6',
		'6D6D6D',
		'9D9D9D',
		'CECECE',
		'FFFFFF',
	],
);

GetOptions(
    'l|list'      => \&list,
    'r|reset'     => \my $reset,
    's|show'      => \&show,
    't|tty=i'     => \(my $tty = ''),
    'c|change=s@' => \(my $changes),
) or pod2usage();

open(my $handle, '>', "/dev/tty$tty") or die "Can't open tty: $!; aborted\n";

if ($reset) {
    syswrite $handle, "\033]R";
    exit;
}
elsif ($changes && @$changes) {
    for my $change (@$changes) {
        my ($num, $color) = $change =~ /^(\d\d?):([0-9A-F]{6})$/i;
        if (!defined $num || !defined $color) {
            die "Malformed color change '$change'; aborted\n";
        }
        syswrite $handle, sprintf("\033]P%X%s", $num, $color);
    }
    exit;
}

my $name = $ARGV[0];
die "No palette name specified; aborted\n" if !defined $name;
die "Unknown palette name; aborted\n" if !exists $palettes{$name};

for my $num (0..$#{ $palettes{$name} }) {
    syswrite $handle, sprintf("\033]P%X%s", $num, $palettes{$name}[$num]);
}

exit;

sub list {
    print $_, "\n" for sort keys %palettes;
    exit;
}

sub show {
    my $esc = "\033[";

    for my $fg_color (0, 7, 1..6) {
        my $normal = '';
        my $bright = '';
        my $dim    = '';

        for my $bg_color (undef, 7, 0, 1..6) {
            my $colors = "3$fg_color";
            my $padding = '  ';

            if (defined $bg_color) {
                $colors .= ";4$bg_color";
                $padding = '';
            }

            $normal = sprintf('%s%s%sm   %s%s %s0m',   $normal, $esc, $colors, $padding, $colors, $esc);
            $bright = sprintf('%s%s1;%sm %s1;%s %s0m', $bright, $esc, $colors, $padding, $colors, $esc);
            $dim    = sprintf('%s%s2;%sm %s2;%s %s0m', $dim,    $esc, $colors, $padding, $colors, $esc);

        }

        print "$normal\n$bright\n$dim\n";
    }
    exit;
}

__END__

=head1 NAME

conpalette - Redefine a Linux console's color palette

=head1 SYNOPSIS

B<conpalette> [options] [palette]

 Options:
   -h, --help              Display this help message
   -l, --list              List the available palettes
   -r, --reset             Reset the console palette
   -s, --show              Show the current palette
   -t N, --tty=N           Specify a different tty
   -c NUM:COLOR, --change  Change color(s) manually (e.g. -c 13:1E2320)

=head1 DESCRIPTION

This little program redefines the color palette of your Linux console using
the escape sequences documented in L<console_codes(4)>.

=head1 EXAMPLES

You might put this in your F<~/.bashrc>:

 if [ "$TERM" = "linux" ]; then
     conpalette tango-dark
 fi

=head1 AUTHOR

Hinrik E<Ouml>rn SigurE<eth>sson, hinrik.sig@gmail.com

=head1 LICENSE AND COPYRIGHT

Copyright 2008 Hinrik E<Ouml>rn SigurE<eth>sson

This program is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
