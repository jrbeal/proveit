$(function() {
	$('#initiatorfallacylist').on("click", function () {
		var Id = $('#initiatorfallacylist option:selected').val();
		var name = $('#initiatorfallacylist option:selected').text();
		console.log(name, Id);
		if (name.search("--->") >= 0 || name.search("<---") >= 0) {
			console.log("Selected filter folder.");
			$.ajax({
				url: '/fallacyfolders/contents/' + Id + '.json?' + $.param({"id": Id}),
				type: 'GET',
				success: function (resp) {
					var results = resp.results;
					var parentid = resp.parentid;
					console.log(results);
					console.log(parentid);
					$('#initiatorfallacylist option').remove();
					if (parentid) {
						$('#initiatorfallacylist').append($("<option />").val(parentid).text("<--- Back"));
					}
					;
					$.each(results, function () {
						$('#initiatorfallacylist').append($("<option />").val(this.id).text(this.name));
					});
					$('#initiatoropinion').val("");
					$('#initiatorsupport').val("");
					$('#initiatorurl').val("");
				}
			});
		} else if (name.length > 0) {
			console.log("Selected fallacy.");
			$("#fallacy_details_id").val(Id);
			$.ajax({
				url: '/fallacies/' + Id + '.json?' + $.param({"id": Id}),
				type: 'GET',
				success: function (resp) {
					var fallacy = resp.fallacy;
					console.log(fallacy);
					$('#initiatoropinion').val(fallacy.opinion);
					$('#initiatorsupport').val(fallacy.support);
					$('#initiatorurl').val(fallacy.url);
				}
			});
		}

		return false;
	});
});
