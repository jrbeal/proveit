$(function() {
	var selectedNames1 = [];
	var selectedNames2 = [];

	var node = document.getElementById('team1members');
	user = node.textContent.trim();
	selectedNames1.push(user);

	$('#teams').on("click", function (e) {
		var $tgt = $(e.target);
		if ($tgt.prop("checked")) {
			$('#postteam1').show();
			$('#postteam2').show();
			$('#postteam1heading1').hide();
			if ($('#type_opinion').is(':checked')) {
				$('#postteam1heading2').show();
				$('#postteam1heading3').hide();
				$('#postteam2heading2').show();
				$('#postteam2heading3').hide();
			} else if ($('#type_initiator').is(':checked')) {
				$('#postteam1heading2').hide();
				$('#postteam1heading3').show();
				$('#postteam2heading2').hide();
				$('#postteam2heading3').show();
			}
		} else {
			$('#postteam1').show();
			$('#postteam2').hide();
			$('#postteam1heading1').show();
			$('#postteam1heading2').hide();
			$('#postteam1heading3').hide();
			$('#postteam2heading2').hide();
			$('#postteam2heading3').hide();
		}
	});

	$('#team2members').hide();
});