event = Google::Apis::CalendarV3::Event.new(
  {
    summary: 'Google I/O 2015',
    location: '800 Howard St., San Francisco, CA 94103',
    description: 'A chance to hear more about Google\'s developer products.',
    start: {
      date_time: '2015-05-28T09:00:00-07:00',
      time_zone: 'America/Los_Angeles',
    },
    end: {
      date_time: '2015-05-28T17:00:00-07:00',
      time_zone: 'America/Los_Angeles',
    },
    recurrence: [
      'RRULE:FREQ=DAILY;COUNT=2'
    ],
    attendees: [
      {email: 'lpage@example.com'},
      {email: 'sbrin@example.com'},
    ]
  })
