require 'net/http'
require 'uri'
require 'base64'

KEY = ENV['DECAPTCHER_API_KEY']

class Decaptcher
  def initialize(file_name)
    @file_name = file_name
    @task_id = rand.to_s
  end

  def break
    return @result if @result

    uri = URI.parse("http://www.fasttypers.org/imagepost.ashx")
    image = File.read(@file_name)
    image_encoded = Base64.encode64(image)

    params = { "action" => "upload",
               "key" => KEY,
               "file" => image_encoded,
               "gen_task_id" => @task_id }

    @result = Net::HTTP.post_form(uri, params).body
  end

  def ask_refund
    uri = URI.parse("http://www.fasttypers.org/imagepost.ashx")

    params = { "action" => "refund",
               "key" => KEY,
               "gen_task_id" => @task_id }

    Net::HTTP.post_form(uri, params).body
  end

  def self.balance
    uri = URI.parse("http://www.fasttypers.org/imagepost.ashx")

    params = { "action" => "balance",
               "key" => KEY }

    Net::HTTP.post_form(uri, params).body.to_i
  end
end
