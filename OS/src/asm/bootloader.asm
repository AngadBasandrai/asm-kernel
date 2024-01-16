[org 0x7c00]

call loadKernel

%include "../src/asm/diskLoad.asm"

times 510-($-$$) db 0

dw 0xaa55