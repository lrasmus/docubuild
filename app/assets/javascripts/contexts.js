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