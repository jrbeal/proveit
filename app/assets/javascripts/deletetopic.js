$(function() {
	$('.deletetopic').on("click", function (e) {
		var $tgt = $(e.target);
		console.log ("Deleting topic");
		var $parent = $($tgt.parent());
		$.ajax({
			url: '/topics/' + $parent.attr("data-topic"),
			type: 'DELETE',
			success: function(resp) {
				console.log("Deleted this topic.");
				window.location.reload();
			}
		})
		return false;
	});
});
