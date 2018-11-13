# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Cat.destroy_all
  sue_cat = Cat.create!(birth_date: '1990/10/31', color: 'calico', name: "Sue", sex: 'F')
  erto_cat = Cat.create!(birth_date: '1996/08/12', color: 'indigo', name: "Erto", sex: 'M')
  julie_cat = Cat.create!(birth_date: '1970/12/24', color: 'red', name: "Jules", sex: 'M')
  mapa_cat = Cat.create!(birth_date: '1990/11/13', color: 'blue', name: "MrMapa", sex: 'M')