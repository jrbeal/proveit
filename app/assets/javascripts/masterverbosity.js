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

//					$('.postverbosity').map(function(e, elem) {
//						var newLevel = Math.max(parseInt($(elem).text()) - 1, 1);
//						$(elem).text(newLevel);
//					});

					$('.verbosity').text(verbosity);

					switch (verbosity) {
						case 4:
							$('.vlevel2').show();
							$('.postimage').show();
							$('.vlevel3').show();
							$('.vlevel4').show();
							$('.vlevel5').fadeOut();
							break;
						default:
							console.log("Unknown verbosity level... using default.");
							verbosity = 3;
							$('.verbosity').text(verbosity);
						case 3:
							$('.vlevel2').show();
							$('.postimage').show();
							$('.vlevel3').show();
							$('.vlevel4').fadeOut();
							$('.vlevel5').fadeOut();
							break;
						case 2:
							$('.vlevel2').show();
							$('.postimage').fadeOut();
							$('.vlevel3').fadeOut();
							$('.vlevel4').fadeOut();
							$('.vlevel5').fadeOut();
							break;
						case 1:
							$('.vlevel2').fadeOut();
							$('.postimage').fadeOut();
							$('.vlevel3').fadeOut();
							$('.vlevel4').fadeOut();
							$('.vlevel5').fadeOut();
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

//					$('.postverbosity').map(function(e, elem) {
//						var newLevel = Math.min(parseInt($(elem).text()) + 1, 5);
//						$(elem).text(newLevel);
//					});

					$('.verbosity').text(verbosity);

					switch (verbosity) {
						case 5:
							$('.vlevel2').fadeIn();
							$('.vlevel3').fadeIn();
							$('.postimage').fadeIn();
							$('.vlevel4').fadeIn();
							$('.vlevel5').fadeIn();
							break;
						case 4:
							$('.vlevel2').fadeIn();
							$('.vlevel3').fadeIn();
							$('.postimage').fadeIn();
							$('.vlevel4').fadeIn();
							$('.vlevel5').hide();
							break;
						case 3:
							$('.vlevel2').fadeIn();
							$('.postimage').fadeIn();
							$('.vlevel3').fadeIn();
							$('.vlevel4').hide();
							$('.vlevel5').hide();
							break;
						case 2:
						default:
							$('.vlevel2').fadeIn();
							$('.postimage').hide();
							$('.vlevel3').hide();
							$('.vlevel4').hide();
							$('.vlevel5').hide();
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