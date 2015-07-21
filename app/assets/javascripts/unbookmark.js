$(function() {
	$('.unbookmark1').on("click", function (e) {
		var $tgt = $(e.target);
		$.ajax({
			url: '/currentprover.json?',
			type: 'GET',
			success: function (resp) {
				console.log("Got current prover.");
				id = resp.currentprover.id;
				$.ajax({
					url: '/bookmarks?' + $.param({"owner": id, "post": $tgt.attr("data-post")}),
					type: 'DELETE',
					success: function () {
						console.log("Removing this bookmark.");
						window.location.reload();
					}
				})
				return false;
			}
		});
	});
});
