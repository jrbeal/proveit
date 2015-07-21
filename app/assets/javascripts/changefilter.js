$(function() {
	$('#filteroptions').on("change", function (e) {
		var filterId = $('#filteroptions').val();
		console.log("Selecting filter.");
		$.ajax({
			url: '/changefilter?' + $.param({"filter_id": filterId}),
			type: 'POST',
			success: function (resp) {
				console.log("Selected this filter.");
				window.location.reload();
			}
		})
		return false;
	});
});
