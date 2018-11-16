// Adapted from http://jsfiddle.net/DkHyd/
// This will make all panels visible by default
$.fn.togglepanels = function(){
  return this.each(function(){
    $(this).addClass("ui-accordion ui-accordion-icons ui-widget ui-helper-reset");
    var openSections = $(this).find(".dub-section-title.dub-default-open");
    openSections.addClass("ui-accordion-header ui-helper-reset ui-state-default ui-corner-top ui-corner-bottom")
      .hover(function() { $(this).toggleClass("ui-state-hover"); })
      .prepend('<span class="fa fa-caret-down"></span>')
      .click(function() {
        $(this)
          .toggleClass("ui-accordion-header-active ui-state-active ui-state-default ui-corner-bottom")
          .find("> .fa").toggleClass("fa-caret-down fa-caret-right").end()
          .next().slideToggle();
        return false;
      })
      .next()
        .addClass("ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom")
        .show();

    var closedSections = $(this).find(".dub-section-title.dub-default-collapse");
    closedSections.addClass("ui-accordion-header ui-helper-reset ui-state-default ui-corner-top ui-corner-bottom")
      .hover(function() { $(this).toggleClass("ui-state-hover"); })
      .prepend('<span class="fa fa-caret-right"></span>')
      .click(function() {
        $(this)
          .toggleClass("ui-accordion-header-active ui-state-active ui-state-default ui-corner-bottom")
          .find("> .fa").toggleClass("fa-caret-down fa-caret-right").end()
          .next().slideToggle();
        return false;
      })
      .next()
        .addClass("ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom")
        .hide();

    var staticSections = $(this).find(".dub-section-title.dub-no-collapse");
    staticSections.addClass("ui-accordion-header ui-helper-reset ui-state-default ui-corner-top ui-corner-bottom")
      .hover(function() { $(this).toggleClass("ui-state-hover"); })
      .next()
        .addClass("ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom")
        .show();
  });
};