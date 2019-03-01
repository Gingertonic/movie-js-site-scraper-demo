class JsScrapingDemo::CLI
  @@muted="\e[1;31m"
  @@grn="\e[1;32m"
  @@blu="\e[1;34m"
  @@mag="\e[1;35m"
  @@cyn="\e[1;36m"
  @@white="\e[0m"

  def call
    puts ""
    puts "#{@@cyn}Welcome to the Javascript Scraping Movie Database!#{@@white}"
    while @input != 'bye'
      list_movies
      get_user_input
      valid_movie_input ? show_movie : show_error
      get_next_step
    end
    goodbye
  end

  def list_movies
    puts ""
    puts "#{@@mag}Loading movies ...#{@@white}"
    puts ""
    JsScrapingDemo::Movie.all.empty? ? JsScrapingDemo::Scraper.scrape_movies : nil
    JsScrapingDemo::Movie.all.each{|m| puts "#{m.id}: #{m.name}"}
    puts ""
    puts "#{@@cyn}Select movie ID#{@@white}"
  end

  def get_user_input
    @input = gets.strip
  end

  def show_error
    puts "#{@@muted}Sorry that's not a valid input! Please try again!#{@@white}"
  end

  def valid_movie_input
    (1..JsScrapingDemo::Movie.all.length).include?(@input.to_i)
  end

  def show_movie
    puts ""
    puts "#{@@mag}Loading your chosen movie ...#{@@white}"
    puts ""
    movie = JsScrapingDemo::Movie.find_by_id(@input)
    movie.get_details
    puts movie.description
    puts ""
    puts "Rotten Tomatoes rating:\t#{movie.rt_rating} \t | \t Audience rating:\t#{movie.aud_rating}"
  end

  def get_next_step
    puts ""
    puts "#{@@cyn}To see all the movies again enter #{@@blu}'list'#{@@cyn} or say #{@@blu}'bye' to exit#{@@white}"
    get_user_input
  end

  def goodbye
    JsScrapingDemo::Scraper.unmount
    puts ""
    puts "#{@@cyn}See you next time!#{@@white}"
    puts ""
  end
end
