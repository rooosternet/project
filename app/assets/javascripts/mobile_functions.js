(function($, window, document, undefined) {
	var $win = $(window);
	var $doc = $(document);

// 	// Simple Templates
// 	// function template(tpl, vars) {
// 	// 	debugger;
// 	// 	return tpl.replace(/{{([^}]+)}}/g, function(match, property) {
// 	// 		var arr = property.split('.');
// 	// 		var obj = vars[arr.shift()];

// 	// 		while(arr.length > 0 && typeof obj === 'object') {
// 	// 			obj = obj[arr.shift()];
// 	// 		}

// 	// 		return typeof obj === 'undefined' ? match : obj;
// 	// 	});
// 	// };

// 	// Leading Zero
// 	function leadingZero(number) {
// 		return number < 10 ? '0' + number : '' + number;
// 	};

	$doc.ready(function() {
		if ( $win.width() > 1024 && $('#main-landing').length ) {
			$('#main-landing').fullpage({
				sectionSelector: '.test',
				scrollingSpeed: 1000
			});
		};

		// Scroll To
		$('[data-scroll-to]').on('click', function(event) {
			event.preventDefault();

			var target = $(this).data('scroll-to');

			$('html, body').animate({
				scrollTop: $(target).offset().top
			}, 500);
		});

		// // Button Collapse Form
		// $('.btn-collapse-form').on('click', function(event) {
		// 	event.preventDefault();

		// 	$(this).hide();
		// });

// 		$('.link-profile').on('click', function(event) {
// 			event.preventDefault();
// 			$('#modal-edit-profile-admin').addClass('in');
// 			$('#modal-edit-profile-admin').show();
// 		});



// 		$('.user-image').on('click', function() {
// 			$(this).closest('.user-alt').siblings().find('.user-image[aria-expanded="true"]').trigger('click');
// 		})

// 		//Modal Fix
// 		// $('.header [data-toggle="modal-alt"]').on('click', function(event) {
// 		// 	event.preventDefault();

// 		// 	var target = $(this).attr('href');

// 		// 	if(!$('.modal-backdrop').length) {
// 		// 		$(target).modal('show');
// 		// 		return;
// 		// 	}

// 		// 	$('.modal').modal('hide');
// 		// 	setTimeout(function() {
// 		// 		$(target).modal('show');
// 		// 	}, 400);
// 		// });

// 		// Autocomplete
// 		$('.select-autocomplete').each(function(index, el) {
// 			var placeholderText = $(this).data('placeholder');
// 			$(this).fastselect({
// 				choiceRemoveClass: 'ico-remove btn-remove',
// 				placeholder: placeholderText
// 			});
// 		});

// 		// Change Class
// 		$('[data-change-class]').on('click', function(event) {
// 			event.preventDefault();

// 			var cl = $(this).data('change-class');
// 			var $target = $($(this).attr('href'));

// 			$target.attr('class', cl);
// 		});

// 		// Teams Sortable
// 		var delay = $win.width() < 768 ? 300 : 0;

// 		/*$('.teams-sortable').sortable({
// 			items: '.team-sortable',
// 			delay: delay,
// 			revert: 300
// 		});*/

// 		// Create Team
// 		// var newTeamsCount = 0;

// 		// $('.teams .team-create').on('click', function(event) {
// 		// 	event.preventDefault();

// 		// 	var tpl = $($(this).attr('href')).html();
// 		// 	var $team = $(template(tpl, {
// 		// 		image: Math.round(Math.random() * 8) + 1
// 		// 	}));

// 		// 	$(this).closest('.team').before($team);

// 		// 	$(this).closest('.teams-sortable').sortable('refresh');

// 		// 	$team.find('.team-title').focus().on('blur keydown', function(event) {
// 		// 		if (event.keyCode === 13 || event.type === 'blur') {
// 		// 			$(this).removeAttr('contentEditable');

// 		// 			if ($(this).html() == '') {
// 		// 				$(this).html('Team ' + leadingZero(newTeamsCount + 1));
// 		// 				newTeamsCount++;
// 		// 			};
// 		// 		};
// 		// 	});
// 		// });

// 		// Teams Slider
// 		/*var $teamsSlider = $('.teams-slider .teams-slides').owlCarousel({
// 			loop: false,
// 			items: 5,
// 			nav: true,
// 			slideBy: 1,
// 			dotsEach: 1,
// 			navText: ['<i class="ico-prev"></i>', '<i class="ico-next"></i>'],
// 			responsive: {
// 				0: {
// 					items: 1
// 				},
// 				480: {
// 					items: 3
// 				},
// 				768: {
// 					items: 4
// 				},
// 				1024: {
// 					items: 5
// 				}
// 			}
// 		});*/

// 		/*$teamsSlider.on('refreshed.owl.carousel', function(event) {
// 			$teamsSlider.trigger('to.owl.carousel', event.item.count - $teamsSlider.find('.owl-item.active').length);
// 		});

// 		$teamsSlider.on('translated.owl.carousel', function(event) {
// 			var $teamNew = $(this).find('.team-new');
// 			$teamNew.find('.team-title').focus().on('blur keydown', function(event) {
// 				if (event.keyCode === 13 || event.type === 'blur') {
// 					$(this).removeAttr('contentEditable');
// 					$(this).closest('.team').removeClass('team-new');

// 					if ($(this).html() == '') {
// 						$(this).html('Team ' + leadingZero(newTeamsCount + 1));
// 						newTeamsCount++;
// 					};
// 				};
// 			});

// 			teamDroppable($teamNew);
// 		});*/

// 		$('.teams-create .team-create').on('click', function(event) {
// 			event.preventDefault();

// 			var tpl = $($(this).attr('href')).html();
// 			var $team = template(tpl, {
// 				image: Math.round(Math.random() * 8) + 1
// 			});

// 			$teamsSlider.trigger('add.owl.carousel', $team);
// 			$teamsSlider.trigger('refresh.owl.carousel');
// 		});

		// Team Droppable
		function teamDroppable(that) {
			var accept = $(that).data('accept');

			$(that).droppable({
				accept: accept,
				hoverClass: 'team-highlighted',
				over: function(event, ui) {
					ui.draggable.addClass('user-draggable-over');
				},
				out: function(event, ui) {
					ui.draggable.removeClass('user-draggable-over');
				},
				deactivate: function(event, ui) {
					ui.draggable.removeClass('user-draggable-over');
				},
				drop: function(event, ui) {
					$(that).addClass('team-dropped');
					ui.draggable.addClass('user-dropped');

					setTimeout(function() {
						ui.draggable.removeAttr('style');
					}, 400);

					setTimeout(function() {
						$(that).removeClass('team-dropped');
						ui.draggable.removeClass('user-dropped');
					}, 1000);
				}
			});
		};

		$('.team-droppable').each(function() {
			teamDroppable(this);
		});

		$('.teams-create .team-droppable').on('drop', function(event) {
			$(this).find('.team-create').trigger('click');
		});

		// User Draggable
		function userDraggable($items) {
			$items.draggable({
				revert: 'invalid',
				stop: function(event, ui) {
					$(this).removeClass('user-draggable-over');
				},
			});
		};

// 		userDraggable($('.user-draggable'));

// 		// User Groups
// 		$('.users').on('click', '.user-alt .user-groups', function(event) {
// 			event.stopPropagation();
// 		});

// 		// Create User Group
// 		$('.users').on('click', '.user-alt .user-create-group', function(event) {
// 			event.preventDefault();

// 			var tpl = $($(this).data('template')).html();
// 			var $userGroup = $(template(tpl, {
// 				user: $(this).closest('.user-alt').index(),
// 				group: $(this).closest('li').index()
// 			}));

// 			$(this).closest('li').before($userGroup);

// 			setTimeout(function() {
// 				$userGroup.find('label').focus().on('blur keydown', function(event) {
// 					if (event.keyCode === 13 || event.type === 'blur') {
// 						$(this).removeAttr('contentEditable');
// 						$(this).siblings('input').prop('disabled', false);

// 						if ($(this).html() == '') {
// 							$(this).html('Team ' + leadingZero(newTeamsCount + 1));
// 							newTeamsCount++;
// 						};
// 					};
// 				});
// 			}, 100);
// 		});

// 		// User Messages
// 		$('.users').on('click', '.user-alt .user-message', function(event) {
// 			event.preventDefault();

// 			$(this).closest('.user-alt').find('.user-expand').fadeIn(300);
// 			$(this).closest('.user-alt').siblings().find('.user-expand').hide();
// 		});

// 		$('.users').on('click', '.user-alt .messages-close', function(event) {
// 			event.preventDefault();

// 			$(this).closest('.user-expand').fadeOut(300);
// 		});

// 		$('.users, .section-team-page, .section-inbox').on('submit', '.form-message form', function(event) {
// 			event.preventDefault();

// 			var $target = $($(this).attr('action'));
// 			var tpl = $('#message-template').html();

// 			var avatar = $(this).find('.field-message-avatar').val();
// 			var author = $(this).find('.field-message-author').val();
// 			var content = $(this).find('.field-message-content').val();

// 			content = '<p>' + content.replace(new RegExp('\n\n', 'g'), '</p><p>').replace(new RegExp('\n', 'g'), '<br>') + '</p>';

// 			if (content !== '') {
// 				var $message = $(template(tpl, {
// 					avatar: avatar,
// 					author: author,
// 					content: content
// 				}));

// 				$target.append($message.fadeIn(300));
// 				$(this).find('.field-message-content').val('');
// 			};
// 		});

// 		// User Touch
// 		$('.users').on('touchstart', '.user-alt', function(event) {
// 			$(this).addClass('user-touch').siblings().removeClass('user-touch');
// 		});

// 		// Infinite Scroll
// 		var $infinite = $('.infinite-scroll');
// 		var loading = false;

// 		if ($infinite.length) {
// 			$win.on('scroll.infiniteScroll', function(event) {
// 				var sectionBottom = $infinite.offset().top + $infinite.outerHeight();

// 				if ($win.scrollTop() + $win.height() > sectionBottom + 100) {
// 					var nextPageHref = $infinite.data('src');

// 					if(loading) {
// 						return;
// 					};

// 					loading = true;
// 					$infinite.addClass('infinite-loading')

// 					loadPage(nextPageHref)
// 						.success(function(response) {
// 							$infinite.data('src', nextPageHref.replace(/\d+/, function(match) {

// 								return parseInt(match) + 1;
// 							}));

// 							var $content = $(response);

// 							userDraggable($content.find('.user-draggable'));

// 							$infinite.append($content);
// 						})
// 						.error(function() {
// 							hasNextPage = false;

// 							$win.off('scroll.infiniteScroll');
// 						})
// 						.always(function() {
// 							loading = false;
// 							$infinite.removeClass('infinite-loading')
// 						});
// 				}
// 			}).scroll();
// 		};

// 		function loadPage(href) {
// 			return $.ajax({
// 				url: href,
// 				type: 'get'
// 			});
// 		};

// 		// Sticky Item
// 		$('.sticky-wrapper').each(function(index, el) {
// 			var $this = $(this);
// 			var $sticky = $this.find('.sticky-item');

// 			$win.on('scroll', function(event) {
// 				if ($win.scrollTop() > $this.offset().top) {
// 					$sticky.addClass('sticky-fixed');
// 				} else {
// 					$sticky.removeClass('sticky-fixed');
// 				};
// 			});
// 		});

// 		// Checkbox
// 		$('.checkbox-group').on('change', function(event) {
// 			var $group = $($(this).data('group'));

// 			$group.prop('checked', this.checked);
// 		});

// 		// Section Inbox
// 		$('.conversation > a, .conversation-compose > a').on('click', function(event) {
// 			event.preventDefault();

// 			$(this).closest('.section-inbox').addClass('has-selected');
// 		});

// 		$('.section-inbox .section-back').on('click', function(event) {
// 			event.preventDefault();

// 			$(this).closest('.section-inbox').removeClass('has-selected');
// 		});

// 		// Change Image
// 		$('.change-image').on('click', function(event) {
// 			event.preventDefault();

// 			var src = $(this).find('img').first().attr('src');
// 			var $target = $($(this).attr('href'));

// 			$target.attr('src', src);
// 		});


// 		// Mass Message
// 		$('.link-mass-message').on('click', function(event) {
// 			event.preventDefault();

// 			setTimeout(function() {
// 				$('body').one('click', function(event) {
// 					$('.section-team-page .section-head-close').trigger('click');
// 				});
// 			}, 500);
// 		});

// 		$('.section-team-page .form-message, .section-team-page .section-actions a:not(.link-mass-message)').on('click', function(event) {
// 			event.stopPropagation();
// 		});

// 		// Team Invites
// 		$('.tabs-invites .tab-pane input').on('input', function(event) {
// 			var allFilled = true;
// 			var $tabBtn = $(this).closest('.tabs-invites').find('.active a');

// 			$(this).closest('.tab-pane').find('input').each(function(index, el) {
// 				if ($(this).val() === '') {
// 					allFilled = false;
// 					return false;
// 				};
// 			});

// 			if (allFilled) {
// 				$tabBtn.addClass('team-filled');
// 			} else {
// 				$tabBtn.removeClass('team-filled');
// 			};
// 		});

// 		var $creatives = $('.creatives');
// 		var creativesOpen = false;
// 		$('.toggle-creatives').on('click', function(event) {
// 			event.preventDefault();

// 			if ( creativesOpen ) {
// 				$('.main-toggle').css('min-height', 0);

// 				creativesOpen = false;
// 			} else {
// 				$('.main-toggle').css('min-height', $creatives.height());

// 				creativesOpen = true;
// 			}

// 			$('.main-toggle').toggleClass('pushed')
// 		});
	});
})(jQuery, window, document);
