class windows_time (
  $enabled = true,
  $ntpservers = '0.us.pool.ntp.org,0x9'
) {

  registry::value { 'Enabled':
    key    => 'HKLM\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient',
    type   => 'dword',
    data   => 1,
    notify => Service['W32Time'],
  }

  registry::value { 'NtpClient':
    key    => 'HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Parameters',
    type   => string,
    data  => $ntpservers,
    notify => Service['W32Time'],
  }

  service { 'W32Time':
    ensure => running,
    enable => $enabled,
  }
}
