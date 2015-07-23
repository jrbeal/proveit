$(function() {
	$('.like').on("click", function (e) {
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
