module Github
  class Changelog
    
    def initialize(organization, repository, branch, tag_name)
      user = Github::User.new
      repo = Github::Repo.new(organization, repository, branch, tag_name, user)
      @parser = Github::Parser.new(repo)
    end

    def generate
      commits = @parser.commits_list
      return false if commits.empty?
      if File.exist?("Changelog.md")
        last_changelog = File.open("Changelog.md", 'r').read 
      else
        last_changelog = ""
      end
      changelog_file = File.open("Changelog.md", 'w')
      commits.each do |date, messages|
        changelog_file.write(date)
        changelog_file.write("\n---------\n")
        messages.each do |message|
          changelog_file.write("####{message}\n\n")
        end
      end
      changelog_file.write("Last tag\n----------\n") if last_changelog != ""
      changelog_file.write(last_changelog)
      changelog_file.close
      commit
      create_tag
    end

    def create_tag
      system("git tag -d #{@parser.repo.tag_name}")
      system("git tag #{@parser.repo.tag_name}")
      system("git push --tags origin #{@parser.repo.branch}")
    end

    def commit
      system("git add ./Changelog.md")
      system("git commit ./Changelog.md -m 'Updating changelog'")
      system("git push origin #{@parser.repo.branch}")
    end
  end
end