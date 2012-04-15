module Github
  class Repo < Github::Base
    attr_accessor :user, :repository, :branch, :org, :tag_name

    def initialize(org, repository, branch, tag_name, user)
      @user = user
      @repository = repository
      @branch = branch
      @org = org
      @tag_name = tag_name
    end

    
  end
end