require './lib/db.rb'

Site.all.each do |site|
  site.keywords.each do |keyword|
    ranking = keyword.rankings.where(created_at: (1.days.ago)..(Time.now)).where('url like ?', "%#{site.url}%").first
    result = site.results.new
    result.keyword_id = keyword.id
    if ranking == nil
      result.rank = 999
    else
      result.rank = ranking.rank
    end
    result.save
  end
end
