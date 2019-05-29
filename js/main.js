$(document).ready(function() {
	 // Owl carousel code

	// Dropdown Visibility on hover
	$('li.dropdown').on('mouseover', function(){
	  		$(this).addClass('open');
	})

	.on('mouseout', function(){
		$(this).removeClass('open');
	});

	
	// fade in #back-top

	$(window).scroll(function () {
		if ($(this).scrollTop() >800) {
			$('#back-top').fadeIn('slow');
		} else {
			$('#back-top').fadeOut('slow');
		}
	});

	// scroll body to 0px on click
	$('#back-top').click(function () {
		$('body,html').animate({
			scrollTop: 0
		}, 800);
		return false;
	});

	$('#myTab a').click(function (e) {
		e.preventDefault()
		$(this).tab('show')
	})

});