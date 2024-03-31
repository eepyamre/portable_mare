  org 0x7C00  
%define WIDTH 320 
%define BLACK 0x00
%define PINK 0x25
%define LIGHT_PINK 0x3D
%define YELLOW 0x2D
%define BLUE 0x0B
%define OFFSET 50
  mov ah, 0x00
  mov ax, 0x13
  int 0x10

  mov ax, 0xA000
  mov es, ax 
  xor di, di
  mov BYTE [color], LIGHT_PINK
  mov WORD [rect_pos_x], 0
  mov WORD [rect_pos_y], 0
  mov WORD [rect_init_pos_x], 0
  mov WORD [rect_end_x], 1
  mov WORD [rect_end_y], 1
  mov ax, 6
  mov bx, 8
  mov cx, 10
  mov dx, 14
  call draw_thing

  mov ax, 14
  mov bx, 14
  mov cx, 10
  mov dx, 14
  call draw_thing

  mov ax, 12
  mov bx, 17
  mov cx, 2
  mov dx, 7
  call draw_thing


  mov ax, 6
  mov bx, 16
  mov cx, 7
  mov dx, 10
  call draw_thing

  mov BYTE [color], BLACK
  mov ax, 15
  mov bx, 17
  mov cx, 5
  mov dx, 7
  call draw_thing

  mov ax, 16
  mov bx, 16
  mov cx, 3
  mov dx, 3
  call draw_thing

  mov BYTE [color], PINK
  mov ax, 12
  mov bx, 15
  mov cx, 0
  mov dx, 0
  call draw_thing

  mov ax, 11
  mov bx, 17
  mov cx, 1
  mov dx, 1
  call draw_thing

  mov ax, 16
  mov bx, 16
  mov cx, 2
  mov dx, 2
  call draw_thing

  mov ax, 10
  mov bx, 13
  mov cx, 2
  mov dx, 8
  call draw_thing

  mov ax, 2
  mov bx, 2
  mov cx, 6
  mov dx, 11
  call draw_thing

  mov ax, 3
  mov bx, 3
  mov cx, 5
  mov dx, 10
  call draw_thing

  mov ax, 4
  mov bx, 4
  mov cx, 5
  mov dx, 9
  call draw_thing

  mov ax, 5
  mov bx, 5
  mov dx, 6
  mov cx, 6
  call draw_thing

  mov BYTE [color], BLACK
  mov ax, 10
  mov bx, 10
  mov dx, 4
  mov cx, 4
  call draw_thing
  jmp $

draw_thing:
; ax, bx, cx, dx
  mov WORD [rect_init_pos_x], ax 
  mov WORD [rect_pos_x], ax 
  mov WORD [rect_end_x], bx
  mov WORD [rect_pos_y], cx
  mov WORD [rect_end_y], dx
  xor dx, dx
  xor cx, cx
  xor bx, bx
  xor ax, ax
  xor dl, dl
  xor di, di
  call draw_rect
  ret

draw_rect:
  mov ax, 0xA000
  mov es, ax 
  mov ax, WORD [rect_init_pos_x] 
  mov WORD [rect_pos_x], ax
loop_row: 
  mov ax, WORD [rect_pos_y]
  add ax, OFFSET
  mov si, WORD WIDTH
  mul si
  add ax, WORD [rect_pos_x]
  add ax, OFFSET
  mov dl, BYTE [color]
  mov di, ax
  mov [es:di], dl
  inc WORD [rect_pos_x]
  mov ax, WORD [rect_pos_x]
  cmp ax, WORD [rect_end_x]
  jb loop_row
  inc WORD [rect_pos_y]
  mov ax, WORD [rect_pos_y]
  cmp ax, WORD [rect_end_y]
  jb draw_rect
  ret

rect_pos_x: dw 0
rect_pos_y: dw 0
rect_init_pos_x: dw 0
rect_end_x: dw 1
rect_end_y: dw 1
color: db LIGHT_PINK

  times 510-($-$$) db 0
  dw 0xaa55