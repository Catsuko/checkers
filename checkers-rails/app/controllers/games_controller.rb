class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def edit
    @game = Game.find(params.require(:id))
  end

  def update
    command = Checkers::Services::MovePiece.new(self, Game)
    command.call(*update_params.values.map(&:to_i))
  rescue Exception => e
    flash[:error] = e.message
    redirect_to(edit_game_path)
  end

  def new
  end

  def create
    command = Checkers::Services::CreateNewGame.new(self, Game)
    command.call(*create_params.values)
  end

  def destroy
    Game.find(params.require(:id)).destroy!
    redirect_to(games_path)
  end

  def handle_game_created(id)
    redirect_to(edit_game_path(id))
  end

  def handle_game_finished(winner, loser)
    flash[:winner] = winner
    flash[:loser] = loser
  end

  def handle_piece_moved(piece_id)
    redirect_to(edit_game_path)
  end

  private

  def create_params
    params.require(:players).permit(:first_player, :second_player)
  end

  def update_params
    params.permit(:id, :piece_id, :position)
  end
end