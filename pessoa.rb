# Parseia todos as páginas *.html com os dados do servidores baixadas em
# crawled/, e imprime os dados em csv.
require 'nokogiri'
require 'open-uri'
require 'lib/camara'

class Servidor
  attr_reader :referencia, :code,
              :nome, :vinculo, :situacao, :exercicio, :cargo, :ref_cargo, :especialidade, :ref_funcao, :funcao,
              :tipo_folha, :remun_basica, :vant_pessoais, :func_comissionada, :grat_natalina,
              :horas_extras, :outras_eventuais, :abono_permanencia, :reversao_teto_const, :imposto_renda,
              :previdencia, :faltas, :rem_liquida, :diarias, :auxilios, :vant_indenizatorias

  def initialize(path)
    page = File.read(path)
    path =~ /(\d+)/
    @code = $1
    parse(page)
  end

  def to_s
      "#{code},#{nome},#{referencia},#{vinculo},#{situacao},#{exercicio},#{cargo},#{ref_cargo},#{especialidade},#{ref_funcao},#{funcao},#{tipo_folha},#{remun_basica},#{vant_pessoais}," +
      "#{func_comissionada},#{grat_natalina},#{horas_extras},#{outras_eventuais},#{abono_permanencia},#{reversao_teto_const},#{imposto_renda},#{previdencia}," +
      "#{faltas},#{rem_liquida},#{diarias},#{auxilios},#{vant_indenizatorias},#{rem_total}"
  end

  def rem_total
      rem_liquida + diarias + auxilios + vant_indenizatorias
  end

  private
  def parse(page)
    if (page =~ /Sem registro de pagamento/)
      raise "Sem registro para #{@code}"
    end
    doc = Nokogiri::HTML(page)
    @referencia = page.match(/Refer.ncia: (\d+\/\d+)/)[1]

    dados_basicos = doc.xpath("//td[contains(@class,'coldados_identifica')]/text()").map(&:to_s)
    @nome, @vinculo, @situacao, @exercicio, @cargo, @ref_cargo, @especialidade, @ref_funcao, @funcao = *dados_basicos

    dados_remuneracao = doc.xpath("//td[contains(@class,'col2_resposta')]/text()").map(&:to_s).map { |x| x.gsub(".", "").gsub(",", ".") }
    @tipo_folha = dados_remuneracao.shift.strip
    @remun_basica, @vant_pessoais, @func_comissionada, @grat_natalina,
    @horas_extras, @outras_eventuais, @abono_permanencia, @reversao_teto_const, @imposto_renda,
    @previdencia, @faltas, @rem_liquida, @diarias, @auxilios, @vant_indenizatorias = *dados_remuneracao.map(&:to_f)
  end
end

Dir.glob("crawled/*.html") do |path|
  begin
    puts Servidor.new(path)
  rescue Exception => e
    STDERR.puts e
  end
end
