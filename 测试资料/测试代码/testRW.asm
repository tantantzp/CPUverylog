	LI R3 0x0010		;Loop time

LOOP:
	MFPC R4
	ADDIU R4 0x0003
	NOP
	B TESTR
	NOP
	LI R1 0x00BF
	SLL R1 R1 0x0000
	LW R1 R5 0x0000
	LI R1 0x00FF
	AND R5 R1
	NOP
	
	MFPC R4
	ADDIU R4 0x0003	
	NOP
	B TESTR
	NOP
	LI R1 0x00BF
	SLL R1 R1 0x0000
	LW R1 R2 0x0000
	LI R1 0x00FF
	AND R2 R1
	NOP
	;R2��������
	SLL R2 R2 0x0000
	OR R2 R5

	
	MFPC R4
	ADDIU R4 0x0003	
	NOP
	B TESTW	
	NOP
	LI R1 0x00BF 
	SLL R1 R1 0x0000 ;R1=0xBF00	
	SW R1 R2 0x0000

	SRA R2 R2 0x0000
	MFPC R4
	ADDIU R4 0x0003	
	NOP
	B TESTW	
	NOP	
	LI R1 0x00BF 
	SLL R1 R1 0x0000 ;R1=0xBF00	
	SW R1 R2 0x0000	
	
	ADDIU R3 0xFFFF	;Looptime --
	NOP
	BNEZ R3 LOOP
	NOP
	B END
	NOP

TESTW:	
	NOP	 		
	LI R1 0x00BF 
	SLL R1 R1 0x0000 
	ADDIU R1 0x0001 
	LW R1 R0 0x0000 
	LI R1 0x0001 
	AND R0 R1 
	BEQZ R0 TESTW     ;BF01&1=0 
	NOP		
	JR R4
	NOP
	
TESTR:	
	NOP	
	LI R1 0x00BF 
	SLL R1 R1 0x0000
	ADDIU R1 0x0001 
	LW R1 R0 0x0000 
	LI R1 0x0002
	AND R0 R1 
	BEQZ R0 TESTR   ;BF01&2=0  
	NOP
	JR R4
	NOP

END:
	NOP
