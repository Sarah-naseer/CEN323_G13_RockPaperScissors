; -------------------------------------------------------
; course: cen 323 - computer organization & assembly language
; project: rock paper scissors vs computer
; module: computer display engine & result matrix
; group member: sarah naseer (01-135232-088)
; -------------------------------------------------------

.model small
.stack 100h


; [lecture 6: 8086 instruction groups & segmented memory model]
; defining data structures in the data segment memory space

.data
; part 1 text definitions 
    compmsg     db 0dh, 0ah, 'computer chose: $'
    rockmsg     db 'rock$', 0dh, 0ah
    papermsg    db 'paper$', 0dh, 0ah
    scissormsg  db 'scissors$', 0dh, 0ah

;part 2 text definitions 
    winmsg      db 'you win!$', 0dh, 0ah
    losemsg     db 'you lose!$', 0dh, 0ah
    drawmsg     db 'its a tie!$', 0dh, 0ah

;placeholders for game states 
    player      db 1    ; 1 = rock, 2 = paper, 3 = scissors
    comp        db 2    ; placeholder computer move

.code
main proc
; initialize data segment registers (lecture 6/7)
    mov ax, @data
    mov ds, ax

; -------------------------------------------------------
; sara part 1  computer display module
; -------------------------------------------------------
show_comp:
    
; [lecture 15: display memory & video functions]
; using bios video services interrupt to manually control 
; screen row (dh) and column (dl) cursor placements.
    
    mov ah, 02h
    mov dh, 19
    mov dl, 22
    int 10h


;[lecture 7: direct addressing & data transfer]
;loading the effective offset address of string buffers
    
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

; -------------------------------------------------------
; sara part 2 — game outcome logic matrix
; -------------------------------------------------------

result:
    
; [lecture 9: branching & conditional jumps]
; check for a tie game first by comparing player and cpu registers
    
    mov al, player
    cmp al, comp
    je draw

; test individual player moves to evaluate outcomes
    cmp al, 1
    je player_rock

    cmp al, 2
    je player_paper

; [lecture 10: unconditional jumps]
; if it isn't 1 or 2, it must be 3 (scissors)
    jmp player_scissor

player_rock:
    cmp comp, 2
    je lose
    jmp win

player_paper:
    cmp comp, 3
    je lose
    jmp win

player_scissor:
    cmp comp, 1
    je lose
    jmp win

win:
    
; [lecture 15: display memory & video functions]
; move cursor to row 21, column 28 to print win banner
    
    mov ah, 02h
    mov dh, 21
    mov dl, 28
    int 10h

    lea dx, winmsg
    mov ah, 09h
    int 21h
    jmp again

lose:
; move cursor to row 21, column 26 to print lose banner
    mov ah, 02h
    mov dh, 21
    mov dl, 26
    int 10h

    lea dx, losemsg
    mov ah, 09h
    int 21h
    jmp again

draw:
; move cursor to row 21, column 32 to print draw banner
    mov ah, 02h
    mov dh, 21
    mov dl, 32
    int 10h

    lea dx, drawmsg
    mov ah, 09h
    int 21h
    jmp again

again:
; regular dos exit service (lecture 5)
    mov ah, 4ch
    int 21h
main endp
end main
