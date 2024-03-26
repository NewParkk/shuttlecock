/*//캘린더
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
      initialView: 'dayGridMonth',
      locale: 'ko',
      dayCellContent: function(arg) {
          return arg.dayNumberText.replace("일", "");
      },
      headerToolbar: {
          left: 'prev',
          center: 'title',
          right: 'next'
      },
      fixedWeekCount: false,
      events: [
          <c:forEach items="${events}" var="event">
              {
            	  title: '${event.region}',
                  start: '${event.start}',
                  end: '${event.end}',
                  backgroundColor: '${event.backgroundColor}',
                  textColor: '#333',
                  borderColor: 'transparent',
                  url: '/getGame'
              },
          </c:forEach>
      ]
	});
   calendar.render();
});*/