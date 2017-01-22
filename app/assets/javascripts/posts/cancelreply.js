$(function() {
	$('#cancelreply').on("click", function () {
		$('#postreply').hide();
		$('#kids').show();

		var $postid = $('#parentpost').val();

		// Unlocking the post -- so other users can edit and respond to it
		$.ajax({
			url: '/unlockpost?' + $.param({"id": $postid}),
			type: 'POST',
			success: function () {
				console.log("Post " + $postid + " is now unlocked.")
			}
		})
	});
});
