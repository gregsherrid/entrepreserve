#place in application.rb: 'Dir.glob("./lib/*.{rb}").each { |file| require file } # require each file from lib directory'

def debug( val )
	$stderr.puts( "\033[46m\033[30m" + val.to_s + "\033[0m" )
end