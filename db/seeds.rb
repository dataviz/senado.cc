# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

ALCUNHAS = ["Acir Gurgacz", "Aécio Neves", "Alfredo Nascimento", "Aloysio Nunes Ferreira", "Alvaro Dias", "Ana Amélia", "Ana Rita", "Angela Portela", "Anibal Diniz",
              "Antonio Carlos Rodrigues", "Antonio Carlos Valadares", "Armando Monteiro", "Ataídes Oliveira", "Benedito de Lira", "Blairo Maggi", "Casildo Maldaner", "Cássio Cunha Lima", "Cícero Lucena",
              "Ciro Nogueira", "Clésio Andrade", "Cristovam Buarque", "Cyro Miranda", "Delcídio do Amaral", "Eduardo Amorim", "Eduardo Braga", "Eduardo Lopes", "Eduardo Suplicy",
              "Epitácio Cafeteira", "Eunício Oliveira", "Fernando Collor", "Flexa Ribeiro", "Francisco Dornelles", "Garibaldi Alves", "Gim", "Humberto Costa", "Inácio Arruda",
              "Ivo Cassol", "Jader Barbalho", "Jarbas Vasconcelos", "Jayme Campos", "João Alberto Souza", "João Capiberibe", "João Durval", "João Vicente Claudino", "Jorge Viana",
              "José Agripino", "José Pimentel", "José Sarney", "Kátia Abreu", "Lídice da Mata", "Lindbergh Farias", "Lobão Filho", "Lúcia Vânia", "Luiz Henrique",
              "Magno Malta", "Maria do Carmo Alves", "Mário Couto", "Mozarildo Cavalcanti", "Paulo Bauer", "Paulo Davim", "Paulo Paim", "Pedro Simon", "Pedro Taques",
              "Randolfe Rodrigues", "Renan Calheiros", "Ricardo Ferraço", "Roberto Requião", "Rodrigo Rollemberg", "Romero Jucá", "Ruben Figueiró", "Sérgio Petecão", "Sérgio Souza",
              "Valdir Raupp", "Vanessa Grazziotin", "Vicentinho Alves", "Vital do Rêgo", "Waldemir Moka", "Walter Pinheiro", "Wellington Dias", "Wilder Morais",
              "Zeze Perrella"]

SENADORES = ["4981", "391", "4527", "846", "945", "4988", "4869", "4697", "4837",
               "5150", "3", "715", "5164", "3823", "111", "13", "5197",
               "4529", "739", "4895", "3398", "4877", "3360", "4721", "4994", "4767",
               "17", "20", "612", "4525", "3634", "765", "4935", "4776", "5008",
               "613", "5004", "35", "4545", "4531", "950", "3394", "4537", "4541",
               "4990", "40", "615", "47", "1249", "4575", "3695", "3579", "643",
               "5002", "631", "1023", "4539", "952", "3741", "5020", "825", "68",
               "5010", "5012", "70", "635", "72", "4593", "73", "4893", "4560",
               "5048", "3372", "558", "4763", "4645", "1176", "604", "5016", "5070",
               "5144"]


def slug(alcunha)
  ret = alcunha.strip
  # Substitui acentos
  ret.gsub! /á/, 'a'
  ret.gsub! /é/, 'e'
  ret.gsub! /í/, 'i'
  ret.gsub! /ó/, 'o'
  ret.gsub! /ú/, 'u'
  ret.gsub! /ã/, 'a'
  ret.gsub! /â/, 'a'
  ret.gsub! /ê/, 'e'
  ret.gsub! /ô/, 'o'
  # Remove alfanumericos
  ret.gsub! /\s*[^A-Za-z0-9'\.]\s*/, '-'

  ret.downcase
end

CSV.foreach(Rails.root + 'public/data/senadores.csv', headers: true) do |row|

  partido, uf = row['partido / UF'].split(' / ')
  senador = Senador.create(nome: row['nome civil'], nascimento: Date.parse(row['data de nascimento']),
              partido: partido, uf: uf, naturalidade: row['naturalidade'], endereco: row['endereço parlamentar'],
              telefone: row['telefones'], fax: row['FAX'], email: row['correio eletrônico'])
end

ids = SENADORES

Senador.all.each_with_index do |sen, idx|
  sen.update_attributes! id_original: SENADORES[idx], alcunha: ALCUNHAS[idx], slug: slug(ALCUNHAS[idx])
end
