class website_deploy::francescagiordano {
  website_deploy {'francescagiordano.com':
    config  => "static",
    domains => ["francescagiordano.com", "www.francescagiordano.com"],
    source  => "https://github.com/JamesMcGuigan/francescagiordano.com.git"
  }
}
