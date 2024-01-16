loadKernel:
	mov ax, 0x2000
	mov es, ax
	mov bx, 0x0

	mov dh, 0x0
	mov dl, 0x0
	mov cx, 0x0
	mov cl, 0x02

	loadLoop:
		mov ah, 0x02	;read sects
		mov al, 0x04	;numOfSectToRead
		int 0x13

		jc loadLoop

	mov ax, 0x1000
	mov es, ax
	mov bx, 0x0

	mov dh, 0x0
	mov dl, 0x0
	mov cx, 0x0
	mov cl, 0x06

	loadLoop2:
		mov ah, 0x02	;read sects
		mov al, 0x02	;numOfSectToRead
		int 0x13

		jc loadLoop2

mov ax, 0x2000
mov ds, ax
mov es, ax
mov fs, ax
mov gs, ax
mov ss, ax

jmp 0x2000:0x0000