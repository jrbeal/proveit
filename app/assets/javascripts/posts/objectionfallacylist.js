$(function() {
	$('#objectionfallacylist').on("click", function () {
		var Back = "<--- Back";
		var Id = $('#objectionfallacylist option:selected').val();
		var name = $('#objectionfallacylist option:selected').text();
		if (name.search("--->") >= 0 || name.search(Back) >= 0) {
			$.ajax({
				url: '/fallacyfolders/contents/' + Id + '.json?' + $.param({"id": Id}),
				type: 'GET',
				success: function (resp) {
					var joined = resp.joined;
					var parentid = resp.parentid;
					var parentname = resp.parentname;
					$('#objectionfallacylist option').remove();
					if (parentid) {
						$('#objectionfallacylist').append($("<option />").val(parentid).text(Back));
					};
					$.each(joined, function () {
						$('#objectionfallacylist').append($("<option />").val(this.id).text(this.name));
					});
					$('#objectiontemplatefolder').text(parentname.replace(" --->", ":"));
					$('#objectiontemplatefolder').val(Id);
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

	$('#filtertemplates').on("click", function () {
		var Id = $('#objectiontemplatefolder').val();
		var keywords = $('#templatekeywords').val().split(" ");
		console.log("ID = " + Id);
		console.log("Keywords = " + keywords.length)
		$.ajax({
			url: '/fallacyfolders/contents/' + Id + '.json?' + $.param({"id": Id}),
			type: 'GET',
			success: function (resp) {
				var contents = resp.joined;

				$.each(contents, function () {
//					if this.id is a folder call function again
//					else
//					$('#objectionfallacylist').append($("<option />").val(this.id).text(this.name));
				});
			}
		});
	});
});
