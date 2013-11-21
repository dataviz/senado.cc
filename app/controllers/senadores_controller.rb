class SenadoresController < ApplicationController
  def show
    @senador = Senador.find_by_slug(params[:slug])
  end
end
