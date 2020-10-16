# Ruby code file - All your code should be located between the comments provided.

# Add any additional gems and global variables here
require 'sinatra'		

# The file where you are to write code to pass the tests must be present in the same folder.
# See http://rspec.codeschool.com/levels/1 for help about RSpec
require "#{File.dirname(__FILE__)}/wad_wof_gen_01"

# Main program
module WOF_Game
	@input = STDIN
	@output = STDOUT
	g = Game.new(@input, @output)
	playing = true
	input = ""
	menu = ""
	guess = ""
	secret = ""
	filename = "wordfile.txt"
	turn = 0
	win = 0
	game = ""
	words = 0
#	game = gets.chomp
#	if game == "1"
#		puts "Command line game"
#	elsif game == "2"
#		puts "Web-based game"
#	else
#		puts "Invalid input! No game selected."
#		exit
#	end		
	# Any code added to command line game should be added below.
	
	Menu1 = Proc.new{      # set proc for "play" in menu
		guess = "_"
		while guess != "" && turn < (GOES) && win != 1
			g.displaytemplate
			@output.puts 'Guess a missing charater from the hidden word/phrase.'
			guess = g.getguess
			@output.puts "You entered: #{guess}"	#need to check value overwritten
	#		g.storeguess(guess)
			if g.charinword(guess) >= 0
				@output.puts "Character #{guess} is in word/phrase."
				  g.addscore
			else
				if  guess != ""
					turn += 1
					g.addplayed
					g.incrementturn
				end
			end
			@output.puts "You have #{g.getturnsleft} goes left."

			 if turn >= (GOES)
				 @output.puts g.DisplayWinner (false)
			 end

			if  g.WordRevealed == 1				
				words += 1
				g.UpdateResulta
				g.GotOneWordRight
				g.UpdateResultb
				win = g.CheckifWin(LineNum,words)
				if win != 1
					secret = g.ReGenSecretWord
					g.setsecretword(secret)
					g.createtemplate
				else
					@output.puts g.DisplayWinner (true)					
				end
				break
			end
		end
	}
		
	Menu2 = Proc.new{  # set proc for "new" in menu
		turn = 0
		win = 0
		words = 0			
		g.resetgame
		g.readwordfile(filename)
		@output.puts "Reset game...\n"
	}	

	Menu3 = Proc.new{  # set proc for "analysis" in menu
		if words == 0
			puts "You got #{words} right."
		elsif words == 1
			puts "You got #{words} word/phrase right. It's: "
			g.DisplayResulta
		else
			puts "You got #{words} words/phrases right. They are: "
			g.DisplayResulta
		end
	}

	Menu9 = Proc.new{  # set proc for "exit" in menu
		@output.puts "Exit game"
		exit	
	}	
	
	# game start from this place
	g.start
	game = gets.chomp
	if game == "1"
		puts "Command line game"
	elsif game == "2"
		puts "Web-based game"
	else
		puts "Invalid input! No game selected."
		exit
	end

	if game == "1"
		g.resetgame
		LineNum = g.readwordfile(filename)
		secret = g.gensecretword	
		while menu != "9"		
			g.setsecretword(secret)
			g.createtemplate
			puts g.displaymenu
			menu = gets.chomp									
			if menu == "1"
				Menu1.call
			elsif menu == "2"		# Reset game
				Menu2.call				
			elsif menu == "3"
				Menu3.call			
			elsif menu == "9"
				Menu9.call
			else
			g.InvalidInput
		end
	end


		
	# Any code added to command line game should be added above.
	
		exit	# Does not allow command-line game to run code below relating to web-based version
	end
end
# End modules

# Sinatra routes

	# Any code added to web-based game should be added below.

	@input = STDIN
	@output = STDOUT
	g = WOF_Game::Game.new(@input, @output)	
	$filename = "wordfile.txt"
	$turn = 0
	$win = 0
	$words = 0	
	g.resetgame
	$LineNum = g.readwordfile($filename)
	g.readwordfile($filename)
	secret = g.gensecretword
	g.setsecretword(secret)
	g.createtemplate
	$GuessCharRight = 0
	$ShowGuess = "Nothing"
	$ShowTurnLeft = 5

	get '/' do
		@ShowName = g.created_by
		@ShowID = g.student_id
		erb :home
	end	

	get '/Play' do	
		@ShowTemplate = g.displaytemplate
		erb :play
	end	

	post '/Play' do
		guess = params[:GuessLetter].to_s.upcase
		$ShowGuess = guess	
		if  g.charinword(guess) >= 0
			$GuessCharRight = 1
			@ShowTemplate = g.displaytemplate			
			g.addscore		
		else
			$GuessCharRight = 0
			if guess != ""
				$turn = $turn + 1
				g.addplayed
				g.incrementturn
			end
		end
		$ShowTurnLeft= g.getturnsleft
		if  $turn >= 5
			redirect "/fail"	
		end

		if  g.WordRevealed == 1
			$GuessCharRight = 0
			$ShowGuess = "Nothing"
			$words += 1	
			g.UpdateResulta
			g.UpdateResultb
			$win = g.CheckifWin($LineNum,$words)
			if $win != 1
				secret = g.ReGenSecretWord
				g.setsecretword(secret)
				g.createtemplate
			else
				redirect "/win"				
			end
		end		

	   redirect "/Play"
	end 
	
	get '/New' do	
		$turn = 0
		$win = 0
		$words = 0			
		g.resetgame
		g.readwordfile($filename)
		secret = g.gensecretword
		g.setsecretword(secret)
		g.createtemplate
		$GuessCharRight = 0
		$ShowGuess = "Nothing"
		$ShowTurnLeft = 5
		erb :new
	end	

	get '/Analysis' do
		$ShowResulta = g.DisplayResulta
		erb :analysis
	end

	get '/Home' do
		redirect "/"
	end	

	get '/Exit' do
		erb :exit
	end

	get '/win' do
		erb :win
	end

	get '/fail' do
		erb :fail
	end


	# Any code added to web-based game should be added above.

# End program