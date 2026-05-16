
; =======================================================
; course: cen 323 - computer organization & assembly language
; project: rock paper scissors vs computer
; module: computer display engine
; =======================================================

.model small
.stack 100h


; lecture 6 : 8086 instruction groups & segmented memory model]
; defining data structures in the data segment memory space

.data
;text data definitions 
    compmsg     db 0dh, 0ah, 'computer chose: $'
    rockmsg     db 'rock$', 0dh, 0ah
    papermsg    db 'paper$', 0dh, 0ah
    scissormsg  db 'scissors$', 0dh, 0ah

;placeholders for game states
    player      db 1    
    comp        db 1    

.code
main proc
    ; initialize data segment registers (lecture 6/7)
    mov ax, @data
    mov ds, ax

; sara part 1  computer display module

show_comp:
   
; lecture 15: display memory & video functions
; using bios video services interrupt to manually control 
; screen row (dh) and column (dl) cursor placements.
    
    mov ah, 02h
    mov dh, 19
    mov dl, 22
    int 10h

    
; lecture 7: direct addressing & data transfer
; loading the effective offset address of string buffers
    
    lea dx, compmsg
    mov ah, 09h
    int 21h

  
; [lecture 9: branching - conditional jumps]
; comparing the data variables and dynamically routing 
; execution using flag status check evaluations.
    
    cmp comp, 1
    je show_comp_rock

    cmp comp, 2
    je show_comp_paper

    
; [lecture 10: unconditional jumps]
; routing execution safely past other blocks without status checks
    
    jmp show_comp_scissor

show_comp_rock:
    lea dx, rockmsg
    mov ah, 09h
    int 21h
    jmp result

show_comp_paper:
    lea dx, papermsg
    mov ah, 09h
    int 21h
    jmp result

show_comp_scissor:
    lea dx, scissormsg
    mov ah, 09h
    int 21h
    jmp result

result:
; (part 2 logic to be integrated on next commit)
    
    mov ah, 4ch
    int 21h

main endp
end main




