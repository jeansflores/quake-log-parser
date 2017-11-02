load 'game.rb'
load 'player.rb'

class Parser

	#
	# Class onde contém as regras de negócio para a realização das task 1 e 2 do projeto
	#

	attr_accessor :games, :file


	# Inicializa e realiza a leitura do arquivo de log
	def initialize

		@games = []
		file = File.open(File.absolute_path("log/games.log"))

		# Lê cada linha do arquivo
		file.each do |line|

			# Faz a primeira verificação de linha: se contém um novo usuário na linha do log
			if new_game?(line)
				@games << Game.new((@games.length + 1).to_s)
				next

			# Faz a segunda verificação de linha: se contém um usuário na linha do log
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
				@games.last.means_of_death[cause] += 1 # adicona uma causa de morte ao histórico da partida

				# Verifica-se os envolvidos no evento do log e conforme as regras de ações, será tomada uma decisão
				if assassin != "<world>" # exemplo: pode ocorrer que o jogador se suicide, então o jogador morreria para o world (regra de negócio)
					@games.last.players[assassin].add_kills # aciona o método de adicição de kills para o jogador
				else
					@games.last.players[victim].subtract_kills # aciona o método de decremento de kill como o envolvido tenha de suicidado ou morrido por um fator esterno sem a açao outro jogador
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

	def new_game?(line) # verifica se o jogo esta iniciando
		line.match(/(?:^|\W)InitGame(?:$|\W)/) ? true : false
	end

	def user?(line) # verifica o jogador em um evento do jogo
		line.match(/(?:^|\W)ClientUserinfoChanged(?:$|\W)/) ? true : false
	end

end
