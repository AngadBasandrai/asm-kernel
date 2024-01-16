mainMenu:
	call clearScreen
	mov si, welcome
	call printString
	
	getInput:
		mov si, nl
		call printString
		mov si, def
		call printString
		xor cx, cx
		mov si, cmdString

		mov ax, 0x2000
		mov es, ax
		mov ds, ax

	keyloop:
		xor ax, ax
		int 0x16

		mov ah, 0x0e
		cmp al, 0xD
		je runCmd

		int 0x10
		mov [si], al
		inc cx
		inc si
		jmp keyloop

	runCmd:
		cmp cx, 0
		je getInput

		mov byte [si], 0
		mov si, cmdString

	checkCmd:

		push cx
		mov di, cmdDir
		repe cmpsb
		je callFileTable

		pop cx
		push cx
		mov di, cmdRbt
		mov si, cmdString
		repe cmpsb
		je warmReboot

		pop cx
		push cx
		mov di, cmdGfx
		mov si, cmdString
		repe cmpsb
		je callGfx

		pop cx
		push cx
		mov di, cmdCls
		mov si, cmdString
		repe cmpsb
		je callClearScreen

		pop cx
		push cx
		mov di, cmdHlt
		mov si, cmdString
		repe cmpsb
		je endPgm

		pop cx

	startSearch:
		mov si, cmdString
		mov ax, 0x1000
		mov es, ax
		xor bx, bx
		inc bx
	
	checkChar:
		mov al, [ES:BX]
		cmp al, 0
		je inputNotFound

		cmp al, [si]
		je startCompare

		add bx, 21
		jmp checkChar

	startCompare:
		push bx

	compareLoop:
		mov al, [ES:BX]
		inc bx
		cmp al, [si]
		jne restartSearch

		dec cx
		jz foundPgm
		inc si
		jmp compareLoop

	restartSearch:
		mov si, cmdString
		pop bx
		inc bx
		jmp checkChar

	foundPgm:

		add bx, 2
		mov cl, [ES:BX]

		add bx, 3
		mov bl, [ES:BX]

		mov ax, 0x8000
		mov es, ax

		mov dh, 0x0
		mov dl, 0x0
		mov cx, 0x0
		mov cl, 0x01

		mov ah, 0x02
		mov al, bl

		mov bx, 0x0
		int 0x13
		jnc pgmLoaded

		mov si, notLoaded
		call printString
		jmp getInput

	pgmLoaded:
		mov ax, 0x8000
		mov ds, ax
		mov es, ax
		mov fs, ax
		mov gs, ax
		mov ss, ax
		jmp 0x8000:0x0000

	inputNotFound:
		mov si, errorBadInput
		call printString
		jmp getInput

callFileTable:
	call printFileTable
	jmp getInput

warmReboot:
	jmp 0x1000:0x0000

callGfx:
	call clearGfxScreen
	call gfx
	mov ah, 0x00
	int 0x16
	jmp mainMenu

callClearScreen:
	jmp clearScreen
	jmp mainMenu

endPgm:
	hlt


;;; INCLUDES

%include "../src/commands/printFileTable.asm"
%include "../src/commands/clearScreen.asm"
%include "../src/commands/clearGfxScreen.asm"
%include "../src/commands/gfx.asm"
%include "../src/print/printString.asm"
%include "../src/print/vars.asm"


;;; MARKING SIZE

times 2048-($-$$) db 0