# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


organizations = [{name: 'xavier-jaipur',domain_name: 'xavierjaipur.org', type: 1},
                {name: 'iisu',domain_name: 'iisuniv.co.in', type: 1},
                {name: 'sbnitm',domain_name: 'sbnitm', type: 1},
                {name: 'tecnho',domain_name: 'technonjr.org', type: 1}]

organizations.each do |o|
  Organization.create(name: o[:name], domain_name: o[:domain_name], organization_type: o[:type], created_by: 'Divyanshu',updated_by: 'Divyanshu')
end
