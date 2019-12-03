class User < ApplicationRecord

    validates :email_id, presence: true, uniqueness: { case_sensitive: false }
    validates :password, presence: true

end
