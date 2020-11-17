#!/usr/bin/env perl

# Simple helpers

sub tee {
    my $file = shift; # first argument is the file
    my $lines = join("\n", @_); # assume the next arguments are the lines
    print "Writing to $file\n";
    print "$lines\n";
    my $fh;
    open(FH, '>', $file) or die "Couldn't open $file for writing! You should run this as root.";
    print FH "$lines\n";
    close(FH);
}

sub apt_update {
    system('apt update');
}

sub apt_upgrade {
    system('apt full-upgrade -y');
}

sub apt_install {
    my $pkgs = join(" ", @_);
    my $cmd = "apt-get install $pkgs -y";
    print("RUN $cmd\n");
    system($cmd);
}

sub apt_install_recommends {
    my $pkgs = join(' ', @_);
    my $cmd = "apt-get install --install-recommends $pkgs -y";
    print("RUN $cmd\n");
    system($cmd);
}

sub apt_add_repo {
    my $repo = shift;
    system("add-apt-repository '$repo' -n -y");
}

sub apt_add_repo_file {
    my $name = shift;
    my $file = "/etc/apt/sources.list.d/$name.list";
    tee($file, @_);
}

sub apt_add_key {
    my $url = shift;
    my $key = `curl -sL '$url'`;
    print "Adding apt key: \n$key\n";
    system("curl -sL '$url' | apt-key add -");
}

sub manual_add_key {
    my $name = shift;
    my $url = shift;
    system("wget -O /usr/share/keyrings/$name.gpg '$url'");
}

sub apt_install_deb {
    my $name = shift;
    my $url = shift;
    system("wget -c -O ./$name.deb '$url'");
    system("apt-get install -y ./$name.deb");
}

sub apt_autoremove {
    system('apt autoremove -y');
}

# Parse CLI parameters and set flags

print "Parsing CLI Params @ARGV\n";

my %cli_params = map {$_ => 1} @ARGV;

my $enable_server = 0;
if(exists($cli_params{'server'})) {
    print "Server Enabled";
    $enable_server = 1;
}

my $enable_desktop = 0;
if(exists($cli_params{'desktop'})) {
    print "Desktop Enabled\n";
    $enable_desktop = 1;
}

my $enable_developer = 0;
if(exists($cli_params{'developer'})) {
    print "Developer Enabled\n";
    $enable_desktop = 1;
    $enable_developer = 1;
}

my $enable_proaudio = 0;
if(exists($cli_params{'proaudio'})) {
    print "Pro Audio Enabled\n";
    $enable_desktop = 1;
    $enable_proaudio = 1;
}

if(exists($cli_params{'all'})) {
    print "EVERYTHING is Enabled\n";
    $enable_server = 1;
    $enable_desktop = 1;
    $enable_developer = 1;
    $enable_proaudio = 1;
}

# Begin Setup

print "Begin Ubuntu 20.04 Setup Process!\n";

my @installer_helpers = (
    'curl',
    'apt-transport-https',
    'ppa-purge',
    'software-properties-common',
);

print "Install software needed for installer\n";
apt_install(@installer_helpers);

# Universe Repo
print "Enable Universe Repo\n";
apt_add_repo('universe');

print "Enable the Proposed Repository but keep it disabled\n";
print "Refer https://wiki.ubuntu.com/Testing/EnableProposed for more info!\n";
apt_add_repo('deb http://archive.ubuntu.com/ubuntu/ focal-proposed restricted main multiverse universe');
tee(
    '/etc/apt/preferences.d/proposed-updates',
    'Package: *',
    'Pin: release a=focal-proposed',
    'Pin-Priority: 400',
);
print "Done! Run 'apt install packagename/focal-proposed' to install a proposed version!\n";
apt_update();

if ($enable_server) {
    print "Enable Nodesource Repo\n";
    apt_add_key('https://deb.nodesource.com/gpgkey/nodesource.gpg.key');
    apt_add_repo_file(
        'nodesource',
        'deb https://deb.nodesource.com/node_14.x focal main',
        'deb-src https://deb.nodesource.com/node_14.x focal main',
    );

    print "Enable Yarn Repo\n";
    apt_add_key('https://dl.yarnpkg.com/debian/pubkey.gpg');
    apt_add_repo_file('yarn', 'deb https://dl.yarnpkg.com/debian/ stable main');

    print "Enable K8s Repo\n";
    apt_add_key('https://packages.cloud.google.com/apt/doc/apt-key.gpg');
    apt_add_repo_file('kubernetes', 'deb http://apt.kubernetes.io/ kubernetes-xenial main');

    print "Enable PGDG Repo\n";
    apt_add_key('https://www.postgresql.org/media/keys/ACCC4CF8.asc');
    apt_add_repo_file(
        'pgdg',
        'deb [arch=amd64] http://apt.postgresql.org/pub/repos/apt/ focal-pgdg main',
    );
    print "Enable Dart Repo\n";
    apt_add_key('https://dl-ssl.google.com/linux/linux_signing_key.pub');
    apt_add_repo_file(
        'dart_stable',
        'deb [arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main',
    );
}

if ($enable_desktop) {
    print "Enable Wire Repo\n";
    apt_add_key('https://wire-app.wire.com/linux/releases.key');
    apt_add_repo_file(
        'wire',
        'deb [arch=amd64] https://wire-app.wire.com/linux/debian stable main',
    );

    print "Enable Riot IM (Matrix)\n";
    manual_add_key(
        'riot-im-archive-keyring',
        'https://packages.riot.im/debian/riot-im-archive-keyring.gpg',
    );
    apt_add_repo_file(
        'riot',
        'deb [signed-by=/usr/share/keyrings/riot-im-archive-keyring.gpg] https://packages.riot.im/debian/ default main',
    );

    print "Enable Graphics Drivers Repo\n";
    apt_add_repo('ppa:graphics-drivers/ppa');
}

if ($enable_developer) {
    print "Enable Cubic Repo\n";
    apt_add_repo('ppa:cubic-wizard/release');
    
    print "Enable Insomnia Repo\n";
    apt_add_key('https://insomnia.rest/keys/debian-public.key.asc');
    apt_add_repo_file(
        'insomnia',
        'deb https://dl.bintray.com/getinsomnia/Insomnia /',
    );

    # TODO update URL to focal/mongodb-org/4.4 when the new version is out
    print "Enable MongoDB Repo\n";
    apt_add_key('https://www.mongodb.org/static/pgp/server-4.2.asc');
    apt_add_repo_file(
        'mongodb',
        'deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse',
    );

    print "Enable Slack Repo\n";
    apt_add_key('https://packagecloud.io/slacktechnologies/slack/gpgkey');
    apt_add_repo_file(
        'slack',
        'deb https://packagecloud.io/slacktechnologies/slack/debian/ jessie main',
        'deb-src https://packagecloud.io/slacktechnologies/slack/debian/ jessie main',
    );

    print "Enable VSCode Repo\n";
    apt_add_key('https://packages.microsoft.com/keys/microsoft.asc');
    apt_add_repo_file(
        'vscode',
        'deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main',
    );

    apt_install_deb(
        'discord',
        'https://discordapp.com/api/download?platform=linux&format=deb',
    );

    apt_install_deb(
        'mongodb-compass-isolated',
        'https://downloads.mongodb.com/compass/mongodb-compass-isolated_1.21.2_amd64.deb',
    );
}

if ($enable_proaudio) {
    print "Enable Ubuntu Studio backports PPA\n";
    apt_add_repo('ppa:ubuntustudio-ppa/backports');

    print "Enable OBS Studio Repo\n";
    apt_add_repo('ppa:obsproject/obs-studio');
}

print "Initial apt-update and full-upgrade\n";
apt_update();
apt_upgrade();

print "Install LTS Enablement Stack & Run Full-Upgrade\n";

my @lts_enablement_pkgs = (
'linux-generic-hwe-20.04-edge',
);

if ($workstation) {
    push(@lts_enablement_pkgs, 'xserver-xorg-hwe-20.04');
    push(@lts_enablement_pkgs, 'xserver-xorg-input-synaptics-hwe-20.04');
}

if ($audio) {
    push(@lts_enablement_pkgs, 'linux-lowlatency-hwe-20.04-edge');
}

# TODO uncomment this when HWE gets released for 20.04
# apt_install_recommends(@lts_enablement_pkgs);
# apt_upgrade();

my @list_server = (
    'byobu',
    'zsh',
    'udisks2',
    'aptitude',
    'hexedit',
    'parallel',
    'fd-find',
    'ripgrep',
    'iotop',
    'atop',
    'binfmt-support',
    'vim',
    'emacs',
    'tar',
    'lzip',
    'p7zip',
    'p7zip-full',
    'p7zip-rar',
    'unzip',
    'qrencode',
    'zbar-tools',
    'ffmpeg',
    'imagemagick',
    'mosh',
    'sshfs',
    'whois',
    'curl',
    'wget',
    'iperf3',
    'nmap',
    'nethogs',
    'wireguard',
    'fail2ban',
    'openssh-server',
    'git-all',
    'doxygen',
    'doxygen-docs',
    'build-essential',
    'cmake',
    'automake',
    'libtool',
    'pkg-config',
    'devscripts',
    'equivs',
    'gdebi-core',
    'qemu',
    'qemu-user-static',
    'nginx',
    'certbot',
    'python3-certbot-nginx',
    'docker.io',
    'docker-compose',
    'kubectl',
    'nodejs',
    'yarn',
    'python3',
    'python3-pip',
    'python3-venv',
    'ipython3',
    'dart',
    'golang-1.14-go',
    'exfat-fuse',
    'exfat-utils',
    'adb',
    'fastboot',
    'mtp-tools',
    'libmtp-common',
    'libmtp-dev',
    'libmtp-runtime',
    'libmtp9',
    'quassel-core',
    'bind9',
    'bind9utils',
    'bind9-doc',
    'dnsutils',
    'lastpass-cli',
);

my @list_desktop = (
    'yakuake',
    'fonts-comic-neue',
    'cpupower-gui',
    'arandr',
    'xscreensaver',
    'keepassxc',
    'pcmanfm-qt',
    'libreoffice',
    'quassel-client',
    'telegram-desktop',
    'wire-desktop',
    'riot-desktop',
    'deluge',
    'kio-gdrive',
    'partitionmanager',
    'gparted',
    'gnome-disk-utility',
    'kde-full',
);

my @list_developer = (
    'thonny',
    'spyder3',
    'code',
    'cubic',
    'kdevelop',
    'kdevelop-python',
    'kdevelop-php',
    'insomnia',
    'slack-desktop',
);

my @list_proaudio = (
    'linux-lowlatency',
    'ubuntustudio-installer',
    'ubuntustudio-menu',
    'ubuntustudio-wallpapers',
    'ubuntustudio-branding-common',
    'ubuntustudio-audio',
    'ubuntustudio-graphics',
    'ubuntustudio-photography',
    'ubuntustudio-publishing',
    'ubuntustudio-video',
    'ubuntustudio-lowlatency-settings',
    'ubuntustudio-performance-tweaks',
    'carla',
    'vmpk',
    'fonts-comic-neue',
    'v4l-utils',
    'v4l2loopback-dkms',
    'v4l2loopback-utils',
    'obs-studio',
    'olive-editor',
);

my @list_install = ();

if ($enable_server) {
    push(@list_install, @list_server);
}

if ($enable_desktop) {
    push(@list_install, @list_desktop);
}

if ($enable_developer) {
    push(@list_install, @list_developer);
}

if ($enable_proaudio) {
    push(@list_install, @list_proaudio);
}

print "Giant apt-install of new packages coming up!\n";
apt_install(@list_install);

print "Try to auto-install custom graphics drivers and hope for the best!\n";
system('ubuntu-drivers autoinstall');

print "Final apt autoremove\n";
apt_autoremove();

print "Enable Docker Service\n";
system('systemctl enable docker');

print "Copying over sample NGINX configs\n";
system('cp ../nginx/*.conf /etc/nginx/sites-available/');

print "Finished Ubuntu 20.04 Setup!\n";
