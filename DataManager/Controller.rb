class Controller
  def initialize

  end

  def self.all
    query = "SELECT * FROM#{@config[0]}"
    p query
  end
end