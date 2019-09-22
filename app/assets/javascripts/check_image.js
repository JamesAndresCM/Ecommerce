$(document).on('turbolinks:load', function() {

  function valid_image(selector, preview_img){
  var readURL;

  readURL = function(input) {
      var reader, types;
      types = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
      if (input.files && input.files[0]) {
        reader = new FileReader;
        if (!types.includes(input.files[0]['type'])) {
          $.gritter.add({ 
            title: 'Error img!', 
            text: input.files[0]['name'] + ' is not valid image'
          }); 
          $(selector).val('');
        } else {
          reader.onload = function(e) {
            $(preview_img).attr('src', e.target.result);
          };
          reader.readAsDataURL(input.files[0]);
        }
      }
    };

    $(selector).change(function() {
      $(preview_img).removeClass('hidden');
      readURL(this);
    });
  }


  valid_image("#avatar-upload","#img_prev");
  valid_image("#product-upload","#product_prev");

});
