INCLUDE Irvine32.inc

.data
    msg  BYTE "The array is as follows : ", 0
    msg1 BYTE "array ", 0
	msg2 BYTE "location ", 0
	output BYTE " = ", 0
	sorted BYTE 2,5,9,11,23,41,57,68,71,82,85
	 msg3  BYTE "Which location do you wish to change:", 0
	index DWORD 0
.code
main PROC
    call Clrscr
    call print
    call PrintArray
    call Shifting
    call print2
    exit
main ENDP

print PROC
    mov edx, OFFSET msg
    call WriteString
    call Crlf
    call Crlf
    
    mov edx, OFFSET msg1
    call WriteString
    call Crlf
    ret
print ENDP

PrintArray PROC
    mov ecx, LENGTHOF sorted
    mov edi, OFFSET sorted

L1:
    mov edx, OFFSET msg2
    call WriteString
    mov eax, LENGTHOF sorted
    sub eax, ecx    ; Move current index to eax for printing
    call WriteDec
    mov edx, OFFSET output
    call WriteString
    mov al, [edi]
    call WriteDec
    call Crlf
    inc edi
    loop L1
    ret
PrintArray ENDP
 
Shifting PROC
     call Crlf
    mov edx, OFFSET msg3
    call WriteString
    call ReadInt               ; Read input location into eax
    mov index, eax             ; Store in index variable

    ; Shift elements to the right
    mov ecx, LENGTHOF sorted
    sub ecx, index             ; Number of elements to shift
    dec ecx                    ; Exclude the last element
    mov edi, OFFSET sorted
    add edi, LENGTHOF sorted
    dec edi                    ; Point to the last element

ShiftRight:
    mov al, [edi - 1]          ; Load the value from the previous position
    mov [edi], al              ; Shift value to the right
    dec edi                    ; Move to the left element
    loop ShiftRight

    ; Insert the new value (0 in this case)
    mov edi, OFFSET sorted
    add edi, index             ; Move edi to the specified location
    mov BYTE PTR [edi], 0      ; Insert 0 at the specified location
    ret
Shifting ENDP

print2 PROC
    call Crlf
    mov edx, OFFSET msg1       ; Print updated message
    call WriteString
    call Crlf
    mov ecx, LENGTHOF sorted
    mov edi, OFFSET sorted

PrintLoop:
    mov edx, OFFSET msg2
    call WriteString
    mov eax, LENGTHOF sorted
    sub eax, ecx
    call WriteDec
    mov edx, OFFSET output
    call WriteString
    mov al, [edi]
    movzx eax, al              ; Zero-extend AL to EAX
    call WriteDec
    call Crlf
    inc edi
    loop PrintLoop
    ret
print2 ENDP

END main