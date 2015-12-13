;Текст программы устройства светодиодная гирлянда

.include "tn2313def.inc"
.CSEG
.def Rab1=r16           ;Рабочие регистры под инициализацию и
.def Rab2=r17           ;формирования рабочих интервалов задержки
.def Rab3=r18
.def Rab4=r19
.def Rab5=r20

.def Bright=r21         ;Регистр для формирования частоты горения 
                        ;светодиода в пределах 100-1000 герц,
                        ;изменяемой от кнопки регулирования яркости 

.def Period=r22         ;Регистр,определяющий период смены комбинаций
                        ;при выполнении программы эффектов

.def CombinacionB=r23   ;Регистр,выводящийся в порт B и 
                        ;определяющий номера зажиганмых
			;светодиодов

.def CombinacionD=r24   ;<<->> ,но для порт D
.def CombinacionA=r27   ;<<->> ,но для порт A
.def Universal=r25      ;Регистр для разных установок во время выполнения программы
.def NumberProgram=r26  ;Регистр,определяющий номер выполняемой программы                                                    
                        ;эффекта
.def Priznak_sostoainia=r1   ;Регистр, определяющий в какой фазе в момент
                             ;прерыв TIM0 находяться порты: 0 - вывод комбинации
			     ;1- вывод ff  
.org 0
rjmp RESET
rjmp EXT_INTO            
nop ;rjmp EXT_INT1
nop ;rjmp TIM_CAPT1
nop ;rjmp TIM_COMP1
rjmp TIM_OVF1
rjmp TIM_OVF0            
nop ;rjmp UART_RXC
nop ;rjmp UART_DRE
nop ;rjmp UART_TXC
nop ;rjmp ANA_COMP
nop ;rjmp PCINT
nop ;rjmp TIMER1 COMPB
nop ;rjmp TIMER0 COMPA 
nop ;rjmp TIMER0 COMPB
nop ;rjmp USI START
nop ;rjmp USI OVERFLOW 
nop ;rjmp EE READY
nop ;rjmp WDT OVERFLOW

.include "Interrupt.asm"

RESET:
ldi Rab1,low(RAMEND)   ;Вершина стека
out SPL,Rab1
ser Rab1              
out PORTB,Rab1         ;На всех портах 1
out PORTD,Rab1
out PORTA,Rab1

out DDRB,Rab1          ;Порт B на вывод
ldi Rab1,$f0           ;Конфигурирование порта D 
out DDRD,Rab1
ldi Rab1,$3            ;Конфигурирование порта A  
out DDRA,Rab1          ;выводы 4 и 5 на вывод

ldi Rab1,15            ;Сторожевой таймер на 2 секунды
out WDTCR,Rab1

ldi Rab1,$80           ;Разрешение прерываний
out SREG,Rab1
ldi Rab1,$82
out TIMSK,Rab1         ;Разрешение прерываний таймера по переполнению
ldi Rab1,$40           ;Разрешение внешних прерываний INT0  
out GIMSK,Rab1         
                       
ldi Rab1,$5            ;Запуск TIM0 c f/1024 
out TCCR0,Rab1
ldi Rab1,$ce
out TCNT0,Rab1         ;Загружаем начальное значение в TIM0 

ldi Rab1,$3            ;Запускаем TIM1 с f=156250 гц 
out TCCR1B,Rab1
ldi Rab1,$9e           ;Загружаем начальное значение 15536
out TCNT1H,Rab1        ;50000/156250 сек.- время до переполнения
ldi Rab1,$58
out TCNT1L,Rab1


ldi Period,50
ldi Bright,206
ldi NumberProgram,0 

ldi CombinacionB,$ff
ldi CombinacionA,$ff
ldi CombinacionD,$ff
sei

;***********MAIN**************************
main:
rcall control_number_program
wdr
rjmp main
;**************Functions*******************
.include "Effect_program.asm"
.include "Time_Interval.asm"

control_number_program:       ;Подпрограмма выбора эффекта
                              ;в зависимости от значения
			      ;регистра NumberProgram
cpi NumberProgram,0           ;В зависимости от выбранного номера программы эффекта
breq call_program0            ;переход к этой подпрограмме
brne to1 
call_program0:
rcall program_0
to1:
cpi NumberProgram,1      
breq call_program1
brne to2
call_program1:
rcall program_1
to2:
cpi NumberProgram,2
breq call_program2
brne to3
call_program2:
rcall program_2
to3:
cpi NumberProgram,3
breq call_program3
brne to4
call_program3:
rcall program_3
to4:
cpi NumberProgram,4
breq call_program4
brne to5
call_program4:
rcall program_4
to5:
cpi NumberProgram,5
breq call_program5
brne to6
call_program5:
rcall program_5
to6:
cpi NumberProgram,6
breq call_program6
brne to7
call_program6:
rcall program_6
to7:
cpi NumberProgram,7
breq call_program7
brne to8
call_program7:
rcall program_7
to8:
cpi NumberProgram,8
breq call_program8
brne to9
call_program8:
rcall program_8
to9:
cpi NumberProgram,9
breq call_program9
brne to10
call_program9:
rcall program_9
to10:
cpi NumberProgram,10
breq call_program10
brne to11
call_program10:
rcall program_10
to11:
cpi NumberProgram,11
breq call_program11
brne exit
call_program11:
rcall program_11
exit:
ret
.exit
	
