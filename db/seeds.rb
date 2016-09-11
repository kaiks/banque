# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

income_brackets =
  IncomeBracket.create([
                           {min: 0, max: 999},
                       {min: 1000, max: 1999},
                       {min: 2000, max: 2999},
                       {min: 3000, max: -1}
                       ])

admin = Admin.create(username: 'admin', password: 'pwd123', name: 'Super', surname: 'User')