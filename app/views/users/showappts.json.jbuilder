json.array! @user.appointments do |appointment|
  appointment.set_color
  date_format = appointment.all_day_event? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'
  json.id appointment.id
  json.start appointment.start.strftime(date_format)
  json.end appointment.end.strftime(date_format)
  json.color appointment.color unless appointment.color.blank?
  json.allDay appointment.all_day_event? ? true : false
  json.update_url appointment_path(appointment, method: :patch)
  json.edit_url edit_appointment_path(appointment)
end
