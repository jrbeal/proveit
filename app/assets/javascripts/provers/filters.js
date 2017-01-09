function filters() {
	$(function () {
		$('.myfilters').on("click", function (e) {
			var $tgt = $(e.target);
			$.ajax({
				url: '/filters/' + $tgt.val() + '.json?' + $.param({"id": $tgt.val()}),
				type: 'GET',
				success: function (resp) {

					var filter = resp.filter;
					var cats = resp.categories;

					console.log(filter);
					console.log(cats);

					$('input[value="category"]').prop('checked', false);
					if (cats) {
						for (var i = 0; i < cats.length; i++) {
							$('input[name="' + cats[i].name + '"][value="category"]').prop('checked', true);
						}
					}

					$('input[name="opinions"][value="true"]').prop('checked', filter.opinions);
					$('input[name="initiators"][value="true"]').prop('checked', filter.initiators);
					$('input[name="comments"][value="true"]').prop('checked', filter.comments);
					$('input[name="bookmarks"][value="true"]').prop('checked', filter.bookmarks);
					$('input[name="sitedefault"][value="true"]').prop('checked', filter.sitedefault);
					$('input[name="sitedefault"][value="false"]').prop('checked', !filter.sitedefault);
					$('input[name="lone_wolf"][value="true"]').prop('checked', filter.lone_wolf);
					if (filter.private) {
						$('input[name="privateposts"][value="true"]').prop('checked', true);
						$('#public_viewing').show();
						$('.publicviewinglabel').show();
					}
					if (filter.public_viewing) {
						$('input[name="public_viewing"][value="true"]').prop('checked', true);
						$('#public_comments').show();
						$('.publiccommentslabel').show();
					}
					$('input[name="public_comments"][value="true"]').prop('checked', filter.public_comments);
					$('input[name="following"][value="true"]').prop('checked', filter.following);
					$('input[name="status"][value="contested"]').prop('checked', filter.contested);
					$('input[name="status"][value="uncontested"]').prop('checked', filter.uncontested);
					$('input[name="parents"][value="has_parent"]').prop('checked', filter.has_parent);
					$('input[name="parents"][value="has_no_parent"]').prop('checked', filter.has_no_parent);
					$('input[name="level"][value="zero"]').prop('checked', filter.level_zero);
					$('input[name="level"][value="nonzero"]').prop('checked', filter.level_nonzero);
					$('input[name="timerange"][value="today"]').prop('checked', filter.today);
					$('input[name="timerange"][value="last_week"]').prop('checked', filter.last_week);
					$('input[name="timerange"][value="last_month"]').prop('checked', filter.last_month);
					$('input[name="timerange"][value="last_year"]').prop('checked', filter.last_year);
					$('input[name="sort"][value="sort_by_created_at"]').prop('checked', filter.sort_by_created_at);
					$('input[name="sort"][value="sort_by_updated_at"]').prop('checked', filter.sort_by_updated_at);
					$('input[name="sort"][value="sort_by_views"]').prop('checked', filter.sort_by_views);
					$('input[name="sort"][value="sort_by_votes"]').prop('checked', filter.sort_by_votes);
					$('input[name="sort"][value="sort_by_scores"]').prop('checked', filter.sort_by_scores);
					$('input[name="descending"][value="true"]').prop('checked', filter.descending);
					$('input[name="descending"][value="false"]').prop('checked', !filter.descending);
					$('.myfiltername').val(filter.name);
					$('.provers_dropdown').val(filter.who_id);
				}
			});

			return false;
		});

		$('.allposttypes').on("click", function () {
			$('input[name="opinions"][value="true"]').prop('checked', true);
			$('input[name="initiators"][value="true"]').prop('checked', true);
			$('input[name="comments"][value="true"]').prop('checked', true);
		});

		$('#filterresetbutton').on("click", function () {
			$('.myfiltername').val("");
			$('input[value="category"]').prop('checked', false);
			$('input[name="opinions"][value="true"]').prop('checked', true);
			$('input[name="initiators"][value="true"]').prop('checked', false);
			$('input[name="comments"][value="true"]').prop('checked', false);
			$('input[name="bookmarks"][value="true"]').prop('checked', false);
			$('input[name="sitedefault"][value="true"]').prop('checked', true);
			$('input[name="sitedefault"][value="false"]').prop('checked', false);
			$('input[name="lone_wolf"][value="true"]').prop('checked', false);
			$('input[name="privateposts"][value="true"]').prop('checked', false);
			$('input[name="pubic_viewing"][value="true"]').prop('checked', false);
			$('input[name="public_comments"][value="true"]').prop('checked', false);
			$('input[name="following"][value="true"]').prop('checked', false);
			$('input[name="status"][value="contested"]').prop('checked', false);
			$('input[name="status"][value="uncontested"]').prop('checked', false);
			$('input[name="parents"][value="has_parent"]').prop('checked', false);
			$('input[name="parents"][value="has_no_parent"]').prop('checked', false);
			$('input[name="level"][value="zero"]').prop('checked', false);
			$('input[name="level"][value="nonzero"]').prop('checked', false);
			$('input[name="timerange"][value="all"]').prop('checked', true);
			$('input[name="sort"][value="sort_by_updated_at"]').prop('checked', true);
			$('input[name="descending"][value="true"]').prop('checked', true);
			$('.provers_dropdown').val(-1);
			$('.myfilters').val(-1);
		});

		$('#filterdeletebutton').on("click", function () {
			var Id = $('#myfilters').val();
			$.ajax({
				url: '/currentprover.json?',
				type: 'GET',
				success: function (resp) {
					console.log("Got current prover.");
					owner = resp.currentprover.id;
					$.ajax({
						url: '/filters/' + Id + '.json?',
						type: 'DELETE',
						success: function () {
							console.log("Deleted filter.");
							window.location = '/provers/' + owner
						}
					});
				}
			});

			return false;
		});

		$('#privateposts').on("click", function (e) {
			var $tgt = $(e.target);
			if ($tgt.prop("checked")) {
				$('#public_viewing').show();
				$('.publicviewinglabel').show();
			} else {
				if ($('#public_viewing').is(':checked')) {
					$('#public_viewing').click();
				}
				$('#public_viewing').hide();
				$('.publicviewinglabel').hide();
			}
		});

		$('#public_viewing').on("click", function (e) {
			var $tgt = $(e.target);
			if ($tgt.prop("checked")) {
				$('#public_comments').show();
				$('.publiccommentslabel').show();
			} else {
				if ($('#public_comments').is(':checked')) {
					$('#public_comments').click();
				}
				$('#public_comments').hide();
				$('.publiccommentslabel').hide();
			}
		});

		$('#public_viewing').hide();
		$('.publicviewinglabel').hide();
		$('#public_comments').hide();
		$('.publiccommentslabel').hide();
		$('.fallacydetails').hide();

	});
}
