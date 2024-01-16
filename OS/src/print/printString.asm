printString:
	mov ah, 0x0e
	mov al, [si]
	cmp al, 0
	je end
	int 0x10
	add si, 1
	jmp printString

end:
	ret