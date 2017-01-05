$(function () {
	$('.lesspost').on("click", function (e) {
		var $tgt = $(e.target);
		var $postVerbosityTextSelector = '#post' + $tgt.attr("data-postid").toString() + 'verbosity';
		var $postSelector = '#post' + $tgt.attr("data-postid").toString();
		var $postVerbosity = parseInt($($postVerbosityTextSelector).text());

		if ($postVerbosity > 1) {
			$postVerbosity -= 1;
			$($postVerbosityTextSelector).text(($postVerbosity).toString());

			switch ($postVerbosity) {
				case 4:
					console.log("Switching to post verbosity level 4.");
					$($postSelector).find(".vlevel5").fadeOut();
					$($postSelector).find(".vlevel4").show();
					$($postSelector).find(".vlevel3").show();
					$($postSelector).find(".postimage").show();
					$($postSelector).find(".vlevel2").show();
					break;
				case 3:
					console.log("Switching to post verbosity level 3.");
					$($postSelector).find(".vlevel5").fadeOut();
					$($postSelector).find(".vlevel4").fadeOut();
					$($postSelector).find(".vlevel3").show();
					$($postSelector).find(".postimage").show();
					$($postSelector).find(".vlevel2").show();
					break;
				case 2:
					console.log("Switching to post verbosity level 2.");
					$($postSelector).find(".vlevel5").fadeOut();
					$($postSelector).find(".vlevel4").fadeOut();
					$($postSelector).find(".vlevel3").fadeOut();
					$($postSelector).find(".postimage").fadeOut();
					$($postSelector).find(".vlevel2").show();
					break;
				case 1:
					console.log("Switching to post verbosity level 1.");
					$($postSelector).find(".vlevel5").fadeOut();
					$($postSelector).find(".vlevel4").fadeOut();
					$($postSelector).find(".vlevel3").fadeOut();
					$($postSelector).find(".postimage").fadeOut();
					$($postSelector).find(".vlevel2").fadeOut();
				break;
			}
		}
	});
})

$(function () {
	$('.morepost').on("click", function (e) {
		var $tgt = $(e.target);
		var $postVerbosityTextSelector = '#post' + $tgt.attr("data-postid").toString() + 'verbosity';
		var $postSelector = '#post' + $tgt.attr("data-postid").toString();
		var $postVerbosity = parseInt($($postVerbosityTextSelector).text());

		if ($postVerbosity < 5) {
			$postVerbosity += 1;
			$($postVerbosityTextSelector).text(($postVerbosity).toString());

			switch ($postVerbosity) {
				case 2:
					console.log("Switching to post verbosity level 2.");
					$($postSelector).find(".vlevel5").hide();
					$($postSelector).find(".vlevel4").hide();
					$($postSelector).find(".vlevel3").hide();
					$($postSelector).find(".postimage").hide();
					$($postSelector).find(".vlevel2").fadeIn();
					break;
				case 3:
					console.log("Switching to post verbosity level 3.");
					$($postSelector).find(".vlevel5").hide();
					$($postSelector).find(".vlevel4").hide();
					$($postSelector).find(".vlevel3").fadeIn();
					$($postSelector).find(".postimage").fadeIn();
					$($postSelector).find(".vlevel2").fadeIn();
					break;
				case 4:
					console.log("Switching to post verbosity level 4.");
					$($postSelector).find(".vlevel5").hide();
					$($postSelector).find(".vlevel4").fadeIn();
					$($postSelector).find(".vlevel3").fadeIn();
					$($postSelector).find(".postimage").fadeIn();
					$($postSelector).find(".vlevel2").fadeIn();
					break;
				case 5:
					console.log("Switching to post verbosity level 5.");
					$($postSelector).find(".vlevel5").fadeIn();
					$($postSelector).find(".vlevel4").fadeIn();
					$($postSelector).find(".vlevel3").fadeIn();
					$($postSelector).find(".postimage").fadeIn();
					$($postSelector).find(".vlevel2").fadeIn();
					break;
			}
		}
	});
})

var $prevpostVerbosity;

$(function () {
	$('.jumptovlevel4').on("click", function (e) {
		var $tgt = $(e.target);
		var $postVerbosityTextSelector = '#post' + $tgt.attr("data-postid").toString() + 'verbosity';
		var $postVerbosity = parseInt($($postVerbosityTextSelector).text());
		var $postSelector = '#post' + $tgt.attr("data-postid").toString();
		switch ($($postSelector).find(".jumptovlevel4").text()) {
			case "[+]":
				if ($postVerbosity < 4) {
					$prevpostVerbosity = $postVerbosity;
					console.log("Jumping up to verbosity level 4 (for this post).");
					$($postSelector).find(".vlevel5").hide();
					$($postSelector).find(".vlevel4").fadeIn();
					$($postSelector).find(".vlevel3").fadeIn();
					$($postSelector).find(".postimage").fadeIn();
					$($postSelector).find(".vlevel2").fadeIn();
					$($postSelector).find(".jumptovlevel4").text("[-]");
				}
				$($postVerbosityTextSelector).text("4");
				break;
			case "[-]":
				console.log("Dropping to previous verbosity level (for this post).");
				switch ($prevpostVerbosity) {
					case 1:
						$($postSelector).find(".vlevel5").hide();
						$($postSelector).find(".vlevel4").hide();
						$($postSelector).find(".vlevel3").hide();
						$($postSelector).find(".postimage").hide();
						$($postSelector).find(".vlevel2").hide();
						break;
					case 2:
						$($postSelector).find(".vlevel5").hide();
						$($postSelector).find(".vlevel4").hide();
						$($postSelector).find(".vlevel3").hide();
						$($postSelector).find(".postimage").hide();
						$($postSelector).find(".vlevel2").fadeIn();
						break;
					case 3:
						$($postSelector).find(".vlevel5").hide();
						$($postSelector).find(".vlevel4").hide();
						$($postSelector).find(".vlevel3").fadeIn();
						$($postSelector).find(".postimage").fadeIn();
						$($postSelector).find(".vlevel2").fadeIn();
						break;
				}
				$($postSelector).find(".jumptovlevel4").text("[+]");
				$($postVerbosityTextSelector).text($prevpostVerbosity);
				break;
		}
	});
})