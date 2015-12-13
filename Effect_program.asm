;***Программы эффектов 
program_0:                  ;Программа эффекта - последовательное загорание
                            ;светодиодов.Бегущий огонь. направление от начала
							;к концу и обратно
;*****Участок порта D*****	
ldi CombinacionD,$ef
rcall create_time_period
ldi CombinacionD,$df
rcall create_time_period
ldi CombinacionD,$bf
rcall create_time_period
ldi CombinacionD,$ff         ;При переходе к следующему порту 
                             ;инициализация предыдущего
;*****Участок порта B*****							 
ldi CombinacionB,$fe
rcall create_time_period
ldi CombinacionB,$fd
rcall create_time_period
ldi CombinacionB,$fb
rcall create_time_period
ldi CombinacionB,$f7
rcall create_time_period
ldi CombinacionB,$ef
rcall create_time_period
ldi CombinacionB,$df
rcall create_time_period
ldi CombinacionB,$bf
rcall create_time_period
ldi CombinacionB,$7f
rcall create_time_period
ldi CombinacionB,$ff

;*****Участок порта A*****
ldi CombinacionA,$fe
rcall create_time_period
ldi CombinacionA,$fd
rcall create_time_period
;*****Участок порта A*****     ;обратное направление
ldi CombinacionA,$fe
rcall create_time_period
ldi CombinacionA,$ff
;*****Участок порта B*****	
ldi CombinacionB,$7f
rcall create_time_period
ldi CombinacionB,$bf
rcall create_time_period
ldi CombinacionB,$df
rcall create_time_period
ldi CombinacionB,$ef
rcall create_time_period
ldi CombinacionB,$f7
rcall create_time_period
ldi CombinacionB,$fb
rcall create_time_period
ldi CombinacionB,$fd
rcall create_time_period
ldi CombinacionB,$fe
rcall create_time_period
ldi CombinacionB,$ff
;*****Участок порта D*****	
ldi CombinacionD,$bf
rcall create_time_period
ldi CombinacionD,$df
rcall create_time_period
ldi CombinacionD,$ef
rcall create_time_period
ldi CombinacionD,$ff				  						
ret
program_1:                      ;Программа эффекта- наращивание огня от начала
                                ;к концу и обратно
;*****Участок порта D*****	
ldi CombinacionD,$ef
rcall create_time_period
ldi CombinacionD,$cf
rcall create_time_period
ldi CombinacionD,$8f
;*****Участок порта B*****
rcall create_time_period
ldi CombinacionB,$fe
rcall create_time_period
ldi CombinacionB,$fc
rcall create_time_period
ldi CombinacionB,$f8
rcall create_time_period
ldi CombinacionB,$f0
rcall create_time_period
ldi CombinacionB,$e0
rcall create_time_period
ldi CombinacionB,$c0
rcall create_time_period
ldi CombinacionB,$80
rcall create_time_period
ldi CombinacionB,$0
rcall create_time_period
;*****Участок порта A*****
ldi CombinacionA,$fe
rcall create_time_period
ldi CombinacionA,$fc
rcall create_time_period
                                 ;*****В обратную сторону*****
ldi CombinacionA,$fe
rcall create_time_period
ldi CombinacionA,$ff
;*****Участок порта B*****
rcall create_time_period
ldi CombinacionB,$80
rcall create_time_period
ldi CombinacionB,$c0
rcall create_time_period
ldi CombinacionB,$e0
rcall create_time_period
ldi CombinacionB,$f0
rcall create_time_period
ldi CombinacionB,$f8
rcall create_time_period
ldi CombinacionB,$fc
rcall create_time_period
ldi CombinacionB,$fe
rcall create_time_period
ldi CombinacionB,$ff
;*****Участок порта D*****	
ldi CombinacionD,$8f
rcall create_time_period
ldi CombinacionD,$cf
rcall create_time_period
ldi CombinacionD,$ef	
ret
program_2:                         ;***Эффект -сдвоение и раздвоение
ldi CombinacionD,$ef
ldi CombinacionA,$fd
rcall create_time_period
ldi CombinacionA,$fe
ldi CombinacionD,$df
rcall create_time_period
ldi CombinacionA,$ff
ldi CombinacionB,$7f
ldi CombinacionD,$bf
rcall create_time_period
ldi CombinacionD,$ff
ldi CombinacionB,$be
rcall create_time_period
ldi CombinacionB,$dd
rcall create_time_period
ldi CombinacionB,$eb
rcall create_time_period
ldi CombinacionB,$f7
rcall create_time_period
ldi CombinacionB,$eb
rcall create_time_period
ldi CombinacionB,$dd
rcall create_time_period
ldi CombinacionB,$be
rcall create_time_period
ldi CombinacionB,$7f
ldi CombinacionD,$bf
rcall create_time_period
ldi CombinacionB,$ff
ldi CombinacionA,$fe
ldi CombinacionD,$df
rcall create_time_period
ldi CombinacionD,$ef
ldi CombinacionA,$fd
rcall create_time_period
ldi CombinacionB,$ff
ldi CombinacionA,$ff
ldi CombinacionD,$ff
ret
program_3:                        ;Эффект - бегущая тень
ldi CombinacionA,$fc
ldi CombinacionB,$0
ldi CombinacionD,$9f
rcall create_time_period
ldi CombinacionD,$af
rcall create_time_period
ldi CombinacionD,$cf
rcall create_time_period
ldi CombinacionD,$8f
ldi CombinacionB,$1
rcall create_time_period
ldi CombinacionB,$2
rcall create_time_period
ldi CombinacionB,$4
rcall create_time_period
ldi CombinacionB,$8
rcall create_time_period
ldi CombinacionB,$10
rcall create_time_period
ldi CombinacionB,$20
rcall create_time_period
ldi CombinacionB,$40
rcall create_time_period
ldi CombinacionB,$80
rcall create_time_period
ldi CombinacionB,$0
ldi CombinacionA,$fd
rcall create_time_period
ldi CombinacionA,$fe
rcall create_time_period
ldi CombinacionA,$fd
rcall create_time_period
ldi CombinacionA,$fc
ldi CombinacionB,$80
rcall create_time_period
ldi CombinacionB,$40
rcall create_time_period
ldi CombinacionB,$20
rcall create_time_period
ldi CombinacionB,$10
rcall create_time_period
ldi CombinacionB,$8
rcall create_time_period
ldi CombinacionB,$4
rcall create_time_period
ldi CombinacionB,$2
rcall create_time_period
ldi CombinacionB,$1
rcall create_time_period
ldi CombinacionB,$0
ldi CombinacionD,$cf
rcall create_time_period
ldi CombinacionD,$af
rcall create_time_period
ldi CombinacionD,$9f
rcall create_time_period
ret 
program_4:                           ;Нарастающий столб со спадами
ldi CombinacionD,$ef
ldi CombinacionB,$ff
ldi CombinacionA,$ff
rcall create_time_period
ldi CombinacionD,$cf
rcall create_time_period
ldi CombinacionD,$ef
rcall create_time_period
ldi CombinacionD,$8f
rcall create_time_period
ldi CombinacionD,$ef
rcall create_time_period
ldi CombinacionD,$8f
ldi CombinacionB,$fe
rcall create_time_period
ldi CombinacionD,$ef
ldi CombinacionB,$ff
rcall create_time_period
ldi CombinacionD,$8f
ldi CombinacionB,$fc
rcall create_time_period
ldi CombinacionD,$ef
ldi CombinacionB,$ff
rcall create_time_period
ldi CombinacionD,$8f
ldi CombinacionB,$f8
rcall create_time_period
ldi CombinacionD,$ef
ldi CombinacionB,$ff
rcall create_time_period
ldi CombinacionD,$8f
ldi CombinacionB,$f0
rcall create_time_period
ldi CombinacionD,$ef
ldi CombinacionB,$ff
rcall create_time_period
ldi CombinacionD,$8f
ldi CombinacionB,$e0
rcall create_time_period
ldi CombinacionD,$ef
ldi CombinacionB,$ff
rcall create_time_period
ldi CombinacionD,$8f
ldi CombinacionB,$c0
rcall create_time_period
ldi CombinacionD,$ef
ldi CombinacionB,$ff
rcall create_time_period
ldi CombinacionD,$8f
ldi CombinacionB,$80
rcall create_time_period
ldi CombinacionD,$ef
ldi CombinacionB,$ff
rcall create_time_period
ldi CombinacionD,$8f
ldi CombinacionB,$0
rcall create_time_period
ldi CombinacionD,$ef
ldi CombinacionB,$ff
rcall create_time_period
ldi CombinacionD,$8f
ldi CombinacionB,$0
ldi CombinacionA,$fe
rcall create_time_period
ldi CombinacionD,$ef
ldi CombinacionB,$ff
ldi CombinacionA,$ff
rcall create_time_period
ldi CombinacionD,$8f
ldi CombinacionB,$0
ldi CombinacionA,$fc
rcall create_time_period
ret
program_5:                            ;Сжимание к центру и нарастание  
                                      ;к краям
ldi CombinacionA,$fc
ldi CombinacionB,$0
ldi CombinacionD,$8f
rcall create_time_period
ldi CombinacionA,$fe
ldi CombinacionD,$9f
rcall create_time_period
ldi CombinacionA,$ff
ldi CombinacionD,$bf
rcall create_time_period
ldi CombinacionD,$ff
ldi CombinacionB,$80
rcall create_time_period
ldi CombinacionB,$c1
rcall create_time_period
ldi CombinacionB,$e3
rcall create_time_period
ldi CombinacionB,$f7
rcall create_time_period
ldi CombinacionB,$e3
rcall create_time_period
ldi CombinacionB,$c1
rcall create_time_period
ldi CombinacionB,$80
rcall create_time_period
ldi CombinacionB,$0
ldi CombinacionD,$bf
rcall create_time_period
ldi CombinacionD,$9f
ldi CombinacionA,$fe
rcall create_time_period
ldi CombinacionD,$8f
ldi CombinacionA,$fc
ret
program_6:                         ;Программа эффекта, реализующего
                                   ;проход 3 светодиодов через все и 
				   ;накопление их в конце
;участок порта D
ldi CombinacionD,$ef
ldi CombinacionA,$fc
ldi CombinacionB,$7f
rcall create_time_period
ldi CombinacionA,$fe
ldi CombinacionB,$3f
rcall create_time_period
ldi CombinacionA,$ff
ldi CombinacionB,$1f
rcall create_time_period
ldi CombinacionB,$8f
rcall create_time_period
ldi CombinacionB,$c7
rcall create_time_period
ldi CombinacionB,$e3
rcall create_time_period
ldi CombinacionB,$f1
rcall create_time_period
ldi CombinacionB,$f8
rcall create_time_period
ldi CombinacionB,$fc
ldi CombinacionD,$af
rcall create_time_period
ldi CombinacionB,$fe
ldi CombinacionD,$8f                  ;первый круг
rcall create_time_period
ldi CombinacionA,$fc
ldi CombinacionB,$7e
rcall create_time_period
ldi CombinacionA,$fe
ldi CombinacionB,$3e
rcall create_time_period
ldi CombinacionA,$ff
ldi CombinacionB,$1e
rcall create_time_period
ldi CombinacionB,$8e
rcall create_time_period
ldi CombinacionB,$c6
rcall create_time_period
ldi CombinacionB,$e2
rcall create_time_period
ldi CombinacionB,$f0
rcall create_time_period               ;второй круг
ldi CombinacionA,$fc
ldi CombinacionB,$70
rcall create_time_period
ldi CombinacionA,$fe
ldi CombinacionB,$30
rcall create_time_period
ldi CombinacionA,$ff
ldi CombinacionB,$10
rcall create_time_period
ldi CombinacionB,$80
rcall create_time_period	        ;третий круг
ldi CombinacionB,$0
ldi CombinacionA,$fc
rcall create_time_period			    
ret

program_7:                              ;Программа эффекта- параллельное
                                        ;следование 2 огней...через 6 
				        ;позиций(для кругового располож)   
ldi CombinacionB,$f7
ldi CombinacionD,$ef
rcall create_time_period
ldi CombinacionB,$ef
ldi CombinacionD,$df
rcall create_time_period
ldi CombinacionD,$bf
ldi CombinacionB,$df
rcall create_time_period
ldi CombinacionD,$ff
ldi CombinacionB,$be
rcall create_time_period
ldi CombinacionB,$7d
rcall create_time_period
ldi CombinacionB,$fb
ldi CombinacionA,$fe
rcall create_time_period
ldi CombinacionB,$f7
ldi CombinacionA,$fd
rcall create_time_period
ldi CombinacionA,$ff
ret

program_8:                              ;Программа эффекта-расшатывающийся
                                        ;огонь 
ldi CombinacionB,$f7
rcall create_time_period
ldi CombinacionB,$fb
rcall create_time_period
ldi CombinacionB,$ef
rcall create_time_period
ldi CombinacionB,$fd
rcall create_time_period
ldi CombinacionB,$df
rcall create_time_period
ldi CombinacionB,$fe
rcall create_time_period
ldi CombinacionB,$bf
rcall create_time_period
ldi CombinacionD,$bf
ldi CombinacionB,$ff
rcall create_time_period
ldi CombinacionD,$ff
ldi CombinacionB,$7f
rcall create_time_period
ldi CombinacionB,$ff
ldi CombinacionD,$df
rcall create_time_period
ldi CombinacionA,$fe
ldi CombinacionD,$ff
rcall create_time_period
ldi CombinacionD,$ef
ldi CombinacionA,$ff
rcall create_time_period
ldi CombinacionD,$ff
ldi CombinacionA,$fd
rcall create_time_period
ldi CombinacionA,$ff
ret

program_9:                             ;Программа эффекта-
                                       ;чередование четные и нечетные(горит-не горит) 
				       ;и меняем
ldi CombinacionD,$af
ldi CombinacionB,$55
ldi CombinacionA,$fd
rcall create_time_period
ldi CombinacionD,$df
ldi CombinacionB,$aa
ldi CombinacionA,$fe
rcall create_time_period
ret

program_10:                            ;Программа эффекта - 5 огней
                                       ;перемещаются 
ldi CombinacionD,$8f
ldi CombinacionB,$fc
rcall create_time_period
ldi CombinacionB,$f8
ldi CombinacionD,$9f
rcall create_time_period
ldi CombinacionD,$bf
ldi CombinacionB,$f0
rcall create_time_period
ldi CombinacionD,$ff
ldi CombinacionB,$e0
rcall create_time_period
ldi CombinacionB,$c1
rcall create_time_period
ldi CombinacionB,$83
rcall create_time_period
ldi CombinacionB,$7
rcall create_time_period
ldi CombinacionB,$f
ldi CombinacionA,$fe
rcall create_time_period
ldi CombinacionA,$fc
ldi CombinacionB,$1f
rcall create_time_period
ldi CombinacionB,$3f
ldi CombinacionD,$6f
rcall create_time_period
ldi CombinacionB,$7f
ldi CombinacionD,$cf
rcall create_time_period
ldi CombinacionB,$ff
ldi CombinacionD,$8f
rcall create_time_period
ldi CombinacionA,$fd
ldi CombinacionB,$fe
rcall create_time_period
ldi CombinacionA,$ff
ret

program_11:                               ;Поочередное повторение
                                          ;всех программ (11)
rcall program_0
rcall program_1
rcall program_2
rcall program_3
rcall program_4
rcall program_5
rcall program_6
ldi CombinacionA,$ff
rcall program_7
rcall program_8
rcall program_9
ldi CombinacionA,$ff
rcall program_10
ldi CombinacionB,$ff
ldi CombinacionD,$ff
ret



