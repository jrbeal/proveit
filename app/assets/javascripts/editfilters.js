$(function() {
	$('#editfilters').on("click", function (e) {
		console.log("Editing filters.");
		$.ajax({
			url: '/currentprover.json?',
			type: 'GET',
			success: function (resp) {
				console.log("Got current prover.");
				id = resp.currentprover.id;
				$.ajax({
					url: '/profiletab?' + $.param({"profiletab": 'filters'}),
					type: 'POST',
					success: function (resp) {
						console.log("Selected this filter.");
						window.location = '/provers/' + id;
					}
				});
			}
		});

		return false;
	});
});