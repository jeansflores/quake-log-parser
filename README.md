# Quake Log Parser

O projeto constitui em ser um analisador (parser) para o arquivo de log do jogo Quake 3 Arena.

O arquivo games.log são gerados pelo servidor de Quake 3 Arena. Ele registra todas as informações dos jogos, quando um jogo começa, quando termina, quem matou quem, quem morreu pq caiu no vazio, quem morreu machucado, entre outros.

O parser é capaz de ler o arquivo, agrupar os dados de cada jogo, e em cada jogo deve coletar as informações de morte.

Ao aplicar o parser sobre o arquivo de log, resultará em um json, como apresentado abaixo:

      "games": [
          {
            "id": "1",
            "total_kills": 11,
            "players": {
              "Isgalamido": {
                "name": "Isgalamido",
                "kills": -3
              },
              "Dono da Bola": {
                "name": "Dono da Bola",
                "kills": 0
              },
              "Mocinha": {
                "name": "Mocinha",
                "kills": 0
              }
            },
            "means_of_death": {
              "MOD_TRIGGER_HURT": 7,
              "MOD_ROCKET_SPLASH": 3,
              "MOD_FALLING": 1
            }
          }
        ]

#### Executando o projeto

Para a execução do projeto localmente, siga os comandos abaixo no terminal:

    $ git clone https://github.com/jeansflores/quake-log-parser.git
    $ cd quake-log-parser
    $ bundle install
    $ rails server

###### Observações

- Foi utilizado para o desenvolvimento do projeto as versões do `ruby-2.1.5` e do `rails-4.1.8`
