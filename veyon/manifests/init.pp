class veyon {

  # Define variables
  $installer_url = 'puppet:///modules/veyon/Veyon-Setup.exe'
  $local_path    = 'C:/Temp/Veyon-Setup.exe'
  $package_name  = 'Veyon'

  # Ensure the Temp directory exists
  file { 'C:/Temp':
    ensure => directory,
  }

  # Download the Veyon installer from Puppet server
  file { $local_path:
    ensure => file,
    source => $installer_url,
    mode   => '0644',
  }

  # Install Veyon silently if it's not already installed
  exec { 'install_veyon':
    command   => "${local_path} /S",
    provider  => powershell,
    unless    => "if (Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -eq '${package_name}' }) { exit 0 } else { exit 1 }",
    require   => File[$local_path],  # Ensure file is downloaded before installation
  }
}
