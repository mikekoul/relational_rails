require 'rails_helper'

RSpec.describe Film, type: :model do
  
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :runtime }
    it { should allow_value(true).for(:streaming_on_netflix) }
    it { should allow_value(false).for(:streaming_on_netflix) }
  end

  describe 'relationships' do
    it { should belong_to :director }
  end

  describe 'methods' do
    it 'return true for the films that are streaming on netflix' do
      kubrick = Director.create!(name: 'Stanley Kubrick', academy_awards: 13, deceased: true)
      carpenter = Director.create!(name: 'John Carpenter', academy_awards: 0, deceased: false)
      toro = Director.create!(name: 'Guillermo del Toro', academy_awards: 6, deceased: false)
      shining = kubrick.films.create!(name: 'The Shining', runtime: 146, streaming_on_netflix: true)
      halloween = carpenter.films.create!(name: 'Halloween', runtime: 91, streaming_on_netflix: false)
      peak = toro.films.create!(name: 'Crimson Peak', runtime: 119, streaming_on_netflix: false)
      water = toro.films.create!(name: 'The Shape of Water', runtime: 123, streaming_on_netflix: true)

      expect(shining.streaming_on_netflix?).to eq(true)
      expect(halloween.streaming_on_netflix?).to eq(false)
      expect(peak.streaming_on_netflix?).to eq(false)
      expect(water.streaming_on_netflix?).to eq(true)
    end

    it 'sort film names alphabetically' do
      kubrick = Director.create!(name: 'Stanley Kubrick', academy_awards: 13, deceased: true)
      carpenter = Director.create!(name: 'John Carpenter', academy_awards: 0, deceased: false)
      toro = Director.create!(name: 'Guillermo del Toro', academy_awards: 6, deceased: false)
      shining = kubrick.films.create!(name: 'The Shining', runtime: 146, streaming_on_netflix: true)
      halloween = carpenter.films.create!(name: 'Halloween', runtime: 91, streaming_on_netflix: false)
      peak = toro.films.create!(name: 'Crimson Peak', runtime: 119, streaming_on_netflix: false)
      water = toro.films.create!(name: 'The Shape of Water', runtime: 123, streaming_on_netflix: true)

      films = Film.all

      expect(films.sort_alphabetically.first).to eq(peak)
      expect(films.sort_alphabetically.last).to eq(shining)
    end
  end
end