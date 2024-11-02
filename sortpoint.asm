INCLUDE Irvine32.inc

.data
    msg  BYTE "The array is as follows : ", 0
    msg1 BYTE "array ", 0
    msg2 BYTE "location ", 0
    output BYTE " = ", 0
    sorted BYTE 2,5,9,11,23,41,57,68,71,82,85
    msg3  BYTE "Which location do you wish to change: ", 0
    arraySize DWORD LENGTHOF sorted

.code
main PROC
    call Clrscr
    call PrintInitial
    call PrintArray
    call Shifting
    call Print2
    exit
main ENDP

PrintInitial PROC
    mov edx, OFFSET msg
    call WriteString
    call Crlf
    call Crlf
    mov edx, OFFSET msg1
    call WriteString
    call Crlf
    ret
PrintInitial ENDP

PrintArray PROC
    mov ecx, arraySize
    mov esi, OFFSET sorted  ; Use ESI as pointer to array elements

PrintLoop:
    mov edx, OFFSET msg2
    call WriteString
    mov eax, arraySize
    sub eax, ecx            ; Calculate current index
    call WriteDec
    mov edx, OFFSET output
    call WriteString
    movzx eax, BYTE PTR [esi]  ; Load byte at [ESI] into EAX with zero extension
    call WriteDec
    call Crlf
    inc esi                 ; Move to next element
    loop PrintLoop
    ret
PrintArray ENDP

Shifting PROC
    mov edx, OFFSET msg3
    call WriteString
    call ReadInt            ; Read input location into EAX
    mov ebx, eax            ; Store the input location in EBX
    
    mov ecx, arraySize
    sub ecx, ebx            ; Number of elements to shift
    dec ecx                 ; Exclude the last element
    
    mov esi, OFFSET sorted
    add esi, arraySize
    dec esi                 ; ESI points to the last element
    mov edi, esi            ; EDI also points to the last element
    dec esi                 ; ESI points to the second-to-last element

    ; Shift elements to the right
ShiftLoop:
    mov al, [esi]           ; Load byte from source
    mov [edi], al           ; Store byte to destination
    dec esi                 ; Move to previous source byte
    dec edi                 ; Move to previous destination byte
    loop ShiftLoop          ; Repeat until ECX becomes zero

    ; Insert the new value (0 in this case)
    mov edi, OFFSET sorted
    add edi, ebx            ; Move to the specified location
    mov BYTE PTR [edi], 0   ; Insert 0 at the specified location

    ret
Shifting ENDP
print2 PROC
    call Crlf
    mov edx, OFFSET msg1
    call WriteString
    call Crlf
    
    mov ecx, arraySize
    mov esi, OFFSET sorted  ; Use ESI as pointer to array elements

PrintLoop:
    mov edx, OFFSET msg2
    call WriteString
    mov eax, arraySize
    sub eax, ecx            ; Calculate current index
    call WriteDec
    mov edx, OFFSET output
    call WriteString
    movzx eax, BYTE PTR [esi]  ; Load byte at [ESI] into EAX with zero extension
    call WriteDec
    call Crlf
    inc esi                 ; Move to next element
    loop PrintLoop
    ret
print2 ENDP
END main