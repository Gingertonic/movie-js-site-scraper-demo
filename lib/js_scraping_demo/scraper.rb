class JsScrapingDemo::Scraper

  # Use Watir to start up a new instance of Chrome (headless)
  @@browser = Watir::Browser.new(:chrome, headless: true)

  def self.scrape_movies
    # Navigate headless browser to desired site
    @@browser.goto 'https://www.rottentomatoes.com/browse/in-theaters/'
    # Get all divs of class 'mb-movie'
    movies = @@browser.divs(class: 'mb-movie')
    movies.each do |m|
      # Get text in the h3 of class 'movieTitle'
      name = m.h3(class: "movieTitle").text
      # Get the href of the a
      url = m.a.href
      JsScrapingDemo::Movie.new(name, url)
    end
  end

  def self.scrape_movie(movie)
    # Navigate headless browser to movie url
    @@browser.goto movie.url
    # Get text in the p of class 'mop-ratings-wrap__text'
    movie.description = @@browser.p(class: "mop-ratings-wrap__text").text
    # Get text in the span of class 'mop-ratings-wrap__percentage' and remove whitespace
    movie.rt_rating = @@browser.span(class: "mop-ratings-wrap__percentage").text.strip
    # Get text in the span of class 'mop-ratings-wrap__percentage--audience' and get rid of the "liked it" text
    movie.aud_rating = @@browser.span(class: "mop-ratings-wrap__percentage--audience").text.strip.gsub("\nliked it", "")
  end

  def self.unmount
    # Close our browser
    @@browser.close
  end
end
