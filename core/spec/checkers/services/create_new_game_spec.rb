require 'spec_helper'
require 'checkers/services/create_new_game'
require 'checkers/game_factory'

RSpec.describe Checkers::Services::CreateNewGame do
  let(:listener) { spy('listener') }
  let(:repository) { spy('repository') }

  subject { Checkers::Services::CreateNewGame.new(listener, repository).(first_player_id, second_player_id) }
  
  context 'given the player ids are the same,' do
    let(:first_player_id) { 1 }
    let(:second_player_id) { first_player_id }

    it 'an argument error is raised' do
      expect{ subject }.to raise_error(ArgumentError)
    end
  end

  context 'given different player ids,' do
    let(:first_player_id) { 1 }
    let(:second_player_id) { 2 }
    let(:game_id) { 512 }

    before(:each) do 
      allow(repository).to receive(:generate_id).and_return(game_id)
      subject
    end

    it 'the command stores the new game id' do
      expect(repository).to have_received(:store).with(hash_including(id: game_id))
    end

    it 'the command stores the first player id' do
      expect(repository).to have_received(:store).with(hash_including(first_player_id: first_player_id))
    end

    it 'the command stores the second player id' do
      expect(repository).to have_received(:store).with(hash_including(second_player_id: second_player_id))
    end

    it 'the command stores the turn' do
      expect(repository).to have_received(:store).with(hash_including(turn: { number: 1}))
    end

    it 'the command stores the pieces on the board' do
      expect(repository).to have_received(:store).with(hash_including(:pieces))
    end

    it 'the command invokes the listener with the game id' do
      expect(listener).to have_received(:handle_game_created).with(game_id)
    end
  end
end