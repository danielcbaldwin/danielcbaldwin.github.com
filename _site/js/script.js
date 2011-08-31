/* Author: 

*/
$(function() {
	$("#contact-form").submit(function() {
		var errors = [],
			_form = $(this);

		// Loop through all inputs, selects, and textareas
		$('input[type=text]:visible, select:visible, textarea:visible', _form).each(function(i, val) {
			var label = $(_form).find('label[for='+$(this).attr('id')+']').text() || null;

			if (label == null) {
				label = $(this).closest('td:has(label), div:has(label)').find('label').text() || null;
			}

			// Validate Required Field
			if (( $(this).hasClass('required') && $(this).val() == "") || ( label.match(/(\*)+/ig) && $(this).val() == "" )) {
				errors.push('The "'+utils.cleanLabel(label)+'" field is required.');
			}

			// Validate Email Address
			if ($(this).attr('name').match(/email/ig) || $(this).hasClass('email') || $(this).hasClass('validate-email')) {
				if (!$(this).val().match(/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/)) {
					errors.push('The "'+utils.cleanLabel(label)+'" field does not contain a valid email address.');
				}	
			}
		});

		// Check if there are any errors and if there are errors then show them and stop submission of the form.
		if (errors.length > 0) {
			utils.addErrors(errors, _form);
			return false;
		} else {
			utils.removeErrors(_form);
		}
	});
	
	// The utils object, used to store general variables and functions.
		var utils = {
	    // Function to clean up labels before they are used in error messages.
			cleanLabel: function(label) {
				label = label.replace(/(\*)+/ig, '');

				return label;
			},

	    // Function to add the error messages to the page for the specified form.
			addErrors: function(errors, _form) {
				this.removeErrors(_form);
				$("div.errors", _form).html(errors.join('<br />'));
			},

	    // Function to remove the error messages from the page for the specified form.
			removeErrors: function(_form) {
				$("div.errors", _form).html("");
			}
		};
});






















