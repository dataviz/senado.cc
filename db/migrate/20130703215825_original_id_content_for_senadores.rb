class OriginalIdContentForSenadores < ActiveRecord::Migration
  SENADORES = ["4981", "391", "4527", "846", "945", "4988", "4869", "4697", "4837",
               "5150", "3", "715", "5164", "3823", "111", "13", "5197",
               "4529", "739", "4895", "3398", "4877", "3360", "4721", "4994", "4767",
               "17", "20", "612", "4525", "3634", "765", "4935", "4776", "5008",
               "613", "5004", "35", "4545", "4531", "950", "3394", "4537", "4541",
               "4990", "40", "615", "47", "1249", "4575", "3695", "3579", "643",
               "5002", "631", "1023", "4539", "952", "3741", "5020", "825", "68",
               "5010", "5012", "70", "635", "72", "4593", "73", "4893", "4560",
               "5048", "3372", "558", "4763", "4645", "1176", "604", "5016", "5070",
               "5144"]

  def up
    ids = SENADORES

    Senador.all.each_with_index do |sen, idx|
      sen.update_attributes! id_original: SENADORES[idx]
    end
  end
end
