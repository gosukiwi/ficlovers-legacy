# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Populate initial categories
Category.create([
  { name: 'Anime/Manga' },
  { name: 'Books' },
  { name: 'Cartoons' },
  { name: 'Comics' },
  { name: 'Games' },
  { name: 'Misc' },
  { name: 'Movies' },
  { name: 'Plays/Musicals' },
  { name: 'TV Shows' }
])

Forum.create([
  { name: 'Fic Discussion', status: :read_only },
  { name: 'General Discussion' },
  { name: 'Support' },
  { name: 'Off-Topic' }
]);
