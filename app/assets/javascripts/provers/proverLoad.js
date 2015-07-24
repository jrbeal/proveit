function proverLoad() {

	$(halfLife);
	$(filters);
	$(fallacies);

	$(function() {
		$('#categorydeletebutton').on("click", function () {
			var Id = $('#mycategories').val();
			$.ajax({
				url: '/currentprover.json?',
				type: 'GET',
				success: function (resp) {
					console.log("Got current prover.");
					owner = resp.currentprover.id;
					$.ajax({
						url: '/categories/' + Id + '.json?',
						type: 'DELETE',
						success: function () {
							console.log("Deleted category.");
							window.location = '/provers/' + owner + "?default_tab=administrative"
						}
					});
				}
			});

			return false;
		});
	});

	$(function() {
		$('.postedbyself').on("click", function () {
			$.ajax({
				url: '/currentprover.json?',
				type: 'GET',
				success: function (resp) {
					console.log("Got current prover.");
					id = resp.currentprover.id;
					$('.provers_dropdown').val(id);
				}
			});

			return false;
		});
	});

	$(function() {
		$('.resethighestratingbutton').on("click", function () {
			$.ajax({
				url: '/currentprover.json?',
				type: 'GET',
				success: function (resp) {
					console.log("Got current prover.");
					id = resp.currentprover.id;
					$.ajax({
						url: '/resetscore',
						type: 'GET',
						success: function () {
							console.log("Resetting highest rating.");
							window.location = '/provers/' + id + "?default_tab=rating"
						}
					});
				}
			});

			return false;
		});
	});

	$(function() {
		$('.resignteam').on("click", function () {
			var Id = $('#teammembership_dropdown').val();
			console.log(Id);
			$.ajax({
				url: '/currentprover.json?',
				type: 'GET',
				success: function (resp) {
					console.log("Got current prover.");
					owner = resp.currentprover.id;
					$.ajax({
						url: '/teams?' + $.param({"owner": owner, "id": Id}),
						type: 'DELETE',
						success: function () {
							console.log("Resigned from team.");
							window.location.reload();
						}
					});
				}
			});

			return false;
		});
	});

	$(function() {
		$('input[name="profile"]').on('click', function (e) {
			console.log("Selecting profile tab...");
			var $tgt = $(e.target);
			if ($tgt.val() == "profile") {
				console.log("profile = profile");
				$('#profileprofile').show();
				$('#profileposts').hide();
				$('#profileaccount').hide();
				$('#profilepassword').hide();
				$('#profilesettings').hide();
				$('#profilefilters').hide();
				$('#profilemobile').hide();
				$('#profileemail').hide();
				$('#profileapps').hide();
				$('#profilerating').hide();
				$('#profileadministrative').hide();
			} else if ($tgt.val() == "posts") {
				console.log("profile = posts");
				$('#profileprofile').hide();
				$('#profileposts').show();
				$('#profileaccount').hide();
				$('#profilepassword').hide();
				$('#profilesettings').hide();
				$('#profilefilters').hide();
				$('#profilemobile').hide();
				$('#profileemail').hide();
				$('#profileapps').hide();
				$('#profilerating').hide();
				$('#profileadministrative').hide();
			} else if ($tgt.val() == "account") {
				console.log("profile = account");
				$('#profileprofile').hide();
				$('#profileposts').hide();
				$('#profileaccount').show();
				$('#profilepassword').hide();
				$('#profilesettings').hide();
				$('#profilefilters').hide();
				$('#profilemobile').hide();
				$('#profileemail').hide();
				$('#profileapps').hide();
				$('#profilerating').hide();
				$('#profileadministrative').hide();
			} else if ($tgt.val() == "password") {
				console.log("profile = password");
				$('#profileprofile').hide();
				$('#profileposts').hide();
				$('#profileaccount').hide();
				$('#profilepassword').show();
				$('#profilesettings').hide();
				$('#profilefilters').hide();
				$('#profilemobile').hide();
				$('#profileemail').hide();
				$('#profileapps').hide();
				$('#profilerating').hide();
				$('#profileadministrative').hide();
			} else if ($tgt.val() == "settings") {
				console.log("profile = settings");
				$('#profileprofile').hide();
				$('#profileposts').hide();
				$('#profileaccount').hide();
				$('#profilepassword').hide();
				$('#profilesettings').show();
				$('#profilefilters').hide();
				$('#profilemobile').hide();
				$('#profileemail').hide();
				$('#profileapps').hide();
				$('#profilerating').hide();
				$('#profileadministrative').hide();
			} else if ($tgt.val() == "filters") {
				console.log("profile = filters");
				$('#profileprofile').hide();
				$('#profileposts').hide();
				$('#profileaccount').hide();
				$('#profilepassword').hide();
				$('#profilesettings').hide();
				$('#profilefilters').show();
				$('#profilemobile').hide();
				$('#profileemail').hide();
				$('#profileapps').hide();
				$('#profilerating').hide();
				$('#profileadministrative').hide();
			} else if ($tgt.val() == "mobile") {
				console.log("profile = mobile");
				$('#profileprofile').hide();
				$('#profileposts').hide();
				$('#profileaccount').hide();
				$('#profilepassword').hide();
				$('#profilesettings').hide();
				$('#profilefilters').hide();
				$('#profilemobile').show();
				$('#profileemail').hide();
				$('#profileapps').hide();
				$('#profilerating').hide();
				$('#profileadministrative').hide();
			} else if ($tgt.val() == "email") {
				console.log("profile = email");
				$('#profileprofile').hide();
				$('#profileposts').hide();
				$('#profileaccount').hide();
				$('#profilepassword').hide();
				$('#profilesettings').hide();
				$('#profilefilters').hide();
				$('#profilemobile').hide();
				$('#profileemail').show();
				$('#profileapps').hide();
				$('#profilerating').hide();
				$('#profileadministrative').hide();
			} else if ($tgt.val() == "apps") {
				console.log("profile = apps");
				$('#profileprofile').hide();
				$('#profileposts').hide();
				$('#profileaccount').hide();
				$('#profilepassword').hide();
				$('#profilesettings').hide();
				$('#profilefilters').hide();
				$('#profilemobile').hide();
				$('#profileemail').hide();
				$('#profileapps').show();
				$('#profilerating').hide();
				$('#profileadministrative').hide();
			} else if ($tgt.val() == "rating") {
				console.log("profile = rating");
				$('#profileprofile').hide();
				$('#profileposts').hide();
				$('#profileaccount').hide();
				$('#profilepassword').hide();
				$('#profilesettings').hide();
				$('#profilefilters').hide();
				$('#profilemobile').hide();
				$('#profileemail').hide();
				$('#profileapps').hide();
				$('#profilerating').show();
				$('#profileadministrative').hide();
			} else if ($tgt.val() == "administrative") {
				console.log("profile = administrative");
				$('#profileprofile').hide();
				$('#profileposts').hide();
				$('#profileaccount').hide();
				$('#profilepassword').hide();
				$('#profilesettings').hide();
				$('#profilefilters').hide();
				$('#profilemobile').hide();
				$('#profileemail').hide();
				$('#profileapps').hide();
				$('#profilerating').hide();
				$('#profileadministrative').show();
			} else {
				console.log("Clicking unknown profile tab: " + $tgt.val());
			}

			$.ajax({
				url: '/profiletab?' + $.param({"profiletab": $tgt.val()}),
				type: 'POST',
				success: function () {
					console.log("Profile tab is now set to " + $tgt.val())
				}
			})
		});
	});

	$(function() {
		$.ajax({
			url: '/currentprover.json?',
			type: 'GET',
			success: function (resp) {
				console.log("Got current prover. Loading defaults...");
				$('input[name="verbosity"][value=' + resp.currentprover.verbosity + ']').click();

				if ($('input[name="profile"][value="' + resp.currentprover.profiletab + '"]').is(":visible")) {
					$('input[name="profile"][value="' + resp.currentprover.profiletab + '"]').click();
				} else {
					$('input[name="profile"][value="profile"]').click();
				}

				$('input[name="offspring_style"][value="' + resp.currentprover.offspring_style + '"]').click();
			}
		});

		return false;
	});
};