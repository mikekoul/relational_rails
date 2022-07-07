require 'rails_helper'

RSpec.describe Director, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :academy_awards }
    it { should allow_value(true).for(:deceased) }
    it { should allow_value(false).for(:deceased) }
  end

    describe 'relationships' do
    it { should have_many :films }
  end
end
