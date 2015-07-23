$(function() {
	$('.follow').on("click", function (e) {
		var $tgt = $(e.target);
		$.ajax({
			url: '/currentprover.json?',
			type: 'GET',
			success: function (resp) {
				console.log("Got current prover.");
				id = resp.currentprover.id;
				$.post('/follows', {owner: id, follows: $tgt.attr("data-prover-id") }, function (resp) {
					var follow = JSON.parse(resp);
					window.location.reload();
				});
			}
		});

		return false;
	});
});