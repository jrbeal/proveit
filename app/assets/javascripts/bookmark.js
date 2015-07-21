$(function() {
	$('.bookmark').on("click", function (e) {
		var $tgt = $(e.target);
		$.ajax({
			url: '/currentprover.json?',
			type: 'GET',
			success: function (resp) {
				console.log("Got current prover.");
				id = resp.currentprover.id;
				$.post('/bookmarks', {owner: id, post: $tgt.attr("data-post") }, function () {
					console.log("Bookmarking this post.");
					window.location.reload();
				});
				return false;
			}
		});
	});
});
