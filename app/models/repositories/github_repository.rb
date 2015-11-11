class GithubRepository < Repository
  validates_presence_of :uuid
  validates_presence_of :name
  
end