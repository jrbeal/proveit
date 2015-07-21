$(function() {
	$("#provers_dropdown2").on("click", function (e) {
		var id = $("#provers_dropdown2").val();

		if (id == -1) {
			return false;
		}

		var name = $("#provers_dropdown2 option[value=" + id + "]").text();

		if (jQuery.inArray(name, selectedNames2) > -1) {
			if (selectedNames2.length == 0) {
				$('#team2members').hide();
			}
			alert(name + " is already on this team");
		} else if (jQuery.inArray(name, selectedNames1) > -1) {
			if (selectedNames1.length == 0) {
				$('#team2members').hide();
			}
			alert(name + " is already on the other team");
		} else {
			selectedNames2.push(name);
			$("#team2members").append(name + "<br>");
			$("#team2").val($("#team2").val() + " " + id);
			$('#team2members').show();
		}
	});
});