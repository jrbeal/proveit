$(function() {
	$('.like').on("click", function (e) {
		var $tgt = $(e.target);
		var $parent = $($tgt.parent());
		var $status = $parent.attr("data-likes");

		$.ajax({
			url: '/currentprover.json?',
			type: 'GET',
			success: function (resp) {
				console.log("Got current prover.");
				id = resp.currentprover.id;
				$.ajax({
					url: '/like?' + $.param({"prover": id, "post": $parent.attr("data-post"), "likes": $status}),
					type: 'POST',
					success: function (resp) {
						console.log("Liked this post.");
						window.location.reload();
					}
				})
			}
		});

		return false;
	});
});
