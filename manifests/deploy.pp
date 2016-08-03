node /jamesmcguigan/ {
  include website_jamesmcguigan::deploy
  include website_infographic_generator::deploy
  include website_statistical_learning::deploy
}
node /liatandco/ {
  include website_liatandco::deploy
}
