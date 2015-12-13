;Файл с подпрограммами формирования временных задержек

waiter_10us:      ;задержка около 1\100000 sec     
ldi Rab2,$14         
LOOP1:
dec Rab2
cpi Rab2,0
brne LOOP1
ret

waiter_1000us:    ;задержка около 1\1000 sec
ldi Rab3,86
nop
nop
LOOP2:
nop
nop
rcall waiter_10us
dec Rab3
cpi Rab3,0
brne LOOP2
ret

waiter_100ms:      ;задержка около 0.1 sec
wdr
ldi Rab4,99
LOOP3:
rcall waiter_1000us
rcall waiter_10us
dec Rab4
cpi Rab4,0
brne LOOP3
ret

waiter_10ms:       ;задержка около 0.01 sec
wdr
ldi Rab4,10
LOOP5:
rcall waiter_1000us
rcall waiter_10us
dec Rab4
cpi Rab4,0
brne LOOP5
ret

create_time_period:       ;задержка кратная 0.1 сек
wdr
mov Rab5,Period           ;зависит от содержимого
LOOP4:                    ;регистра Period 
rcall waiter_10ms
dec Rab5
cpi Rab5,0
brne LOOP4
ret
