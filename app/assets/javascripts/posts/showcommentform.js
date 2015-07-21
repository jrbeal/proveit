$(function() {
	$('#type_comment').on("click", function () {
		$(".submit_text.message_text").text("Comment:");
		$(".submit_text.support_text").text("Support (Optional): ");
		document.getElementsByClassName('message message_placeholder')[0].placeholder = 'Enter casual comment here.';
		document.getElementsByClassName('message support_placeholder')[0].placeholder = 'Enter additional information here.';
		$('#private').hide();
		$('#postteam2').hide();
		if ($('#format_public').is(':checked')) {
			$('#public').show();
			$('#postteam1').hide();
		} else {
			$('#postteam1').show();
			$('#postteam1heading1').show();
			$('#postteam1heading2').hide();
			$('#postteam1heading3').hide();
		}
	});
});
