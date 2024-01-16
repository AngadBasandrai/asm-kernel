nl:
	db 0xA, 0xD, 0

test:
	db 'TEST ', 0

test2:
	db 'TEST? ', 0

welcome:
	db '------------------------------', 0xA, 0xD, 'Kernel Booted! Welcome to MyOS', 0xA, 0xD, '------------------------------', 0xA, 0xD, 0

fileTableHeading:
	db '------------        ------        ----        ---', 0xA, 0xD,\
	   'File/Program        Sector        Size        Ext', 0xA, 0xD,\
	   '------------        ------        ----        ---', 0xA, 0xD, 0

cmdDir:
	db 'dir', 0

cmdRbt:
	db 'rbt', 0

cmdGfx:
	db 'gfx', 0

cmdHlt:
	db 'hlt', 0

cmdCls:
	db 'cls', 0

def:
	db '>> ', 0

errorBadInput:
	db 0xA, 0xD, 'Error! Command/Program not found!', 0

sectNotFoundString:
	db 0xA, 0xD, 'Sector not found!', 0xA, 0xD, 0

notLoaded:
	db 0xA, 0xD, 'Program could not be loaded!', 0

cmdLength:
	db 0

cmdString:
	db ''