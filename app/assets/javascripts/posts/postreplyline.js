$(function() {
	// Need to know what the featured node is...
	var postKind = $('.post').attr('data_post_kind');
	var defaultkidtype;

	$.ajax({
		url: '/currentprover.json?',
		type: 'GET',
		success: function (resp) {
			defaultkidtype = resp.currentprover.kidtype;

			console.log("Default kidtype = " + defaultkidtype);
			console.log("You're viewing a " + postKind);

			switch (postKind) {
				case 'comment':
					// If the featured post is a comment, ignore the default kidtype...
					$('input[name="kidtype"][value="comment"]').click();
					break;
				case 'opinion':
				case 'initiator':
					$('input[name="kidtype"][value="' + defaultkidtype + '"]').click();
					break;
				default:
					console.log("Invalid post kind.");
			}

			// Now display the "kids" according to the prover's offspring style.
			switch (resp.currentprover.offspring_style) {
				case 'collapsed':
					$('#expand').show();
					$('#collapse').hide();
					break;
				case 'expanded':
					$('#expand').hide();
					$('#collapse').show();
					break;
				default:
					console.log("Invalid offspring style.");
			}
		}
	});

	$('input[name="kidtype"]').click(doStuff);

	function doStuff(e) {
		var $tgt = $(e.target);
		var $commentrepliable = $tgt.attr("data-commentrepliable");
		var $opinionrepliable = $tgt.attr("data-opinionrepliable");
		console.log("Comment repliable = " + $commentrepliable);
		console.log("Opinion repliable = " + $opinionrepliable);
		switch ($tgt.val()) {
			case 'comment':
				console.log("kidtype = comment here");
				$('.opinion').hide();
				$('.comment').show();

				if ($commentrepliable == "true") {
					console.log("commentreliable is true, showing createkid on a comment");
					$('#createkid').show();
				} else {
					console.log("commentreliable is false, hiding createkid on a comment");
					$('#createkid').hide();
				}
				break;
			case 'initiator':
				console.log("kidtype = initiator here");
				$('.opinion').show();
				$('.comment').hide();

				if ($opinionrepliable == "true") {
					console.log("opinionreliable is true, showing createkid on an initiator");
					$('#createkid').show();
				} else {
					console.log("opinionreliable is false, hiding createkid on an initiator");
					$('#createkid').hide();
				}
				break;
			default:
				console.log("Clicking unknown kidtype: " + $tgt.val());
			case 'opinion':
				console.log("kidtype = opinion here");
				$('.opinion').show();
				$('.comment').hide();

				if ($opinionrepliable == "true") {
					console.log("opinionreliable is true, showing createkid on an opinion");
					$('#createkid').show();
				} else {
					console.log("opinionreliable is true, hiding createkid on an opinion");
					$('#createkid').hide();
				}
				break;
		}

		// If the featured post is NOT a comment, go ahead and set the default kidtype. Otherwise, leave it alone.
		if (postKind != "comment") {
			$.ajax({
				url: '/kidtype?' + $.param({"kidtype": $tgt.val()}),
				type: 'POST',
				success: function () {
					console.log("Kidtype default is now set to " + $tgt.val())
				}
			})
		}
	}

	$('#createkid').on("click", function (e) {
		$('#kids').hide();
		var $tgt = $(e.target);
		switch ($tgt.attr("data-kind")) {
			case 'initiator':
				if ($('#kidtype_comment').is(':checked')) {
					$('#commentreply').show();
				} else {
					$('#initiatorreply').show();
				}
			break;
			case 'comment':
				$('#commentreply').show();
			break;
			default:
			case 'opinion':
				if ($('#kidtype_comment').is(':checked')) {
					$('#commentreply').show();
				} else {
					$('#opinionreply').show();
				}
			break;
		}
	});
});
