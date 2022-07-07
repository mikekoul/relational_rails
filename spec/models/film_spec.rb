require 'rails_helper'

RSpec.describe Film, type: :model do
  
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :runtime }
    it { should allow_value(true).for(:streaming_on_netflix) }
    it { should allow_value(false).for(:streaming_on_netflix) }
  end

  describe 'relationships' do
    it { should belong_to :director }
  end
end