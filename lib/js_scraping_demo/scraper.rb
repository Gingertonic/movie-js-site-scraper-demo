class JsScrapingDemo::Scraper

  @@browser = Watir::Browser.new(:chrome, headless: true)

  def self.scrape_movies
    @@browser.goto 'https://www.rottentomatoes.com/browse/in-theaters/'
    movies = @@browser.divs(class: 'mb-movie')
    movies.each do |m|
      name = m.h3(class: "movieTitle").text
      url = m.a.href
      JsScrapingDemo::Movie.new(name, url)
    end
  end

  def self.scrape_movie(movie)
    @@browser.goto movie.url
    movie.description = @@browser.p(class: "mop-ratings-wrap__text").text
    movie.rt_rating = @@browser.span(class: "mop-ratings-wrap__percentage").text.strip
    movie.aud_rating = @@browser.span(class: "mop-ratings-wrap__percentage--audience").text.strip.gsub("\nliked it", "")
  end

  def self.unmount
    @@browser.close
  end
end
