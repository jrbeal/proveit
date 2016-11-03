$(function() {
	$('input[name="objectiontype"]').on('click', function (e) {
		console.log("Selecting objection type...");
		var $tgt = $(e.target);
		if ($tgt.val() == "manual") {
			$('#templates').hide();
			$('#objectionopinion').val("");
			$('#objectionsupport').val("");
			$('#objectionurl').val("");
		} else if ($tgt.val() == "fallacy") {
			$('#templates').show();
			$('#objectionopinion').val("");
			$('#objectionsupport').val("");
			$('#objectionurl').val("");
		} else if ($tgt.val() == "mediationrequest") {
			$('#templates').hide();
			$('#objectionopinion').val("Requesting mediation.");
			$('#objectionsupport').val("Describe impasse here.");
			$('#objectionurl').val("");
		}
	});
});
