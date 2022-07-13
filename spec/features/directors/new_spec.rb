require 'rails_helper'

RSpec.describe 'Director creation' do
  describe "#creating a new director form" do
    it 'links to new director page from director index' do
      visit '/directors'

      click_link("New Director")

      expect(current_path).to eq('/directors/new')
    end

    it 'can create a new director' do
      
      visit '/directors/new'

      fill_in('Name', with: 'Peter Jackson')
      fill_in('Academy awards', with: '9')
      select('false', from:'Deceased')
      
      click_button("Create Director")

      expect(current_path).to eq("/directors")
      expect(page).to have_content("Peter Jackson")
    end
  end
end