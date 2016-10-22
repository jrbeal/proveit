$(function() {
	$('input[name="objectiontype"]').on('click', function (e) {
		console.log("Selecting objection type...");
		var $tgt = $(e.target);
		if ($tgt.val() == "manual") {
			$('#objectionfallacy').hide();
			$('#objectionopinion').val("");
			$('#objectionsupport').val("");
			$('#objectionurl').val("");
		} else if ($tgt.val() == "fallacy") {
			$('#objectionfallacy').show();
			$('#objectionopinion').val("");
			$('#objectionsupport').val("");
			$('#objectionurl').val("");
		} else if ($tgt.val() == "mediationrequest") {
			$('#objectionfallacy').hide();
			$('#objectionopinion').val("Requesting mediation.");
			$('#objectionsupport').val("Describe impass here.");
			$('#objectionurl').val("");
		}
	});
});
