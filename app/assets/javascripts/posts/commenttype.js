$(function() {
	$('input[name="commenttype"]').on('click', function (e) {
		console.log("Selecting comment type...");
		var $tgt = $(e.target);
		if ($tgt.val() == "manual") {
			$('#commentfallacy').hide();
			$('#commentopinion').val("");
			$('#commentsupport').val("");
			$('#commenturl').val("");
		} else if ($tgt.val() == "fallacy") {
			$('#commentfallacy').show();
			$('#commentopinion').val("");
			$('#commentsupport').val("");
			$('#commenturl').val("");
		} else if ($tgt.val() == "mediationrequest") {
			$('#commentfallacy').hide();
			$('#commentopinion').val("Requesting mediation.");
			$('#commentsupport').val("Describe impasse here.");
			$('#commenturl').val("");
		}
	});
});
