;***** Обработка прерываний от переполнения TIM0******
TIM_OVF0:
out TCNT0,Bright                  ;Установка начального значения счетчика
                                  ;зависящего от Bright

rcall set_value
reti
  
set_value:
mov Universal,Priznak_sostoainia  ;Смотрим признак состояния
cpi Universal,1                   ;Если 1 то устанавливаем комбинацию   
breq set_combination  
brne set_ff           
set_ff:
ldi Universal,$ff                 ;Если стоит комбинация то устанавливем ff
out PORTB,Universal
out PORTD,Universal
out PORTA,Universal
inc Priznak_sostoainia            ;Устан. 1 призн. состояния при устан. ff
ret
set_combination:
dec Priznak_sostoainia            ;Устан. 0 призн. состояния при устан. комбинации
out PORTB,CombinacionB
out PORTD,CombinacionD
out PORTA,CombinacionA
ret
  
;***** Обработка прерываний от переполнения TIM1*****
TIM_OVF1:
ldi Rab1,$3                      ;Запускаем TIM1 с f=156250 
out TCCR1B,Rab1
ldi Rab1,$9e                     ;Загружаем начальное значение 15536
out TCNT1H,Rab1                  ;50000/156250 сек. до переполнения
ldi Rab1,$58
out TCNT1L,Rab1

sbis PIND,0                      ;Если нажата кнопка "+"
rcall look_switcher_plus
sbis PIND,1
rcall look_switcher_minus                       
reti

look_switcher_plus:              ;Подпрограмма обработки положения 
                                 ;переключателя Bright/Period при нажат "+"
sbis PIND,3                      ;Режим период PIND.1==0 
                                 ;Режим частота мерцания PIND.1==1
rcall set_period_plus_up
sbic PIND,3
rcall set_bright_plus_up			    
ret

set_period_plus_up:              ;Подпрограмма установки периода
ldi Universal,10         
add Period,Universal             ;Увеличиваем регистр Period на 10 
rcall clr_period_plus            ;Если он ==250, то запрет на инкремент
ret		

clr_period_plus:
cpi Period,250   
breq clr_period_plus_set
brne clr_period_plus_no_set
clr_period_plus_set:         
ldi Period,240
clr_period_plus_no_set:
ret

set_bright_plus_up:               ;Подпрограмма установки частоты мерцания
subi Bright,20                    ;Уменьшаем Bright на 20
                                  ;Если Bright==106 то запрет на декремент
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

look_switcher_minus:              ;Подпрограмма обработки положения 
                                  ;переключателя Bright/Period при нажат "-"
sbis PIND,3                       ;Режим период PIND.1==0 
                                  ;Режим частота мерцания PIND.1==1
rcall set_period_minus_up
sbic PIND,3
rcall set_bright_minus_up			    
ret

set_period_minus_up:              ;Подпрограмма установки периода
subi Period,10                    ;Уменьшаем регистр Period на 10
rcall clr_period_minus            ;Если он ==0 то установ запрета на уменьшение
ret		

clr_period_minus:
cpi Period,0   
breq clr_period_minus_set
brne clr_period_minus_no_set
clr_period_minus_set:         
ldi Period,10
clr_period_minus_no_set:
ret

set_bright_minus_up:               ;Подпрограмма установки частоты мерцания
ldi Universal,20                   ;Увеличиваем Bright на 20                       
add Bright,Universal               ;Если Bright==246 то ставим запрет на инкремент
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

;*****Обработка прерываний от INT0 - кнопка переключения программ*****
EXT_INTO:
ldi CombinacionA,$ff               ;Инициализация портов 
ldi CombinacionB,$ff
ldi CombinacionD,$ff
rcall waiter_100ms                 ;Задержка для предотвращения дребезга
rcall waiter_100ms
rcall waiter_100ms
rcall waiter_100ms

ldi Universal,221                  ;меняем указатель стэка для выхода на Main
                                   ;после обработки прерывания  
out SPL,Universal

cpi NumberProgram,11               ;Смотрим что программа эффекта не последняя
breq clr_NumberProgram             ;Если последняя то переход к подпрог. уст. первой
brne inc_NumberProgram             ;Если непоследняя то переход к подпрог. перехода
                                   ;к следующему эффекту
clr_NumberProgram:
clr NumberProgram
reti
inc_NumberProgram:
inc NumberProgram
reti
      

										   
