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
end