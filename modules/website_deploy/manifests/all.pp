class website_deploy::all {
  include website_deploy::all::static
  include website_deploy::all::original
}
class website_deploy::all::static {
  include website_deploy::bedandbreakfasttintern
  include website_deploy::earthemergency
  include website_deploy::fixgov
  include website_deploy::francescagiordano
  include website_deploy::starsfaq
}
class website_deploy::all::original {
  include website_jamesmcguigan
  include website_jamesmcguigan::deploy
  include website_statistical_learning
  include website_statistical_learning::database
  include website_statistical_learning::deploy
  include website_infographic_generator
  include website_infographic_generator::deploy
}
