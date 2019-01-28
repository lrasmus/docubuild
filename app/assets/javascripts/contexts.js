function _getContextListItems(contextItem) {
  var values = [];
  var codeSystemOid = contextItem.attr('data-code-system-oid');
  var codeSystemName = contextItem.attr('data-code-system-name');
  contextItem.find("input:checkbox:checked").each(function() {
    values.push({
      code: $(this).val(),
      codeSystem: codeSystemOid,
      codeSystemName: codeSystemName,
      term: $(this).closest("label").text().trim()
    });
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
    item.term = $(this).find(".termCodeText").val();
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

function createTermTemplate(elem) {
  var template = elem.closest(".mainSearchCriteria").find(".termTemplate").find(".term").clone();
  template.insertBefore(elem.closest(".mainSearchCriteria").find(".searchTemplate"));
  return template;
}

$(function() {
  // Init a timeout variable to be used below
  var timeout = null;

  // Listen for keystroke events in the term search field
  $("body").on("keyup", ".termCodeSearch", function (e) {
    var input = $(this);
    // Clear the timeout if it has already been set. This will prevent the previous search
    // from executing.
    clearTimeout(timeout);

    // Make a new timeout set to go off in 500ms - at that point the search will be performed.
    timeout = setTimeout(function () {
      var templateDiv = input.closest(".searchTemplate");
      templateDiv.find("#termSearchError").hide();
      templateDiv.find("#termSearchWaiting").show();
      if (input.val().trim() === '') {
        templateDiv.find("#termSearchResults").html("");
        templateDiv.find("#termSearchWaiting").hide();
      }
      else {
        $.ajax({
          url: '/terminology/search/' + templateDiv.find("#termCodeSystem").val() + '/' + input.val(),
          dataType: 'html'
        }).done(function(data) {
          templateDiv.find("#termSearchResults").html(data);
          templateDiv.find("#termSearchWaiting").hide();
        }).error(function(d) {
          console.log("Error");
          templateDiv.find("#termSearchError").show();
          templateDiv.find("#termSearchWaiting").hide();
        });
      }
    }, 500);
  });

  $("body").on("click", ".add_context_link", function(e) {
    e.preventDefault();
    var button = $(this);
    $.get(button.attr('href'), function(data) {
      $(data).insertBefore(button);
    });
  });

  $("body").on("click", "#selected_term_", function(e) {
    var checkbox = $(this);
    var dataRow = checkbox.closest("tr");
    var template = createTermTemplate(checkbox);
    template.find("#termCodeSystem").val(checkbox.closest(".searchTemplate").find("#termCodeSystem").val());
    var dataElements = dataRow.find("td");
    template.find(".termCodeValue").val(dataElements[1].innerText);
    template.find(".termCodeText").val(dataElements[2].innerText);

    dataRow.remove();
    template.closest(".mainSearchCriteria").find("#no-codes").hide();
  })

  $("body").on("click", ".save_context_link", function(e) {
    e.preventDefault();
    var form = $(this).closest(".context_form");
    var context = getInfobuttonContext(form);
    $.post($(this).attr('href'), context, function(data) {});
  });

  $("body").on("click", ".addTerm", function(e) {
    e.preventDefault();
    createTermTemplate($(this));

    $(this).closest(".mainSearchCriteria").find("#no-codes").hide();
  });

  $("body").on("click", ".removeContextItem", function(e) {
    e.preventDefault();
    $(this).closest(".term, .contextItemContainer").remove();
  });

  $("body").on("click", ".removeTerm", function(e) {
    e.preventDefault();
    var elem = $(this);
    var mainSearchCriteriaElem = elem.closest(".mainSearchCriteria");
    elem.closest(".term").remove();
    if (mainSearchCriteriaElem.children(".term").length == 0) {
      mainSearchCriteriaElem.find("#no-codes").show();
    }
  });
});