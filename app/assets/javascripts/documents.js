$.fn.replaceWithPush = function(a) {
    var $a = $(a);

    this.replaceWith($a);
    return $a;
};

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


  $(document).on("click", "a.edit-link", function(e){
    e.preventDefault();
    var $parent = $(this).closest('.cnt_text'); 
    $parent.find('.editForm').show();
    $parent.find('.section_display').hide();
    $(this).hide();
  });
  
  $(document).on("click", "a.cancel", function(e){
    e.preventDefault();
    var $parent = $(this).closest('.cnt_text');
    $parent.find('.editForm').hide();
    $parent.find('.section_display').show();
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

  $(document).on("click", ".edit", function(){
    $(".editable").toggle();
    $(".hidden_form_btn").each(function(index, btn) {
      if ($(btn).is(":visible")) { $(btn).css('display', 'inline-block'); }  // inline -> inline-block
    });
  });

  $(document).on("click", "a#save_document", function(event) {
    event.stopPropagation();
    event.preventDefault();
    $("input.editable, textarea.editable").each(function(index, obj) {
      $(obj).prev().text($(obj).val());
    });
    $("#document_properties_form").submit();
  });


  $(document).on("click", "a.save_section", function(event){
    event.stopPropagation();
    event.preventDefault();
    var $form = $(this).closest("form");
    if ($form) {
      event.stopPropagation();
      event.preventDefault();
      $form.submit();
    }
  });

  // $("a.save_section").on("click", function(event) {
  //   event.stopPropagation();
  //   event.preventDefault();
  //   var $form = $(this).closest("form");
  //   if ($form) {
  //     $.ajax({
  //         type: "PUT",
  //         url: $form.attr('action'),
  //         dataType: "json",
  //         data: $form.serializeArray(),
  //         complete: function(data){
  //           alert(data);
  //         }
  //     });
  //   }
  // });


  $(document).on("click", "a.cancel_section", function(event){
    event.stopPropagation();
    event.preventDefault();
    var $form = $(this).closest("form");
    if ($form) {
      var element = $form.find("#section_content");
      element.val(element.attr('data-original-text'));
    }
  });

  $(document).on("click", "a.delete_section", function(event){
    event.stopPropagation();
    event.preventDefault();
    var $form = $(this).closest("form");
    if ($form) {
      $.ajax({
          type: "DELETE",
          url: $form.attr('action'),
          dataType: "json",
          complete: function(data){
            $form.closest(".box_panel").fadeOut(300, function(){ $(this).remove();});
            if (data && data.responseText) { AjaxFlash.flash("#ajax-flash", data.responseText); }
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