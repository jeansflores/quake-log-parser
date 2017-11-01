load 'game.rb'
load 'player.rb'

class Parser

	#
	# Class onde contém as regras de negocio para a realização das task 1 e 2 do projeto
	#

	attr_accessor :games, :file


	# Inicializa e ja realiza a leitura do arquivo updato para o projeto antes de ser destruido
	def initialize

		@games = []
		file = File.open(File.absolute_path("log/games.log"))

		# Lê cada linha do arquivo
		file.each do |line|

			# Faz a primeira verificação de linha: se contém um novo usuário na linha do log
			if new_game?(line)
				@games << Game.new((@games.length + 1).to_s)
				next

			# Faz a segunda verificação de linha: se contém um usuário na linha do log adiciona na lista de players
			elsif user?(line)
				player = Player.new get_user(line)
				@games.last.players[player.name] = player
				next

			# Faz a terceira verificação de linha: se contém algum kill na linha do log
			elsif kill?(line)

				# se tiver, será feita uma distinção entre os envolvidos no evento do log
				assassin = get_assassin(line)
				victim = get_victim(line)
				cause = cause_of_death(line)

				@games.last.add_total_kill # Realiza a chamada de métodos do model game
				@games.last.means_of_death[cause] += 1 # adicona uma causa de morte ao historico da partida

				# Verifica-se os envolvidos no log e conforme a regra ações serão tomadas conforme a condição
				if assassin != "<world>" # pode ocorrer que o jogador de suicide então o jogador morreria para o worls (regra de negocio)
					@games.last.players[assassin].add_kills # aciona o metodo de adicição de kills para o jogador
				else
					@games.last.players[victim].subtract_kills # acionao o metodo de decremento de kill como o envolvido tenha de suicidado ou morrido por um fator esterno sem a açao outro jogador
				end
			end
		end
	end

	#
	# Conjunto de métodos privadors de Regexp para as verificações dos itens descitos em cada linhado do games.log
	#

	private
	def cause_of_death(line) # captura a causa da morte do jogador
		line.match(/((?<=by\s).*)/)[0]
	end

	def end_game?(line) # verifica a situação do jogo (se ja terminou)
		line.match(/(?:^|\W)ShutdownGame(?:$|\W)/) ? true : false
	end

	def get_assassin(line) # captura o jogador que executou outro
		line.match(/([^:]+).(?=\skilled)/)[0].strip
	end

	def get_user(line) # captura o nome do jogador
		line.match(/((?<=n\\).*?(?=\\t))/)[0]
	end

	def get_victim(line) # captura o jogador morto por outro
		line.match(/((?<=killed\s).*(?=\sby))/)[0]
	end

	def kill?(line) # verifica o evento de morte no jogo
		line.match(/(?:^|\W)Kill(?:$|\W)/) ? true : false
	end

	def new_game?(line)
		line.match(/(?:^|\W)InitGame(?:$|\W)/) ? true : false
	end

	def user?(line)
		line.match(/(?:^|\W)ClientUserinfoChanged(?:$|\W)/) ? true : false
	end

end
