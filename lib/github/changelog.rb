module Github
  class Changelog
    
    def initialize
      user = Github::User.new('yurimello', 'inferno1010')
      repo = Github::Repo.new("sucurilabs", "github_changelog", "master", 'dev', user)
      @parser = Github::Parser.new(repo)
    end

    def generate
      if File.exist?("Changelog.md")
        last_changelog = File.open("Changelog.md", 'r').read 
      else
        last_changelog = ""
      end
      changelog_file = File.open("Changelog.md", 'w')
      @parser.commits_list.each do |date, messages|
        changelog_file.write(date)
        changelog_file.write("\n---------\n")
        messages.each do |message|
          changelog_file.write("####{message}\n\n")
        end
      end
      changelog_file.write("Last tag\n----------\n") if last_changelog
      changelog_file.write(last_changelog)
      changelog_file.close
    end

  end
end