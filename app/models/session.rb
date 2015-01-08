# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  token      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Session < ActiveRecord::Base
  validates :user_id, :token, presence: true
  validates :token, uniqueness: true
  after_initialize :ensure_token

  belongs_to :user

  def self.generate_token
    SecureRandom::urlsafe_base64(16)
  end

  def ensure_token
    self.token ||= self.class.generate_token
  end

end
