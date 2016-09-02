module SectionsHelper
  def format_order_and_title section
    'Section ' + section.order.to_s.rjust(2, '0') + ': ' + section.title
  end
end
