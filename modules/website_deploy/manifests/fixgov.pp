class website_deploy::fixgov {
  #contain php::php4
  contain php::php5

  website_deploy {'fixgov.org':
    config  => "static",
    domains => ["fixgov.org", "www.fixgov.org"],
    source  => "https://github.com/JamesMcGuigan/fixgov.org.git"
  }
}
