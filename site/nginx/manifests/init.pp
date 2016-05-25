class nginx {
file {'nginx rpm' :
ensure => file,
path => '/opt/nginx-1.6.2-1.el7.centos.ngx.x86_64.rpm',
source => 'puppet:///modules/nginx/nginx-1.6.2-1.el7.centos.ngx.x86_64.rpm',
}
package { 'nginx' :
  ensure => '1.6.2-1.el7.centos.ngx',
  source => '/opt/nginx-1.6.2-1.el7.centos.ngx.x86_64.rpm',
  provider => rpm,
  require => File['nginx rpm']
  }

file { '/var/www' :
ensure => directory,
owner => 'root',
group => 'root',
mode => '0775',
}
file {'/var/www/index.html' :
ensure => file,
owner => 'root',
group => 'root',
mode => '0664',
source => 'puppet:///modules/nginx/index.html',
}
file {'/etc/nginx/nginx.conf' :
ensure => file,
owner => 'root',
group => 'root',
mode => '0664',
source => 'puppet://modules/nginx/nginx.conf',
require => Package['nginx'],
notify => Service['nginx'],
}
file {'/etc/nginx/conf.d' :
ensure => directory,
owner => 'root',
group => 'root',
mode => '0775',
}
file {'/etc/nginx/conf.d/default.conf' :
ensure => file,
owner => 'root',
group => 'root',
mode => '0664',
source => 'puppet:///modules/nginx/default.conf',
require => Package['nginx']
notify => Service['nginx']
}
service {'nginx' :
ensure => running,
enable => true,
}
}









