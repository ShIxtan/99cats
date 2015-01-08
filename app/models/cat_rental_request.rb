# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :string           not null
#  user_id    :integer          not null
#

class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, :user_id, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED),
    message: "%{value} is not a valid status" }
  after_initialize :set_default_status
  validate :overlapping_approved_requests?

  belongs_to :cat, dependent: :destroy
  belongs_to :user

  def approved?
    status == "APPROVED"
  end

  def denied?
    status == "DENIED"
  end

  def overlapping_approved_requests?
    unless overlapping_approved_requests.empty? || status != "APPROVED"
      errors[:status] << "This cat is already requested during these dates"
    end
  end

  def approve!
    self.status = "APPROVED"
    CatRentalRequest.transaction do
      overlapping_pending_requests.each do |request|
        request.deny!
      end
      self.save!
    end
  end

  def deny!
    self.status = "DENIED"
    self.save!
  end

  private
  def overlapping_pending_requests
    overlapping_requests.where(status: "PENDING")
  end

  def set_default_status
    self.status ||= "PENDING"
  end

  def overlapping_requests
    # self.class.find_by_sql([<<-SQL, start_date, end_date, cat_id, id])
    #   SELECT
    #     *
    #   FROM
    #     cat_rental_requests A
    #   WHERE
    #     ((? BETWEEN A.start_date AND A.end_date)
    #     OR (? BETWEEN A.start_date AND A.end_date))
    #     AND A.cat_id = ? AND A.id != ?
    # SQL
    where_condition = "((? BETWEEN start_date AND end_date)
                      OR (? BETWEEN start_date AND end_date))"

    CatRentalRequest.where(cat_id: cat_id).where.not(id: id)
      .where(where_condition, start_date, end_date)
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end
end
