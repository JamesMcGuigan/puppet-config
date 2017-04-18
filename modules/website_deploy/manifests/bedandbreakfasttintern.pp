class website_deploy::bedandbreakfasttintern {
  website_deploy {'bedandbreakfasttintern.co.uk':
    config  => "static",
    domains => ["bedandbreakfasttintern.co.uk", "www.bedandbreakfasttintern.co.uk"],
    source  => "https://github.com/JamesMcGuigan/bedandbreakfasttintern.co.uk.git"
  }
}
