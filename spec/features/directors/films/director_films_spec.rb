require 'rails_helper'

RSpec.describe "Director films index", type: :feature do
  it "display name of film" do
    kubrick = Director.create!(name: "Stanley Kubrick", academy_awards: 13, deceased: true)
    shining = kubrick.films.create!(name: 'The Shining', runtime: 146, streaming_on_netflix: true)
    fmj = kubrick.films.create!(name: 'Full Metal Jacket', runtime: 116, streaming_on_netflix: true)

    visit "/directors/#{kubrick.id}/films"

    expect(page).to have_content(shining.name)
    expect(page).to have_content(shining.runtime)
    expect(page).to have_content(shining.streaming_on_netflix)
    expect(page).to have_content(fmj.name)
    expect(page).to have_content(fmj.runtime)
    expect(page).to have_content(fmj.streaming_on_netflix)
  end

  it "has link to director index" do
    carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)

    visit "/directors/#{carpenter.id}/films"

    expect(page).to have_link('Director Index')
  end

  it "click director index link and go to director index page" do
    carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)

    visit "/directors/#{carpenter.id}/films"

    click_link('Director Index')

    expect(current_path).to eq("/directors")
  end

  it "has link to films index" do
    carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
    mars = carpenter.films.create!(name: 'Ghosts of Mars', runtime: 98, streaming_on_netflix: false)

    visit "/directors/#{carpenter.id}/films"

    expect(page).to have_link('Film Index')
  end

  it "click film index link and go to film index page" do
    carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
    mars = carpenter.films.create!(name: 'Ghosts of Mars', runtime: 98, streaming_on_netflix: false)
    
    visit "/directors/#{carpenter.id}/films"

    click_link('Film Index')

    expect(current_path).to eq("/films")
  end
end