$(function() {
	$('#format_private').on("click", function () {
		if ($('#lone_wolf').is(':checked')) {
			$('input[name="lone_wolf"][value="lone_wolf"]').click();
		}

		$('#postteam1').show();

		if ($('#type_opinion').is(':checked')) {
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
		} else if ($('#type_initiator').is(':checked')) {
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
		} else {
			$('#public').hide();
			$('#private').hide();
			$('#postteam1').show();
			$('#postteam1heading1').show();
			$('#postteam1heading2').hide();
			$('#postteam1heading3').hide();
		}
	});
});