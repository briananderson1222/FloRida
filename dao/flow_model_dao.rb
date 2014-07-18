require_relative '../models/flow_model'
require 'mongo'

module FlowModelDAO

  include Mongo

  def client
    mongo_client = ENV['MONGO_PORT'] ? MongoClient.new(ENV['MONGO_HOST'], ENV['MONGO_PORT'].to_i) : MongoClient.new(ENV['MONGO_HOST'])
    db = mongo_client.db(ENV['MONGO_DB'])
    db.authenticate(ENV['MONGO_USERNAME'], ENV['MONGO_PASSWORD'])
    {
      :db => db,
      :mongo_client => mongo_client
    }
  end


  def save_flow_model(flow_model)
    mongo_details = client
    model_id = flow_model.id.nil? ? (0...50).map { ('a'..'z').to_a[rand(26)] }.join : flow_model.id
    flow_model.id = model_id
    mongo_details[:db].collection('flow_model').find_and_modify({ :query => { :id => flow_model.id }, :update => flow_model.to_hash, :upsert => true })
  end


end
