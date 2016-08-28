$(function () {
	$.ajax({
		url: '/verbosity.json?',
		type: 'GET',
		success: function (resp) {

			$('.verbosity').text(resp.verbosity);

			switch (resp.verbosity) {
				case 5:
					$('.vlevel1').show();
					$('.vlevel2').show();
					$('.vlevel3').show();
					$('.vlevel4').show();
					$('.vlevel5').show();
					$('.postimage').show();
					break;
				case 4:
					$('.vlevel1').show();
					$('.vlevel2').show();
					$('.vlevel3').show();
					$('.vlevel4').show();
					$('.vlevel5').hide();
					$('.postimage').show();
					break;
				default:
				case 3:
					$('.vlevel1').show();
					$('.vlevel2').show();
					$('.vlevel3').show();
					$('.vlevel4').hide();
					$('.vlevel5').hide();
					$('.postimage').show();
					break;
				case 2:
					$('.vlevel1').show();
					$('.vlevel2').show();
					$('.vlevel3').hide();
					$('.vlevel4').hide();
					$('.vlevel5').hide();
					$('.postimage').hide();
					break;
				case 1:
					$('.vlevel1').show();
					$('.vlevel2').hide();
					$('.vlevel3').hide();
					$('.vlevel4').hide();
					$('.vlevel5').hide();
					$('.postimage').hide();
			}

			$('.post').css('visibility', 'visible');
		}
	})

	return false;
})