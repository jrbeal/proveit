function lessMaster() {
	$(function () {
		$('#lessmaster').on("click", function () {
			$.ajax({
				url: '/verbosity.json?',
				type: 'GET',
				success: function (resp) {
					console.log("Got verbosity.");
					verbosity = resp.verbosity;

					if (verbosity > 1) {
						verbosity -= 1;

						switch (verbosity) {
							case 4:
								$('.vlevelindicator4').show();
								$('.vlevelindicator5').hide();
								$('.vlevel5').fadeOut();
								break;
							case 3:
								$('.vlevelindicator3').show();
								$('.vlevelindicator4').hide();
								$('.vlevel4').fadeOut();
								break;
							case 2:
								$('.vlevelindicator2').show();
								$('.vlevelindicator3').hide();
								$('.postimage').fadeOut();
								$('.vlevel3').fadeOut();
								break;
							case 1:
							default:
								$('.vlevelindicator1').show();
								$('.vlevelindicator2').hide();
								$('.vlevel2').fadeOut();
								break;
						}

						$.ajax({
							url: '/verbosity?' + $.param({"verbosity": verbosity}),
							type: 'POST',
							success: function () {
								console.log("verbosity level is now set to " + verbosity)
							}
						})
					}
				}
			});

			return false;
		});
	});
}
