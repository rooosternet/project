// var create_team = function(attributes,target){
  // console.log(attributes);
  // 	$.ajax({
  // 		url: "/teams/",
  // 		type: 'post',
  // 		data: {team: attributes },
  // 		dataType: 'script',
  // 		success: function(data){
  			// console.log(data);
  // 			$("a.team-inner").filter("[href='#']").attr('href',"/teams/" + data);
  // 			if(target){
  // 				target.attr('data-team',data);
  // 			}
  // 		},
  // 		error: function(data){
  			// console.log(data);
  // 		},
  // 		complete: function(data){
  			// console.log(data);
  // 		}
  // 	});
// }

var alertMsg = function(title,message){
  $("#modal-alert-message-alt .form-head h4").text(title);
  $("#modal-alert-message-alt .form-head p").text(message);
  $("#modal-alert-message-alt").modal('show');
};

var add_profile_to_team = function(profile_id,team_id){
	// console.log(profile_id +" "+ team_id);
	$.ajax({
		url: "/teams/"+team_id,
		type: 'PUT',
		data: {team: {team_profiles_attributes: {team_id: team_id, profile_id: profile_id} }},
		dataType: 'script',
		success: function(data){
			// console.log(data);
		},
		error: function(data){
			// console.log(data);
		},
		complete: function(data){
			// console.log(data);
			return data;
		}
	});
}

var remove_profile_from_team = function(profile_id,team_id){
	// console.log(profile_id +" "+ team_id);
	$.ajax({
		url: "/teams/remove_profile",
		type: 'POST',
		data: {team_profile: {team_id: team_id, profile_id: profile_id}},
		dataType: 'script',
		success: function(data){
			// console.log(data);
		},
		error: function(data){
			// console.log(data);
		},
		complete: function(data){
			// console.log(data);
			return data;
		}
	});
}

var update_team = function(team_id,properties){
	// console.log(team_id);
	// console.log(properties);

	$.ajax({
		url: "/teams/"+team_id,
		type: 'PUT',
		data: {team: properties},
		dataType: 'script',
		success: function(data){
			// console.log(data);
		},
		error: function(data){
			// console.log(data);
		},
		complete: function(data){
			// console.log(data);
			return data;
		}
	});
}

var update_teams_order = function(team_ids){
	// console.log(team_ids);

	$.ajax({
		url: "/teams/update_teams_order",
		type: 'post',
		data: {team_ids: team_ids},
		dataType: 'script',
		success: function(data){
			// console.log(data);
		},
		error: function(data){
			// console.log(data);
		},
		complete: function(data){
			// console.log(data);
		}
	});
}

var update_profile_image = function(user_id,properties){
	// console.log(user_id);
	// console.log(properties);

	$.ajax({
		url: "/users/"+user_id+"/update_profile_image",
		type: 'post',
		data: {user: properties},
		dataType: 'script',
		success: function(data){
			// console.log(data);
		},
		error: function(data){
			// console.log(data);
		},
		complete: function(data){
			// console.log(data);
			return data;
		}
	});
}

var update_user = function(user_id,properties){
	// console.log(user_id);
	// console.log(properties);

	$.ajax({
		url: "/users/"+user_id,
		type: 'PUT',
		data: {user: properties},
		dataType: 'script',
		success: function(data){
			// console.log(data);
		},
		error: function(data){
			// console.log(data);
		},
		complete: function(data){
			// console.log(data);
			return data;
		}
	});
}

;(function($, window, document, undefined) {
	var $win = $(window);
	var $doc = $(document);

	// Leading Zero
	function leadingZero(number) {
		return number < 10 ? '0' + number : '' + number;
	};

	$doc.ready(function() {

	  //// Scroll To
  		// $('[data-scroll-to]').on('click', function(event) {
  		// 	event.preventDefault();

  		// 	var target = $(this).data('scroll-to');

  		// 	$('html, body').animate({
  		// 		scrollTop: $(target).offset().top
  		// 	}, 500);
  		// });

  		// // Button Collapse Form
  		// $('.btn-collapse-form').bind('click', function(event) {
  		// 	event.preventDefault();
  		// 	$(this).hide();
  		// });

  		// // Modal Fix
  		// $('.header [data-toggle="modal-alt"]').on('click', function(event) {
  		// 	event.preventDefault();

  		// 	var target = $(this).attr('href');

  		// 	if(!$('.modal-backdrop').length) {
  		// 		$(target).modal('show');
  		// 		return;
  		// 	}

  		// 	$('.modal').modal('hide');
  		// 	setTimeout(function() {
  		// 		$(target).modal('show');
  		// 	}, 400);
  		// });

  		// // Autocomplete
  		// $('.select-autocomplete').each(function(index, el) {
  		// 	var placeholderText = $(this).data('placeholder');
  		// 	$(this).fastselect({
  		// 		choiceRemoveClass: 'ico-remove btn-remove',
  		// 		placeholder: placeholderText
  		// 	});
  		// });

    // Simple Templates
    function template(tpl, vars) {
      return tpl.replace(/{{([^}]+)}}/g, function(match, property) {
        var arr = property.split('.');
        var obj = vars[arr.shift()];

        while(arr.length > 0 && typeof obj === 'object') {
          obj = obj[arr.shift()];
        }

        return typeof obj === 'undefined' ? match : obj;
      });
    };

    // Teams Slider
    var $teamsSlider = $('.teams-slider .teams-slides').owlCarousel({
      loop: false,
      items: 5,
      nav: true,
      slideBy: 1,
      dotsEach: 1,
      navText: ['<i class="ico-prev"></i>', '<i class="ico-next"></i>'],
      responsive: {
        0: {
          items: 1
        },
        480: {
          items: 3
        },
        768: {
          items: 4
        },
        1024: {
          items: 5
        }
      }
    });

    // handle long team list
    var checkShowAllToggle = function(){
      var lists = $('.user-groups');

      $.each(lists, function(i,l) {
        var length = $(l).find('li').length,
            allButton = $(l).find('.show-all-teams');
        if (length > 10) {
          allButton.show();
        } else {
          allButton.hide();
        }
      });
    };
    checkShowAllToggle();

    var create_team = function(attributes,onSeccuss,onFail){
      onSeccuss = onSeccuss || function(){};
      onFail = onFail || function(){};

      $.ajax({
        url: "/teams/",
        type: 'post',
        data: {team: attributes },
        dataType: 'script',
        success: function(data){
          onSeccuss(data);
          // if(target){
          //  target.attr('data-team',data);
          // }
        },
        error: function(data){
          console.log(data);
          // alert(data.responseText);
          onFail(data.responseText);
        },
        complete: function(data){
          console.log(data);
        }
      });
    }

    var addItemToCarousel = function (teamData){
      teamData = teamData || {};
      var tpl = $('#template-team').html(),
          name = teamData.name || '',
          imageId = teamData.image || Math.round(Math.random() * 8),
          image = team_images[imageId],
          image_name = "team"+(imageId + 1),
          teamId = teamData.id || '',
          team = template(tpl, {
            image: image,
            image_name: image_name,
            name: name,
            team_id: teamId
          });

      $teamsSlider.trigger('add.owl.carousel', team);
      $teamsSlider.trigger('refresh.owl.carousel');

      if(name == '') {
        var teamCreated = false;
        $('.teams-slider').find('.team-new .team-title').focus().on('blur keydown', function(event) {
          var $this = $(this);
          if ((event.keyCode === 13 || event.type === 'blur') && !teamCreated) {
            teamCreated = true;

            $this.removeAttr('contentEditable');
            $this.closest('.team').removeClass('team-new');

            if ($this.html() == '') {
              $this.html('Team ' + leadingZero(newTeamsCount + 1));
              newTeamsCount++;
            }

            var attrs = {
              name: $this.html(),
              image: image,
            }

            create_team(attrs,
              // onSuccess
              function(id){
                  $this.parent().attr('href',"/teams/" + id);
                  // $this.siblings().first().addClass('team-image-'+id);
                  $this.siblings().find('.team-count').addClass('team-count-'+id);
                  teamDroppable($this.parents('.team-droppable'));
                  addItemToTeamsList({
                    name: attrs.name,
                    image: attrs.image,
                    id: id
                  });
              },function(message){ //onFail
                // $this.focus();
                teamCreated = false;
                alertMsg("Create Team Failed!",message);
                index = $(".owl-item.active").last().index();
                $teamsSlider.trigger('remove.owl.carousel', index).trigger('refresh.owl.carousel')

                // $(".owl-item.active .team-title").last().focus();
                // $this.parent().parent().remove();
              });
          }
        });
      } else {
        $('.teams-slider').find('.team-new .team-inner').attr('href',"/teams/" + teamId);
        $('.teams-slider').find('.team-new .team-count').addClass('team-count-'+teamId);
        $('.teams-slider').find('.team-new').removeClass('team-new');
        teamDroppable(team);
      }

      checkShowAllToggle();
    }

    // Add new added team to the teams list on the profile card
    var addItemToTeamsList = function (teamData){
      teamData = teamData || {}
      var backetid = $("a.team-inner").attr('href').match(/\d+/)[0];

      var tpl = $('#user-group-template').html(),
          name = teamData.name || '',
          imageId = teamData.image || Math.round(Math.random() * 8),
          image = team_images[imageId],
          profile_id = teamData.profile_id,
          teamId = teamData.id || '',
          $userGroup = $(template(tpl, {
            user: profile_id,
            name: name,
            group: teamId
          }));

      $('#profile_'+profile_id).find('.show-all-teams').before($userGroup);

      if(name == ''){
        var teamCreated = false;
        var selected_profile_id = profile_id;
        $userGroup.find('label').focus().on('blur keydown', function(event) {
          var $this = $(this);
          if ((event.keyCode === 13 || event.type === 'blur') && !teamCreated) {
            teamCreated = true;
            $this.removeAttr('contentEditable');
            if($this.html() == '') {
              $(this).html('Team ' + leadingZero(newTeamsCount + 1));
              newTeamsCount++;
            }
            var newName = $this.text()
            $this.siblings('input').prop('disabled', false).attr("checked", "checked");

            create_team({name: newName, image: image, team_profiles_attributes: {profile_id: profile_id}}, function(id){
              var newAttr = 'field-user' + profile_id + '-group' + id;
              $userGroup.find('label').attr({for: newAttr, 'data-team': id});
              $userGroup.find('input').attr({name: newAttr, id: newAttr, 'data-team': id});
              $userGroup.removeAttr('style')

              $.each($('.dropdown-menu.user-groups:not(#profile_'+profile_id +')'), function(i,list){
                var profileId = $(list).data('profile'),
                    tmplt = $(template(tpl, {
                      user: profileId,
                      group: id,
                      name: newName
                    }));

                var attr = 'field-user' + profileId + '-group' + id;
                tmplt.find('input').attr({name: attr, id: attr}).prop('disabled', false);
                tmplt.find('label').attr('for', attr).removeAttr('contentEditable');
                tmplt.removeAttr('style');
                $(list).find('.show-all-teams').before(tmplt);
              });
              addItemToCarousel({
                image: imageId,
                name: newName,
                id: id
              });
              $userGroup.find('input').trigger('change');
            },function(message){
              teamCreated = false;
              $("#field-user"+selected_profile_id+"-group").parent().parent().remove();
              alertMsg("Create Team Failed!",message);
            });
          }
        });
      } else {
        $.each($('.dropdown-menu.user-groups'), function(i,list){
          var $list = $(list),
              profileId = $list.data('profile'),
              tmplt = $(template(tpl, {
                user: profileId,
                group: teamId,
                name: name
              }));

            var attr = 'field-user' + profileId + '-group' + teamId;
            tmplt.find('input').attr({name: attr, id: attr}).prop('disabled', false);
            tmplt.find('label').attr('for', attr).removeAttr('contentEditable');
            tmplt.removeAttr('style');
            $(list).find('.show-all-teams').before(tmplt);
        });
      }

      checkShowAllToggle();
    }

    $('.infinite-scroll').on('click', '.user-groups .show-all-teams', function(e) {
      e.preventDefault();
      $(this).parents('.user-groups').toggleClass('show-all');
    });

		$(".team-page-name,.team-page-description").focusout(function(){
			var target = $(this).parent();
			// console.log(target);
			var team_id = target.data('team-id');
			// console.log("team_id: " + team_id);
			update_team(team_id,{name: target.find(".team-page-name")[0].innerText, description: target.find(".team-page-description")[0].innerText});
		});

    //editable fields////////////////////////////
    $(".user-description").focusout(function(){
      var target = $(this).parent();
      var user_id = target.data('user-id');

      update_profile(user_id,{description: target.find(".user-description")[0].innerText});
    });

    $(".user-location").focusout(function(){
      var target = $(this).parent();
      var user_id = target.data('user-id');

      update_profile(user_id,{location: target.find(".user-location")[0].innerText});
    });

    $(".user-about-me").focusout(function(){
      var target = $(this).parent();
      var user_id = target.data('user-id');

      update_profile(user_id,{about_me: target.find(".user-about-me")[0].innerText});
    });

    // $("#edit_user").focusout(function(){
    //   this.submit();
    // });

    update_profile = function(user_id, properties){
      $.ajax({
        url: "/users/"+user_id+"/update_profile",
        type: 'PUT',
        data: {profile: properties},
        dataType: 'script',
        success: function(data){
          // console.log(data);
        },
        error: function(data){
          // console.log(data);
        },
        complete: function(data){
          // console.log(data);
          return data;
        }
      });
    }
    ///////////////////////////////////////////////

		// Scroll To
		$('[data-scroll-to]').on('click', function(event) {
			event.preventDefault();

			var target = $(this).data('scroll-to');

			$('html, body').animate({
				scrollTop: $(target).offset().top
			}, 500);
		});

		// Button Collapse Form
		$('.btn-collapse-form').on('click', function(event) {
			event.preventDefault();

			$(this).hide();
		});

		// Modal Fix
		$('.header [data-toggle="modal-alt"]').on('click', function(event) {
			event.preventDefault();

			var target = $(this).attr('href');

			if(!$('.modal-backdrop').length) {
				$(target).modal('show');
				return;
			}

			$('.modal').modal('hide');
			setTimeout(function() {
				$(target).modal('show');
			}, 400);
		});

		// Autocomplete
		$('.select-autocomplete').each(function(index, el) {
			var placeholderText = $(this).data('placeholder');
			$(this).fastselect({
				choiceRemoveClass: 'ico-remove btn-remove',
				placeholder: placeholderText,
        noResultsText: 'No results'
			});
		});

		// Change Class
		$('[data-change-class]').on('click', function(event) {
			event.preventDefault();

			var cl = $(this).data('change-class');
			var $target = $($(this).attr('href'));

			$target.attr('class', cl);
		});

		// Teams Sortable
		var delay = $win.width() < 768 ? 300 : 0;

		$('.teams.teams-sortable').sortable({
			items: 'li.team-sortable',
			delay: delay,
			revert: 300,
		      update: function(e, ui){
		        var team_ids = $('.teams .team-sortable .team-inner').map(function() {return $(this).attr('href').match(/\d+/);}).get();
				update_teams_order(team_ids);
		      }
		});

		// Create Team
    // Moved to layout/application
		// var newTeamsCount = 0;
		var last_team_id = 0;
		$('.teams .team-create').on('click', function(event) {
			event.preventDefault();
			console.log(1);
			var tpl = $($(this).attr('href')).html();

			if(last_team_id == 19){
				last_team_id = 0;
			}
      var image_id =  Math.round(Math.random() * 18),
          image_name =  team_images[image_id], //"team"+(image_id + 1);
          last_team_id = image_id,
          $team = $(template(tpl, {
            image: team_images[image_id],
            name: ''
          }));
      $(this).closest('.team').before($team);

      $(this).closest('.teams-sortable').sortable('refresh');
      var team_created = false;

      $team.find('.team-title').focus().on('blur keydown', function(event) {
        if ((event.keyCode === 13 || event.type === 'blur') && !team_created) {
          team_created = true
          $(this).removeAttr('contentEditable');
          if ($(this).html() == '') {
            $(this).html('Team ' + leadingZero(newTeamsCount + 1));
            newTeamsCount++;
          }

          create_team({name: $(this).html(),image: image_name }, function(id){
            $("a.team-inner").filter("[href='#']").attr('href',"/teams/" + id);
            teamDroppable($team);
          },function(message){
              team_created = false
             $("a.team-inner").filter("[href='#']").parent().remove();
             alertMsg("Create Team Failed!",message);
          });
        };
      });
      //teamDroppable($team);
    });

		$teamsSlider.on('refreshed.owl.carousel', function(event) {
			$teamsSlider.trigger('to.owl.carousel', event.item.count - $teamsSlider.find('.owl-item.active').length);
		});

		// $teamsSlider.on('add.owl.carousel', function(event) {
			// var $teamNew = $(this).find('.team-new');
			// var team_created = false;

			// $teamNew.find('.team-title').focus().on('blur keydown', function(event) {

			// 	if (event.keyCode === 13 || event.type === 'blur') {
			// 		$(this).removeAttr('contentEditable');
			// 		$(this).closest('.team').removeClass('team-new');

			// 		if ($(this).html() == '') {
			// 			$(this).html('Team ' + leadingZero(newTeamsCount + 1));
			// 			newTeamsCount++;
			// 		};

			// 		if(team_created == false){
			// 			// create_team({name: $(this).html(),image: $(this).closest('.team').data('image')},$(this));
			// 			// console.log("+++++");
			// 			// team_created = true
			// 			create_team({name: $(this).html(),image: $(this).closest('.team').data('image')}, function(id){
			// 				team_created = true
			// 				$("a.team-inner").filter("[href='#']").attr('href',"/teams/" + id);
			// 				$(this).attr('data-team',id);
			// 				teamDroppable($teamNew);
			// 			})
			// 		};
			// 	};
			// });
			// teamDroppable($teamNew);
		// });

    // Create User Group
    // teams list inside member
    $('.users').on('click', '.user-alt .user-create-group', function(event) {
      event.preventDefault();
      // addItemToCarousel();
      addItemToTeamsList({
        profile_id: $(this).data('profile')
      });

      // var tpl = $($(this).data('template')).html();
      // var profile_id = $(this).data('profile');
      // var $userGroup = $(template(tpl, {
      //  user: $(this).closest('.user-alt').index(),
      //  group: $(this).closest('li').index()
      // }));

      // $(this).closest('li').before($userGroup);
      // // team_created = false
      // setTimeout(function() {
      // $userGroup.find('label').focus().on('blur keydown', function(event) {
      // if (event.keyCode === 13 || event.type === 'blur') {
      // $(this).removeAttr('contentEditable');
      // $(this).siblings('input').prop('disabled', false);
      // if ($(this).html() == '') {
        // $(this).html('Team ' + leadingZero(newTeamsCount + 1));
        // newTeamsCount++;
      // };

      // if(team_created == false){
        //  create_team({name: $(this).html(),image: "team1" ,team_profiles_attributes: {profile_id: profile_id}},$(this));
        //  console.log("------");
        //  team_created = true
        //  $(this).addClass("add-profile");
        //  $(this).attr('data-profile',profile_id);
        //  // $(this).attr('data-team',);
      // }
      // create_team({name: $(this).html(),image: "team1" ,team_profiles_attributes: {profile_id: profile_id}}, function(id){
        // $(this).addClass("add-profile");
        // $("a.team-inner").filter("[href='#']").attr('href',"/teams/" + id);
        // $(this).attr('data-profile',id);
        // // teamDroppable(sliderTeam);

        // $(sliderTeam).find('.team-title').html($(this).html());
        // var sliderTpl   = $('#template-team').html(),
        // image_id    = Math.round(Math.random() * 18),
        // image_name  = "team"+(image_id + 1),
        // sliderTeam  = $(template(sliderTpl, {
        // image: team_images[image_id],
        // image_name: image_name
      // }));

      // $teamsSlider.trigger('add.owl.carousel', sliderTeam);
      // $teamsSlider.trigger('refresh.owl.carousel');
      // });
      //    };
      //  });
      // }, 100);
    });

    // inside carousel
    $('.teams-create .team-create').on('click', function(event) {
      event.preventDefault();
      addItemToCarousel();
      console.log('.teams-create .team-create');

		// 	var tpl = $($(this).attr('href')).html();

		// 	var image_id = Math.round(Math.random() * 8);
		// 	var image_name = "team"+(image_id + 1);
		// 	var $team = template(tpl, {
		// 		image: team_images[image_id],
		// 		image_name: image_name
		// 	});

		// 	$teamsSlider.trigger('add.owl.carousel', $team);
		// 	$teamsSlider.trigger('refresh.owl.carousel');
		});

		// Delete team
		$('.team-delete.ico-delete').on('click', function(event) {
			event.preventDefault();
			// console.log("team-delete");
		});

		// Team Droppable
		function teamDroppable(that) {
      var that    = $(that),
          that_id = that.find('a.team-inner').attr('href').match(/\d+/),
          that_id = that_id ? that_id[0] : 0,
          accept  = $(that).data('accept') + ':not(.g-'+that_id+')';
      that.droppable({
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
					that.addClass('team-dropped');
					ui.draggable.addClass('user-dropped g-' + that_id);

					setTimeout(function() {
						ui.draggable.removeAttr('style');
					}, 400);

					setTimeout(function() {
						that.removeClass('team-dropped');
						ui.draggable.removeClass('user-dropped');
					}, 1000);

					var user_id = ui.draggable.parents('li.user-alt').attr('id');
          $('#' + user_id).find('#field-user'+ user_id +'-group'+ that_id).attr("checked", "checked").trigger('change');

					// that.find('.team-count').text(parseInt(that.find('.team-count').text()) + 1).css('color','#fff');

					if(!(that.find('.team-count').hasClass('team-count-backet'))){
						var backet = $('.team-count-backet');
						var team_id = backet.closest('a.team-inner').attr('href').match(/\d+/)[0];
						if(!(ui.draggable.hasClass('g-'+team_id))){
							backet.text(parseInt(backet.text()) + 1).css('color','#fff');
							ui.draggable.addClass('g-' + team_id);
						}
					}
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

		userDraggable($('.user-draggable'));

		// User Groups
		$('.users').on('click', '.user-alt .user-groups', function(event) {
			event.stopPropagation();
		});


		// // Create User Group
		// $('.users').on('click', '.user-alt .user-create-group', function(event) {
		// 	event.preventDefault();

		// 	var tpl = $($(this).data('template')).html();
		// 	var profile_id = $(this).data('profile');
		// 	var $userGroup = $(template(tpl, {
		// 		user: $(this).closest('.user-alt').index(),
		// 		group: $(this).closest('li').index()
		// 	}));

    // $(this).closest('li').before($userGroup);
      //     // team_created = false
      //     setTimeout(function() {
      //       $userGroup.find('label').focus().on('blur keydown', function(event) {
      //         if (event.keyCode === 13 || event.type === 'blur') {
      //           $(this).removeAttr('contentEditable');
      //           $(this).siblings('input').prop('disabled', false);

      //           if ($(this).html() == '') {
      //             $(this).html('Team ' + leadingZero(newTeamsCount + 1));
      //             newTeamsCount++;
      //           };

      // 				// if(team_created == false){
      // 				// 	create_team({name: $(this).html(),image: "team1" ,team_profiles_attributes: {profile_id: profile_id}},$(this));
      // 					console.log("------");
      // 				// 	team_created = true
      // 				// 	$(this).addClass("add-profile");
      // 				// 	$(this).attr('data-profile',profile_id);
      // 				// 	// $(this).attr('data-team',);
      // 				// }
      //           create_team({name: $(this).html(),image: "team1" ,team_profiles_attributes: {profile_id: profile_id}}, function(id){
      //             $(this).addClass("add-profile");
      //             $("a.team-inner").filter("[href='#']").attr('href',"/teams/" + id);
      //             $(this).attr('data-profile',id);
      //             teamDroppable(sliderTeam);
      //             // $(sliderTeam).find('.team-title').html($(this).html());
      //             // var sliderTpl   = $('#template-team').html(),
      //             //     image_id    = Math.round(Math.random() * 18),
      //             //     image_name  = "team"+(image_id + 1),
      //             //     sliderTeam  = $(template(sliderTpl, {
      //             //       image: team_images[image_id],
      //             //       image_name: image_name
      //             //     }));

      //             // $teamsSlider.trigger('add.owl.carousel', sliderTeam);
      //             // $teamsSlider.trigger('refresh.owl.carousel');
      //           });
      // 			};
      // 		});
      // 	}, 100);
    // });

		// Add User To Group
		$('.users').on('change', '.checkbox input[type="checkbox"]', function(event) {
      console.log('change ');
			// event.preventDefault();
      var team_id = $(this).data('team');
			var profile_id = $(this).data('profile');
			var action = $(this).is(':checked');
			var menu_backet = $("#"+$(this).data('backet'));
			// console.log("Add User To Group: " + action);
			var teams_count = $('.team-count-'+team_id);

      if(action == true){
        add_profile_to_team(profile_id,team_id);
        teams_count.text(parseInt(teams_count.text()) + 1).css('color','#fff');

        if(!(teams_count.hasClass('team-count-backet'))){
          var top_backet = $('.team-count-backet');
          top_backet.text(parseInt(top_backet.text()) + 1).css('color','#fff');
        }
        if(menu_backet && !menu_backet.is(':checked')){
          menu_backet.each(function(){ this.checked = true; });
        }
        $(this).closest('.user-main').find('a.user-image').addClass('g-'+team_id);
      } else {
				remove_profile_from_team(profile_id,team_id);
				teams_count.text(parseInt(teams_count.text()) - 1).css('color','#fff');

				if(!(teams_count.hasClass('team-count-backet'))){
					var top_backet = $('.team-count-backet');
					top_backet.text(parseInt(top_backet.text()) - 1).css('color','#fff');
				}
        $(this).closest('.user-main').find('a.user-image').removeClass('g-'+team_id);
			}
		});

		// User Messages
		$('.users').on('click', '.user-alt .user-message', function(event) {
			event.preventDefault();

			$(this).closest('.user-alt').find('.user-expand').fadeIn(300);
			$(this).closest('.user-alt').siblings().find('.user-expand').hide();
		});

		$('.users').on('click', '.user-alt .messages-close', function(event) {
			event.preventDefault();

			$(this).closest('.user-expand').fadeOut(300);
		});

		// $('.users, .section-team-page, .section-inbox').on('submit', '.form-message form', function(event) {
		$('.users, .section-team-page, .section-inbox').on('submit', '.form', function(event) {
			event.preventDefault();

			var $target = $($(this).attr('action'));
			var tpl = $('#message-template').html();

			var avatar = $(this).find('.field-message-avatar').val();
			var author = $(this).find('.field-message-author').val();
			var content = $(this).find('.field-message-content').val();

			content = '<p>' + content.replace(new RegExp('\n\n', 'g'), '</p><p>').replace(new RegExp('\n', 'g'), '<br>') + '</p>';

			if (content !== '') {
				var $message = $(template(tpl, {
					avatar: avatar,
					author: author,
					content: content
				}));

				$target.append($message.fadeIn(300));
				$(this).find('.field-message-content').val('');
			};
		});

		// User Touch
		$('.users').on('touchstart', '.user-alt', function(event) {
			$(this).addClass('user-touch').siblings().removeClass('user-touch');
		});

		// Infinite Scroll
		var $infinite = $('.infinite-scroll');
		var loading = false;

		if ($infinite.length) {
			$win.on('scroll.infiniteScroll', function(event) {
				var sectionBottom = $infinite.offset().top + $infinite.outerHeight();

				if ($win.scrollTop() + $win.height() > sectionBottom + 100) {
					var nextPageHref = $infinite.data('src');

					if(loading) {
						return;
					};

					loading = true;
					$infinite.addClass('infinite-loading')

					loadPage(nextPageHref)
					.success(function(response) {
						$infinite.data('src', nextPageHref.replace(/\d+/, function(match) {

							return parseInt(match) + 1;
						}));

						var $content = $(response);

						userDraggable($content.find('.user-draggable'));

						$infinite.append($content);
            checkShowAllToggle();
					})
					.error(function() {
						hasNextPage = false;

						$win.off('scroll.infiniteScroll');
					})
					.always(function() {
						loading = false;
						$infinite.removeClass('infinite-loading')
					});
				}
			}).scroll();
		};

		function loadPage(href) {
			return $.ajax({
				url: href,
				type: 'get'
			});
		};

		// Sticky Item
		$('.sticky-wrapper').each(function(index, el) {
			var $this = $(this);
			var $sticky = $this.find('.sticky-item');

			$win.on('scroll', function(event) {
				if ($win.scrollTop() > $this.offset().top) {
					$sticky.addClass('sticky-fixed');
				} else {
					$sticky.removeClass('sticky-fixed');
				};
			});
		});

		// Section Inbox
		$('.conversation > a, .conversation-compose > a').on('click', function(event) {
			event.preventDefault();

			$(this).closest('.section-inbox').addClass('has-selected');
		});

		$('.section-inbox .section-back').on('click', function(event) {
			event.preventDefault();

			$(this).closest('.section-inbox').removeClass('has-selected');
		});

		// Change Team Image
		$('.change-image').on('click', function(event) {
			event.preventDefault();

			var src = $(this).find('img').first().attr('src');
			var $target = $($(this).attr('href'));
			var image_name = $(this).data('image');
			$("#user_image").val(image_name);

			$target.attr('src', src);
			var team_id = $target[0].id;
			if(team_id){
				update_team(team_id,{image: image_name});
			}
		});

		// Change User Image
		$('.change-user-image').on('click', function(event) {
			event.preventDefault();

			var src = $(this).find('img').first().attr('src');
			var $target = $($(this).attr('href'));
			var image_name = $(this).data('image');
			$("#user_image").val(image_name);

			$target.attr('src', src);
			var user_id = $(".user-main-image").data('user-id');
			if(user_id){
				update_profile_image(user_id,{image: image_name});
			}
		});

		$('#user_attachments').on('change', function(event) {
			event.preventDefault();
			// console.log("user_attachments");
			// var avatars = $("#user_attachments").val();
			var user_id = $(".user-main-image").data('user-id');
			if(user_id){
				// update_profile_image(user_id,{avatars: [avatars]});
				// update_profile_image(user_id,$('#edit_user').serialize());
				// $.post('users/'+user_id, $('form#edit_user_avatars_form').serialize());
				$('form#edit_user_avatars_form').submit();
			}
		});

    $('#team_attachments').on('change', function(event) {
      event.preventDefault();
      console.log("team_attachments");
      var avatars = $("#team_attachments").val();

      var team_id = $(".team-image-selected")[0].id;
      if(team_id){
        $('form#edit_team_avatars_form').attr('action',"/teams/"+team_id+"/update_team_avatar");
        $('form#edit_team_avatars_form').submit();
      }
    });

		// Mass Message
		// $('.link-mass-message').on('click', function(event) {
		// 	event.preventDefault();

		var update_user = function(user_id,properties){
    	// console.log(user_id);
    	// console.log(properties);

    	$.ajax({
    		url: "/users/"+user_id,
    		type: 'PUT',
    		data: {user: properties},
    		dataType: 'script',
    		success: function(data){
    			// console.log(data);
    		},
    		error: function(data){
    			// console.log(data);
    		},
    		complete: function(data){
    			// console.log(data);
    			return data;
    		}
    	});
    }

		// 	setTimeout(function() {
		// 		$('body').one('click', function(event) {
		// 			$('.section-team-page .section-head-close').trigger('click');
		// 		});
		// 	}, 500);
		// });

		$('.section-team-page .form-message').on('click', function(event) {
			event.stopPropagation();

			var update_user = function(user_id,properties){
      	// console.log(user_id);
      	// console.log(properties);

      	$.ajax({
      		url: "/users/"+user_id,
      		type: 'PUT',
      		data: {user: properties},
      		dataType: 'script',
      		success: function(data){
      			// console.log(data);
      		},
      		error: function(data){
      			// console.log(data);
      		},
      		complete: function(data){
      			// console.log(data);
      			return data;
      		}
      	});
      }
		});

		// var update_user = function(user_id,properties){
  //   	// console.log(user_id);
  //   	// console.log(properties);

  //   	$.ajax({
  //   		url: "/users/"+user_id,
  //   		type: 'PUT',
  //   		data: {user: properties},
  //   		dataType: 'script',
  //   		success: function(data){
  //   			// console.log(data);
  //   		},
  //   		error: function(data){
  //   			// console.log(data);
  //   		},
  //   		complete: function(data){
  //   			// console.log(data);
  //   			return data;
  //   		}
  //   	});
  //   }

		// Team Invites
		$('.tabs-invites .tab-pane input').on('input', function(event) {
			var allFilled = true;
			var $tabBtn = $(this).closest('.tabs-invites').find('.active a');

			$(this).closest('.tab-pane').find('input').each(function(index, el) {
				if ($(this).val() === '') {
					allFilled = false;
					return false;
				};
			});

			if (allFilled) {
				$tabBtn.addClass('team-filled');
			} else {
				$tabBtn.removeClass('team-filled');
			};
		});

	});

})(jQuery, window, document);
