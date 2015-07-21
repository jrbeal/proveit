$(function() {
	$('.deletepost').on("click", function (e) {
		var $tgt = $(e.target);
		console.log("Deleting post");
		var $parent = $($tgt.parent());
		$.ajax({
			url: '/posts/' + $parent.attr("data-post"),
			type: 'DELETE',
			success: function (resp) {
				console.log("Deleted this post.");
				window.location.reload();
			}
		})
		return false;
	});
});
