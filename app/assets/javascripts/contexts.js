function _getContextListItems(contextItem) {
  var values = [];
  var codeSystemOid = contextItem.attr('data-code-system-oid');
  var codeSystemName = contextItem.attr('data-code-system-name');
  contextItem.find("input:checkbox:checked").each(function() {
    values.push( {code: $(this).val(), codeSystem: codeSystemOid, codeSystemName: codeSystemName } );
  });
  return (values.length == 0) ? null : values;
}

function _getMainSearchCriteriaItems(contextItem) {
  var values = [];
  contextItem.find(".term").each(function() {
    var item = {};
    item.code = $(this).find(".termCodeValue").val();
    item.codeSystem = $(this).find(".termCodeSystem option:selected").val();
    item.codeSystemName = $(this).find(".termCodeSystem option:selected").text();
    if (item.codeSystem && item.code) {
      values.push(item);
    }
  });
  return (values.length == 0) ? null : values;
}

function getInfobuttonContext(formElement) {
  var itemContexts = [];
  formElement.find(".contextItemContainer").each(function() {
    var context = {};
    context.category = $(this).find(".contextElement").val();
    if (context.category === "") {
      // Do nothing
    }
    else {
      var elementDetails = $(this).find(".contextDetails." + context.category);
      if (context.category === "mainSearchCriteria") {
        context.values = _getMainSearchCriteriaItems(elementDetails);
      }
      else {
        context.values = _getContextListItems(elementDetails);
      }
    }

    if (context.category && context.values) {
      itemContexts.push(context);
    }
  });

  return {context: itemContexts};
}

$(function() {
  $(".add_context_link").on("click", function(e) {
    e.preventDefault();
    var button = $(this);
    $.get(button.attr('href'), function(data) {
      $(data).insertBefore(button);
    });
  });

  $(".save_context_link").on("click", function(e) {
    e.preventDefault();
    var form = $(this).closest(".context_form");
    var context = getInfobuttonContext(form);
    $.post($(this).attr('href'), context, function(data) {
      debugger;
    });
  });

  $("body").on("click", ".addTerm", function(e) {
    e.preventDefault();
    var template = $(this).closest(".mainSearchCriteria").find(".termTemplate").clone().removeClass("termTemplate").addClass("term");
    template.insertBefore($(this).closest(".mainSearchCriteria").find("div.actions"));
  });

  $("body").on("click", ".removeTerm", function(e) {
    e.preventDefault();
    $(this).closest(".term, .contextItemContainer").remove();
  });
});