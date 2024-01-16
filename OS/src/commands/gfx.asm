gfx:
	mov ax, 0x0C04	;Edit pixels
	mov cx, 100
	mov dx, 60

	squareLoop:
		inc cx
		int 0x10
		cmp cx, 220
		jne squareLoop

		inc dx
		mov cx, 100
		cmp dx, 140
		jne squareLoop

	ret