$(function() {
	$('#format_public').on("click", function () {
		$('#postteam1').hide();
		$('#postteam2').hide();

		if ($('#type_opinion').is(':checked')) {
			$('#public').show();
			$('#private').hide();
		} else if ($('#type_initiator').is(':checked')) {
			$('#public').hide();
			$('#private').hide();
		} else {
			$('#public').show();
			$('#private').hide();
		}
	});

	$('#publicviewing').on("click", function(e) {
		var $tgt = $(e.target);
		if($tgt.prop("checked")) {
			$('#pubcomments').show();
		} else {
			$('#pubcomments').hide();
		}
	});

	$('input[name="format"][value="public"]').click();

	$('#pubcomments').hide();
});
