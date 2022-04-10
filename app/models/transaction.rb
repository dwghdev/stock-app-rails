class Transaction < ApplicationRecord
  belongs_to :user

  scope :buy_transactions, -> { where transaction_type: 'buy' }
  scope :sell_transactions, -> { where transaction_type: 'sell' }

  validates :quantity, numericality: { greater_than: 0 }
  validates :total_cost, numericality: { greater_than: 0 }
  enum transaction_type: [:buy, :sell]

  before_save :compute_total_cost

  private
  # getters
  def get_stock = Stock.find(self.stock_id)

  def get_user = User.find(self.user_id)

  def stock_price = get_stock.latest_price

  def total_stock_cost = self.quantity.to_d * stock_price.to_d

  # before_save
  def update_stock_qty
    case self.transaction_type
    when transaction_type.buy
      get_stock.quantity -= self.quantity
    when transaction_type.sell
      get_stock.quantity += self.quantity
    end
  end

  def update_user_wallet
    case self.transaction_type
    when transaction_type.buy
      get_user.wallet -= self.total_cost
    when transaction_type.sell
      get_user.wallet += self.total_cst
    end
  end

  def compute_total_cost
    self.total_cost = total_stock_cost
  end
end
