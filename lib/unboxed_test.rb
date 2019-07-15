require 'json'

class UnboxedTest
  attr_reader :langs

  def initialize(username)
    @trigger = TriggerGithubApi.new
    @username = username
  end

  def find_favourite_language
    repositories = fetch_user_repositories
    return "User does not have any repository on Github" if repositories.nil?
    language_count_hash = calculate_language_count(repositories)
    sorted = language_count_hash.sort_by { |lang, count| count }
    "User #{@username} favourite language is #{sorted.last}"
  end

  private

  def fetch_user_repositories
    all_repos = @trigger.get_repos_through_api(@username)
    parsed_hash = JSON.parse(all_repos)
    parsed_hash.empty? ? nil : parsed_hash
  end

  def calculate_language_count(repositories)
    langs = Hash.new
    langs.default = 0
    repositories.each do |repo|
      langs[repo['language'].to_s] += 1 if not repo['language'].nil?
    end
    langs
  end
end
