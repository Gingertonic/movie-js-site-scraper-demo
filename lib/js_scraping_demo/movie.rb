class JsScrapingDemo::Movie
  attr_accessor :id, :description, :rt_rating, :aud_rating
  attr_reader :name, :url
  @@all = []

  def initialize(name, url)
    @name = name
    @url = url
    assign_id
    save
  end

  def assign_id
    @id = @@all.size + 1
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.exists?(idx)
    (1..all.length).include?(idx.to_i)
  end

  def self.prepare_to_list
    JsScrapingDemo::Scraper.scrape_movies if all.empty?
  end

  def self.find_by_id(input)
    all.find{|m| m.id == input.to_i}
  end

  def get_details
    JsScrapingDemo::Scraper.scrape_movie(self) unless @description
  end

end
