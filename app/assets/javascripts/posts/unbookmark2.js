$(function() {
	$('.unbookmark2').on("click", function (e) {
		var Id = $('#bookmark_dropdown').val();
		console.log(Id);
		$.ajax({
			url: '/bookmarks?' + $.param({"id": Id}),
			type: 'DELETE',
			success: function() {
				console.log("Removing this bookmark.");
				window.location.reload();
			}
		});
		return false;
	});
});
