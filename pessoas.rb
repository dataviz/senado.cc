# Esse arquivo caminha por todas as páginas dos servidores imprimindo o código
# de cada um.
require 'open-uri'

URL = "http://www.senado.gov.br/transparencia/rh/servidores/nova_consulta.asp?fnome=&fvinculo=&fsituacao=&flotacao=&fcategoria=&fcargo=0&fsimbolo=&ffuncao=0&fadini=&fadfim=&fconsulta=ok&fpagina={{pagina}}"
PAGINAS = 483

def parse_page(url)
  page = open(url)

  results = page.read.scan(/fcodigo=(\d+)/)
  results.map(&:to_s)
end

(1..PAGINAS).each do |pagina|
  begin
    STDERR.puts "#{pagina}/#{PAGINAS}"
    url = URL.gsub("{{pagina}}", pagina.to_s)

    puts parse_page(url).join("\n")
  rescue Exception => e
    redo
  end
end
