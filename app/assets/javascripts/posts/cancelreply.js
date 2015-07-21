$(function() {
	$('#cancelopinionreply').on("click", function () {
		$('#kids').show();
		$('#opinionreply').hide();
		$('#commentreply').hide();
		$('#initiatorreply').hide();
	});

	$('#cancelinitiatorreply').on("click", function () {
		$('#kids').show();
		$('#opinionreply').hide();
		$('#commentreply').hide();
		$('#initiatorreply').hide();
	});

	$('#cancelcommentreply').on("click", function () {
		$('#kids').show();
		$('#opinionreply').hide();
		$('#commentreply').hide();
		$('#initiatorreply').hide();
	});

	$('#createcancelbutton').on("click", function () {
		history.back();
	});
});
