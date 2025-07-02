class User < ApplicationRecord
    has_secure_password

  ROLES = %w[admin user]
  ACCOUNT_TYPES = %w[savings current joint business]

  validates :role, inclusion: { in: ROLES }
  validates :account_type, inclusion: { in: ACCOUNT_TYPES }, allow_nil: true
end

