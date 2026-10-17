
.data
size:   .word 50, 50, 100, 100, 100, 9599
price:  .word 1760, 1820, 2110, 2660, 3010, 3160
prompt: .asciiz "Nhap so kWh (0..9999): "
errmsg: .asciiz "Gia tri khong hop le, nhap lai.\n"
res1:   .asciiz "Tien dien: "
res2:   .asciiz " dong\n"

.text
.globl main
main:
        la   $s2, size
        la   $s3, price
input:
        la   $a0, prompt
        li   $v0, 4
        syscall
        li   $v0, 5
        syscall
        move $s0, $v0
        sltiu $t1, $s0, 10000      
        bne  $t1, $zero, valid
        la   $a0, errmsg
        li   $v0, 4
        syscall
        j    input
valid:
        li   $s1, 0
        li   $t0, 0
loop:
        add  $t1, $s2, $t0
        lw   $t2, 0($t1)           
        add  $t1, $s3, $t0
        lw   $t3, 0($t1)           
        slt  $t4, $t2, $s0          
        beq  $t4, $zero, last
        mul  $t5, $t2, $t3
        add  $s1, $s1, $t5
        sub  $s0, $s0, $t2
        addi $t0, $t0, 4
        j    loop
last:
        mul  $t5, $s0, $t3
        add  $s1, $s1, $t5
        la   $a0, res1
        li   $v0, 4
        syscall
        move $a0, $s1
        li   $v0, 1
        syscall
        la   $a0, res2
        li   $v0, 4
        syscall
        li   $v0, 10
        syscall
