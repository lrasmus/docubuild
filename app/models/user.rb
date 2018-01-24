class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  # Via response at https://github.com/nsarno/knock/issues/70

  # Knock requires :authenticate
  alias_method :authenticate, :valid_password?

  # Returns the user stored in the payload's subject
  def self.from_token_payload payload
    self.find payload["sub"]
  end
end
