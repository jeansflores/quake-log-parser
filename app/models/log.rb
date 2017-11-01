class Log

    #
    # Faz a cópia do arquivo selecionado na tela de update, para diretório log/ do projeto
    #
    def initialize(log)
      File.open(Rails.root.join('log/', 'games.log'), 'wb') do |file|
        file.write(log.read)
      end
    end

    #
    # Destroi o arquivo copiado para o projeto
    #
    def destroy
      FileUtils.rm("log/games.log")
    end

end
