require 'rails_helper'

RSpec.describe 'director update' do
  it 'links to the director edit page' do
    kubrick = Director.create!(name: "Stanley Kubrick", academy_awards: 13, deceased: true)

    visit "/directors/#{kubrick.id}"

    click_link "Update Director"

    expect(current_path).to eq("/directors/#{kubrick.id}/edit")
  end

  it 'errors director attributes' do
    kubrick = Director.create!(name: "Stanley Kubric", academy_awards: 11, deceased: false)

    visit "/directors/#{kubrick.id}"

    expect(page).to have_content('Stanley Kubric')
  end

  it 'displays the director update form takes you to director show page when update is clicked' do  
    kubrick = Director.create!(name: "Stanley Kubric", academy_awards: 11, deceased: false)

    visit "/directors/#{kubrick.id}/edit"

    fill_in('Name', with: 'Stanley Kubrick')
    fill_in('Academy awards', with: '13')
    fill_in('Deceased', with: 'true')

    click_button 'Update Director'

    expect(current_path).to eq("/directors/#{kubrick.id}")
  end
end