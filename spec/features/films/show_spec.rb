require 'rails_helper'

RSpec.describe "Films show page", type: :feature do
  describe "#user experience" do
    it "display name of film" do
      kubrick = Director.create!(name: "Stanley Kubrick", academy_awards: 13, deceased: true)
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
      shining = kubrick.films.create!(name: 'The Shining', runtime: 146, streaming_on_netflix: true)
      vamps = carpenter.films.create!(name: 'Vampires', runtime: 103, streaming_on_netflix: true)

      visit "/films/#{shining.id}"

      expect(page).to have_content(shining.name)
      expect(page).to_not have_content(vamps.name)
    end

    it "display runtime of film" do
      kubrick = Director.create!(name: "Stanley Kubrick", academy_awards: 13, deceased: true)
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
      shining = kubrick.films.create!(name: 'The Shining', runtime: 146, streaming_on_netflix: true)
      vamps = carpenter.films.create!(name: 'Vampires', runtime: 103, streaming_on_netflix: true)

      visit "/films/#{shining.id}"

      expect(page).to have_content(shining.runtime)
    end

    it "displays if film is streaming on Netflix" do
      kubrick = Director.create!(name: "Stanley Kubrick", academy_awards: 13, deceased: true)
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
      shining = kubrick.films.create!(name: 'The Shining', runtime: 146, streaming_on_netflix: true)
      vamps = carpenter.films.create!(name: 'Vampires', runtime: 103, streaming_on_netflix: true)

      visit "/films/#{shining.id}"
      
      expect(page).to have_content(shining.streaming_on_netflix)
    end
  end

  describe "#film show page links" do
    it "has link to director index" do
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
      vamps = carpenter.films.create!(name: 'Vampires', runtime: 103, streaming_on_netflix: true)

      visit "/films/#{vamps.id}"

      expect(page).to have_link('Director Index')
    end

    it "click director index link and go to director index page" do
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
      vamps = carpenter.films.create!(name: 'Vampires', runtime: 103, streaming_on_netflix: true)

      visit "/films/#{vamps.id}"

      click_link('Director Index')

      expect(current_path).to eq("/directors")
    end

    it "has link to films index" do
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
      mars = carpenter.films.create!(name: 'Ghosts of Mars', runtime: 98, streaming_on_netflix: false)

      visit "/films/#{mars.id}"

      expect(page).to have_link('Film Index')
    end

    it "click film index link and go to film index page" do
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
      mars = carpenter.films.create!(name: 'Ghosts of Mars', runtime: 98, streaming_on_netflix: false)

      visit "/films/#{mars.id}"

      click_link('Film Index')

      expect(current_path).to eq("/films")
    end

    it "has link to film update page" do
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
      vamps = carpenter.films.create!(name: 'Vampires', runtime: 103, streaming_on_netflix: true)

      visit "/films/#{vamps.id}"

      expect(page).to have_link('Update Film')
    end
  end  

  describe "#deleting an existing film" do
    it "has button to delete film show page" do
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
      vamps = carpenter.films.create!(name: 'Vampires', runtime: 103, streaming_on_netflix: true)

      visit "/films/#{vamps.id}"

      expect(page).to have_button('Delete')
    end

    it "click button to delete film show page" do
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
      toro = Director.create!(name: 'Guillermo del Toro', academy_awards: 6, deceased: false)
      vamps = carpenter.films.create!(name: 'Vampires', runtime: 103, streaming_on_netflix: true)
      water = toro.films.create!(name: 'The Shape of Water', runtime: 123, streaming_on_netflix: true)

      visit "/films/#{vamps.id}"

      click_button('Delete')

      expect(current_path).to eq("/films")
      expect(page).to_not have_content(vamps.name)
    end
  end
end