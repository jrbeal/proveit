var currentProver = '<%= current_prover.id %>';

function postReady() {

	var selectedNames1 = [];
	var selectedNames2 = [];

	var node = document.getElementById('team1members');
	user = node.textContent.trim();
	selectedNames1.push(user);

	$('#team2members').hide();

	$("#provers_dropdown1").change(function(e) {
		var id = $("#provers_dropdown1").val();

		if(id == -1) {
			return false;
		}

		var name = $("#provers_dropdown1 option[value=" + id + "]").text();
		console.log(name);

		if (jQuery.inArray(name, selectedNames1) > -1) {
			if (selectedNames1.length == 0) {
				$('#team1members').hide();
			}
			alert(name + " is already on this team");
		} else if (jQuery.inArray(name, selectedNames2) > -1) {
			if (selectedNames2.length == 0) {
				$('#team1members').hide();
			}
			alert(name + " is already on the other team");
		}	else {
			selectedNames1.push(name);
			$("#team1members").append("<br>" + name);
			$("#team1").val($("#team1").val() + " " + id);
			$('#team1members').show();
		}
		console.info(selectedNames1)
	});

	$("#provers_dropdown2").change(function(e) {
		var id = $("#provers_dropdown2").val();

		if(id == -1) {
			return false;
		}

		var name = $("#provers_dropdown2 option[value=" + id + "]").text();

		if (jQuery.inArray(name, selectedNames2) > -1) {
			if (selectedNames2.length == 0) {
				$('#team2members').hide();
			}
			alert(name + " is already on this team");
		} else if (jQuery.inArray(name, selectedNames1) > -1) {
			if (selectedNames1.length == 0) {
				$('#team2members').hide();
			}
			alert(name + " is already on the other team");
		}	else {
			selectedNames2.push(name);
			$("#team2members").append(name + "<br>");
			$("#team2").val($("#team2").val() + " " + id);
			$('#team2members').show();
		}
	});

	$('#type_opinion').on("click", function() {
		console.log("Now we're in opinion mode.");
		$(".submit_text.message_text").text("In my opinion:");
		$(".submit_text.support_text").text("Support (Optional):");
		document.getElementsByClassName('message message_placeholder')[0].placeholder='Enter opinion here. Be as concise as possible.';
		document.getElementsByClassName('message support_placeholder')[0].placeholder='Enter additional rationale, clarification and supporting information here.';
		if ($('#format_public').is(':checked')) {
			$('#public').show();
			$('#private').hide();
			$('#postteam1').hide();
			$('#postteam2').hide();
		} else {
			$('#public').hide();
			$('#private').show();
			$('#postteam1').show();
			$('#postteam1heading3').hide();
			$('#postteam2heading3').hide();
			if ($('#use_teams').is(':checked')) {
				$('#postteam2').show();
				$('#postteam1heading1').hide();
				$('#postteam1heading2').show();
				$('#postteam2heading2').show();
			} else {
				$('#postteam1heading1').show();
				$('#postteam1heading2').hide();
				$('#postteam2heading2').hide();
			}
		}
	});

	$('#type_initiator').on("click", function() {
		console.log("Now we're in initiator mode.");
		$(".submit_text.message_text").text("Initiator:");
		$(".submit_text.support_text").text("Support (Optional):");
		document.getElementsByClassName('message message_placeholder')[0].placeholder='Enter thought provoking question, comment, quote or directive here. Be as concise as possible.';
		document.getElementsByClassName('message support_placeholder')[0].placeholder='Enter additional clarification and supporting information here.';
		if ($('#format_public').is(':checked')) {
			$('#public').hide();
			$('#private').hide();
			$('#postteam1').hide();
			$('#postteam2').hide();
		} else {
			$('#public').hide();
			$('#private').show();
			$('#postteam1').show();
			$('#postteam1heading2').hide();
			$('#postteam2heading2').hide();
			if ($('#use_teams').is(':checked')) {
				$('#postteam2').show();
				$('#postteam1heading3').show();
				$('#postteam2heading3').show();
				$('#postteam1heading1').hide();
			} else {
				$('#postteam1heading1').show();
				$('#postteam1heading3').hide();
				$('#postteam2heading3').hide();
			}
		}
	});

	$('#type_comment').on("click", function() {
		console.log("Now we're in casual mode.");
		$(".submit_text.message_text").text("Comment:");
		$(".submit_text.support_text").text("Support (Optional): ");
		document.getElementsByClassName('message message_placeholder')[0].placeholder='Enter casual comment here.';
		document.getElementsByClassName('message support_placeholder')[0].placeholder='Enter additional information here.';
		$('#public').hide();
		$('#private').hide();
		$('#postteam2').hide();
		if ($('#format_public').is(':checked')) {
			$('#postteam1').hide();
		} else {
			$('#postteam1').show();
			$('#postteam1heading1').show();
			$('#postteam1heading2').hide();
			$('#postteam1heading3').hide();
		}
	});

	$('#format_public').on("click", function() {
		console.log("Selecting public.");
		$('#postteam1').hide();
		$('#postteam2').hide();

		if ($('#type_opinion').is(':checked')) {
			$('#public').show();
			$('#private').hide();
		} else if ($('#type_initiator').is(':checked')) {
			$('#public').hide();
			$('#private').hide();
		} else {
			$('#public').hide();
			$('#private').hide();
		}
	});

	$('#format_private').on("click", function() {
		console.log("Selecting private.");

		if ($('#lone_wolf').is(':checked')) {
			$('input[name="lone_wolf"][value="lone_wolf"]').click();
		}

		$('#postteam1').show();

		if ($('#type_opinion').is(':checked')) {
			console.log("Type opinion is selected...");
			$('#public').hide();
			$('#private').show();
			$('#postteam1').show();
			$('#postteam1heading3').hide();
			$('#postteam2heading3').hide();
			if ($('#use_teams').is(':checked')) {
				$('#postteam2').show();
				$('#postteam1heading1').hide();
				$('#postteam1heading2').show();
				$('#postteam2heading2').show();
			} else {
				$('#postteam1heading1').show();
				$('#postteam1heading2').hide();
				$('#postteam2heading2').hide();
			}
		} else if ($('#type_initiator').is(':checked')) {
			console.log("Type initiator is selected...");
			$('#public').hide();
			$('#private').show();
			$('#postteam1').show();
			$('#postteam1heading2').hide();
			$('#postteam2heading2').hide();
			if ($('#use_teams').is(':checked')) {
				$('#postteam2').show();
				$('#postteam1heading3').show();
				$('#postteam2heading3').show();
				$('#postteam1heading1').hide();
			} else {
				$('#postteam1heading1').show();
				$('#postteam1heading3').hide();
				$('#postteam2heading3').hide();
			}
		} else {
			console.log("Type Casual is selected...");
			$('#public').hide();
			$('#private').hide();
			$('#postteam1').show();
			$('#postteam1heading1').show();
			$('#postteam1heading2').hide();
			$('#postteam1heading3').hide();
		}
	});

	$('#teams').on("click", function(e) {
		console.log("Clicking teams checkbox.");
		var $tgt = $(e.target);
		if($tgt.prop("checked")) {
			$('#postteam1').show();
			$('#postteam2').show();
			$('#postteam1heading1').hide();
			if ($('#type_opinion').is(':checked')) {
				$('#postteam1heading2').show();
				$('#postteam1heading3').hide();
				$('#postteam2heading2').show();
				$('#postteam2heading3').hide();
			} else if ($('#type_initiator').is(':checked')) {
				$('#postteam1heading2').hide();
				$('#postteam1heading3').show();
				$('#postteam2heading2').hide();
				$('#postteam2heading3').show();
			}
		} else {
			$('#postteam1').show();
			$('#postteam2').hide();
			$('#postteam1heading1').show();
			$('#postteam1heading2').hide();
			$('#postteam1heading3').hide();
			$('#postteam2heading2').hide();
			$('#postteam2heading3').hide();
		}
	});

	$('#publicviewing').on("click", function(e) {
		console.log("Clicking public viewing checkbox.");
		var $tgt = $(e.target);
		if($tgt.prop("checked")) {
			$('#pubcomments').show();
		} else {
			$('#pubcomments').hide();
		}
	});

	$('input[name="format"][value="public"]').click();
	$('#pubcomments').hide();

	$('#createcancelbutton').on("click", function () {
		console.log("Selecting quit button.");
		history.back();
	});

//	$('.follow').on("click", function (e) {
//		var $tgt = $(e.target);
//		$.post('/follows', {owner: currentProver, follows: $tgt.attr("data-prover-id") }, function(resp) {
//					var follow = JSON.parse(resp);
//					console.log(follow);
//				});
//
//		console.log("Following this prover.");
//		window.location.reload();
//		return false;
//	});
};