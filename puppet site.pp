class file

{ file {'/tmp/damed': # resource type file and filename
  ensure  => present,    # make sure it exists
  mode    => 0644,       # perm
  content => "Here is my Public IP Address: ${ipaddress_eth0}.\n",  #ip get
}

}




class users
{

file {'/home/amal':

ensure => 'directory',

}



group {'amal':

ensure => present,

gid => '1503',

}



user {'amal':

ensure => present,

uid => '1503',

gid => '1503',

password => '!!',

shell => '/bin/bash',

home => '/home/amal',

}

}








class apache
{
case $operatingsystem {
centos: { $apache = "httpd" }
redhat: { $apache = "httpd" }
debian: { $apache = "apache2" }
ubuntu: { $apache = "apache2" }
}
package { 'apache':
name => $apache,
ensure => latest,
}

}


class user_account 
{

  file { '/tmp/user1':
     ensure  => present,    
     mode    => 0644,
     source  => "puppet:///files/user1",
  }

}




class mysql
{

  file { '/tmp/mysql.sh':
     ensure  => file,
     mode    => 0777,
     source  => "puppet:///files/mysql.sh",
  }
exec { 'mysql':

command => '/tmp/mysql.sh',
  
 }

}










node 'puppetagent2.com'

{

include users
include apache
include user_account
include mysql
}



node 'puppetagent1.com'

{

include  user_account
include file
include mysql

}
