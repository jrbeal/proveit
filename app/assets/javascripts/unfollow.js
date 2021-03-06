$(function() {
	$('.unfollow').on("click", function (e) {
		var $tgt = $(e.target);
		$.ajax({
			url: '/currentprover.json?',
			type: 'GET',
			success: function (resp) {
				console.log("Got current prover.");
				owner = resp.currentprover.id;

				if($tgt.attr("data-prover-id") !== undefined) {
					Id = $tgt.attr("data-prover-id");
				} else {
					Id = $('#following_dropdown').val();
				}

				$.ajax({
					url: '/follows?' + $.param({"owner": owner, "follows": Id}),
					type: 'DELETE',
					success: function (resp) {
						console.log("Unfollowing this prover.");
						window.location.reload();
					}
				})
			}
		});

		return false;
	});
});
