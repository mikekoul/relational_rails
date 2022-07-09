require 'rails_helper'

RSpec.describe "Directors show page", type: :feature do
  describe "#director attributes" do
    it "display name of director" do
      kubrick = Director.create!(name: "Stanley Kubrick", academy_awards: 13, deceased: true)
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)

      visit "/directors/#{kubrick.id}"

      expect(page).to have_content(kubrick.name)
      expect(page).to_not have_content(carpenter.name)
    end

    it "display number of academy awards" do
      kubrick = Director.create!(name: "Stanley Kubrick", academy_awards: 13, deceased: true)
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)

      visit "/directors/#{kubrick.id}"

      expect(page).to have_content(kubrick.academy_awards)
      expect(page).to_not have_content(carpenter.name)
    end

    it "display whether they are deceased or not" do
      kubrick = Director.create!(name: "Stanley Kubrick", academy_awards: 13, deceased: true)
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)

      visit "/directors/#{kubrick.id}"

      expect(page).to have_content(kubrick.deceased)
      expect(page).to_not have_content(carpenter.name)
    end

    it "displays the number of films belonging to the director" do
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
      halloween = carpenter.films.create!(name: 'Halloween', runtime: 91, streaming_on_netflix: false)
      vamps = carpenter.films.create!(name: 'Vampires', runtime: 103, streaming_on_netflix: true)
      mars = carpenter.films.create!(name: 'Ghosts of Mars', runtime: 98, streaming_on_netflix: false)

      visit "/directors/#{carpenter.id}"

      expect(page).to have_content("Number of Films: 3")
    end
  end
end