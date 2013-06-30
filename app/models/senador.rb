class Senador < ActiveRecord::Base
  def idade
    Time.now.year - nascimento.year
  end
end
