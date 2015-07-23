$(function () {
	$.ajax({
		url: '/verbosity.json?',
		type: 'GET',
		success: function (resp) {
			console.log("Got verbosity.");

			switch (resp.verbosity) {
				case 5:
					console.log("Showing verbosity level 5.");
					$('.vlevelindicator1').hide();
					$('.vlevelindicator2').hide();
					$('.vlevelindicator3').hide();
					$('.vlevelindicator4').hide();
					$('.vlevelindicator5').show();
					$('.vlevel1').show();
					$('.vlevel2').show();
					$('.vlevel3').show();
					$('.vlevel4').show();
					$('.vlevel5').show();
					$('.postimage').show();
					break;
				case 4:
					console.log("Showing verbosity level 4.");
					$('.vlevelindicator1').hide();
					$('.vlevelindicator2').hide();
					$('.vlevelindicator3').hide();
					$('.vlevelindicator4').show();
					$('.vlevelindicator5').hide();
					$('.vlevel1').show();
					$('.vlevel2').show();
					$('.vlevel3').show();
					$('.vlevel4').show();
					$('.vlevel5').hide();
					$('.postimage').show();
					break;
				case 3:
					console.log("Showing verbosity level 3.");
					$('.vlevelindicator1').hide();
					$('.vlevelindicator2').hide();
					$('.vlevelindicator3').show();
					$('.vlevelindicator4').hide();
					$('.vlevelindicator5').hide();
					$('.vlevel1').show();
					$('.vlevel2').show();
					$('.vlevel3').show();
					$('.vlevel4').hide();
					$('.vlevel5').hide();
					$('.postimage').show();
					break;
				case 2:
					console.log("Showing verbosity level 2.");
					$('.vlevelindicator1').hide();
					$('.vlevelindicator2').show();
					$('.vlevelindicator3').hide();
					$('.vlevelindicator4').hide();
					$('.vlevelindicator5').hide();
					$('.vlevel1').show();
					$('.vlevel2').show();
					$('.vlevel3').hide();
					$('.vlevel4').hide();
					$('.vlevel5').hide();
					$('.postimage').hide();
					break;
				case 1:
				default:
					console.log("Showing verbosity level 1.");
					$('.vlevelindicator1').show();
					$('.vlevelindicator2').hide();
					$('.vlevelindicator3').hide();
					$('.vlevelindicator4').hide();
					$('.vlevelindicator5').hide();
					$('.vlevel1').show();
					$('.vlevel2').hide();
					$('.vlevel3').hide();
					$('.vlevel4').hide();
					$('.vlevel5').hide();
					$('.postimage').hide();
			}
		}
	})

	return false;
})