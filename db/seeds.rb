# EVERYONE'S SEED DATA AREA EXCEPT IAN'S (IAN'S ARE AT THE BOTTOM OF THE FILE)

#PARENTS
# User.create!(first_name: "I", last_name: "Luc", email: ENV['IAN_EMAIL'], phone_number: ENV['IAN_PHONE'], password:"password")#1
# User.create(first_name: "Clar", last_name: "Bov", email: "clara@clara.com", phone_number: ENV['IAN_PHONE'], password:"password")#2
User.create(first_name: "Andr", last_name: "Palm", email: "andrew@andrew.com", password:"password")#3
User.create(first_name: "Breanne", last_name: "Bonnilla", email: "breanne@breanne.com", password:"password")#5

#COACHES
# User.create(first_name: "Rach", last_name: "Mun", email: "rachel@rachel.com", password:"password")#4

Child.create(first_name: "Romeo",last_name: "Lucia", age: 8, parent_id: 1)#1
Child.create(first_name: "Olivia",last_name: "Lucia", age: 8, parent_id: 1)#2
Child.create(first_name: "Stella", last_name: "Artois", age: 14, parent_id: 2)#3
Child.create(first_name: "Natalie", last_name: "Bhan", age: 17, parent_id:3)#4

Location.create(name: "Mira Mesa Rec", address: "1234 Mira Mesa Way");#1

Location.create(name: "Poway Rec", address: "5678 Poway Center Dr")#2
Location.create(name: "Escondido Rec", address: "91011 Poway Center Dr")#2

Activity.create(name: "Soccer")#1
Activity.create(name: "Ballet")#2
Activity.create(name: "Skateboarding")#3
Activity.create(name: "Gymnastics")#4
Activity.create(name: "Figure Skating")#5

# CoachActivity.create(coach_id: 3,activity_id: 1)


# Invite.create(client_id: 1, coach_activity_id:1)
# Invite.create(client_id: 2, coach_activity_id:1)

# CoachLocation.create(location_id: 1, coach_id:3)

# Invite.create(client_id: 1, coach_activity_id:1)
# Invite.create(client_id: 2, coach_activity_id:1)
# Invite.create(client_id: 3, coach_activity_id:5)

# seed_time = Faker::Time.between(5.days.ago, Date.today+20, :morning)
# # IAN'S APPTS
# appt = Appointment.create!(coach_activity_id: 1, child_id: 1, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 2, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 1, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 2, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 1, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 2, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 1, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 2, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 1, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 2, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))

# # CLARA'S APPTS
# appt = Appointment.create!(coach_activity_id: 1, child_id: 3, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 3, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 3, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 3, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 3, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))

# # ANDREW'S APPTS
# appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 4, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 4, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 4, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 4, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 4, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))

# # RACHELS'S APPTS
# appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 5, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 5, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 5, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 5, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 5, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))



































# # IAN SEED DATA

# #PARENTS
# User.create!(first_name: "I", last_name: "Luc", email: ENV['IAN_EMAIL'], phone_number: ENV['IAN_PHONE'], password:"password")#1
# User.create(first_name: "Clar", last_name: "Bov", email: "clara@clara.com", phone_number: ENV['IAN_PHONE'], password:"password")#2
# # User.create(first_name: "Andr", last_name: "Palm", email: "andrew@andrew.com", password:"password")#3
# # User.create(first_name: "Rach", last_name: "Mun", email: "rachel@rachel.com", password:"password")#4

# #COACHES
# User.create(first_name: "Breanne", last_name: "Bonnilla", email: "breanne@breanne.com", password:"password")#5

# Child.create(first_name: "Romeo",last_name: "Lucia", age: 8, parent_id: 1)#1
# Child.create(first_name: "Olivia",last_name: "Lucia", age: 8, parent_id: 1)#2
# Child.create(first_name: "Stella", last_name: "Artois", age: 14, parent_id: 2)#3
# # Child.create(first_name: "Natalie", last_name: "Bhan", age: 17, parent_id:3)#4
# # Child.create(first_name: "Sarah", last_name: "Jennikasinsmanov", age: 17, parent_id:4)#4

# Location.create(name: "Mira Mesa Rec", address: "1234 Mira Mesa Way");#1

# Activity.create(name: "Figure Skating")

# CoachActivity.create(coach_id: 3, activity_id: 1)

# CoachLocation.create(location_id: 1, coach_id:3)

# Invite.create(client_id: 1, coach_activity_id:1)
# Invite.create(client_id: 2, coach_activity_id:1)

# seed_time = Faker::Time.between(5.days.ago, Date.today+20, :morning)
# # IAN'S APPTS
# appt = Appointment.create!(coach_activity_id: 1, child_id: 1, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 2, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 1, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 2, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 1, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 2, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 1, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 2, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 1, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 2, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))

# # CLARA'S APPTS
# appt = Appointment.create!(coach_activity_id: 1, child_id: 3, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 3, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 3, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 3, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id: 1, child_id: 3, location_id: 1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))

# ANDREW'S APPTS
# appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 4, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 4, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 4, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 4, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 4, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))

# RACHELS'S APPTS
# appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 5, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 5, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 5, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 5, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
# appt = Appointment.create!(coach_activity_id:rand(5)+1, child_id: 5, location_id: rand(3)+1, start: Faker::Time.between(5.days.ago, Date.today+20, :morning), end: Faker::Time.between(seed_time, seed_time+1.hours, :morning))
