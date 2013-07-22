def must_be_present( obj, assign )
	val = obj.send( assign )

	obj.send( assign+"=", "" )
	should_not be_valid

	obj.send( assign+"=", val )
	should be_valid
end
