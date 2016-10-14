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
		} else if ($tgt.val() == "inconclusive") {
			$('#objectionfallacy').hide();
			$('#objectionopinion').val("This objection fails to draw a conclusion.");
			$('#objectionsupport').val("");
			$('#objectionurl').val("");
		} else if ($tgt.val() == "ambiguous") {
			$('#objectionfallacy').hide();
			$('#objectionopinion').val("This objection is unclear.");
			$('#objectionsupport').val("");
			$('#objectionurl').val("");
		} else if ($tgt.val() == "irrelevant") {
			$('#objectionfallacy').hide();
			$('#objectionopinion').val("This objection misses the point.");
			$('#objectionsupport').val("");
			$('#objectionurl').val("");
		} else if ($tgt.val() == "duplicate") {
			$('#objectionfallacy').hide();
			$('#objectionopinion').val("This objection already exists");
			$('#objectionsupport').val("");
			$('#objectionurl').val("");
		} else if ($tgt.val() == "unsubstantiated") {
			$('#objectionfallacy').hide();
			$('#objectionopinion').val("This objection lacks rationale or evidence.");
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
