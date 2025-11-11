.text
.global setday
#Packed Structure - Read Struct values by (Shifting & ANDing)
#int setday(yearday_t yd);#Argument not pointer/address

setday:
## c function call - int setday(yearday_t yd); 
## rdi = yd = 1st argument

## extract day from packed struct into rax
# No shift needed for reading Day - since Packed Bits 0-31
movq %rdi, %rax  		# copy to rax
andq $0xFFFFFFFF, %rax  # rax = day

## extract year from packed struct into rcx
# Shift needed for reading Year - since Packed Bits 32-63
movq %rdi, %rcx  # copy to rcx
sarq $32, %rcx   # shift right by 32 bits
andq $0xFFFFFFFF, %rcx  # rcx = current year

# check if day is negative
cmpl $0, %eax    
jl .ERROR

##  check if year is < 1970
cmpl $1970, %ecx
jl .ERROR

# get number of years since 1970 = current year - 1970
subl $1970, %ecx   # ecx = number of years

# number of days = 365 * number of years
imull $365, %ecx
movl %ecx, DAYS_SINCE_1970(%rip) # write to global variable
movl $0, %eax
ret

.ERROR:
#  sets the global variable DAYS_SINCE_1970 to be -1 
movl $-1, DAYS_SINCE_1970(%rip)
movl $1, %eax  # set return value to 1
ret 

