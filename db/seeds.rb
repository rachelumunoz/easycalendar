# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(first_name: "Ian", last_name: "Lucas", email: ENV['IAN_EMAIL'], phone_number: ENV['IAN_PHONE'], password:"password")#1
User.create(first_name: "Phil", last_name: "Jackson",email: "soccer_coach@gmail.com", password:"password")#2
User.create(first_name: "Phil", last_name: "Jackson", email: "balet_coach@gmail.com", password:"password")#3
User.create(first_name: "Phil", last_name: "Jackson", email: "NIKESB_coach@gmail.com", password:"password")#4
User.create(first_name: "Phil", last_name: "Jackson", email: "gymnast_coach@gmail.com", password:"password")#5
User.create(first_name: "Phil", last_name: "Jackson", email: "ice_queen@gmail.com", password:"password")#6

User.create(first_name: "Phil", last_name: "Jackson", email: "soccermom1@gmail.com", password:"password")#7
User.create(first_name: "Phil", last_name: "Jackson", email: "soccermom2@gmail.com", password:"password")#8
User.create(first_name: "Phil", last_name: "Jackson", email: "dancedad@gmail.com", password:"password")#9
User.create(first_name: "Phil", last_name: "Jackson", email: "gymmom@gmail.com", password:"password")#10

Child.create(first_name: "Romeo",last_name: "Lucia", age: 8, parent_id: 1)#1
Child.create(first_name: "Olivia",last_name: "Lucia", age: 8, parent_id: 1)#2
Child.create(first_name: "Stella", last_name: "Artois", age: 14, parent_id: 8)#3
Child.create(first_name: "Natalie", last_name: "Bhan", age: 17, parent_id:9)#4
Child.create(first_name: "Sarah", last_name: "Jennikasinsmanov", age: 17, parent_id:9)#4

Location.create(name: "Mira Mesa Rec", address: "1234 Mira Mesa Way");#1
Location.create(name: "Poway Rec", address: "5678 Poway Center Dr")#2
Location.create(name: "Escondido Rec", address: "91011 Poway Center Dr")#2

Activity.create(name: "Soccer")
Activity.create(name: "Balet")
Activity.create(name: "Skateboarding")
Activity.create(name: "Gymnastics")
Activity.create(name: "Figure Skating")

10.times do
  CoachActivity.create(coach_id:rand(10)+1,activity_id:rand(5)+1)
end

CoachLocation.create(location_id: 1, coach_id:5)
CoachLocation.create(location_id: 2, coach_id:5)
CoachLocation.create(location_id: 3, coach_id:5)
CoachLocation.create(location_id: 1, coach_id:1)
CoachLocation.create(location_id: 2, coach_id:3)
CoachLocation.create(location_id: 3, coach_id:2)
CoachLocation.create(location_id: 3, coach_id:4)

Invite.create(client_id: 6, coach_activity_id:1)
Invite.create(client_id: 7, coach_activity_id:2)
Invite.create(client_id: 8, coach_activity_id:3)
Invite.create(client_id: 9, coach_activity_id:4)
Invite.create(client_id: 10, coach_activity_id:5)

seed_time = Faker::Time.between(5.days.ago, Date.today+20, :morning)
appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 1, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 2, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 1, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 2, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 1, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 2, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 1, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 2, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 1, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 2, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))

# 50.times do
#   appt = Appointment.new(coach_activity_id:rand(5)+1, child_id: rand(5)+1, location_id: rand(3)+1)
#   seed_time = Faker::Time.between(5.days.ago, Date.today+20, :morning)
#   appt.start = seed_time
#   appt.end = Faker::Time.between(seed_time, seed_time+1.hours, :morning)
#   appt.color = ["blue","green","yellow","orange"].sample
#   appt.save
# end
