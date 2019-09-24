class Invoice < ActiveRecord::Base
  belongs_to :payer, :polymorphic => true
  belongs_to :payable, :polymorphic => true

  validates_presence_of :title, :amount, :start_date, :due_date, :status, :payable, :payer
  validates_associated :payable, :payer

  def validate
    errors.add(:start_date, "cannot be a past date") if self.start_date < Date.today unless self.start_date.nil?
    errors.add(:due_date, "cannot be earlier than start date") if self.due_date < self.start_date unless self.due_date.nil?
  end

  default_scope :order=>'created_at DESC'

  def amount_in_bucks
    '%.2f' % (amount.to_f/100) if amount
  end
end
