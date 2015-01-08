# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#

class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :sex, :user_id, presence: true
  validates :color, inclusion: { in: %w(red orange yellow green blue indigo
    violet black white calico brown tabby), message: "%{value} is not a valid color" }
  validates :sex, inclusion: { in: ["M", "F"], message: "%{value} is not a valid choice"}

  has_many :cat_rental_requests
  belongs_to :owner, class_name: "User", foreign_key: :user_id, primary_key: :id

  def is_owner?(user)
    user_id == user.id
  end

  def age
    Time.now.to_date.year - self.birth_date.year
  end
end
