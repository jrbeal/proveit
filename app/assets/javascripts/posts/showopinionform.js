$(function() {
	$('#type_opinion').on("click", function () {
		$(".submit_text.message_text").text("In my opinion:");
		$(".submit_text.support_text").text("Support (Optional):");
		document.getElementsByClassName('message message_placeholder')[0].placeholder = 'Enter opinion here. Be as concise as possible.';
		document.getElementsByClassName('message support_placeholder')[0].placeholder = 'Enter additional rationale, clarification and supporting information here.';
		if ($('#format_public').is(':checked')) {
			$('#public').show();
			$('#private').hide();
			$('#postteam1').hide();
			$('#postteam2').hide();
		} else {
			$('#public').hide();
			$('#private').show();
			$('#postteam1').show();
			$('#postteam1heading3').hide();
			$('#postteam2heading3').hide();
			if ($('#use_teams').is(':checked')) {
				$('#postteam2').show();
				$('#postteam1heading1').hide();
				$('#postteam1heading2').show();
				$('#postteam2heading2').show();
			} else {
				$('#postteam1heading1').show();
				$('#postteam1heading2').hide();
				$('#postteam2heading2').hide();
			}
		}
	});
});
