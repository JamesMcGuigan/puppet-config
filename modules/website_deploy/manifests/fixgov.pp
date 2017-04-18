class website_deploy::fixgov {
  website_deploy {'fixgov.org':
    config  => "php",
    domains => ["fixgov.org", "www.fixgov.org"],
    source  => "https://github.com/JamesMcGuigan/fixgov.org.git"
  }
}
