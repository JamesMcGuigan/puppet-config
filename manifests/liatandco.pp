node /jamesmcguigan/ {
  include website_liatandco
  include website_liatandco::deploy
}
node /liatandco/ {
  include website_liatandco
  include website_liatandco::deploy
}