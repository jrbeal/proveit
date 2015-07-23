function moreMaster() {
	$(function () {
		$('#moremaster').on("click", function () {
			$.ajax({
				url: '/verbosity.json?',
				type: 'GET',
				success: function (resp) {
					console.log("Got verbosity.");
					verbosity = resp.verbosity;

					if (verbosity < 5) {
						verbosity += 1;

						switch (verbosity) {
							case 5:
								$('.vlevelindicator4').hide();
								$('.vlevelindicator5').show();
								$('.vlevel5').fadeIn();
								break;
							case 4:
								$('.vlevelindicator3').hide();
								$('.vlevelindicator4').show();
								$('.vlevel4').fadeIn();
								break;
							case 3:
								$('.vlevelindicator2').hide();
								$('.vlevelindicator3').show();
								$('.postimage').fadeIn();
								$('.vlevel3').fadeIn();
								break;
							case 2:
							default:
								$('.vlevelindicator1').hide();
								$('.vlevelindicator2').show();
								$('.vlevel2').fadeIn();
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