class ProductDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

   def img_product
    if object.img?
      h.image_tag(object.img.url, alt: "#{object.name}" , title: "#{object.name}", id: 'product_prev', class:'img-fluid mt-2 avatar_profile')
    else
      h.image_tag('fallback/default.jpg',  id: 'product_prev', class:'img-fluid mt-2 avatar_profile')
    end
  end

  def image_card(class_style)
    h.image_tag(object.img.url, alt: "#{object.name}" , title: "#{object.name}" , class: class_style)
  end

end
