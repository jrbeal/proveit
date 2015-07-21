$(function() {
	$('input[name="initiatortype"]').on('click', function (e) {
		console.log("Selecting opinion type...");
		var $tgt = $(e.target);
		if ($tgt.val() == "manual") {
			console.log("Opinion type = Manual");
			$('#initiatorfallacy').hide();
		} else if ($tgt.val() == "fallacy") {
			console.log("Opinion type = Fallacy");
			$('#initiatorfallacy').show();
		}
		$('#initiatoropinion').val("");
		$('#initiatorsupport').val("");
		$('#initiatorurl').val("");
	});
});
