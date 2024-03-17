;Implementation of Binary Search in 8086 Assembly Language by Hari Venkataraman, Suriya M, and Harsith Sh

DATA segment
    ARR DW 17,20,26,31,44,54,55,77,93
    LEN DW ($-a)/2
    KEY DW 31
    MSG1 DB "KEY WAS FOUND AT: "
    RES DB ?
    MSG3 DB " POSITION",13,10,"$" 
    MSG2 DB "KEY NOT FOUND $"
data ends 
code segment
    assume cs:code, ds:data
   
start:
    MOV AX,DATA ;Setting up Accumulator for Data Array Values
    MOV DS,AX
    MOV BX,0
    MOV DX,LEN
    MOV CX,KEY ;Setting Count Register to the Search Key  

LOCA2:
    CMP BX,DX
    JA FAIL
    MOV AX,BX
    ADD AX,BX
    SHR AX,1  ;Finds the Median Index by Shifting Right
    MOV SI,AX
    ADD SI,SI
    CMP CX,ARR[SI] ;Compares the Search Key with Current Value
    JAE LOCA1 ;If match found
    DEC AX
    MOV DX,AX
    JMP LOCA2
    
LOCA1:
    JE SUCCESS ;Displaying found message
    INC AX
    MOV BX,AX
    JMP LOCA2

SUCCESS:
    ADD AL,01
    ADD AL,'0'  ;Convert to ASCII to print the message
    MOV RES,AL
    LEA DX,MSG1  ;Message found is printed along with index
    JMP DISPLAY
    
FAIL:
    LEA DX,MSG2    ;If element is not found, then failure message printed
    
DISPLAY:
    MOV AH,09H
    INT 21H
    MOV AH,4CH
    INT 21H
    
code ends
end start
    
   