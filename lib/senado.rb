# Esse código não funciona mais, pois agora adicionaram, além do código, o
# vínculo.
require "mechanize"
require "lib/decaptcher"
require 'pry'

URL = "http://www.senado.gov.br/transparencia/rh/servidores/detalhe.asp?fcodigo="

class Camara
  def initialize(code)
    @code = code
    @agent = Mechanize.new
  end

  def get
    @agent.get(URL + @code.to_s)
  
    form = @agent.page.forms[0]
    
    form.fnome = ENV["SENADO_NOME"]
    form.fcpf = ENV["SENADO_CPF"]
    form.femail = ENV["SENADO_EMAIL"]
    form.fcep = ENV["SENADO_CEP"]
    form.fendereco = ENV["SENADO_ENDERECO"]
    form.fbairro = ENV["SENADO_BAIRRO"]
    form.fcidade = ENV["SENADO_CIDADE"]
    form.fuf = ENV["SENADO_UF"]
    form.checkboxes[0].check
  
    form.txtCaptcha = break_captcha
  
    page = form.submit
  
    if page.body =~ /txtCaptcha/
      @captcha.ask_refund
      #puts "Asked Refund (balance #{Decaptcher.balance})"
      #puts "Retrying..."
      get
    else
      File.open("crawled/#{@code}.html", "w+") do |file|
        file.write(page.body)
      end
    end
  end

  def break_captcha
    begin
      filename = '/tmp/captcha.bmp'
      @agent.get("http://www.senado.gov.br/transparencia/rh/servidores/captcha.asp").save(filename)
      
      @captcha = Decaptcher.new(filename)
      result = @captcha.break
      
      #puts "Captcha? #{result}"
      result
    rescue Timeout::Error
      #puts "TIMEOUT! Retrying..."
      break_captcha
    ensure
      `rm #{filename}* > /dev/null 2>&1`
    end
  end
end
