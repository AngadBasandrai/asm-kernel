printFileTable:
	xor cx, cx
	mov ax, 0x1000
	mov es, ax
	xor bx, bx
	mov ah, 0x0e

	mov si, nl
	call printString
	mov si, fileTableHeading
	call printString

	fileTableLoop:
		inc bx
		mov al, [ES:BX]
		cmp al, '}'
		je endFileTable
		cmp al, '-'
		je sectorNumLoop
		int 0x10
		inc cx
		jmp fileTableLoop

	sectorNumLoop:
		cmp cx, 20
		je fileTableLoop2
		mov al, ' '
		int 0x10
		inc cx
		jmp sectorNumLoop

	fileTableLoop2:
		inc bx
		mov al, [ES:BX]
		cmp al, '}'
		je endFileTable
		cmp al, '-'
		je sizeLoop
		cmp al, ','
		je nextElem
		int 0x10
		inc cx
		jmp fileTableLoop2

	sizeLoop:
		cmp cx, 34
		je fileTableLoop3
		mov al, ' '
		int 0x10
		inc cx
		jmp sizeLoop

	fileTableLoop3:
		inc bx
		mov al, [ES:BX]
		cmp al, '}'
		je endFileTable
		cmp al, '-'
		je extLoop
		cmp al, ','
		je nextElem
		int 0x10
		inc cx
		jmp fileTableLoop3

	extLoop:
		cmp cx, 46
		je fileTableLoop3
		mov al, ' '
		int 0x10
		inc cx
		jmp extLoop

	nextElem:
		xor cx, cx
		mov si, nl
		call printString
		mov si, nl
		call printString
		jmp fileTableLoop

	endFileTable:
		ret