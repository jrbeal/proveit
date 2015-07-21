$(function() {
	$('.unfollow').on("click", function (e) {
		var $tgt = $(e.target);
		$.ajax({
			url: '/currentprover.json?',
			type: 'GET',
			success: function (resp) {
				console.log("Got current prover.");
				id = resp.currentprover.id;
				$.ajax({
					url: '/follows?' + $.param({"owner": id, "follows": $tgt.attr("data-prover-id")}),
					type: 'DELETE',
					success: function (resp) {
						console.log("Unfollowing this prover.");
						window.location.reload();
					}
				})
				return false;
			}
		});
	});
});
