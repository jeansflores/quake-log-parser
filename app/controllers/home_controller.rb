class HomeController < ApplicationController

  #
  # Método e rota de página inicial do projeto para a inserção do games.log
  #
  def index
  end

  #
  # Método e rota que faz a chamada da função de copiar o arquivo selecionado
  # na página de index do projeto e ao mesmo tenso acionar o parser do arquivo
  # após destruir o arquivo para que não fique rastros ou restos de log
  #
  def games_reports
    log = Log.new(params[:log])
    @games = Parser.new.games
    log.destroy
  end

end
