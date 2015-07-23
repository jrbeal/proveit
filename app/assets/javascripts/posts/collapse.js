$(function () {
	$('#collapse').on("click", function () {
		$.ajax({
			url: '/toggleoffspringsetting',
			type: 'POST',
			success: function (resp) {
				console.log("Collapsing offspring.");
				window.location.reload();
			}
		})
		$('#expand').show();
		$('#collapse').hide();

		return false;
	});
});
