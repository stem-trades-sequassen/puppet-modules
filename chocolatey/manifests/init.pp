exec { 'Install Chocolatey':
  command   => 'Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString("https://community.chocolatey.org/install.ps1"))',
  onlyif    => 'if (!(Get-Command choco -ErrorAction SilentlyContinue)) { exit 1 } else { exit 0 }',
  provider  => powershell,
}
class { 'chocolatey':
  use_7zip      => false,  # Optional, don't use 7zip during install
  choco_install_timeout => 1500,  # Optional, increase timeout if needed
}

package { 'chocolatey':
  ensure => installed,
  provider => 'chocolatey',
}