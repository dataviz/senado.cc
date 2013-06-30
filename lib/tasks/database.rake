require 'csv'

namespace :db do
  desc "Load db/data/senadores.csv into the database"
  task senadores: :environment do
    filename = 'public/data/senadores.csv'
    CSV.foreach(filename, :headers => true) do |row|
      attributes = row.to_hash
      Senador.where(nome: row[:nome]).first_or_create
             .update_attributes(attributes)
    end
  end
end
