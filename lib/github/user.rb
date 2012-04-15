module Github
  class User
    attr_accessor :username, :password

    def initialize(username, password)
      @username = username
      @password = password
    end

    def authentication
      {:http_basic_authentication => [@username, @password]}
    end
  end
end