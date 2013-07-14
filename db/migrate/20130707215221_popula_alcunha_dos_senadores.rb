class PopulaAlcunhaDosSenadores < ActiveRecord::Migration
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

  def up
    alcunhas = ALCUNHAS

    Senador.all.each_with_index do |sen, idx|
      sen.update_attributes! alcunha: ALCUNHAS[idx]
    end
  end

end
