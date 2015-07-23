$(function() {
	$('.unfollowedby').on("click", function (e) {
		var $tgt = $(e.target);
		$.ajax({
			url: '/currentprover.json?',
			type: 'GET',
			success: function (resp) {
				console.log("Got current prover.");
				owner = resp.currentprover.id;

				if ($tgt.attr("data-prover-id") !== undefined) {
					Id = $tgt.attr("data-prover-id");
				} else {
					Id = $('#followers_dropdown').val();
				}

				$.ajax({
					url: '/follows?' + $.param({"owner": Id, "follows": owner}),
					type: 'DELETE',
					success: function () {
						console.log("Removing this follower.");
						window.location.reload();
					}
				});
			}
		});

		return false;
	});
});

