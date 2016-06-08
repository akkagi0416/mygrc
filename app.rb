require 'sinatra'
require './lib/db.rb'
require './lib/helper.rb'
require 'json'

require 'logger'

logger = Logger.new(STDOUT)

get '/' do
  @sites = Site.all
  @site  = Site.first
  # @results = @site.results.where("results.created_at > ?", 1.days.ago)
  # @results = @site.results.where("results.created_at > ?", Time.now.all_day)
  @results = @site.results.created_today
  logger.info Time.now.all_day
  erb :index
end

get '/result' do
  # data = {
  #   "column" => [
  #     "date",
  #     "keyword1",
  #     "keyword2",
  #     "keyword3",
  #   ],
  #   "result" => [
  #     ['2016/06/05', 1, 5, 10],
  #     ['2016/06/06', 3, 3, 4],
  #     ['2016/06/07', 4, 7, 8],
  #     ['2016/06/08', 3, 4, 12],
  #   ]
  # }
  # data.to_json

  make_ajax_data(params['site_id']).to_json
end
