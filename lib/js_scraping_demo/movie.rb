class JsScrapingDemo::Movie
  attr_accessor :id, :name, :url, :description, :rt_rating, :aud_rating
  attr_writer :description
  @@all = []

  def initialize(name, url)
    @name = name
    @url = url
    assign_id
    @@all << self
  end

  def self.all
    @@all
  end

  def assign_id
    @id = @@all.size + 1
  end

  def self.find_by_id(input)
    all.find{|m| m.id == input.to_i}
  end

  def get_details
    JsScrapingDemo::Scraper.scrape_movie(self) unless @description
  end

end
