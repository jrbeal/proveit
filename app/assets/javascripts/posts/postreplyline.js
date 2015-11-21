$(function() {
	$.ajax({
		url: '/currentprover.json?',
		type: 'GET',
		success: function (resp) {
			console.log("Got prover for setting kidtype (" + resp.currentprover.kidtype + ") and offspring style (" + resp.currentprover.offspring_style + ").");
			$('input[name="kidtype"][value="' + resp.currentprover.kidtype + '"]').click();
			switch (resp.currentprover.offspring_style) {
				case 'collapsed':
					$('#expand').show();
					$('#collapse').hide();
				break;
				default:
					console.log("Invalid offspring style.");
				case 'expanded':
					$('#expand').hide();
					$('#collapse').show();
				break;
			}

			$.ajax({
				url: '/kidtype?' + $.param({"kidtype": resp.currentprover.kidtype}),
				type: 'POST',
				success: function () {
					console.log("Kidtype default is reset to " + resp.currentprover.kidtype)
				}
			})
		}
	});

	$('input[name="kidtype"]').click(function (e) {
		var $tgt = $(e.target);
		var $commentrepliable = $tgt.attr("data-commentrepliable");
		var $opinionrepliable = $tgt.attr("data-opinionrepliable");
		console.log("Comment repliable = " + $commentrepliable);
		console.log("Opinion repliable = " + $opinionrepliable);
		switch ($tgt.val()) {
			case 'comment':
				console.log("kidtype = comment");
				$('.opinion').hide();
				$('.comment').show();

				if ($commentrepliable == "true") {
					$('#createkid').show();
				} else {
					$('#createkid').hide();
				}
			break;
			case 'initiator':
				console.log("kidtype = initiator");
				$('.opinion').show();
				$('.comment').hide();

				if ($opinionrepliable == "true") {
					$('#createkid').show();
				} else {
					$('#createkid').hide();
				}
			break;
			default:
				console.log("Clicking unknown kidtype: " + $tgt.val());
			case 'opinion':
				console.log("kidtype = opinion");
				$('.opinion').show();
				$('.comment').hide();

				if ($opinionrepliable == "true") {
					$('#createkid').show();
				} else {
					$('#createkid').hide();
				}
			break;
		}

		$.ajax({
			url: '/kidtype?' + $.param({"kidtype": $tgt.val()}),
			type: 'POST',
			success: function () {
				console.log("Kidtype default is now set to " + $tgt.val())
			}
		})
	});

	$('#createkid').on("click", function (e) {
		$('#kids').hide();
		var $tgt = $(e.target);
		switch ($tgt.attr("data-kind")) {
			case 'initiator':
				console.log("initiator!");
				if ($('#kidtype_comment').is(':checked')) {
					$('#commentreply').show();
				} else {
					$('#initiatorreply').show();
				}
			break;
			case 'comment':
				console.log("comment!");
				$('#commentreply').show();
			break;
			default:
				console.log("Unknown post type");
			case 'opinion':
				console.log("opinion!");
				if ($('#kidtype_comment').is(':checked')) {
					$('#commentreply').show();
				} else {
					$('#opinionreply').show();
				}
			break;
		}
	});
});
