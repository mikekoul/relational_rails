class Film < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :runtime
  validates :streaming_on_netflix, inclusion: [true, false]
  belongs_to :director

  def self.streaming_on_netflix?
    streaming_on_netflix == true
  end

  def self.sort_alphabetically
    order(:name)
  end
end