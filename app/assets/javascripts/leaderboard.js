$(function() {
	reloadLeaderboard();

	function reloadLeaderboard() {
		setTimeout(reloadLeaderboard,10000);

		$.get('/leaderboard', function(data) {
			$('#leaderboard').html(data);
		});
	}
});