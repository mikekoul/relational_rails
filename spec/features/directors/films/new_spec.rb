require 'rails_helper'

RSpec.describe "Director films creation page", type: :feature do
  describe "#creating a new film for a director" do
    it "click link and go to creation page" do
      carpenter = Director.create!(name: 'John Carpenter', academy_awards: 0, deceased: false)
      halloween = carpenter.films.create!(name: 'Halloween', runtime: 91, streaming_on_netflix: false)
      vamps = carpenter.films.create!(name: 'Vampires', runtime: 103, streaming_on_netflix: true)
      mars = carpenter.films.create!(name: 'Ghosts of Mars', runtime: 98, streaming_on_netflix: false)

      visit "/directors/#{carpenter.id}/films"

      click_link('Add Film')

      expect(current_path).to eq("/directors/#{carpenter.id}/films/new")
    end

    it 'can add a new film' do
      carpenter = Director.create!(name: 'John Carpenter', academy_awards: 0, deceased: false)
      halloween = carpenter.films.create!(name: 'Halloween', runtime: 91, streaming_on_netflix: false)
      vamps = carpenter.films.create!(name: 'Vampires', runtime: 103, streaming_on_netflix: true)
      mars = carpenter.films.create!(name: 'Ghosts of Mars', runtime: 98, streaming_on_netflix: false)

      visit "/directors/#{carpenter.id}/films/new"

      fill_in('Name', with: 'The Thing')
      fill_in('Runtime', with: '109')
      select('true', from:'Streaming on netflix')
      
      click_button("Add Film")

      expect(current_path).to eq("/directors/#{carpenter.id}/films")
      expect(page).to have_content("The Thing")
    end
  end
end