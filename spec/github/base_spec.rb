require './lib/github/base.rb'

describe Github::Base do

  it "should using the github v3 api" do
    subject.api_url.should eq 'https://api.github.com/repos'
  end
  
end