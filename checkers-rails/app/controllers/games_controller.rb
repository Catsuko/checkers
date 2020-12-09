class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def edit
  end

  def update
  end

  def new
  end

  def create
    command = Checkers::Services::CreateNewGame.new(self, Game)
    command.call(*create_params.values)
  end

  def handle_game_created(id)
    redirect_to(game_path(id))
  end

  private

  def create_params
    params.require(:players).permit(:first_player, :second_player)
  end
end