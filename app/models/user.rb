class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:saml]

  def self.from_omniauth(auth)
    find_or_initialize_by(pid: auth.uid.try(:strip))
  end
end
