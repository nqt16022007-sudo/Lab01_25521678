
.data
pitch:   .word 64,64,65,67,67,65,64,62,60,60,62,64,64,62,62   
dur:     .word 2,2,2,2,2,2,2,2,2,2,2,2,3,1,4                   
count:   .word 15
msgsum:  .asciiz "Tong du kien (ms): "
msgmeas: .asciiz "Thoi gian do duoc (ms): "
space:   .asciiz " "
newline: .asciiz "\n"

.text
.globl main
main:
        la   $s0, pitch
        la   $s1, dur
        la   $t0, count
        lw   $s2, 0($t0)            
        li   $s3, 0                
        li   $s4, 0                
        li   $s5, 220               
        li   $v0, 30                
        syscall
        move $s6, $a0               
loop:
        beq  $s3, $s2, done         
        sll  $t0, $s3, 2            
        add  $t1, $s0, $t0
        lw   $t2, 0($t1)            
        add  $t3, $s1, $t0
        lw   $t4, 0($t3)            
        addi $t2, $t2, 8            
        mul  $t5, $t4, $s5          
        add  $s4, $s4, $t5          
        move $a0, $t2               
        li   $v0, 1
        syscall
        la   $a0, space
        li   $v0, 4
        syscall
        move $a0, $t5               # in thoi luong ms
        li   $v0, 1
        syscall
        la   $a0, newline
        li   $v0, 4
        syscall
        move $a0, $t2               # a0 = cao do
        move $a1, $t5               # a1 = thoi luong (ms)
        li   $a2, 73                # a2 = nhac cu
        li   $a3, 100               # a3 = am luong
        li   $v0, 33                # cau hinh A: phat dong bo (cho not ket thuc)
        syscall
        addi $s3, $s3, 1
        j    loop
done:
        li   $v0, 30
        syscall
        sub  $s7, $a0, $s6          # thoi gian do duoc = ket thuc - bat dau
        la   $a0, msgsum
        li   $v0, 4
        syscall
        move $a0, $s4
        li   $v0, 1
        syscall
        la   $a0, newline
        li   $v0, 4
        syscall
        la   $a0, msgmeas
        li   $v0, 4
        syscall
        move $a0, $s7
        li   $v0, 1
        syscall
        la   $a0, newline
        li   $v0, 4
        syscall
        li   $v0, 10
        syscall
