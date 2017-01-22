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
		var $postid = $tgt.attr("data-id");

		// Locking the post -- so other users can't edit it respond to it (until it's unlocked)
		$.ajax({
			url: '/lockpost?' + $.param({"id": $postid}),
			type: 'POST',
			success: function () {
				console.log("Post " + $postid + " is now locked.")
			}
		})

		switch ($tgt.attr("data-kind")) {
			case 'initiator':
				$('#message').val("");
				$('#support').val("");
				$('#url').val("");
				if ($('#kidtype_comment').is(':checked')) {
					$('#objectiontypelabel').text("Comment Type:");
					if ($('#objectiontype_fallacy').is(':checked')) {
						$('#templates').show();
					} else {
						$('#templates').hide();
					}
					$('#objectiontypeline').show();
					$('#replymessagelabel').text("Comment:");
					$('#message').attr('placeholder', "Enter comment here.");
					$('#replysupportlabel').text("Supplemental (Optional):");
					$('#support').attr('placeholder', "Enter additional comments here.");
					$('#replyurllabel').text("URL (Optional):");
					$('#url').attr('placeholder', "Enter related link here.");
					$('#kind').val('comment')
				} else {
					$('#objectiontypeline').hide();
					$('#replymessagelabel').text("In my opinion:");
					$('#message').attr('placeholder', "Enter opinion here. Be as concise as possible");
					$('#replysupportlabel').text("Justification:");
					$('#support').attr('placeholder', "For an opinion to be true, it must be supported by valid justification.");
					$('#replyurllabel').text("URL (Optional):");
					$('#url').attr('placeholder', "Enter related link here.");
					$('#kind').val('opinion')
				}
				break;
			case 'comment':
				$('#objectiontypelabel').text("Comment Type:");
				if ($('#objectiontype_fallacy').is(':checked')) {
					$('#templates').show();
				} else {
					$('#templates').hide();
				}
				$('#objectiontypeline').show();
				$('#replymessagelabel').text("Comment:");
				$('#message').val("");
				$('#message').attr('placeholder', "Enter comment here.");
				$('#replysupportlabel').text("Supplemental (Optional):");
				$('#support').val("");
				$('#support').attr('placeholder', "Enter additional comments here.");
				$('#replyurllabel').text("URL (Optional):");
				$('#url').val("");
				$('#url').attr('placeholder', "Enter related link here.");
				$('#kind').val('comment')
				break;
			default:
			case 'opinion':
				$('#message').val("");
				$('#support').val("");
				$('#url').val("");
				if ($('#kidtype_comment').is(':checked')) {
					$('#objectiontypelabel').text("Comment Type:");
					$('#replymessagelabel').text("Comment:");
					$('#message').attr('placeholder', "Enter comment here.");
					$('#replysupportlabel').text("Supplemental (Optional):");
					$('#support').attr('placeholder', "Enter additional comments here.");
					$('#replyurllabel').text("URL (Optional):");
					$('#url').attr('placeholder', "Enter related link here.");
					$('#kind').val('comment')
				} else {
					$('#objectiontypelabel').text("Objection Type:");
					$('#replymessagelabel').text("In my opinion:");
					$('#message').attr('placeholder', "Enter objection here. Be as concise as possible");
					$('#replysupportlabel').text("Justification:");
					$('#support').attr('placeholder', "For an opinion to be true, it must be supported by valid justification.");
					$('#replyurllabel').text("URL (Optional):");
					$('#url').attr('placeholder', "Enter related link here.");
					$('#kind').val('opinion')
				}
				if ($('#objectiontype_fallacy').is(':checked')) {
					$('#templates').show();
				} else {
					$('#templates').hide();
				}
				$('#objectiontypeline').show();
				break;
		}
		$('#replyoredit').val('reply');
		$('#postreply').show();
	});

	$('#editpost').on("click", function (e) {
		$('#kids').hide();
		var $tgt = $(e.target);
		var $postid = $tgt.attr("data-id");
		var $postkind = $tgt.attr("data-kind");

		// Locking the post -- so other users can't edit or respond to it (until it's unlocked)
		$.ajax({
			url: '/lockpost?' + $.param({"id": $postid}),
			type: 'POST',
			success: function () {
				console.log("Post " + $postid + " is now locked.")
			}
		})

		$('#templates').hide();
		$('#objectiontypeline').hide();

		$.ajax({
			url: '/posts/' + $postid + '/edit' + '.json?' + $.param({"id": $postid}),
			type: 'GET',
			success: function (resp) {

				var $message = resp.message;
				var $support = resp.support;
				var $url = resp.url;
				console.log("Post requested is " + $postid + " with message '" + $message + "'");

				switch ($postkind) {
					case 'initiator':
						$('#replymessagelabel').text("Initiator:");
						$('#message').attr('placeholder', "Enter thought provoking question, comment, quote or directive here. Be as concise as possible.");
						$('#message').val($message);
						$('#replysupportlabel').text("Supplemental (Optional):");
						$('#support').attr('placeholder', "Enter additional comments here.");
						$('#support').val($support);
						$('#replyurllabel').text("URL (Optional):");
						$('#url').val($url);
						$('#kind').val('initiator')
						break;
					case 'comment':
						$('#replymessagelabel').text("Comment:");
						$('#message').attr('placeholder', "Enter comment here.");
						$('#message').val($message);
						$('#replysupportlabel').text("Supplemental (Optional):");
						$('#support').attr('placeholder', "Enter additional comments here.");
						$('#support').val($support);
						$('#replyurllabel').text("URL (Optional):");
						$('#url').val($url);
						$('#kind').val('comment')
						break;
					case 'opinion':
					default:
						$('#replymessagelabel').text("In my opinion:");
						$('#message').val($message);
						$('#replysupportlabel').text("Justification:");
						$('#support').val($support);
						$('#replyurllabel').text("URL (Optional):");
						$('#url').val($url);
						$('#kind').val('opinion')
						break;
				}

				$('#replyoredit').val('edit');
				$('#postreply').show();
			}
		});
	});
});
