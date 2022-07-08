require 'rails_helper'

RSpec.describe 'Films index' do
  it 'shows a list of all the films' do
    kubrick = Director.create!(name: 'Stanley Kubrick', academy_awards: 13, deceased: true)
    carpenter = Director.create!(name: 'John Carpenter', academy_awards: 0, deceased: false)
    shining = kubrick.films.create!(name: 'The Shining', runtime: 146, streaming_on_netflix: true)
    vamps = carpenter.films.create!(name: 'Vampires', runtime: 103, streaming_on_netflix: true)

    visit "/films"

    expect(page).to have_content(shining.name)
    expect(page).to have_content(shining.runtime)
    expect(page).to have_content(shining.streaming_on_netflix)
    expect(page).to have_content(vamps.name)
    expect(page).to have_content(vamps.runtime)
    expect(page).to have_content(vamps.streaming_on_netflix)

  end
end