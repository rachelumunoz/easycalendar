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

      // eventSave: function(event, delta, revertFunc) {
      //   event_data = {
      //     event: {
      //       coach_activity_id: event.coach_activity_id,
      //       child_id: event.child_id,
      //       location_id: event.location_id,
      //       start: event.start.format(),
      //       end: event.end.format()
      //     }
      //   };
      //   $.ajax({
      //       url: event.create_url,
      //       data: event_data,
      //       type: 'PUT'
      //   });
      // }

//       eventDrop: function(event, delta, revertFunc) {
//         console.log("about to drop an event")
//         event_data = {
//           event: {
//             id: event.id,
//             start: event.start.format(),
//             end: event.end.format()
//           }
//         };
//         $.ajax({
//             url: event.update_url,
//             data: event_data,
//             type: 'PATCH'
//         });
//       },

      eventClick: function(event, jsEvent, view) {
        $.getScript(event.edit_url, function() {});
      }
    });
  })
};
$(document).on('turbolinks:load', initialize_calendar);



