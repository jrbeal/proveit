$(function() {
	$('.deletetopic').on("click", function (e) {
		var $tgt = $(e.target);
		var $parent = $($tgt.parent());
		console.log("Deleting topic.");

		$.ajax({
			url: '/topics/' + $parent.attr("data-topic") + ".json",
			type: 'DELETE',
			success: function (resp) {
				console.log("Deleted topic.");
				window.location.reload();
			}
		})
		return false;
	});
});