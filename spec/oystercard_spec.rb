require "oystercard"

describe Oystercard do
  subject(:card) { Oystercard.new }

  context 'new card' do
    it 'initialise oystercard with balance of 0' do
      expect(card.balance).to eq 0
    end

    it 'checks for empty journey history' do
      expect(card.journeys).to be_empty
    end
  end

  context 'with balance' do
    before do
      card.top_up(50)
      card.touch_in(station)
    end

    let(:station){ double :station }

    it 'touch out card reduces balance by minimum fare' do
      expect { card.touch_out(station) }.to change{ card.balance }.by -1
    end

  end

  context 'stations' do
    before do
      card.top_up(50)
    end

    let(:entry_station){ double :entry_station }
    let(:exit_station){ double :exit_station }

    it 'assigning the entry station' do
      card.touch_in(entry_station)
      expect(card.entry_station).to eq entry_station
    end

    it 'forgets entry station' do
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.entry_station).to eq nil
    end

    it 'checks for journey hash' do
      expect(card.journeys).to be_a(Array)
    end

    it 'creates journey record' do
      journey = { entry: entry_station, exit: exit_station }
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.journeys).to include(journey)
    end

  end

  context 'without balance' do

    let(:station){ double :station }

    it 'check minimum balance on touch in' do
      expect { card.touch_in(station) }.to raise_error("Balance too low to touch in. Minimum balance is £#{Oystercard::MINIMUM_BALANCE}")
    end
  end

  describe '#top_up' do

    it 'can top up the balance' do
      expect{  card.top_up 10 }.to change{ card.balance }.by 10
    end

    it 'throws error when trying to top up past limit' do
      expect { card.top_up 100 }.to raise_error(RuntimeError, "top up limit #{Oystercard::LIMIT} reached")
    end
  end

end
