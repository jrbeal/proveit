$(function() {
	$('#type_initiator').on("click", function () {
		$(".submit_text.message_text").text("Initiator:");
		$(".submit_text.support_text").text("Support (Optional):");
		document.getElementsByClassName('message message_placeholder')[0].placeholder = 'Enter thought provoking question, comment, quote or directive here. Be as concise as possible.';
		document.getElementsByClassName('message support_placeholder')[0].placeholder = 'Enter additional clarification and supporting information here.';
		if ($('#format_public').is(':checked')) {
			$('#public').hide();
			$('#private').hide();
			$('#postteam1').hide();
			$('#postteam2').hide();
		} else {
			$('#public').hide();
			$('#private').show();
			$('#postteam1').show();
			$('#postteam1heading2').hide();
			$('#postteam2heading2').hide();
			if ($('#use_teams').is(':checked')) {
				$('#postteam2').show();
				$('#postteam1heading3').show();
				$('#postteam2heading3').show();
				$('#postteam1heading1').hide();
			} else {
				$('#postteam1heading1').show();
				$('#postteam1heading3').hide();
				$('#postteam2heading3').hide();
			}
		}
	});
});
