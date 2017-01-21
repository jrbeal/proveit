$(function() {
	$('#fallacylist').on("click", function () {
		var Back = "<--- Back";
		var Id = $('#fallacylist option:selected').val();
		var name = $('#fallacylist option:selected').text();
		if (name.search("--->") >= 0 || name.search(Back) >= 0) {
			$.ajax({
				url: '/fallacyfolders/contents/' + Id + '.json?' + $.param({"id": Id}),
				type: 'GET',
				success: function (resp) {
					var results = resp.results;
					var parentid = resp.parentid;
					var parentname = resp.parentname;
					$('#fallacylist option').remove();
					if (parentid) {
						$('#fallacylist').append($("<option />").val(parentid).text(Back));
					};
					$.each(results, function () {
						$('#fallacylist').append($("<option />").val(this.id).text(this.name));
					});
					$('#templatepath').text(parentname.replace(" --->", ":"));
					$('#message').val("");
					$('#support').val("");
					$('#url').val("");
				}
			});
		} else if (name.length > 0) {
			$("#fallacy_details_id").val(Id);
			$.ajax({
				url: '/fallacies/' + Id + '.json?' + $.param({"id": Id}),
				type: 'GET',
				success: function (resp) {
					var fallacy = resp.fallacy;
					$('#message').val(fallacy.opinion);
					$('#support').val(fallacy.support);
					$('#url').val(fallacy.url);
				}
			});
		}

		return false;
	});
});