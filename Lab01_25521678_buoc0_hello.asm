
.data
ChuoiHello: .asciiz "Xin chao MARS"
.text
main:
        li   $v0, 4
        la   $a0, ChuoiHello
        syscall
        li   $v0, 10
        syscall
