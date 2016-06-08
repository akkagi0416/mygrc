require 'active_record'
require 'activerecord-import'

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: './mygrc.db'
)

class Site < ActiveRecord::Base
  has_many  :site_keywords
  has_many  :keywords, through: :site_keywords 
  has_many  :results

  validates :url, uniqueness: true
end

class Keyword < ActiveRecord::Base
  has_many    :site_keywords
  has_many    :sites, through: :site_keywords 
  has_many    :rankings
  belongs_to  :result

  validates :word, uniqueness: true
end

class SiteKeyword < ActiveRecord::Base
  belongs_to  :site
  belongs_to  :keyword
end

class Ranking < ActiveRecord::Base
  belongs_to  :keyword
end

class Result < ActiveRecord::Base
  belongs_to  :site
  has_one     :keyword

  scope :created_today, -> { where(created_at: Time.now.all_day) }
end
