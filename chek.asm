IDEAL
MODEL small
STACK 100h
DATASEG
x db 0
y db 0
color db 0Fh
;availableSpots db dup 32 {0Fh}
CODESEG

;===============;
;===============;
;proc legalMoves
;currentLocation equ [bp+4]
;offsetcolors equ [bp+6]
;turnoffset equ [bp+8]
;push bp
;mov bp, sp
;push cx
;mov cx, 32
;cmp turnoffset, 0
;jne player2Turn
;player1Turn:
	

;player2Turn:


proc drawSquare
	push bp
	mov bp, sp
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	xor ax, ax
	mov bx, [bp+8] ;moving the x axis offset to bx
	mov si, [bp+6] ;moving the y axis offset to si
	mov di, [bp+4] ;moving the color offset to di
	mov cx, 19h
	;mov dx, [si] ;y
	
yAxis: ;repeats the loop 19h times which is the hight of the rectangle
	push dx
	push cx ; pushed the value of cx so the loop won't break
	push [bx] ; holes the location of the start of the rectangle in the x axis

	mov ax, 28h	
	xAxis: ;repeats the printing of the pixel 28h times which is the length of the rectangle 
		mov cl,[bx] ;x axis of the pixel drawn
		mov dl, [si] ; y axis of the pixel drawn
		push ax
		mov al,[byte ptr di] ;color of the pixel drawn
		mov ah,0ch
		int 10h
		pop ax
		inc [byte ptr bx] ; the value of the x axis is increased so it will make a line (the the y axis is increased and it makes a line again)
		dec ax
		cmp ax, 0
		jne xAxis
	inc [byte ptr si]
	;mov [si], dx
	pop [bx]
	mov [byte ptr bx], cl ; restores the x value of the start of the rectangle so when the y axis is increased it will start from the right x axis
	pop cx
	;mov

	; new line
	mov ah, 2
	mov dl, 10
	int 21h
	mov dl, 13
	int 21h
	pop dx
	loop yAxis 
	
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp
	ret 6
endp drawSquare
proc drawBoard
push bp 
mov bp, sp
push cx
push bx
mov cx,8
xAxisOffset equ [bp+8]
loop1:
	push cx
	push [bp+8]
	push [bp+6]
	push [bp+4]
	call drawSquare
	mov bx, [bp+8]
	add [byte ptr bx], 50h
	pop cx
	loop loop1
pop bx
pop cx
pop bp
ret 6
endp drawBoard

start:
	mov ax, @data
	mov ds, ax
	mov ax, 13h
	int 10h
	push offset x
	push offset y
	push offset color
	call drawSquare ; recives x location, y location, and the color of the square
	mov ah,00h ; wait for key press so the program won't end instantly
	int 16h
	





exit:
mov ax, 4c00h
int 21h
END start
