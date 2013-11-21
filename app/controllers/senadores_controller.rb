class SenadoresController < ApplicationController
  def show
    @senador = Senador.find(params[:id])
  end
end
