node /jamesmcguigan/ {
  include website_infographic_generator::deploy
  include website_statistical_learning::deploy
  include website_liatandco::deploy
}
node /liatandco/ {
  include website_liatandco::deploy
}
