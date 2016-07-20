class CheckoutController < ApplicationController
  def show
    @order = current_order
    @cart_total = cart_total
  end
  def shipping
  end

  def billing
  end

  def delivery
  end

  def payment
  end

  def review
  end

  def pay
    # params contains the data posted from the "checkout" form (see the
    # "checkout" action in this class)

    request = params[:sale]

    # This is where you would make any adjustments to the information gathered by
    # Rails into "request", such as setting request[:amount] based on an invoice
    # or the current cart balance.
    request[:amount] = cart_total

    @request = request.to_json # For display

    response = paytrace_api.post('/v1/transactions/sale/keyed', body: request)
    @response_status = response.status
    @response = response.body

    # In a real application, you would capture the result of paytrace_api.post
    # in a model instance, then redirect to a page displaying the information,
    # obtaining it for display from the model object.
  end

  protected

  def cart_total
    10.00
  end
end
