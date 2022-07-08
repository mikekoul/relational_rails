require 'rails_helper'

RSpec.describe "Films show page", type: :feature do
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