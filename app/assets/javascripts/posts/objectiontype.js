$(function() {
	$('input[name="objectiontype"]').on('click', function (e) {
		console.log("Selecting objection type...");
		var $tgt = $(e.target);
		if ($tgt.val() == "manual") {
			$('#templates').hide();
			$('#message').val("");
			$('#support').val("");
			$('#url').val("");
		} else if ($tgt.val() == "fallacy") {
			$('#templates').show();
			$('#message').val("");
			$('#support').val("");
			$('#url').val("");
		} else if ($tgt.val() == "mediationrequest") {
			$('#templates').hide();
			$('#message').val("Requesting mediation.");
			$('#support').val("Describe impasse here. Note that this will simply post a request for mediation. Future improvements will include notifications to actual mediators.");
			$('#url').val("");
		}
	});
});
