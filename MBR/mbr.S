;
;the program is MBR assembly
SECTION MBR vstart=0x7c00
;初始化段寄存器
    mov ax,cs
    mov ds,ax
    mov ss,ax
    mov fs,ax
    mov sp,ax

;use 0x06 function to clear table
; int 0x10 function_number:0x06 function：上卷窗口
;----------------------------------------------------
;use assembly to make these things:
;AH=0x06, AL=上卷行数(0表示上卷全部，依靠这个可以实现清屏的操作), BH=上卷属性, (CL,CH)=窗口左上角(X,Y)的属性, (DL,DH)=窗口右下角的属性
;无返回值
    mov ax,0x0600
    mov bx,0x0700
    mov cx,0
    moc dx,0x184f

    int 0x10 ;执行系统调用，将之前BIOS打印出的信息上卷，以此来输出我们想要输出的内容


;这块可以类比为一个函数：get_cursor(功能：获取当前光标位置)
    mov ax,3 ;int 0x10的三号子功能就是获取当前光标的位置
    mov bh,0
    int 0x10

;get_cursor finish
;接下来我们使用汇编语言来打印我们想要输出的内容
    mov ax,name
    mov bp,ax
    ;光标位置要使用到dx，cx寄存器
    mov cx,5
    mov ax,0x1301

    moc bx,2
    int 0x10 
    ;至此打印功能结束

    jmp $;使用这条汇编语言实现暂停功能

    name db "eur1ka"
    times 510-($-$$) db 0
    db 0x55,x0aa