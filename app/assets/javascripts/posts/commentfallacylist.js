$(function() {
	$('#commentfallacylist').on("click", function () {
		var Back = "<--- Back";
		var Id = $('#commentfallacylist option:selected').val();
		var name = $('#commentfallacylist option:selected').text();
		if (name.search("--->") >= 0 || name.search(Back) >= 0) {
			$.ajax({
				url: '/fallacyfolders/contents/' + Id + '.json?' + $.param({"id": Id}),
				type: 'GET',
				success: function (resp) {
					var joined = resp.joined;
					var parentid = resp.parentid;
					var parentname = resp.parentname;
					$('#commentfallacylist option').remove();
					if (parentid) {
						$('#commentfallacylist').append($("<option />").val(parentid).text(Back));
					};
					$.each(joined, function () {
						$('#commentfallacylist').append($("<option />").val(this.id).text(this.name));
					});
					$('#commenttemplatepath').text(parentname.replace(" --->", ":"));
					$('#commentopinion').val("");
					$('#commentsupport').val("");
					$('#commenturl').val("");
				}
			});
		} else if (name.length > 0) {
			$("#fallacy_details_id").val(Id);
			$.ajax({
				url: '/fallacies/' + Id + '.json?' + $.param({"id": Id}),
				type: 'GET',
				success: function (resp) {
					var fallacy = resp.fallacy;
					$('#commentopinion').val(fallacy.opinion);
					$('#commentsupport').val(fallacy.support);
					$('#commenturl').val(fallacy.url);
				}
			});
		}

		return false;
	});
});
