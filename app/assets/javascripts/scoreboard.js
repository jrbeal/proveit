$(function() {
	reloadScoreboard();

	function reloadScoreboard() {
		setTimeout(reloadScoreboard,10000);

		$.get('/scoreboard', function(data) {
			$('#scoreboard').html(data);
		});
	}
});