class wordpress::wp{
	file { '/tmp/latest.tar.gz':
        ensure => present,
        source => "puppet:///modules/wordpress/latest.tar.gz"
    	}

	exec { 'extract':
        cwd => "/tmp",
        command => "tar -xvzf latest.tar.gz",
        require => File['/tmp/latest.tar.gz'],
        path => ['/bin'],
    	}

	exec { 'copy':
        command => "cp -r /tmp/wordpress/* /var/www/",
        require => Exec['extract'],
        path => ['/bin'],
    	}

    	file { '/var/www/wp-config.php':
        ensure => present,
        require => Exec['copy'],
        content => template("wordpress/wp-config.php.erb")
    	}
}
