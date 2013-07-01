class HomeController < ApplicationController

  def index
    @senators = Senador.all
  end

end
