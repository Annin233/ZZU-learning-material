 .text
#################################################################################
#本程序实现（字节地址0x200，字地址0x80）开始的8个字单元的降序排序,此程序可在mars mips仿真器中运行,运行时请将Mars Setting中的Memory Configuration设置为Compact，data at address 0
#
#################################################################################
 .text
sort_init:
 addi $s0,$0,-1     #s0=-1
 addi $s1,$0,0      #s1=0
 sw $s0,512($s1)  #[0x200]=-1
 addi $s0,$s0,2    #s0=0
 addi $s1,$s1,4    #s1=4
 sw $s0,512($s1) #[0x204]=0
 addi $s0,$s0,4   #s0=1
 addi $s1,$s1,4   #s1=8
 sw $s0,512($s1) #[0x208]=1
 addi $s0,$s0,6   #s0=2
 addi $s1,$s1,4   #s1=12
 sw $s0,512($s1) #[0x212]=2
 addi $s0,$s0,8
 addi $s1,$s1,4
 sw $s0,512($s1)
 addi $s0,$s0,10
 addi $s1,$s1,4
 sw $s0,512($s1)
 addi $s0,$s0,12
 addi $s1,$s1,4
 sw $s0,512($s1)
 addi $s0,$s0,14
 addi $s1,$s1,4
 sw $s0,512($s1)
#0x200开始初始化8个数，依次是-1(0x200),0(0x204),1(0x208),2(0x212),3(0x216),4(0x220),5(0x224),6(0x228)

 add $s0,$zero,$zero   #s0=0
 addi $s1,$zero,28   #排序区间s0=28=4*7

sort_loop:
 lw $s3,512($s0)    # s3=前面的数
 lw $s4,512($s1)    # s4=后面的数
 slt $t0,$s4,$s3     # 如果 s4 < s3（即前面比后面大），t0=1
 beq $t0,$0,sort_next   # 若 s4 >= s3，跳过交换（保持升序）
 sw $s3, 512($s1)   # 交换：把大的 s3 放后面
 sw $s4, 512($s0)   # 把小的 s4 放前面

sort_next:
 addi $s1, $s1, -4   #s1=s1-4
 bne $s0, $s1, sort_loop  #s1==s0 冒泡(选择)排序法 内循环
 
 addi $s0,$s0,4
 addi $s1,$zero,28
 bne $s0, $s1, sort_loop #冒泡(选择)排序法 外循环
 addi   $v0,$zero,10         # system call for exit
 syscall                  # we are out of here.   
