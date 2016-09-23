$(function () {
  var active = true;
  $('#collapse-init').click(function () {
    if (active) {
      active = false;
      $('.panel-collapse').collapse('show');
      $('.panel-title').attr('data-toggle', '');
      $(this).text('Enable accordion behavior');
    } else {
      active = true;
      $('.panel-collapse').collapse('hide');
      $('.panel-title').attr('data-toggle', 'collapse');
      $(this).text('Disable accordion behavior');
    }
  });
  
  $('#accordion').on('show.bs.collapse', function () {
    if (active) { $('#accordion .in').collapse('hide'); }
  });

  $('a.edit-link').on('click', function(e){
    e.preventDefault();
    var $parent = $(this).closest('div'); 
    $parent.find('.editForm').show();
    $(this).hide();
  });
  
  $('a.cancel').on('click', function(e){
    e.preventDefault();
    var $parent = $(this).closest('.cnt_text'); 
    $parent.find('.editForm').hide();
    $parent.find('a.edit-link').show();
  });
});

$(function(){
  $('.tital_chk').click(function(el){
    var re = new RegExp("cbxShowHide([\\d]+)");
    var match = re.exec(this.id);
    if (match !== null) {
      var checked = !($(this).attr("data-checked"));
      checked?$('#block' + match[1]).show(500):$('#block' + match[1]).hide(500);
      $(this).attr("data-checked", !checked);
    }
  });

  $(".edit").click(function(){
    $(".editable").toggle();
    $(".hidden_form_btn").each(function(index, btn) {
      if ($(btn).is(":visible")) { $(btn).css('display', 'inline-block'); }  // inline -> inline-block
    });
  });

  $("a#save_document").on("click", function(event) {
    event.stopPropagation();
    event.preventDefault();
    $("input.editable, textarea.editable").each(function(index, obj) {
      $(obj).prev().text($(obj).val());
    });
    $("#document_properties_form").submit();
  });

  $("a.save_section").on("click", function(event) {
    event.stopPropagation();
    event.preventDefault();
    var $form = $(this).closest("form");
    if ($form) {
      $form.submit();
    }
  });

  $("a.cancel_section").on("click", function(event) {
    event.stopPropagation();
    event.preventDefault();
    var $form = $(this).closest("form");
    if ($form) {
      var element = $form.find("#section_content");
      element.val(element.attr('data-original-text'));
    }
  });

  $("a.delete_section").click(function(event){
    event.stopPropagation();
    event.preventDefault();
    var $form = $(this).closest("form");
    if ($form) {
      $.ajax({
          type: "DELETE",
          url: $form.attr('action'),
          dataType: "json",
          complete: function(){
            $form.closest(".box_panel").fadeOut(300, function(){ $(this).remove();});
          }
      });
    }
  });

  $("body").on("change", ".contextElement", function() {
    var container = $(this).closest(".contextItemContainer");
    container.find(".contextDetails").hide();
    var element = $(this).val();
    container.find("." + element).show();
  });
});