$(function() {
	$('.unlike').on("click", function (e) {
		var $tgt = $(e.target);
		var $parent = $($tgt.parent());
		$.ajax({
			url: '/currentprover.json?',
			type: 'GET',
			success: function (resp) {
				console.log("Got current prover.");
				id = resp.currentprover.id;
				$.ajax({
					url: '/likes?' + $.param({"prover": id, "post": $parent.attr("data-post")}),
					type: 'DELETE',
					success: function (resp) {
						console.log("Unliked this post.");
						window.location.reload();
					}
				})
			}
		});

		return false;
	});
});
