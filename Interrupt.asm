;***** ��������� ���������� �� ������������ TIM0******
TIM_OVF0:
out TCNT0,Bright                  ;��������� ���������� �������� ��������
                                  ;���������� �� Bright

rcall set_value
reti
  
set_value:
mov Universal,Priznak_sostoainia  ;������� ������� ���������
cpi Universal,1                   ;���� 1 �� ������������� ����������   
breq set_combination  
brne set_ff           
set_ff:
ldi Universal,$ff                 ;���� ����� ���������� �� ������������ ff
out PORTB,Universal
out PORTD,Universal
out PORTA,Universal
inc Priznak_sostoainia            ;�����. 1 �����. ��������� ��� �����. ff
ret
set_combination:
dec Priznak_sostoainia            ;�����. 0 �����. ��������� ��� �����. ����������
out PORTB,CombinacionB
out PORTD,CombinacionD
out PORTA,CombinacionA
ret
  
;***** ��������� ���������� �� ������������ TIM1*****
TIM_OVF1:
ldi Rab1,$3                      ;��������� TIM1 � f=156250 
out TCCR1B,Rab1
ldi Rab1,$9e                     ;��������� ��������� �������� 15536
out TCNT1H,Rab1                  ;50000/156250 ���. �� ������������
ldi Rab1,$58
out TCNT1L,Rab1

sbis PIND,0                      ;���� ������ ������ "+"
rcall look_switcher_plus
sbis PIND,1
rcall look_switcher_minus                       
reti

look_switcher_plus:              ;������������ ��������� ��������� 
                                 ;������������� Bright/Period ��� ����� "+"
sbis PIND,3                      ;����� ������ PIND.1==0 
                                 ;����� ������� �������� PIND.1==1
rcall set_period_plus_up
sbic PIND,3
rcall set_bright_plus_up			    
ret

set_period_plus_up:              ;������������ ��������� �������
ldi Universal,10         
add Period,Universal             ;����������� ������� Period �� 10 
rcall clr_period_plus            ;���� �� ==250, �� ������ �� ���������
ret		

clr_period_plus:
cpi Period,250   
breq clr_period_plus_set
brne clr_period_plus_no_set
clr_period_plus_set:         
ldi Period,240
clr_period_plus_no_set:
ret

set_bright_plus_up:               ;������������ ��������� ������� ��������
subi Bright,20                    ;��������� Bright �� 20
                                  ;���� Bright==106 �� ������ �� ���������
rcall clr_bright_plus  
ret

clr_bright_plus:
cpi Bright,106 
breq clr_bright_plus_set
brne clr_bright_plus_no_set
clr_bright_plus_set:
ldi Bright,126
clr_bright_plus_no_set:
ret

look_switcher_minus:              ;������������ ��������� ��������� 
                                  ;������������� Bright/Period ��� ����� "-"
sbis PIND,3                       ;����� ������ PIND.1==0 
                                  ;����� ������� �������� PIND.1==1
rcall set_period_minus_up
sbic PIND,3
rcall set_bright_minus_up			    
ret

set_period_minus_up:              ;������������ ��������� �������
subi Period,10                    ;��������� ������� Period �� 10
rcall clr_period_minus            ;���� �� ==0 �� ������� ������� �� ����������
ret		

clr_period_minus:
cpi Period,0   
breq clr_period_minus_set
brne clr_period_minus_no_set
clr_period_minus_set:         
ldi Period,10
clr_period_minus_no_set:
ret

set_bright_minus_up:               ;������������ ��������� ������� ��������
ldi Universal,20                   ;����������� Bright �� 20                       
add Bright,Universal               ;���� Bright==246 �� ������ ������ �� ���������
rcall clr_bright_minus  
ret

clr_bright_minus:
cpi Bright,246 
breq clr_bright_minus_set
brne clr_bright_minus_no_set
clr_bright_minus_set:
ldi Bright,226
clr_bright_minus_no_set:
ret

;*****��������� ���������� �� INT0 - ������ ������������ ��������*****
EXT_INTO:
ldi CombinacionA,$ff               ;������������� ������ 
ldi CombinacionB,$ff
ldi CombinacionD,$ff
rcall waiter_100ms                 ;�������� ��� �������������� ��������
rcall waiter_100ms
rcall waiter_100ms
rcall waiter_100ms

ldi Universal,221                  ;������ ��������� ����� ��� ������ �� Main
                                   ;����� ��������� ����������  
out SPL,Universal

cpi NumberProgram,11               ;������� ��� ��������� ������� �� ���������
breq clr_NumberProgram             ;���� ��������� �� ������� � �������. ���. ������
brne inc_NumberProgram             ;���� ����������� �� ������� � �������. ��������
                                   ;� ���������� �������
clr_NumberProgram:
clr NumberProgram
reti
inc_NumberProgram:
inc NumberProgram
reti
      

										   
