require './lib/db.rb'

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

def make_ajax_data(site_id)

  summary = {}
  keyword_ids = Site.find(site_id).keywords.ids
  keyword_ids.each {|keyword_id| summary[keyword_id] = Hash.new }

  date_oldest = Time.now.strftime('%Y-%m-%d')
  date_newest = Time.now.strftime('%Y-%m-%d')
  # dbのデータを成形
  # summary[keyword_id][date] = rank
  Result.where(site_id: site_id).order(:created_at).each do |result|
    keyword_id = result.keyword_id
    rank       = result.rank
    date       = Time.parse(result.created_at).strftime('%Y-%m-%d')
    date_oldest = date if date_oldest > date
    date_newest = date if date_newest < date
    summary[keyword_id][date] = rank
  end

  # summaryからresultへ変換
  # reslut[
  #   ['2016-06-08', 5, nil, 10]
  #   ['2016-06-09', 3, 999, 15]...
  # ]
  result = []
  (Date.parse(date_oldest)..Date.parse(date_newest)).each do |date|
    date_str = date.strftime('%Y-%m-%d')
    date_result = []
    date_result << date_str
    keyword_ids.each do |keyword_id|
      date_result << summary[keyword_id][date_str]
    end
    result << date_result
  end

  # google chart用にcolumn追加
  column = Keyword.find(keyword_ids).map{|keyword| keyword.word }
  column.unshift("date")
  data = {
    "column" => column,
    "result" => result
  }
  
end
