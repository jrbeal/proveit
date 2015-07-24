function halfLife() {
	function getRangeGradient(color1, color2, value, maximum) {
		var gradient = "linear-gradient(to right, ";
		var breakPoint = (value / maximum) * 100;

		var attrValue = gradient + color1 + " 0%, " + color1 + " " + breakPoint + "%, " + color2 + " " + breakPoint + "%, " + color2 + " 100%)";
		return attrValue;
	}

	$(function () {
		$.ajax({
			url: '/halflife.json?',
			type: 'GET',
			success: function (resp) {
				var halflife = resp.halflife;
				$('input[name=weeks]').val(halflife);
				updateRangeValue($('input[name=weeks]'));
			}
		});

		$('input[name=weeks]').on('input change', function () {
			var input = $(this);
			updateRangeValue(input);
		});
	});

	function updateRangeValue(input) {
		var selectedColor = "black";
		var nonSelectedColor = "white";

		var value = input.val();
		var max = input.attr('max');
		var inputWidth = input.width();
		var background = getRangeGradient(selectedColor, nonSelectedColor, value, max);

		var offLeft = Math.floor(((value - 1 + (value / max)) / max) * inputWidth) - (((value - 1 + (value / max)) / max) * 60) + 30;
		input.next('.text').css({'left': offLeft + 'px'});
		if (value == 1) {
			text = (value.toString().concat("Week"));
		} else {
			text = (value.toString().concat("Weeks"));
		}
		input.next('.text').html(text);
		input.css('background', background);
	};
};
