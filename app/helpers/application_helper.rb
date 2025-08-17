module ApplicationHelper
  def formatted_price(price, unit: "€")
    "#{'%.2f' % price}#{unit} "
  end

  def turbo_flash(message, type)
    turbo_stream.append("flash", partial: "shared/flash", locals: { type:, message: })
  end

  def turbo_modal(partial:, target: "modal", locals: {})
    turbo_stream.replace(target, partial:, locals:)
  end

end
