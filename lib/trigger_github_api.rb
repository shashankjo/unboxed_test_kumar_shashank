require 'httparty'
class TriggerGithubApi
  include HTTParty
  base_uri 'https://api.github.com'    # link of Github API

  def get_repos_through_api(user)
    response = self.class.get("/users/#{user}/repos")
    response.body
  end
end
