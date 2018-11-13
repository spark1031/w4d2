require 'action_view'

class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper
  
  CAT_COLORS = %w(blue red calico indigo).freeze
  
  SEX = %w(M F).freeze
  
  validates :birth_date, :color, :name, :sex, presence: true
  validates :color, inclusion: CAT_COLORS
  validates :sex, inclusion: SEX
  
  def age
    time_ago_from_now(birth_date)
  end
  
end
