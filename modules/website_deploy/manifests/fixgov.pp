class website_deploy::fixgov {
  website_deploy {'fixgov.org':
    config  => "php",
    domains => ["fixgov.org", "www.fixgov.org", "fixgov.com", "www.fixgov.com"],
    source  => "https://github.com/JamesMcGuigan/fixgov.org.git"
  }
}
