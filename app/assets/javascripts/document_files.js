// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$.ajaxSetup({
  headers: {
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  }
});