$(function() {
	$('input[name="objectiontype"]').on('click', function (e) {
		console.log("Selecting objection type...");
		var $tgt = $(e.target);
		if ($tgt.val() == "manual") {
			$('#objectionfallacy').hide();
		} else if ($tgt.val() == "fallacy") {
			$('#objectionfallacy').show();
		} else if ($tgt.val() == "inconclusive") {
			$('#objectionfallacy').hide();
		} else if ($tgt.val() == "ambiguous") {
			$('#objectionfallacy').hide();
		} else if ($tgt.val() == "irrelevant") {
			$('#objectionfallacy').hide();
		} else if ($tgt.val() == "duplicate") {
			$('#objectionfallacy').hide();
		} else if ($tgt.val() == "mediationrequest") {
			$('#objectionfallacy').hide();
		}
		$('#objectionopinion').val("");
		$('#objectionsupport').val("");
		$('#objectionurl').val("");
	});
});
