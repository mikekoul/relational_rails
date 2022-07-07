class Director < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :academy_awards
  validates :deceased, inclusion: [true, false]
  has_many :films
end