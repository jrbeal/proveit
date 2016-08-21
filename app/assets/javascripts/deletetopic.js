$(function() {
	$('.deletetopic').on("click", function (e) {
		var $tgt = $(e.target);
		var $parent = $($tgt.parent());

		$.ajax({
			url: '/topics/' + $parent.attr("data-topic") + ".json",
			type: 'DELETE',
			success: function(resp) {
				console.log("Deleted this topic.");
				window.location.reload();
			}
		})
		return false;
	});
});