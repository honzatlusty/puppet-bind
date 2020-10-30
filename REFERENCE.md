# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

* [`bind`](#bind): Manage the Bind DNS daemon and configuration
* [`bind::rate_limit`](#bindrate_limit): Manage rate limiting

### Defined types

#### Public Defined types

* [`bind::acl`](#bindacl): Manage ACL entries
* [`bind::config`](#bindconfig): Manage configuration files
* [`bind::key`](#bindkey): Manage keys
* [`bind::listen_on`](#bindlisten_on): Manage listen-on option clause
* [`bind::listen_on_v6`](#bindlisten_on_v6): Manage listen-on-v6 option clause
* [`bind::logging::category`](#bindloggingcategory): Manage logging category
* [`bind::logging::channel_file`](#bindloggingchannel_file): Manage logging channel to a logfile
* [`bind::logging::channel_syslog`](#bindloggingchannel_syslog): Manage logging channel to syslog
* [`bind::statistics_channel`](#bindstatistics_channel): Manage statistics channel
* [`bind::view`](#bindview): Manage a view
* [`bind::zone::forward`](#bindzoneforward): Manage a forward zone
* [`bind::zone::hint`](#bindzonehint): Manage a hint zone
* [`bind::zone::in_view`](#bindzonein_view): Manage a in-view zone reference
* [`bind::zone::mirror`](#bindzonemirror): Manage a mirror zone
* [`bind::zone::primary`](#bindzoneprimary): Manage a primary zone
* [`bind::zone::secondary`](#bindzonesecondary): Manage a secondary zone

#### Private Defined types

* `bind::aml`: Manage an address match list

### Resource types

* [`dnssec_key`](#dnssec_key): Manage DNSSEC keys for the Bind9 DNS server. This type creates, deletes and maintains key files in a directory on the DNS server.  Examples: 

### Functions

* [`bind::zonefile_path`](#bindzonefile_path): zonefile_path.pp --- Generate zonefile name from zone

### Data types

* [`Bind::AddressMatchList`](#bindaddressmatchlist): Type to match allowed values for an address match list
* [`Bind::Auto_dnssec`](#bindauto_dnssec): Type to match allowed values for the auto-dnssec option
* [`Bind::Filter_aaaa_on_v4`](#bindfilter_aaaa_on_v4): Type to match allowed values for the filter-aaaa-on-v4 option
* [`Bind::Forward`](#bindforward): Type to match allowed values for the forward option
* [`Bind::Key::Algorithm`](#bindkeyalgorithm): Type to match allowed values for the key algorithm
* [`Bind::Notify_secondaries`](#bindnotify_secondaries): Type to match allowed values for the notify option
* [`Bind::Syslog::Facility`](#bindsyslogfacility): Type to match allowed values for the syslog facility
* [`Bind::Syslog::Severity`](#bindsyslogseverity): Type to match allowed values for the syslog severity
* [`Bind::Zone::Class`](#bindzoneclass): Type to match allowed values for the zone class

## Classes

### `bind`

Manage the Bind DNS daemon and configuration

#### Examples

##### Install a local caching resolver

```puppet

class { 'bind':
  listen_on       => [ '127.0.0.1' ],
  listen_on_v6    => [ '::1' ],
  allow_query     => [ '127.0.0.1', '::1' ],
  allow_recursion => [ '127.0.0.1', '::1' ],
}
```

#### Parameters

The following parameters are available in the `bind` class.

##### `confdir`

Data type: `Stdlib::Absolutepath`

The directory where the main Bind configuration file is located. Example:
`/etc/bind`.

Default: operating system specific

##### `vardir`

Data type: `Stdlib::Absolutepath`

The directory where Bind stores other config files (zonefiles, ...).
Example: `/var/lib/bind`.

Default: operating system specific

##### `cachedir`

Data type: `Stdlib::Absolutepath`

The directory where Bind stores volatile data. Example:
`/var/cache/bind`.

Default: operating system specific

##### `rndc_keyfile`

Data type: `Stdlib::Absolutepath`

The file where the secret key for the rndc program is stored.

Default: operating system specific

##### `rndc_program`

Data type: `Stdlib::Absolutepath`

The full path of the rndc program.

Default: operating system specific

##### `rndc_key_algorithm`

Data type: `Bind::Key::Algorithm`

The authentication algorithm used on the communication channel between
rndc and the Bind daemon. Supported valued: `hmac-md5`, `hmac-sha1`,
`hmac-sha224`, `hmac-sha256`, `hmac-sha384`, `hmac-sha512`.

Default: operating system specific

##### `bind_user`

Data type: `String`

Run the Bind daemon as this user. This parameter is also used to set the
owner of some directories and files that the Bind daemon needs to write
to.

Default: operating system specific

##### `bind_group`

Data type: `String`

The group ownership for some Bind related directories and files.

Default: operating system specific

##### `package_name`

Data type: `String`

The name of the Bind package to install.

Default: operating system specific

##### `service_name`

Data type: `String`

The name of the Bind service to manage.

Default: operating system specific

##### `listen_on`

Data type: `Bind::AddressMatchList`

An array of strings to define the IPv4 address(es) on which the daemon
will listen for queries. The string `any` may be used to listen on all
available interfaces and addresses. This is also the default if the
parameter is unset. The string `none` may be used to disable IPv4.

Use `bind::listen_on` to define more complex configurations.

Default value: `[]`

##### `listen_on_v6`

Data type: `Bind::AddressMatchList`

An array of strings to define the IPv6 address(es) on which the daemon
will listen for queries. The string `any` may be used to listen on all
available interfaces and addresses. This is also the default if the
parameter is unset. The string `none` may be used to disable IPv6.

Use `bind::listen_on_v6` to define more complex configurations.

Default value: `[]`

##### `ipv4_enable`

Data type: `Boolean`

Should Bind use IPv4. At least one of `ipv4_enable` and `ipv6_enable`
must be set to true.

Default value: ``true``

##### `ipv6_enable`

Data type: `Boolean`

Should Bind use IPv6. At least one of `ipv4_enable` and `ipv6_enable`
must be set to true.

Default value: ``true``

##### `views_enable`

Data type: `Boolean`

Should views be enabled.

Default value: ``false``

##### `dnssec_enable`

Data type: `Boolean`

Should DNSSEC be enabled.

Default value: ``true``

##### `empty_zones_enable`

Data type: `Boolean`

Should automatic empty zones be enabled.

Default value: ``true``

##### `root_mirror_enable`

Data type: `Boolean`

Should a local mirror zone the root zone be configured.

Default value: ``false``

##### `allow_query`

Data type: `Bind::AddressMatchList`

An array of IP addresses/networks or ACL names that are allowed to query
this Bind server.

Default value: `[]`

##### `allow_recursion`

Data type: `Bind::AddressMatchList`

An array of IP addresses/networks or ACL names that are allowed to use
this Bind server for recursion. Recursion is automatically turned on if
this parameter is not empty.

Default value: `[]`

##### `blackhole`

Data type: `Bind::AddressMatchList`

An array of IP addresses/networks that are ignored by the server. Requests
from sources matching this list will not be answered.

Default value: `[]`

##### `forwarders`

Data type: `Bind::AddressMatchList`

An array of other DNS servers that can be used to forward unresolvable
queries to.

Default value: `[]`

##### `forward`

Data type: `Bind::Forward`

The type of forwarding used. This parameter is only used if forwarders
are actually defined. Valid values: 'first', 'only'. Note that
automatic empty zones for RFC 6303 are ignored if this parameter
is set to `only`.

Default value: `'first'`

##### `filter_aaaa_on_v4`

Data type: `Bind::Filter_aaaa_on_v4`

Should AAAA records be omitted from the response if the IPv4 transport is
used. If this is set to `yes` then it does not apply if the queried zone
is DNSSEC-signed. Setting this parameter to `break-dnssec` will also omit
DNSSEC related RRs if AAAA records are filtered. Valid options: `no`,
`yes`, `break-dnssec`.

Default value: `'no'`

##### `max_cache_size`

Data type: `Integer`

The maximum number of bytes to use for the server's cache. If views are
used then the size applies to every view seperately. If this value is
zero then no limit is configured.

Default value: `0`

##### `max_cache_ttl`

Data type: `Integer`

The maximum number of seconds for which the server will cache positove
answers. If this value is zero then the config parameter will be omitted
and the Bind default of 1 week will be used.

Default value: `0`

##### `max_ncache_ttl`

Data type: `Integer`

The maximum number of seconds for which the server will cache negative
answers. If this value is zero then the config parameter will be omitted
and the Bind default of 3 hours will be used.

Default value: `0`

##### `package_ensure`

Data type: `String`

The state of the Bind package. Normally this is set to `installed` or a
specific version number.

Default value: `'installed'`

##### `service_ensure`

Data type: `Stdlib::Ensure::Service`

Whether the Bind service should be running.

Default value: `'running'`

##### `service_enable`

Data type: `Boolean`

Should the Bind service be enabled.

Default value: ``true``

##### `report_hostname`

Data type: `Optional[String]`

The hostname the will be reported by Bind. If this is undefined
(default), then Bind will report the local hostname. Set this to a string
to hide the hostname and report the given string instead. Use the empty
string to disable hostname reporting completely.

Default value: ``undef``

##### `report_version`

Data type: `Optional[String]`

The version string that will be reported by Bind. If this is undefined
(default), then Bind will report the version that has been installed. Set
this to a string to hide the version number and report the given string
instead. Use the empty string to disable version reporting completely.

Use the following command to test: dig @127.0.0.1 version.bind chaos txt

Default value: ``undef``

##### `allow_query_cache`

Data type: `Bind::AddressMatchList`



Default value: `[]`

##### `root_hints_enable`

Data type: `Boolean`



Default value: ``true``

##### `root_hints_source`

Data type: `String`



Default value: `"puppet:///modules/${module_name}/zones/db.root"`

##### `localhost_forward_enable`

Data type: `Boolean`



Default value: ``true``

##### `localhost_forward_source`

Data type: `String`



Default value: `"puppet:///modules/${module_name}/zones/db.localhost"`

##### `localhost_reverse_enable`

Data type: `Boolean`



Default value: ``true``

##### `localhost_reverse_source`

Data type: `String`



Default value: `"puppet:///modules/${module_name}/zones/db.127"`

##### `min_cache_ttl`

Data type: `Integer`



Default value: `0`

##### `min_ncache_ttl`

Data type: `Integer`



Default value: `0`

##### `servfail_ttl`

Data type: `Integer`



Default value: `0`

##### `querylog_enable`

Data type: `Optional[Boolean]`



Default value: ``undef``

### `bind::rate_limit`

Manage rate limiting

#### Examples

##### Establish a limit

```puppet

class { bind::rate_limit':
  all_per_second => 1000,
}
```

#### Parameters

The following parameters are available in the `bind::rate_limit` class.

##### `window`

Data type: `Integer[0,3600]`

The size of the rolling window measured in seconds over which the rate
limits are calculated.

Default value: `0`

##### `ipv4_prefix_length`

Data type: `Integer[0,32]`

Define the number of bits that are used to group IPv4 addresses (like a
netmask). The limits are applied to all requests having the same network
prefix.

Default value: `0`

##### `ipv6_prefix_length`

Data type: `Integer[0,128]`

Define the number of bits that are used to group IPv6 addresses (like a
netmask). The limits are applied to all requests having the same network
prefix.

Default value: `0`

##### `log_only`

Data type: `Boolean`

Do not really limit the queries but only log that it would happen. This
can be used to test limits before enforcing them.

Default value: ``false``

##### `exempt_clients`

Data type: `Array[String]`

An array of IP addresses/networks or ACL names that are never limited.

Default value: `[]`

##### `all_per_second`

Data type: `Optional[Integer[0,1000]]`

Limit the number of total answers per second for an IP address to the
given value.

Default value: ``undef``

##### `errors_per_second`

Data type: `Optional[Integer[0,1000]]`

Limit the number of total error answers per second for an IP address to
the given value.

Default value: ``undef``

##### `responses_per_second`

Data type: `Optional[Integer[0,1000]]`

Limit the number of identical responses per second for an IP address to
the given value.

Default value: ``undef``

##### `referrals_per_second`

Data type: `Optional[Integer[0,1000]]`

Limit the number of referrals per second to the given value.

Default value: ``undef``

##### `nodata_per_second`

Data type: `Optional[Integer[0,1000]]`

Limit the number of NODATA responses per second to the given value.

Default value: ``undef``

##### `nxdomains_per_second`

Data type: `Optional[Integer[0,1000]]`

Limit the number of NXDOMAIN responses per second to the given value.

Default value: ``undef``

##### `qps_scale`

Data type: `Optional[Integer[0,1000]]`

Value to define the query per second scaling.

Default value: ``undef``

##### `slip`

Data type: `Optional[Integer[0,10]]`

Set the rate at which queries over the defined limit are returned with
the truncate bit.

Default value: ``undef``

## Defined types

### `bind::acl`

Manage ACL entries

#### Examples

##### Create an ACL for an internal network

```puppet

bind::acl { 'internal':
  address_match_list => [ '10.0.0.0/8', ],
  comment            => 'internal network',
}
```

#### Parameters

The following parameters are available in the `bind::acl` defined type.

##### `address_match_list`

Data type: `Array[String,1]`

An array of IP addresses/networks, which can be referenced in other Bind
configuration clauses to limit access to a component. The array parameter
must have at least one entry.

##### `comment`

Data type: `Optional[String]`

An optional string that is used as comment in the generated ACL file.

Default value: ``undef``

##### `order`

Data type: `String`

The sorting order of the ACLs in the configuration file.

Default value: `'10'`

##### `acl`

Data type: `String`

The name of the ACL. Defaults to the name of the resource.

Default value: `$name`

### `bind::config`

Manage configuration files

#### Examples

##### Install the named.conf config file

```puppet

bind::config { 'named.conf':
  source => "puppet:///modules/local/named.conf",
}
```

#### Parameters

The following parameters are available in the `bind::config` defined type.

##### `ensure`

Data type: `Enum['present','absent']`

The state of the resource. Must be either `present` or `absent`.

Default value: `'present'`

##### `file`

Data type: `String`

The name of the configuration file. This must be only the basename of the
file and not an absolute pathname. Default is the name of the resource.

Default value: `$name`

##### `owner`

Data type: `String`

The file owner for the config file.

Default value: `'root'`

##### `group`

Data type: `String`

The file group for the key file. Default is the value of the class
parameter `bind::bind_group`.

Default value: `$::bind::bind_group`

##### `mode`

Data type: `Stdlib::Filemode`

The file mode for the key file.

Default value: `'0640'`

##### `source`

Data type: `Optional[String]`

The file source for the configuration file. Either the parameter `source`
or `content` should be set to actually manage any file content. See the
Puppet standard `file` type.

Default value: ``undef``

##### `content`

Data type: `Optional[String]`

The file content for the configuration file. Either the parameter
`source` or `content` should be set to actually manage any file content.
See the Puppet standard `file` type.

Default value: ``undef``

### `bind::key`

Manage keys

#### Examples

##### Using the defined type

```puppet

bind::key { 'rndc-key':
  secret  => 'secret',
  keyfile => '/etc/bind/rndc.key',
}
```

#### Parameters

The following parameters are available in the `bind::key` defined type.

##### `key`

Data type: `String`

The name of the key.

Default value: `$name`

##### `algorithm`

Data type: `Bind::Key::Algorithm`

The algorithm to use for the encoding of the secret key. Can be one of:
`hmac-md5`, `hmac-sha1`, `hmac-sha224`, `hmac-sha256`, `hmac-sha384`,
`hmac-sha512`. The default is `hmac-sha256`.

Default value: `'hmac-sha256'`

##### `owner`

Data type: `String`

The file owner for the key file.

Default value: `'root'`

##### `group`

Data type: `String`

The file group for the key file.

Default value: `$::bind::bind_group`

##### `mode`

Data type: `Stdlib::Filemode`

The file mode for the key file.

Default value: `'0640'`

##### `keyfile`

Data type: `Optional[Stdlib::Absolutepath]`

Set this parameter to a file name if you need to reference the key from
other tools (like 'rndc'). In this case the file with the key will be
saved in the named file. Otherwise a a system selected file will be used.

Default value: ``undef``

##### `base64_secret`

Data type: `Optional[String]`

A base64 encoded secret to copy verbatim into the key. The parameters
secret and seed are ignored if this parameter is set.

Default value: ``undef``

##### `secret`

Data type: `Optional[String]`

The secret to use for the key. A random secret is created internally if
this parameter is not set.

Default value: ``undef``

##### `seed`

Data type: `Optional[String]`

An optional seed to use if the random secret is created internally.

Default value: ``undef``

### `bind::listen_on`

Manage listen-on option clause

#### Examples

##### Listen on the loopback interface

```puppet

listen_on { '127.0.0.1': }
```

##### Listen on two interfaces

```puppet

listen_on { 'IPv4':
  address => [ '10.0.0.1', '192.168.0.1' ],
}
```

##### Listen on a non-default port

```puppet

listen_on { '127.0.0.1':
  port    => 8053,
}
```

#### Parameters

The following parameters are available in the `bind::listen_on` defined type.

##### `address`

Data type: `Bind::AddressMatchList`

A single string or an array of strings to define the port and IP
address(es) on which the daemon will listen for queries. The string `any`
may be used to listen on all available interfaces and addresses. The
string `none` may be used to disable IPv4.

Default value: `$name`

##### `port`

Data type: `Optional[Stdlib::Port]`

The port number on which the daemon will listen. Port 53 will be used if
this is not defined.

Default value: ``undef``

### `bind::listen_on_v6`

Manage listen-on-v6 option clause

#### Examples

##### Listen on the IPv6 loopback interface

```puppet

listen_on_v6 { '::1': }
```

##### Listen on a non-default port

```puppet

listen_on_v6 { '::1':
  port => 8053,
}
```

#### Parameters

The following parameters are available in the `bind::listen_on_v6` defined type.

##### `address`

Data type: `Variant[String,Array[String,1]]`

A single string or an array of strings to define the port and IP
address(es) on which the daemon will listen for queries. The string `any`
may be used to listen on all available interfaces and addresses. The
string `none` may be used to disable IPv6.

Default value: `$name`

##### `port`

Data type: `Optional[Stdlib::Port]`

The port number on which the daemon will listen. Port 53 will be used if
this is not defined.

Default value: ``undef``

### `bind::logging::category`

Manage logging category

#### Examples

##### Use a single channel

```puppet

bind::logging::category { 'default':
  channels => 'syslog',
}
```

##### Use multiple channels

```puppet

bind::logging::category { 'default':
  channels => [ 'syslog', 'file', ],
}
```

#### Parameters

The following parameters are available in the `bind::logging::category` defined type.

##### `channels`

Data type: `Variant[String,Array[String]]`

A string or an array of strings to define the channels to use for this
category.

##### `category`

Data type: `String`

The logging category.

Default value: `$name`

##### `order`

Data type: `String`

A string to use for ordering different categories in the configuration
file.

Default value: `'50'`

### `bind::logging::channel_file`

Manage logging channel to a logfile

#### Examples

##### Define a logfile channel for Bind9

```puppet

bind::logging::channel_file { 'security':
  logfile => '/var/lob/bind/security',
}
```

#### Parameters

The following parameters are available in the `bind::logging::channel_file` defined type.

##### `logfile`

Data type: `Stdlib::Absolutepath`

The filename where the logs are written to.

##### `channel`

Data type: `String`

The name of the channel for the logfile. Use bind::logging::category to
route a given category to this channel.

Default value: `$name`

##### `severity`

Data type: `Bind::Syslog::Severity`

The severity of log messages that are written to the file. Valid values:
`critical`, `error`, `warning`, `notice`, `info`, `debug`, `dynamic`.

Default value: `'notice'`

##### `print_category`

Data type: `Boolean`

Should the category of the message be logged to the file.

Default value: ``true``

##### `print_severity`

Data type: `Boolean`

Should the severity of the message be logged to the file.

Default value: ``true``

##### `print_time`

Data type: `Boolean`

Should a timestamp be logged to the file.

Default value: ``true``

##### `size`

Data type: `Optional[String]`

The maximum size of the logfile. Logfile rotation takes place if this
size is reached. If the size is undefined then the logfile will not be
rotated.

Default value: ``undef``

##### `versions`

Data type: `Optional[Integer]`

The number of logfile to keep if log rotation is used.

Default value: ``undef``

### `bind::logging::channel_syslog`

Manage logging channel to syslog

#### Examples

##### Define a syslog channel for Bind9

```puppet

bind::logging::channel_syslog { 'syslog':
  facility => 'local0',
  severity => 'info',
}
```

#### Parameters

The following parameters are available in the `bind::logging::channel_syslog` defined type.

##### `channel`

Data type: `String`

The name of the channel. Use bind::logging::category to route a given
category to this channel.

Default value: `$name`

##### `facility`

Data type: `Bind::Syslog::Facility`

The syslog facility to use. Valid value: `auth`, `authpriv`, `cron`,
`daemon`, `ftp`, `kern`, `local0`, `local1`, `local2`, `local3`,
`local4`, `local5`, `local6`, `local7`, `lpr`, `mail`, `news`, `syslog`,
`user`, `uucp`.

Default value: `'daemon'`

##### `severity`

Data type: `Bind::Syslog::Severity`

The severity of log messages that are written to the file. Valid values:
`critical`, `error`, `warning`, `notice`, `info`, `debug`, `dynamic`.

Default value: `'notice'`

##### `print_category`

Data type: `Optional[Boolean]`

Should the category of the message be logged to the file.

Default value: ``undef``

##### `print_severity`

Data type: `Optional[Boolean]`

Should the severity of the message be logged to the file.

Default value: ``undef``

##### `print_time`

Data type: `Optional[Boolean]`

Should a timestamp be logged to the file.

Default value: ``undef``

### `bind::statistics_channel`

Manage statistics channel

#### Examples

##### Create a statistics channel for localhost access

```puppet

bind::statistics_channel { '127.0.0.1':
  port  => 8053,
  allow => [ '127.0.0.1', ],
}
```

#### Parameters

The following parameters are available in the `bind::statistics_channel` defined type.

##### `port`

Data type: `Optional[Stdlib::Port]`

The port number to listen on. If no port is specified , port 80 is used.

Default value: ``undef``

##### `allow`

Data type: `Array[String]`

An array of IP addresses that are allowed to query the statistics. If
this parameter is not set, all remote addresses are permitted to use the
statitiscs channel.

Default value: `[]`

##### `ip`

Data type: `String`

The IP address to listen on. This can be an IPv4 address or an IPv6
address if IPv6 is in use. An address of `*` is interpreted as the IPv4
wildcard address.

Default value: `$name`

### `bind::view`

Manage a view

#### Examples

##### Create a view for a guest network

```puppet

bind::view { 'guest':
  match_clients   => [ 'guest' ],
  allow_recursion => [ 'any' ],
}
```

#### Parameters

The following parameters are available in the `bind::view` defined type.

##### `match_clients`

Data type: `Array[String]`

An array of ACL names or networks that this view will be used for.

Default value: `[ 'any', ]`

##### `match_destinations`

Data type: `Array[String]`

An array of ACL names or networks. The view is used if the query
destination matches this list.

Default value: `[]`

##### `allow_query`

Data type: `Array[String]`

An array of ACL names or networks that are allowed to query the view.

Default value: `[ 'any', ]`

##### `allow_query_on`

Data type: `Array[String]`

An array of interfaces on the DNS server from which queries are accepted.

Default value: `[]`

##### `recursion`

Data type: `Boolean`

Should recursion be enabled for this view.

Default value: ``true``

##### `match_recursive_only`

Data type: `Boolean`

Should this view be used for recursive queried only.

Default value: ``false``

##### `allow_recursion`

Data type: `Array[String]`

An array of ACL names or networks for which recursive queries are
allowed.

Default value: `[]`

##### `allow_recursion_on`

Data type: `Array[String]`

An array of interfaces on the DNS server from which recursive queries are
accepted.

Default value: `[]`

##### `allow_query_cache`

Data type: `Array[String]`

An array of ACL names or networks for which access to the cache is
allowed.

Default value: `[]`

##### `allow_query_cache_on`

Data type: `Array[String]`

An array of interfaces on the DNS server from which access to the cache
is allowed.

Default value: `[]`

##### `allow_transfer`

Data type: `Array[String]`

An array of ACL names or networks that are allowed to transfer zone
information from this server.

Default value: `[]`

##### `root_mirror_enable`

Data type: `Boolean`

Enable local root zone mirror for the view.

Default value: ``false``

##### `view`

Data type: `String`

The name of the view.

Default value: `$name`

##### `order`

Data type: `String`

The order in which different views are configured. The first matching
view is used to answer the query for a client. If you use one view where
match_clients contains `any` then this view should probably have the
highest order value.

Default value: `'10'`

##### `root_hints_enable`

Data type: `Optional[Boolean]`



Default value: ``undef``

##### `localhost_forward_enable`

Data type: `Optional[Boolean]`



Default value: ``undef``

##### `localhost_reverse_enable`

Data type: `Optional[Boolean]`



Default value: ``undef``

### `bind::zone::forward`

Manage a forward zone

#### Examples

##### Using the defined type

```puppet

bind::zone::forward { 'example.com':
  forwarders => [ '192.168.1.1', '192.168.1.2', ],
  forward    => 'only',
}
```

#### Parameters

The following parameters are available in the `bind::zone::forward` defined type.

##### `forwarders`

Data type: `Array[String]`

An array of strings that define the forwarding servers for this zone.
All queries for the zone will be forwarded to these servers.

Default value: `[]`

##### `forward`

Data type: `Optional[Bind::Forward]`

Only forward queries (value `only`) or try to resolve if forwarders do
not answer the query (value `first`).

Default value: ``undef``

##### `view`

Data type: `Optional[String]`

The name of the view that should include this zone. Must be set if views
are used.

Default value: ``undef``

##### `zone`

Data type: `String`

The name of the zone.

Default value: `$name`

##### `comment`

Data type: `Optional[String]`



Default value: ``undef``

##### `class`

Data type: `Bind::Zone::Class`



Default value: `'IN'`

##### `order`

Data type: `String`



Default value: `'40'`

### `bind::zone::hint`

Manage a hint zone

#### Examples

##### Using the defined type

```puppet

bind::zone::hint { '.':
  file => '/etc/bind/db.root',
}
```

#### Parameters

The following parameters are available in the `bind::zone::hint` defined type.

##### `zone`

Data type: `String`

The name of the zone.

Default value: `$name`

##### `file`

Data type: `String`



##### `view`

Data type: `Optional[String]`



Default value: ``undef``

##### `comment`

Data type: `Optional[String]`



Default value: ``undef``

##### `class`

Data type: `Bind::Zone::Class`



Default value: `'IN'`

##### `order`

Data type: `String`



Default value: `'10'`

### `bind::zone::in_view`

Manage a in-view zone reference

#### Examples

##### Using the defined type

```puppet

bind::zone::in_view { 'example.com':
  view    => 'internal',
  in_view => 'external',
}
```

#### Parameters

The following parameters are available in the `bind::zone::in_view` defined type.

##### `view`

Data type: `String`

The name of the view that should include this zone.

##### `in_view`

Data type: `String`

The name of the view where the referenced view is defined.

##### `zone`

Data type: `String`

The name of the zone.

Default value: `$name`

##### `comment`

Data type: `Optional[String]`



Default value: ``undef``

##### `class`

Data type: `Bind::Zone::Class`



Default value: `'IN'`

##### `order`

Data type: `String`



Default value: `'60'`

### `bind::zone::mirror`

Manage a mirror zone

#### Examples

##### Using the defined type

```puppet

bind::zone::mirror { '.':
}
```

#### Parameters

The following parameters are available in the `bind::zone::mirror` defined type.

##### `zone`

Data type: `String`

The name of the zone.

Default value: `$name`

##### `view`

Data type: `Optional[String]`



Default value: ``undef``

##### `comment`

Data type: `Optional[String]`



Default value: ``undef``

##### `class`

Data type: `Bind::Zone::Class`



Default value: `'IN'`

##### `order`

Data type: `String`



Default value: `'50'`

### `bind::zone::primary`

Manage a primary zone

#### Examples

##### Create a primary zone

```puppet

bind::zone::primary { 'example.com':
  source => 'puppet:///modules/profile/example.com.zone',
}
```

##### Use DNSSEC inline signing for a primary zone

```puppet

bind::zone::primary { 'example.com':
  inline_signing => true,
  auto_dnssec    => 'maintain',
  source         => 'puppet:///modules/profile/example.com.zone',
}
```

#### Parameters

The following parameters are available in the `bind::zone::primary` defined type.

##### `dnssec`

Data type: `Boolean`

Enable DNSSEC for the zone.

Default value: ``false``

##### `inline_signing`

Data type: `Boolean`

Enable inline signing for the zone.

Default value: ``false``

##### `auto_dnssec`

Data type: `Bind::Auto_dnssec`

How to sign and resign the DNSSEC zone. Can be one of `allow`, `maintain`
or `off`.

Default value: `'off'`

##### `also_notify`

Data type: `Array[String]`

Secondary servers that should be notified in addition to the
nameservers that are listed in the zone file.

Default value: `[]`

##### `notify_secondaries`

Data type: `Optional[Bind::Notify_secondaries]`

Should NOTIFY messages be sent out to the name servers defined in the NS
records for the zone. The messages are sent to all name servers except
itself and the primary name server defined in the SOA record and to any
IPs listed in any also-notify statement. Can be either `yes`, `no` or
`explicit`.

Default value: ``undef``

##### `view`

Data type: `Optional[String]`

The name of the view that should include this zone. Must be set if views
are used.

Default value: ``undef``

##### `source`

Data type: `Optional[String]`

The source for the zone file. See the standard Puppet file type.

Default value: ``undef``

##### `content`

Data type: `Optional[String]`

The content for the zone file. See the standart Puppet file type.

Default value: ``undef``

##### `zone_statistics`

Data type: `Optional[Boolean]`

Collect statistics for this zone.

Default value: ``undef``

##### `zone`

Data type: `String`

The name of the zone.

Default value: `$name`

##### `file`

Data type: `Optional[String]`



Default value: ``undef``

##### `comment`

Data type: `Optional[String]`



Default value: ``undef``

##### `class`

Data type: `Bind::Zone::Class`



Default value: `'IN'`

##### `order`

Data type: `String`



Default value: `'20'`

### `bind::zone::secondary`

Manage a secondary zone

#### Examples

##### Create a secondary zone

```puppet

bind::zone::secondary { 'example.com':
  masters => [ '192.168.1.1', ],
}
```

#### Parameters

The following parameters are available in the `bind::zone::secondary` defined type.

##### `masters`

Data type: `Array[String,1]`

An array of strings that define the master servers for this zone.
There must be at least one master server for a secondary zone.

##### `view`

Data type: `Optional[String]`

The name of the view that should include this zone. Must be set if views
are used.

Default value: ``undef``

##### `zone_statistics`

Data type: `Optional[Boolean]`

Collect statistics for this zone.

Default value: ``undef``

##### `multi_master`

Data type: `Optional[Boolean]`

If the zone has multiple primaries and the serial might be
different for the masters then named normally logs a message. Set
this to `true` to disable the message in this case.

Default value: ``undef``

##### `zone`

Data type: `String`

The name of the zone.

Default value: `$name`

##### `comment`

Data type: `Optional[String]`



Default value: ``undef``

##### `class`

Data type: `Bind::Zone::Class`



Default value: `'IN'`

##### `order`

Data type: `String`



Default value: `'30'`

## Resource types

### `dnssec_key`

Manage DNSSEC keys for the Bind9 DNS server. This type creates, deletes
and maintains key files in a directory on the DNS server.

Examples:

Create a key-signing-key for the example.com domain using defaults:

  dnssec_key { 'example.com':
    key_directory => '/etc/bind/keys',
    ksk           => true,
  }

Create a zone-signing-key for the example.com domain using a specified
algorithm and key size:

  dnssec_key { 'example.com-ZSK':
    key_directory => '/etc/bind/keys',
    algorithm     => 'RSASHA256',
    bits          => 2048,
  }


key-1 ------ active ----------><-- retired --><-- deleted --

key-2       <--- published ---><---------- active ----------><-- retired -->

            <----------------->
               prepublication
                  interval

#### Properties

The following properties are available in the `dnssec_key` type.

##### `ensure`

Valid values: `present`, `absent`

Specifies whether the destination file should exist. Setting to
"absent" tells Puppet to delete the destination file if it exists,
and negates the effect of any other parameters.

Default value: `present`

#### Parameters

The following parameters are available in the `dnssec_key` type.

##### `active`

Valid values: `%r{^[0-9]+(y|mo|w|d|h|mi)?$}`

The time when the key will be used for signing.

##### `algorithm`

Valid values: `DSA`, `ECCGOST`, `ECDSAP256SHA256`, `ECDSAP384SHA384`, `ED25519`, `ED448`, `NSEC3DSA`, `NSEC3RSASHA1`, `RSAMD5`, `RSASHA1`, `RSASHA256`, `RSASHA512`

The cryptographic alghorithm that the key should use.

Default value: `RSASHA1`

##### `bits`

Valid values: `%r{^[0-9]+$}`

The number of bits in the key. The possible range depends on the
selected algorithm:

RSA  : 512 .. 2048
DH   : 128 .. 4096
DSA  : 512 .. 1024 and an exact multiple of 64
HMAC :   1 ..  512

Elliptic curve algorithms don't need this parameter.

##### `inactive`

Valid values: `%r{^[0-9]+(y|mo|w|d|h|mi)?$}`

The time when the key is still published after it became inactive.

##### `key_directory`

The directory where the key should be created. This parameter is
mandatory.

##### `ksk`

Valid values: ``true``, ``false``

Whether the key should be a key-signing-key.

Default value: ``false``

##### `name`

namevar

The name of the resource.

##### `nsec3`

Valid values: ``true``, ``false``

Whether the key should be NSEC3-capable.

Default value: ``false``

##### `provider`

The specific backend to use for this `dnssec_key` resource. You will seldom need to specify this --- Puppet will usually
discover the appropriate provider for your platform.

##### `publish`

Valid values: `%r{^[0-9]+(y|mo|w|d|h|mi)?$}`

The time before activation when the key will be published.

##### `rrtype`

Valid values: `DNSKEY`, `KEY`

The resource record type to use for the key.

Default value: `DNSKEY`

##### `successor`

Valid values: ``true``, ``false``

Whether the key should be created as an explicit successor to an
existing key. In this case the name, algorithm, size and type of the
key will be take from the existing key. The activation date will match
the inactivation date of the existing key.

Default value: ``false``

##### `zone`

Valid values: `%r{^[a-zA-Z][a-zA-Z0-9.-]+\.[a-zA-Z]+$}`

The zone for which the key should be generated. This must be a
valid domain name. Defaults to the resource title if unset.

## Functions

### `bind::zonefile_path`

Type: Puppet Language

zonefile_path.pp --- Generate zonefile name from zone

#### `bind::zonefile_path(String $zone)`

zonefile_path.pp --- Generate zonefile name from zone

Returns: `String` The relative path and filename where the zonefile should be
stored.  Example: 'com/example/db.example.com'

##### `zone`

Data type: `String`

The name of the zone for which the path should be
returned.  Example: 'example.com'

## Data types

### `Bind::AddressMatchList`

Type to match allowed values for an address match list

Alias of `Variant[String, Array[String]]`

### `Bind::Auto_dnssec`

Type to match allowed values for the auto-dnssec option

Alias of `Enum['allow', 'maintain', 'off']`

### `Bind::Filter_aaaa_on_v4`

Type to match allowed values for the filter-aaaa-on-v4 option

Alias of `Enum['no', 'yes', 'break-dnssec']`

### `Bind::Forward`

Type to match allowed values for the forward option

Alias of `Enum['first', 'only']`

### `Bind::Key::Algorithm`

Type to match allowed values for the key algorithm

Alias of `Enum['hmac-md5', 'hmac-sha1', 'hmac-sha224', 'hmac-sha256', 'hmac-sha384', 'hmac-sha512']`

### `Bind::Notify_secondaries`

Type to match allowed values for the notify option

Alias of `Enum['yes', 'no', 'explicit']`

### `Bind::Syslog::Facility`

Type to match allowed values for the syslog facility

Alias of `Enum['auth', 'authpriv', 'cron', 'daemon', 'ftp', 'kern', 'local0', 'local1', 'local2', 'local3', 'local4', 'local5', 'local6', 'local7', 'lpr', 'mail', 'news', 'syslog', 'user', 'uucp']`

### `Bind::Syslog::Severity`

Type to match allowed values for the syslog severity

Alias of `Enum['critical', 'error', 'warning', 'notice', 'info', 'debug', 'dynamic']`

### `Bind::Zone::Class`

Type to match allowed values for the zone class

Alias of `Enum['IN', 'HS', 'CH']`
