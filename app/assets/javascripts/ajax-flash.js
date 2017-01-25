// Simple helper to flash a notification message to the user, ensuring that it's not called
// repeatedly if a message is displaying.  Otherwise, you get an ugly series of messages showing
// and hiding one after the other.

function AjaxFlash() {}

AjaxFlash.flash = function(id, message) {
  if (!$(id).is(":visible")) {
    $(id).html(message).slideToggle(150);
    setTimeout(function() {$(id).slideToggle(150);}, 4000);
  }
}