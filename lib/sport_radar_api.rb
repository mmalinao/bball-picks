class SportRadarApi
  include HTTParty

  base_uri 'api.sportradar.us'
  default_params output: 'json'
  format :json

  OPTIONS = { query: { api_key: ENV['SPORTRADAR_API_KEY'] } }

  def self.schedules
    (get '/nba-t3/series/2014/PST/schedule.json', OPTIONS).parsed_response.with_indifferent_access
  end

  def self.teams
    (get '/nba-t3/league/hierarchy.json', OPTIONS).parsed_response.with_indifferent_access
  end
end
