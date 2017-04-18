class website_deploy::starsfaq {
  website_deploy {'starsfaq.com':
    config  => "static",
    domains => ["starsfaq.com", "www.starsfaq.com"],
    source  => "https://github.com/JamesMcGuigan/starsfaq.com.git"
  }
}
