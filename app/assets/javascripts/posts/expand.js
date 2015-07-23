$(function () {
	$('#expand').on("click", function () {
		$.ajax({
			url: '/toggleoffspringsetting',
			type: 'POST',
			success: function (resp) {
				console.log("Expanding offspring.");
				window.location.reload();
			}
		})
		$('#expand').hide();
		$('#collapse').show();

		return false;
	});
});
