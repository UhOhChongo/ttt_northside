class Order < ActiveRecord::Base
  # associations
  belongs_to :order_status
  has_many :order_items

  # callbacks
  before_create :set_order_status
  before_save :update_subtotal

  def subtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

  def shipping
    subtotal > 99.99 ? 0 : 5
  end

  def pre_tax
    subtotal + shipping
  end

  def tax
    0
  end

  def total
    pre_tax + tax
  end

  private
  def set_order_status
    self.order_status_id = 1
  end

  def update_subtotal
    self[:subtotal] = subtotal
  end
end