module ApplicationHelper
  def formatted_price(price, unit: "€")
    "#{'%.2f' % price}#{unit} "
  end
end
