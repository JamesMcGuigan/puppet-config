class mailx {
  package { 'heirloom-mailx':  ensure  => installed }
  package { 'sendmail':        ensure  => installed }
}
