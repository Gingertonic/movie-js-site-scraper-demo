class JsScrapingDemo::CLI
  # Bash color codes to make it look pretty!
  @@muted="\e[1;31m"
  @@grn="\e[1;32m"
  @@blu="\e[1;34m"
  @@mag="\e[1;35m"
  @@cyn="\e[1;36m"
  @@white="\e[0m"

  def call
    puts "\n#{@@cyn}Welcome to the Javascript Scraping Movie Database!#{@@white}"
    while @input != 'bye'
      list_movies
      get_user_input
      valid_movie_input ? show_movie : show_error
      get_next_step
    end
    goodbye
  end

  def list_movies
    puts "\n#{@@mag}Loading movies ...#{@@white}"
    puts "\n"
    JsScrapingDemo::Movie.prepare_to_list
    JsScrapingDemo::Movie.all.each{|m| puts "#{m.id}: #{m.name}"}
    puts "\n#{@@cyn}Select movie ID#{@@white}"
  end

  def get_user_input
    @input = gets.strip
  end

  def show_error
    puts "#{@@muted}Sorry that's not a valid input! Please try again!#{@@white}"
  end

  def valid_movie_input
    JsScrapingDemo::Movie.exists?(@input)
  end

  def show_movie
    puts "\n#{@@mag}Loading your chosen movie ...#{@@white}"
    movie = JsScrapingDemo::Movie.find_by_id(@input)
    movie.get_details
    puts "\n#{movie.description}"
    puts "\nRotten Tomatoes rating:\t#{movie.rt_rating}\t|\tAudience rating:\t#{movie.aud_rating}"
  end

  def get_next_step
    puts "\n#{@@cyn}To see all the movies again enter #{@@blu}'list'#{@@cyn} or say #{@@blu}'bye'#{@@cyn} to exit#{@@white}"
    get_user_input
  end

  def goodbye
    JsScrapingDemo::Scraper.unmount
    puts "\n#{@@cyn}See you next time!#{@@white}"
    puts "\n"
  end
end
