class Director < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :academy_awards
  validates :deceased, inclusion: [true, false]
  has_many :films

  def self.sort_by_datetime_created
    order(created_at: :desc)
  end

  def film_count
    self.films.count
  end
end