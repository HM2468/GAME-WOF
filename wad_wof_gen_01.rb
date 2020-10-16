# Ruby code file - All your code should be located between the comments provided.
# Main class module
module WOF_Game
	# Input and output constants processed by subprocesses. MUST NOT change.
	GOES = 5

	class Game
		attr_reader :template, :wordtable, :input, :output, :turn, :turnsleft, :winner, :secretword, :played, :score, :resulta, :resultb, :guess
		attr_writer :template, :wordtable, :input, :output, :turn, :turnsleft, :winner, :secretword, :played, :score, :resulta, :resultb, :guess
		
		def initialize(input, output)
			@input = input
			@output = output
			@played = 0
			@score = 0
		end

		
		
		# Any code/methods aimed at passing the RSpect tests should be added below.
		def start
			@output.puts('Welcome to Hangman!')
			@output.puts("Created by: #{created_by} (#{student_id})")
			@output.puts('Starting game...')
			@output.puts('Enter 1 to run the game in the command-line window or 2 to run it in a web browser')
		end

		def created_by
			return "HuangMiao"
		end

		def student_id
			return 51988466
		end

		def displaymenu
			@output.puts("Menu: (1) Play | (2) New | (3) Analysis | (9) Exit")
		end

		def resetgame
			@wordtable = []
			@secretword = ""
			@turn = 0
			@resulta = []
			@resultb = []
			@winner = 0
			@guess = ""
			@template = "[]"
		end

		def readwordfile(filename)
			if !@wordtable
				@wordtable = []
			end
			file = File.open(filename)
			cnt = 0	            
			file.each do |line|
				if line
					cnt += 1
					@wordtable.push(line.strip) 
				end	                                  
			end 				                    
			file.close
			return cnt
		end
		
		def gensecretword
			return @wordtable[rand(0..@wordtable.length-1)].upcase
		end

		def ReGenSecretWord
			return @resultb[rand(0..@resultb.length-1)]
			
		end		

		def setsecretword(secret)
			@secretword = secret
		end

		def getsecretword
			return @secretword
		end

		def createtemplate
			strlen = @secretword.length
			str = '['
			for i in 1..strlen
				str += '_'
			end
			str += ']'
			@template =str
			return @template
		end

		def displaytemplate
			puts @template
			return @template
		end
	
		def charinword(char)
			check = CheckIfExistChar(char)
			strlen = @secretword.length
			if(check >= 0)
				for i in 0..strlen
					if(char == @secretword[i])
						@template[i+1] = @secretword[i].upcase
					end
				end				
			end
			return check
		end

		def CheckIfExistChar(char)
			check = @secretword.index(char)
			if !check
				return -1
			end
			return check
		end

		def GotOneWordRight
			rightword = @secretword.to_s
			puts "Congratulations! You got #{rightword} right."
		end

 		def CheckifWin(a,b)
 			if a == b
				return 1
			end
 			return 0
 		end		

		def addplayed
			@played += 1
		end

		def incrementturn
			@turn += 1
		end

		def addscore
			@score += 100
		end
	
		def getturnsleft
			@turnsleft = GOES - @turn
		end

		def DisplayWinner(result)
			if result == true
				return "Well done. You win."
			end
			if result == false
				return "Sorry, you failed."
			end
		end

		def getguess
			guess = @input.gets.chomp.upcase
		end
		
#		def storeguess(guess)
#			if guess!= ""
#				@guess = @guess.to_a.push "#{guess}"
#			end
#		end

		def InvalidInput
			@output.puts('Invalid input.')
		end

		def WordRevealed
			if  @secretword.upcase.count("A-Z") == @template.count("A-Z")
				return 1
			else
				return 0
			end
		end


		def UpdateResulta
			return @resulta.push(@secretword) 		
		end

		def UpdateResultb
			temp = @wordtable
			for i in 0..(temp.length-1)
				temp[i] = temp[i].upcase
			end
			@resultb = temp - @resulta
			return @resultb
		end

		def DisplayResulta
			puts @resulta
			puts
			return @resulta
		end

		def DisplayResultb
			print @resultb
			puts
			return @resultb
		end

		def ShowWordtable
			print @wordtable
			puts
			return @wordtable
		end
		# Any code/methods aimed at passing the RSpect tests should be added above.

	end
end