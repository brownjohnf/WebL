$(document).ready(function(){
  $("#datetimepicker").datetimepicker({
		dateFormat: 'yy-mm-dd',
		timeFormat: 'hh:mm:ss',
		stepMinute: 5,
		minuteGrid: 10,
		minDate: 0
	});
});
