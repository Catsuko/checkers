require 'spec_helper'
require 'checkers/services/move_piece'

RSpec.describe Checkers::Services::MovePiece do
  let(:listener) { spy('listener') }
  let(:repository) { spy('repository') }
  let(:game_id) { 1 }
  let(:piece_id) { 1 }
  let(:position) { 9 }
  let(:first_player_id) { 'Andy' }
  let(:second_player_id) { 'Bob' }

  subject { Checkers::Services::MovePiece.new(listener, repository).(game_id, piece_id, position) }

  before(:each) do
    allow(repository).to receive(:get).and_return(
      {
        id: game_id,
        first_player_id: first_player_id,
        second_player_id: second_player_id,
        turn: { number: 1 },
        pieces: {
          0 => { id: piece_id, light: false, is_king: false }
        }
      }
    )
    subject
  end

  it 'the command saves the game' do
    expect(repository).to have_received(:save).with(hash_including(id: game_id))
  end

  it 'the command saves the game at the next turn' do
    expect(repository).to have_received(:save).with(hash_including(turn: { number: 2}))
  end

  it 'the command saves the game with the moved piece' do
    expect(repository).to have_received(:save).with(hash_including(pieces: hash_including(position => anything)))
  end

  it 'the command invokes the listener with the game id' do
    expect(listener).to have_received(:handle_piece_moved).with(game_id)
  end

  it 'the command invokers the listener with the winner and loser' do
    expect(listener).to have_received(:handle_game_finished).with(first_player_id, second_player_id)
  end
end