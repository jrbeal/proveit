$(function() {
	$('#objectionfallacylist').on("click", function () {
		var Id = $('#objectionfallacylist option:selected').val();
		var name = $('#objectionfallacylist option:selected').text();
		if (name.search("--->") >= 0 || name.search("<---") >= 0) {
			$.ajax({
				url: '/fallacyfolders/contents/' + Id + '.json?' + $.param({"id": Id}),
				type: 'GET',
				success: function (resp) {
					var joined = resp.joined;
					var parentid = resp.parentid;
					$('#objectionfallacylist option').remove();
					if (parentid) {
						$('#objectionfallacylist').append($("<option />").val(parentid).text("<--- Back"));
					}
					;
					$.each(joined, function () {
						$('#objectionfallacylist').append($("<option />").val(this.id).text(this.name));
					});
					$('#objectionopinion').val("");
					$('#objectionsupport').val("");
					$('#objectionurl').val("");
				}
			});
		} else if (name.length > 0) {
			$("#fallacy_details_id").val(Id);
			$.ajax({
				url: '/fallacies/' + Id + '.json?' + $.param({"id": Id}),
				type: 'GET',
				success: function (resp) {
					var fallacy = resp.fallacy;
					$('#objectionopinion').val(fallacy.opinion);
					$('#objectionsupport').val(fallacy.support);
					$('#objectionurl').val(fallacy.url);
				}
			});
		}

		return false;
	});
});
