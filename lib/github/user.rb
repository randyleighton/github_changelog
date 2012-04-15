module Github
  class User
    attr_accessor :username, :password

    def initialize
      puts "Enter username:"
      @username = STDIN.gets().chomp
      puts "Enter Passowrd:"
      system "stty -echo"
      @password = STDIN.gets().chomp
      system "stty echo"
    end

    def authentication
      {:http_basic_authentication => [@username, @password]}
    end
  end
end