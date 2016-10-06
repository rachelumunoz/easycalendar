function formatDate(moment_obj) {
  return moment_obj.format("YYYY-MM-DD") + 'T' + moment_obj.format("HH:mm");
}

var initialize_calendar;
initialize_calendar = function() {
  console.log("enter initialize calendar");
  $('.calendar').each(function(){
    var calendar = $(this);
    calendar.fullCalendar({
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
      },
      selectable: true,
      selectHelper: true,
      editable: true,
      eventLimit: true,
      //events: '/appointments.json',
      events: '/users/events-appts.json',

      select: function(start, end) {
        $.getScript('/appointments/new', function() {
          var end_date = start.clone();
          console.log(start)
          console.log(end)
          start_date_str = formatDate(start);
          end_date_str = formatDate(end_date);
          $('#appointment_start').val(start_date_str);
          $('#appointment_end').val(end_date_str);
        });

        calendar.fullCalendar('unselect');
      },

      // eventDrop: function(event, delta, revertFunc) {
      //   console.log("about to drop an event")
      //   event_data = {
      //     event: {
      //       id: event.id,
      //       start: event.start,
      //       end: event.end
      //     }
      //   };
      //   $.ajax({
      //       url: event.update_url,
      //       data: event_data,
      //       type: 'PATCH'
      //   });
      // },

      eventClick: function(event, jsEvent, view) {
        $.getScript(event.edit_url, function() {});
      }
    });
  })
};
$(document).on('turbolinks:load', initialize_calendar);



