$(function() {
	$('.deletepost').on("click", function (e) {
		var $tgt = $(e.target);
		var $parent = $($tgt.parent());
		console.log("Deleting post.");

		$.ajax({
			url: '/posts/' + $parent.attr("data-post") + ".json",
			type: 'DELETE',
			success: function (resp) {
				window.location.reload();
			}
		})
		return false;
	});
});