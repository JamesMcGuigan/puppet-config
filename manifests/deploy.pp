node /jamesmcguigan/ {
  include website_deploy::all
}
node /liatandco/ {
  include website_liatandco
  include website_liatandco::deploy
}
