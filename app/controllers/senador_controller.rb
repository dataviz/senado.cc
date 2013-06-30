class SenadorController < ApplicationController
  def show
    @senador = Senador.find(params[:id])
  end
end
