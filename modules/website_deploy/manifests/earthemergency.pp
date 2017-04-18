class website_deploy::earthemergency {
  website_deploy {'earthemergency.org':
    config  => "static",
    domains => ["earthemergency.org", "www.earthemergency.org"],
    source  => "https://github.com/JamesMcGuigan/earthemergency.org.git"
  }
}
