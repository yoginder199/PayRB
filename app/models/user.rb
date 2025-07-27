class User < ApplicationRecord
    has_secure_password

  ROLES = %w[admin user]
  ACCOUNT_TYPES = %w[savings current joint business]

  validates :role, inclusion: { in: ROLES }
  validates :account_type, inclusion: { in: ACCOUNT_TYPES }, allow_nil: true

   has_many :sent_transfers, class_name: "Transfer", foreign_key: "sender_id"
  has_many :received_transfers, class_name: "Transfer", foreign_key: "recipient_id"
  has_many :transfers_as_sender, class_name: "Transfer", foreign_key: :sender_id

  def total_transferred_amount
    sent_transfers.sum(:amount)
  end

  def pin_set?
    pin_digest.present?
  end
end
