$(function() {
	$("#provers_dropdown1").on("click", function (e) {
		var id = $("#provers_dropdown1").val();

		if (id == -1) {
			return false;
		}

		var name = $("#provers_dropdown1 option[value=" + id + "]").text();

		if (jQuery.inArray(name, selectedNames1) > -1) {
			if (selectedNames1.length == 0) {
				$('#team1members').hide();
			}
			alert(name + " is already on this team");
		} else if (jQuery.inArray(name, selectedNames2) > -1) {
			if (selectedNames2.length == 0) {
				$('#team1members').hide();
			}
			alert(name + " is already on the other team");
		} else {
			selectedNames1.push(name);
			$("#team1members").append("<br>" + name);
			$("#team1").val($("#team1").val() + " " + id);
			$('#team1members').show();
		}
		console.info(selectedNames1)
	});
});
