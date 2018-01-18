# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Reservation.destroy_all
Schedule.destroy_all
User.destroy_all

User.create!(email: 'test@gmail.com', password: 'QWEqwe123', role: 'admin')
User.create!(email: 'test2@gmail.com', password: 'QWEqwe123', role: 'operator')

(0..60).each do |day|
  Schedule.create!(date: Time.zone.today + day.days, count: (10..30).to_a.sample)
end
