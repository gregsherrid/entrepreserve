#place in application.rb: 'Dir.glob("./lib/*.{rb}").each { |file| require file } # require each file from lib directory'

def debug( val )
	if val.nil?
		val = "<NIL>"
	else
		val = val.to_s
		if val.length == 0
			val = "<EMPTY>"
		end
	end
	$stderr.puts( "\033[46m\033[30m" + val + "\033[0m" )
end