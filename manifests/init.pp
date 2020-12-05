# @summary Manage the Bind DNS daemon and configuration
#
# @example Install a local caching resolver
#
#   class { 'bind':
#     listen_on         => [ '127.0.0.1' ],
#     listen_on_v6      => [ '::1' ],
#     allow_query       => [ '127.0.0.1', '::1' ],
#     allow_query_cache => [ '127.0.0.1', '::1' ],
#     allow_recursion   => [ '127.0.0.1', '::1' ],
#   }
#
# @param confdir
#   The directory where the main Bind configuration file is located. Example:
#   `/etc/bind`.
#
#   Default: operating system specific
#
# @param vardir
#   The directory where Bind stores other config files (zonefiles, ...).
#   Example: `/var/lib/bind`.
#
#   Default: operating system specific
#
# @param cachedir
#   The directory where Bind stores volatile data. Example:
#   `/var/cache/bind`.
#
#   Default: operating system specific
#
# @param rndc_keyfile
#   The file where the secret key for the rndc program is stored.
#
#   Default: operating system specific
#
# @param rndc_program
#   The full path of the rndc program.
#
#   Default: operating system specific
#
# @param bind_user
#   Run the Bind daemon as this user. This parameter is also used to set the
#   owner of some directories and files that the Bind daemon needs to write
#   to.
#
#   Default: operating system specific
#
# @param bind_group
#   The group ownership for some Bind related directories and files.
#
#   Default: operating system specific
#
# @param package_name
#   The name of the Bind package to install.
#
#   Default: operating system specific
#
# @param service_name
#   The name of the Bind service to manage.
#
#   Default: operating system specific
#
# @param listen_on
#   An array of strings to define the IPv4 address(es) on which the daemon
#   will listen for queries. The string `any` may be used to listen on all
#   available interfaces and addresses. This is also the default if the
#   parameter is unset. The string `none` may be used to disable IPv4.
#
#   Use `bind::listen_on` to define more complex configurations.
#
# @param listen_on_v6
#   An array of strings to define the IPv6 address(es) on which the daemon
#   will listen for queries. The string `any` may be used to listen on all
#   available interfaces and addresses. This is also the default if the
#   parameter is unset. The string `none` may be used to disable IPv6.
#
#   Use `bind::listen_on_v6` to define more complex configurations.
#
# @param ipv4_enable
#   Should Bind use IPv4. At least one of `ipv4_enable` and `ipv6_enable`
#   must be set to true.
#
# @param ipv6_enable
#   Should Bind use IPv6. At least one of `ipv4_enable` and `ipv6_enable`
#   must be set to true.
#
# @param views_enable
#   Should views be enabled.
#
# @param dnssec_enable
#   Should DNSSEC be enabled.
#
# @param empty_zones_enable
#   Should automatic empty zones be enabled.
#
# @param root_mirror_enable
#   Should a local mirror zone the root zone be configured.
#
# @param control_channels_enable
#   Should control channels be enabled. All `bind::controls::unix` and
#   `bind::controls::inet` configuration items will be ignored if this is set
#   to `false`. In this case an empty controls statement will be generated and
#   the default control channel will also be disabled. The default control
#   channel will be enabled automatically if this parameter is `true` and no
#   explicit channels are created using the `bind::controls::unix` or
#   `bind::controls::inet` defined type.
#
# @param allow_query
#   An array of IP addresses/networks or ACL names that are allowed to query
#   this Bind server.
#
# @param allow_recursion
#   An array of IP addresses/networks or ACL names that are allowed to use
#   this Bind server for recursion. Recursion is automatically turned on if
#   this parameter is not empty.
#
# @param blackhole
#   An array of IP addresses/networks that are ignored by the server. Requests
#   from sources matching this list will not be answered.
#
# @param forwarders
#   An array of other DNS servers that can be used to forward unresolvable
#   queries to.
#
# @param forward
#   The type of forwarding used. This parameter is only used if forwarders
#   are actually defined. Valid values: 'first', 'only'. Note that
#   automatic empty zones for RFC 6303 are ignored if this parameter
#   is set to `only`.
#
# @param filter_aaaa_on_v4
#   Should AAAA records be omitted from the response if the IPv4 transport is
#   used. If this is set to `yes` then it does not apply if the queried zone
#   is DNSSEC-signed. Setting this parameter to `break-dnssec` will also omit
#   DNSSEC related RRs if AAAA records are filtered. Valid options: `no`,
#   `yes`, `break-dnssec`.
#
# @param max_cache_size
#   The maximum number of bytes to use for the server's cache. If views are
#   used then the size applies to every view seperately. If this value is
#   zero then no limit is configured.
#
# @param max_cache_ttl
#   The maximum number of seconds for which the server will cache positove
#   answers. If this value is zero then the config parameter will be omitted
#   and the Bind default of 1 week will be used.
#
# @param max_ncache_ttl
#   The maximum number of seconds for which the server will cache negative
#   answers. If this value is zero then the config parameter will be omitted
#   and the Bind default of 3 hours will be used.
#
# @param package_ensure
#   The state of the Bind package. Normally this is set to `installed` or a
#   specific version number.
#
# @param service_ensure
#   Whether the Bind service should be running.
#
# @param service_enable
#   Should the Bind service be enabled.
#
# @param manage_rndc_keyfile
#   Should the rndc key file be managed by the main class. If this is `true`
#   (the default) then the secret key generated by the package installation
#   will be used. Only the file mode and owner are managed without updating
#   the content of the key file. If this is `false` then the key file for the
#   `rndc` tool is not managed by the main class. Use the `bind::key` defined
#   type to manage the key on your own. Caution: changing the key while
#   `named` is running leads to a problem because Puppet can't reload or
#   restart the service after the key file has been updated because the daemon
#   still uses the old key.
#
# @param report_hostname
#   The hostname the will be reported by Bind. If this is undefined
#   (default), then Bind will report the local hostname. Set this to a string
#   to hide the hostname and report the given string instead. Use the empty
#   string to disable hostname reporting completely.
#
# @param report_version
#   The version string that will be reported by Bind. If this is undefined
#   (default), then Bind will report the version that has been installed. Set
#   this to a string to hide the version number and report the given string
#   instead. Use the empty string to disable version reporting completely.
#
#   Use the following command to test: dig @127.0.0.1 version.bind chaos txt
#
#
class bind (
  Stdlib::Absolutepath    $confdir,
  Stdlib::Absolutepath    $vardir,
  Stdlib::Absolutepath    $cachedir,
  Stdlib::Absolutepath    $rndc_keyfile,
  Stdlib::Absolutepath    $rndc_program,
  String                  $bind_user,
  String                  $bind_group,
  String                  $package_name,
  String                  $service_name,
  Bind::AddressMatchList  $listen_on                  = [],
  Bind::AddressMatchList  $listen_on_v6               = [],
  Boolean                 $ipv4_enable                = true,
  Boolean                 $ipv6_enable                = true,
  Boolean                 $views_enable               = false,
  Boolean                 $dnssec_enable              = true,
  Boolean                 $empty_zones_enable         = true,
  Boolean                 $root_mirror_enable         = false,
  Boolean                 $control_channels_enable    = true,
  Bind::AddressMatchList  $allow_query                = [],
  Bind::AddressMatchList  $allow_query_cache          = [],
  Bind::AddressMatchList  $allow_recursion            = [],
  Bind::AddressMatchList  $blackhole                  = [],
  Bind::AddressMatchList  $forwarders                 = [],
  Bind::Forward           $forward                    = 'first',
  Boolean                 $root_hints_enable          = true,
  String                  $root_hints_source          = "puppet:///modules/${module_name}/zones/db.root",
  Boolean                 $localhost_forward_enable   = true,
  String                  $localhost_forward_source   = "puppet:///modules/${module_name}/zones/db.localhost",
  Boolean                 $localhost_reverse_enable   = true,
  String                  $localhost_reverse_source   = "puppet:///modules/${module_name}/zones/db.127",
  Bind::Filter_aaaa_on_v4 $filter_aaaa_on_v4          = 'no',
  Integer                 $max_cache_size             = 0,
  Integer                 $min_cache_ttl              = 0,
  Integer                 $max_cache_ttl              = 0,
  Integer                 $min_ncache_ttl             = 0,
  Integer                 $max_ncache_ttl             = 0,
  Integer                 $servfail_ttl               = 0,
  String                  $package_ensure             = 'installed',
  Stdlib::Ensure::Service $service_ensure             = 'running',
  Boolean                 $service_enable             = true,
  Boolean                 $manage_rndc_keyfile        = true,
  Hash[String, String]    $custom_options             = {},
  Optional[String]        $report_hostname            = undef,
  Optional[String]        $report_version             = undef,
  Optional[Boolean]       $querylog_enable            = undef,

) {

  $header_message = '// This file is managed by Puppet. DO NOT EDIT.'

  #
  # Package
  #

  package { 'bind':
    ensure => $package_ensure,
    name   => $package_name,
  }

  #
  # Directories
  #

  file { $confdir:
    ensure  => directory,
    owner   => 'root',
    group   => $bind_group,
    mode    => '2755',
    require => Package['bind'],
  }

  file { $vardir:
    ensure  => directory,
    owner   => 'root',
    group   => $bind_group,
    mode    => '0775',
    require => Package['bind'],
  }

  # Some directories must be writable by the user that named runs as.
  [ 'primary', 'secondary' ].each |$type| {
    file { "${vardir}/${type}":
      ensure => directory,
      owner  => $bind_user,
      group  => $bind_group,
      mode   => '0750',
      before => Bind::Config['named.conf'],
    }

    file { "${vardir}/${type}/README":
      ensure => file,
      owner  => $bind_user,
      group  => $bind_group,
      mode   => '0444',
      source => "puppet:///modules/${module_name}/README.${type}",
    }
  }

  file { $cachedir:
    ensure  => directory,
    owner   => 'root',
    group   => $bind_group,
    mode    => '0775',
    require => Package['bind'],
    before  => Bind::Config['named.conf'],
  }

  #
  # Keys
  #

  file { "${confdir}/keys":
    ensure => directory,
    owner  => 'root',
    group  => $bind_group,
    mode   => '0750',
  }

  concat { 'named.conf.keys':
    path           => "${confdir}/named.conf.keys",
    owner          => 'root',
    group          => $bind_group,
    mode           => '0640',
    ensure_newline => true,
    warn           => $header_message,
    require        => File[$confdir],
    notify         => Service['bind'],
  }

  # Manage keyfile for rndc.
  if $manage_rndc_keyfile {
    bind::key { 'rndc-key':
      keyfile        => $rndc_keyfile,
      manage_content => false,
      require        => File[$confdir],
      notify         => Service['bind'],
    }
  }

  #
  # Logging
  #

  concat { 'named.conf.logging':
    path           => "${confdir}/named.conf.logging",
    owner          => 'root',
    group          => $bind_group,
    mode           => '0640',
    ensure_newline => true,
    warn           => $header_message,
    require        => File[$confdir],
    notify         => Service['bind'],
  }

  concat::fragment { 'named.conf.logging-start':
    target  => 'named.conf.logging',
    order   => '00',
    content => "\nlogging {\n",
  }

  concat::fragment { 'named.conf.logging-end':
    target  => 'named.conf.logging',
    order   => '99',
    content => "};\n",
  }

  #
  # ACLs
  #

  concat { 'named.conf.acls':
    path           => "${confdir}/named.conf.acls",
    owner          => 'root',
    group          => $bind_group,
    mode           => '0640',
    ensure_newline => true,
    warn           => $header_message,
    require        => File[$confdir],
    notify         => Service['bind'],
  }

  #
  # Views
  #

  concat { 'named.conf.views':
    ensure         => bool2str($views_enable, 'present', 'absent'),
    path           => "${confdir}/named.conf.views",
    owner          => 'root',
    group          => $bind_group,
    mode           => '0640',
    ensure_newline => true,
    warn           => $header_message,
    require        => File[$confdir],
    notify         => Service['bind'],
  }

  #
  # Zones
  #

  concat { 'named.conf.zones':
    path           => "${confdir}/named.conf.zones",
    owner          => 'root',
    group          => $bind_group,
    mode           => '0640',
    ensure_newline => true,
    warn           => $header_message,
    require        => File[$confdir],
    notify         => Service['bind'],
  }

  #
  # Options
  #

  $options = {
    'vardir'             => $vardir,
    'confdir'            => $confdir,
    'cachedir'           => $cachedir,
    'report_hostname'    => $report_hostname,
    'report_version'     => $report_version,
    'servfail_ttl'       => $servfail_ttl,
    'min_cache_ttl'      => $min_cache_ttl,
    'max_cache_ttl'      => $max_cache_ttl,
    'min_ncache_ttl'     => $min_ncache_ttl,
    'max_ncache_ttl'     => $max_ncache_ttl,
    'max_cache_size'     => $max_cache_size,
    'filter_aaaa_on_v4'  => $filter_aaaa_on_v4,
    'querylog_enable'    => $querylog_enable,
    'dnssec_enable'      => $dnssec_enable,
    'empty_zones_enable' => $empty_zones_enable,
    'custom_options'     => $custom_options,
  }

  concat { 'named.conf.options':
    path           => "${confdir}/named.conf.options",
    owner          => 'root',
    group          => $bind_group,
    mode           => '0640',
    ensure_newline => true,
    warn           => $header_message,
    require        => File[$confdir],
    notify         => Service['bind'],
  }

  # Order of fragments in Concat['named.conf.options']:
  # 10 options {
  # 11   listen-on { }
  # 12   listen-on port ... { }
  # 13   listen-on-v6 { }
  # 14   listen-on-v6 port ... { }
  # 20   forwarders
  # 21   forward
  # 40   blackhole
  # 75   main
  # 80   rate-limit { }
  # 85 }
  # 90 controls {
  # 91   unix ...
  # 92   inet ...
  # 93 }

  concat::fragment { 'named.conf.options-head':
    target  => 'named.conf.options',
    order   => '10',
    content => epp("${module_name}/options.head.epp", { 'cachedir' => $cachedir }),
  }

  concat::fragment { 'named.conf.options-main':
    target  => 'named.conf.options',
    order   => '75',
    content => epp("${module_name}/options.main.epp", $options),
  }

  concat::fragment { 'named.conf.options-tail':
    target  => 'named.conf.options',
    order   => '85',
    content => "};\n",
  }

  #
  # Listen-on
  #

  unless empty($listen_on) {
    bind::listen_on { 'bind::listen-on':
      address => $listen_on,
    }
  }

  unless empty($listen_on_v6) {
    bind::listen_on_v6 { 'bind::listen-on-v6':
      address => $listen_on_v6,
    }
  }

  #
  # Options
  #

  unless empty($forwarders) {
    bind::aml { 'forwarders':
      address_match_list => $forwarders,
      target             => 'named.conf.options',
      order              => '20',
      omit_empty_list    => true,
      final_empty_line   => false,
    }

    concat::fragment { 'named.conf.options-forward':
      target  => 'named.conf.options',
      order   => '21',
      content => "  forward ${forward};\n\n",
    }
  }

  unless empty($allow_query) {
    bind::aml { 'allow-query':
      address_match_list => $allow_query,
      target             => 'named.conf.options',
      order              => '30',
    }
  }

  unless empty($allow_query_cache) {
    bind::aml { 'allow-query-cache':
      address_match_list => $allow_query_cache,
      target             => 'named.conf.options',
      order              => '31',
    }
  }

  concat::fragment { 'named.conf.options-recursion':
    target  => 'named.conf.options',
    order   => '35',
    content => bool2str(empty($allow_recursion), '  recursion no;', '  recursion yes;')
  }

  unless empty($allow_recursion) {
    bind::aml { 'allow-recursion':
      address_match_list => $allow_recursion,
      target             => 'named.conf.options',
      order              => '36',
      initial_empty_line => true,
      final_empty_line   => false,
    }
  }

  unless empty($blackhole) {
    bind::aml { 'blackhole':
      address_match_list => $blackhole,
      target             => 'named.conf.options',
      order              => '40',
      initial_empty_line => true,
      final_empty_line   => false,
    }
  }

  #
  # Controls
  #

  if $control_channels_enable {
    @concat::fragment { 'named.conf.controls-head':
      target  => 'named.conf.options',
      order   => '90',
      tag     => [ 'named.conf.controls', ],
      content => "\ncontrols {\n",
    }

    @concat::fragment { 'named.conf.controls-tail':
      target  => 'named.conf.options',
      order   => '93',
      tag     => [ 'named.conf.controls', ],
      content => "};\n",
    }
  }
  else {
    concat::fragment { 'named.conf.controls':
      target  => 'named.conf.options',
      order   => '90',
      content => "\n// Disable controls\ncontrols { };\n",
    }
  }

  #
  # Main Configuration
  #

  $config = {
    'confdir'      => $confdir,
    'views_enable' => $views_enable,
  }

  bind::config { 'named.conf':
    content => epp("${module_name}/named.conf.epp", $config),
  }

  # Ensure named.conf.local exists and has correct permissions but do not
  # manage any future content.

  file { "${confdir}/named.conf.local":
    ensure  => file,
    owner   => 'root',
    group   => $bind_group,
    mode    => '0640',
    replace => false,
    source  => "puppet:///modules/${module_name}/named.conf.local",
    before  => Service['bind'],
  }

  #
  # Misc zone files
  #

  bind::config { 'db.root':
    source => $root_hints_source,
  }

  bind::config { 'db.localhost':
    source => $localhost_forward_source,
  }

  bind::config { 'db.127':
    source => $localhost_reverse_source,
  }

  bind::config { 'db.empty':
    source => "puppet:///modules/${module_name}/zones/db.empty",
  }

  unless $views_enable {
    if $root_hints_enable {
      bind::zone::hint { '.':
        file    => "${confdir}/db.root",
        comment => 'Prime server with knowledge of the root servers',
      }
    }

    if $root_mirror_enable {
      bind::zone::mirror { '.':
        comment => 'Local copy of the root zone (see RFC 7706)',
        order   => '11',
      }
    }

    if $localhost_forward_enable {
      bind::zone::primary { 'localhost':
        file  => "${confdir}/db.localhost",
        order => '15',
      }
    }

    if $localhost_reverse_enable {
      bind::zone::primary { '127.in-addr.arpa':
        file  => "${confdir}/db.127",
        order => '15',
      }
    }
  }

  #
  # Service
  #

  if ($ipv4_enable and $ipv6_enable) {
    $network_options = []
  }
  elsif $ipv4_enable {
    $network_options = [ '-4' ]
  }
  elsif $ipv6_enable {
    $network_options = [ '-6' ]
  }
  else {
    fail('One of ipv4_enable or ipv6_enable must be true')
  }

  # Start daemon as $bind_user if configured
  $user_options = $bind_user ? {
    undef   => [],
    default => [ '-u', $bind_user, ],
  }

  $default_options = join(concat($user_options, $network_options), ' ')

  $options_file = $facts['os']['name'] ? {
    'Debian' => '/etc/default/bind9',
    'Ubuntu' => '/etc/default/named',
  }

  file_line { 'named-options':
    path    => $options_file,
    line    => "OPTIONS=\"${default_options}\"",
    match   => '^OPTIONS=',
    require => Package['bind'],
    notify  => Service['bind'],
  }

  service { 'bind':
    ensure  => $service_ensure,
    enable  => $service_enable,
    name    => $service_name,
    restart => "${rndc_program} reconfig",
  }
}
