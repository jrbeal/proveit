function fallacies() {
	$(function () {
		$('#fallacyopen').on("click", function (e) {
			$.ajax({
				url: '/currentprover.json?',
				type: 'GET',
				success: function (resp) {
					console.log("Got current prover.");
					var owner = resp.currentprover.id;
					var Id = $('#fallacy option:selected').val();
					var name = $("#fallacy option:selected").text();
					if (name.search("--->") > 0) {
						console.log("Opened selected filter folder.");
						window.location = '/provers/' + owner + "?folderid=" + Id
					} else {
						$("#fallacy_details_id").val(Id);
						$('.fallacydetails').show();
						$.ajax({
							url: '/fallacies/' + Id + '.json?' + $.param({"id": Id}),
							type: 'GET',
							success: function (resp) {
								console.log("Opened fallacy.");
								var fallacy = resp.fallacy;
								$('#fallacydeclaration').val(fallacy.opinion);
								$('#fallacysupport').val(fallacy.support);
								$('#fallacyurl').val(fallacy.url);
							}
						});
					}
				}
			});

			return false;
		});

		$('#fallacydelete').on("click", function () {
			$.ajax({
				url: '/currentprover.json?',
				type: 'GET',
				success: function (resp) {
					console.log("Got current prover.");
					var owner = resp.currentprover.id;
					var name = $("#fallacy option:selected").text();
					var Id = $('#fallacy option:selected').val();
					console.log(name);
					console.log(Id);

					if (name.search("--->") > 0) {
						if (confirm("Deleting \"" + name + "\" (and all its subfolders)")) {
							$.ajax({
								url: '/fallacyfolders/' + Id + '.json?',
								type: 'DELETE',
								success: function (resp) {
									console.log("Deleted fallacy folder.");
									var parent = resp.parent;
									window.location = '/provers/' + owner + "?folderid=" + parent
								}
							});
						}
					} else {
						if (confirm("Deleting \"" + name + "\"")) {
							$.ajax({
								url: '/fallacies/' + Id + '.json?',
								type: 'DELETE',
								success: function (resp) {
									console.log("Deleted fallacy.");
									var parent = resp.parent;
									window.location = '/provers/' + owner + "?folderid=" + parent
								}
							});
						}
					}
				}
			});

			return false;
		});

		$('#cancelfallacydetails').on("click", function () {
			$('#fallacydeclaration').val("");
			$('#fallacysupport').val("");
			$('#fallacyurl').val("");
			$('.fallacydetails').hide();
			return false;
		});
	});
}
