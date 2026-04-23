.586
.model flat, stdcall
option casemap:none

include \masm32\include\kernel32.inc
includelib \masm32\lib\kernel32.lib

.data
    Arreglo  SDWORD 7, 9, 5, 1, 6, 8, 3, 2, 9, 0
    ; Calculamos la cantidad de elementos dinámicamente
    Cantidad EQU ($ - Arreglo) / 4 

.code 
main proc
    call Ordenar
    
    ; Terminar el proceso limpiamente
    push 0
    call ExitProcess
main endp

; --- SUBRUTINA DE ORDENAMIENTO (Bubble Sort) ---
Ordenar proc
    mov ecx, Cantidad
    dec ecx             ; Necesitamos (n-1) pasadas externas

L1:
    push ecx            ; Guardamos el contador externo
    mov esi, offset Arreglo

L2:
    mov eax, [esi]      ; Elemento actual
    mov ebx, [esi+4]    ; Elemento siguiente
    
    cmp eax, ebx        ; ¿El de la izquierda es mayor que el de la derecha?
    jle NoIntercambio   ; Si es menor o igual, no hacemos nada
    
    ; Intercambio (Swap)
    mov [esi], ebx
    mov [esi+4], eax

NoIntercambio:
    add esi, 4          ; Movemos el puntero al siguiente elemento (4 bytes)
    loop L2             ; Repetimos para la pasada interna

    pop ecx             ; Recuperamos el contador externo
    loop L1             ; Siguiente pasada completa
    ret 
Ordenar endp

end main
