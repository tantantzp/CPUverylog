NOP
LI R1 23		
LI R2 1		
LI R3 3		
LI R4 4		
LI R6 82		
SLL R6 R6 0	
SW R6 R2 0	
SLT R1 R2		
BTEQZ 2
NOP
LI R3 33		
CMPI R2 1	
BTEQZ 2
NOP
LI R4 44		
JR R7
NOP