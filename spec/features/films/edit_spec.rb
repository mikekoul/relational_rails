require 'rails_helper'

RSpec.describe "Film update on show page", type: :feature do
  describe "#updating an existing film" do
    it 'click link and goes to update page' do
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
      vamps = carpenter.films.create!(name: 'Vampires', runtime: 103, streaming_on_netflix: true)

      visit "/films/#{vamps.id}"

      click_link 'Update Film'

      expect(current_path).to eq("/films/#{vamps.id}/edit")
    end

    it 'can update the film' do
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
      vamps = carpenter.films.create!(name: 'Vampir', runtime: 101, streaming_on_netflix: false)

      visit "/films/#{vamps.id}/edit"

      fill_in('Name', with: 'Vampires')
      fill_in('Runtime', with: '103')
      select('true', from:'Streaming on netflix')

      click_button 'Update Film'

      expect(current_path).to eq("/films/#{vamps.id}")
      expect(page).to have_content('Vampires')
    end
  end
end