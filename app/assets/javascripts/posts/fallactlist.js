$(function() {
	var Back = "<--- Back";

	$('#fallacylist').on("click", function () {
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

//	function searchfolder (folderid, keyword) {
//		$.ajax({
//			url: '/fallacyfolders/contents/' + folderid + '.json?' + $.param({"id": folderid}),
//			type: 'GET',
//			success: function (resp) {
//				var results = resp.results;
//
//				results.each(function () {
//					var name = ( $(this).text() );
//					if (name == Back) {
//						var id = ( $(this).val() );
//						searchfolder (id, keyword);
//						return false;
//					} else {
//						// do nothing... just skip to the next entry (we're looking for "Back"...
//					}
//				})
//			}
//		});
//
//		if (name == Back) { 										// do nothing
//			rootfolder = ( $(this).val() );
//		} else if (name.search("--->") >= 0) { 	// this is a folder. We need to dig deeper
//			searchfolder (id, keyword);
//		} else { 																// this is a template. Let's search it
//			$.ajax({
//				url: '/fallacies/' + id + '.json?' + $.param({"id": id}),
//				type: 'GET',
//				success: function (resp) {
//					var fallacy = resp.fallacy;
//					if ((fallacy.name + fallacy.opinion + fallacy.support).search(keyword) >= 0) { // We have a match!
//						matches.push(id);
//					}
//				}
//			});
//		}
//	}
//
//	$('#searchtemplates').on("click", function () {
//		var keyword = $('#templatekeyword').val();
//		console.log("Searching for " + keyword);
//		$('#fallacylist option').each(function() { // for each item in the current list...
//			var name = ( $(this).text() );
//			console.log("Name is " + name);
//			if (name == Back) {
//				var id = ( $(this).val() );
//				searchfolder (id, keyword);
//				return false;
//			} else {
//				// do nothing... just skip to the next entry (we're looking for "Back"...
//			}
//		})
//
//		// If no "<--- Back" is found, then just search from the root folder...
//		var rootfolder = $('#rootfolder').val();		// (The root folder was saved here by the controller)
//		searchfolder (rootfolder, keyword);
//	});
});