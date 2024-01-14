extends Node

func keys_pressed():
	
	var pressed = []
	
	# Add pressed keys to list in big 
	
	if Input.is_key_pressed(KEY_A): pressed.append("A")
	if Input.is_key_pressed(KEY_B): pressed.append("B")
	if Input.is_key_pressed(KEY_C): pressed.append("C")
	if Input.is_key_pressed(KEY_D): pressed.append("D")
	if Input.is_key_pressed(KEY_E): pressed.append("E")
	if Input.is_key_pressed(KEY_F): pressed.append("F")
	if Input.is_key_pressed(KEY_G): pressed.append("G")
	if Input.is_key_pressed(KEY_H): pressed.append("H")
	if Input.is_key_pressed(KEY_I): pressed.append("I")
	if Input.is_key_pressed(KEY_J): pressed.append("J")
	if Input.is_key_pressed(KEY_K): pressed.append("K")
	if Input.is_key_pressed(KEY_L): pressed.append("L")
	if Input.is_key_pressed(KEY_M): pressed.append("M")
	if Input.is_key_pressed(KEY_N): pressed.append("N")
	if Input.is_key_pressed(KEY_O): pressed.append("O")
	if Input.is_key_pressed(KEY_P): pressed.append("P")
	if Input.is_key_pressed(KEY_Q): pressed.append("Q")
	if Input.is_key_pressed(KEY_R): pressed.append("R")
	if Input.is_key_pressed(KEY_S): pressed.append("S")
	if Input.is_key_pressed(KEY_T): pressed.append("T")
	if Input.is_key_pressed(KEY_U): pressed.append("U")
	if Input.is_key_pressed(KEY_V): pressed.append("V")
	if Input.is_key_pressed(KEY_W): pressed.append("W")
	if Input.is_key_pressed(KEY_X): pressed.append("X")
	if Input.is_key_pressed(KEY_Y): pressed.append("Y")
	if Input.is_key_pressed(KEY_Z): pressed.append("Z")
	if Input.is_key_pressed(KEY_SPACE): pressed.append("SPACE")
	
	# A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
	print(pressed)
	
	return pressed
	
