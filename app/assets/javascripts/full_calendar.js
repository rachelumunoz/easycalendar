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
        // console.log("about to $.getScript of appointments new")
        $.getScript('/appointments/new', function() {});

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



