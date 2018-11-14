# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :bigint(8)        not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'action_view'

class CatRentalRequest < ApplicationRecord
  include ActionView::Helpers::DateHelper
  
  STATUS_VALUES = %w(PENDING APPROVED DENIED).freeze
  
  validates :status, inclusion: STATUS_VALUES
  validates :start_date, :end_date, :status, presence: true
  validate :overlapping_requests
  
  def overlapping_requests
    requests = CatRentalRequest.where(cat_id: self.cat_id)
    return false if requests.nil?
    approved_requests = requests.where(status: 'APPROVED')
    overlapping_dates = approved_requests.where.not('end_date < ? OR start_date > ?', self.start_date, self.end_date)
    
    if overlapping_dates.empty?
      return true
    else
      self.errors[:overlappers] << "THIS CAT IS TAKEN >:C"
    end
  end
  
  def overlapping_pending_requests
    requests = CatRentalRequest.where(cat_id: self.cat_id)
    return false if requests.nil?
    pending_requests = requests.where(status: 'PENDING')
  end
  
  def approve!
    self.status = 'APPROVED'
    self.update
    pending_overlappers = self.overlapping_pending_requests
    pending_overlappers.map { |overlapper| overlapper.status = 'DENIED' }  
  end
  
  def deny!
    self.status = 'DENIED'
    self.update
  end
  
  belongs_to :cat,
    foreign_key: :cat_id,
    class_name: 'Cat'
end
