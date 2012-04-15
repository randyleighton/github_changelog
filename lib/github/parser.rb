module Github
  class Parser
    attr_accessor :repo, :last_tag_commit, :commits
    
    def initialize(repo)
      @repo = repo
      @commits = {}
    end
    
    def tags_list
      JSON.parse(open("#{@repo.api_url}/#{@repo.org}/#{@repo.repository}/tags", @repo.user.authentication).read)
    end

    def last_tag
      tags_list.each do |tag|
        @last_tag_commit = tag["commit"]["sha"] if tag["name"] == @repo.tag_name
      end
    end

    def commits_list(sha = nil)
      sha ||= @repo.branch
      response = open("#{@repo.api_url}/#{@repo.org}/#{@repo.repository}/commits?sha=#{sha}&per_page=100").read
      commits = JSON.parse(response)
      commits_by_date = {}
      commits.each do |commit|
        return @commits if commit["sha"] == (@last_tag_commit || last_tag)
        date = Date.parse(commit["commit"]["committer"]["date"]).strftime("%d/%m/%Y")

        if @commits[date] 
          @commits[date] << commit["commit"]["message"]
        else
          @commits[date] = [commit["commit"]["message"]]
        end
      end
      commits_list(commits.last["sha"])
    end
  end
end