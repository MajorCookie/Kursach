
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega8
;Program type           : Application
;Clock frequency        : 4,000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega8
	#pragma AVRPART MEMORY PROG_FLASH 8192
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	RCALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	RCALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	RCALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	RJMP __RESET
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;/*******************************************************
;This program was created by the
;CodeWizardAVR V3.10 Advanced
;Automatic Program Generator
;© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 16.12.2015
;Author  :
;Company :
;Comments:
;
;
;Chip type               : ATmega8
;Program type            : Application
;AVR Core Clock frequency: 4,000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 256
;*******************************************************/
;
;#include <mega8.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;
;void main(void)
; 0000 001C {

	.CSEG
_main:
; .FSTART _main
; 0000 001D 	/*
; 0000 001E 		0: default mode, all diods blink
; 0000 001F 		1: switch 1 by 1 to right
; 0000 0020 		2: switch 1 by 1 to left
; 0000 0021 		3: snake move
; 0000 0022 	*/
; 0000 0023 	int MODE = 0;
; 0000 0024 
; 0000 0025 	PORTD=0b00000001;
;	MODE -> R16,R17
	__GETWRN 16,17,0
	LDI  R30,LOW(1)
	OUT  0x12,R30
; 0000 0026 	DDRD=0b00000000;
	LDI  R30,LOW(0)
	OUT  0x11,R30
; 0000 0027 
; 0000 0028 	PORTC=0x00;
	OUT  0x15,R30
; 0000 0029 	DDRC=0x00;
	OUT  0x14,R30
; 0000 002A 
; 0000 002B 	PORTB=0b00000000;
	OUT  0x18,R30
; 0000 002C 	DDRB=0b00111111;
	LDI  R30,LOW(63)
	OUT  0x17,R30
; 0000 002D 
; 0000 002E 
; 0000 002F 	while (1){
_0x3:
; 0000 0030 
; 0000 0031 		PORTB.6 = 0;
	CBI  0x18,6
; 0000 0032 		// checking button state, changing mode if needed
; 0000 0033 		// 1 is off, 0 is on
; 0000 0034 		if (PINC.0 == 0){
	SBIC 0x13,0
	RJMP _0x8
; 0000 0035 			MODE++; //increasing mode variable
	__ADDWRN 16,17,1
; 0000 0036 			if (MODE>=6){
	__CPWRN 16,17,6
	BRLT _0x9
; 0000 0037 				MODE = 0; //resetting mode if we're out of em
	__GETWRN 16,17,0
; 0000 0038 			}
; 0000 0039 			PORTB.0 = 1;
_0x9:
	RCALL SUBOPT_0x0
; 0000 003A 			PORTB.1 = 1;
; 0000 003B 			PORTB.2 = 1;
; 0000 003C 			PORTB.3 = 1;
; 0000 003D 			PORTB.4 = 1;
; 0000 003E 			PORTB.5 = 1;
; 0000 003F 			delay_ms(1500);
	LDI  R26,LOW(1500)
	LDI  R27,HIGH(1500)
	RCALL _delay_ms
; 0000 0040 		}
; 0000 0041 
; 0000 0042 		// party time !!!
; 0000 0043 
; 0000 0044 		// resetting state
; 0000 0045 		PORTB.0 = 0;
_0x8:
	RCALL SUBOPT_0x1
; 0000 0046 		PORTB.1 = 0;
; 0000 0047 		PORTB.2 = 0;
; 0000 0048 		PORTB.3 = 0;
; 0000 0049 		PORTB.4 = 0;
; 0000 004A 		PORTB.5 = 0;
; 0000 004B 
; 0000 004C 		switch(MODE){
	MOVW R30,R16
; 0000 004D 			case 0:
	SBIW R30,0
	BRNE _0x25
; 0000 004E 				{
; 0000 004F 					PORTB.0 = 1;
	RCALL SUBOPT_0x0
; 0000 0050 					PORTB.1 = 1;
; 0000 0051 					PORTB.2 = 1;
; 0000 0052 					PORTB.3 = 1;
; 0000 0053 					PORTB.4 = 1;
; 0000 0054 					PORTB.5 = 1;
; 0000 0055 					delay_ms(500);
	RCALL SUBOPT_0x2
; 0000 0056 					PORTB.0 = 0;
	RCALL SUBOPT_0x1
; 0000 0057 					PORTB.1 = 0;
; 0000 0058 					PORTB.2 = 0;
; 0000 0059 					PORTB.3 = 0;
; 0000 005A 					PORTB.4 = 0;
; 0000 005B 					PORTB.5 = 0;
; 0000 005C 					delay_ms(500);
	RCALL SUBOPT_0x2
; 0000 005D 					break;
	RJMP _0x24
; 0000 005E 				}
; 0000 005F 			case 1:
_0x25:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x3E
; 0000 0060 				{
; 0000 0061 					// turning on 1st indicator
; 0000 0062 					PORTB.0 = 1;
	RCALL SUBOPT_0x3
; 0000 0063 					delay_ms(100);
; 0000 0064 
; 0000 0065 					// turning off 1st indicator, turning on 2nd indicator
; 0000 0066 					PORTB.0 = 0;
	CBI  0x18,0
; 0000 0067 					PORTB.1 = 1;
	RCALL SUBOPT_0x4
; 0000 0068 					delay_ms(100);
; 0000 0069 
; 0000 006A 					// turning off 2nd indicator, turning on 3rd indicator
; 0000 006B 					PORTB.1 = 0;
; 0000 006C 					PORTB.2 = 1;
	RCALL SUBOPT_0x5
; 0000 006D 					delay_ms(100);
; 0000 006E 
; 0000 006F 					// same ...
; 0000 0070 					PORTB.2 = 0;
; 0000 0071 					PORTB.3 = 1;
	RCALL SUBOPT_0x6
; 0000 0072 					delay_ms(100);
; 0000 0073 
; 0000 0074 					PORTB.3 = 0;
; 0000 0075 					PORTB.4 = 1;
	RCALL SUBOPT_0x7
; 0000 0076 					delay_ms(100);
; 0000 0077 
; 0000 0078 					PORTB.4 = 0;
; 0000 0079 					PORTB.5 = 1;
	RCALL SUBOPT_0x8
; 0000 007A 					delay_ms(100);
; 0000 007B 
; 0000 007C 					// turning off last indicator
; 0000 007D 					delay_ms(100);
	RCALL SUBOPT_0x9
; 0000 007E                     PORTB.5 = 1;
	SBI  0x18,5
; 0000 007F                     PORTB.4 = 0;
	CBI  0x18,4
; 0000 0080                     delay_ms(100);
	RCALL SUBOPT_0x9
; 0000 0081                     PORTB.4 = 1;
	SBI  0x18,4
; 0000 0082                     PORTB.3 = 0;
	CBI  0x18,3
; 0000 0083                     delay_ms(100);
	RCALL SUBOPT_0x9
; 0000 0084                     PORTB.3 = 1;
	SBI  0x18,3
; 0000 0085                     PORTB.2 = 0;
	CBI  0x18,2
; 0000 0086                     delay_ms(100);
	RCALL SUBOPT_0x9
; 0000 0087                     PORTB.2 = 1;
	SBI  0x18,2
; 0000 0088                     PORTB.1 = 0;
	CBI  0x18,1
; 0000 0089                     delay_ms(100);
	RCALL SUBOPT_0x9
; 0000 008A                     PORTB.1 = 1;
	SBI  0x18,1
; 0000 008B                     PORTB.0 = 0;
	CBI  0x18,0
; 0000 008C                     delay_ms(100);
	RCALL SUBOPT_0x9
; 0000 008D                     PORTB.0 = 1;
	RCALL SUBOPT_0x3
; 0000 008E                     delay_ms(100);
; 0000 008F 
; 0000 0090 					break;
	RJMP _0x24
; 0000 0091 				}
; 0000 0092 			case 2:
_0x3E:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x6B
; 0000 0093 				{
; 0000 0094 					// turning on last indicator
; 0000 0095 					PORTB.5 = 1;
	RCALL SUBOPT_0x8
; 0000 0096 					delay_ms(100);
; 0000 0097 
; 0000 0098 					PORTB.5 = 0;
	CBI  0x18,5
; 0000 0099 					PORTB.4 = 1;
	RCALL SUBOPT_0x7
; 0000 009A 					delay_ms(100);
; 0000 009B 
; 0000 009C 					PORTB.4 = 0;
; 0000 009D 					PORTB.3 = 1;
	RCALL SUBOPT_0x6
; 0000 009E 					delay_ms(100);
; 0000 009F 
; 0000 00A0 					PORTB.3 = 0;
; 0000 00A1 					PORTB.2 = 1;
	RCALL SUBOPT_0x5
; 0000 00A2 					delay_ms(100);
; 0000 00A3 
; 0000 00A4 					PORTB.2 = 0;
; 0000 00A5 					PORTB.1 = 1;
	RCALL SUBOPT_0x4
; 0000 00A6 					delay_ms(100);
; 0000 00A7 
; 0000 00A8 					PORTB.1 = 0;
; 0000 00A9 					PORTB.0 = 1;
	RCALL SUBOPT_0x3
; 0000 00AA 					delay_ms(100);
; 0000 00AB 
; 0000 00AC 					// turning off first indicator
; 0000 00AD 					PORTB.0 = 0;
	CBI  0x18,0
; 0000 00AE 					delay_ms(100);
	RCALL SUBOPT_0x9
; 0000 00AF 
; 0000 00B0 					break;
	RJMP _0x24
; 0000 00B1 				}
; 0000 00B2 			case 3:
_0x6B:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x84
; 0000 00B3 				{
; 0000 00B4 					PORTB.0 = 1;
	RCALL SUBOPT_0x3
; 0000 00B5 					delay_ms(100);
; 0000 00B6 					PORTB.1 = 1;
	SBI  0x18,1
; 0000 00B7 					delay_ms(100);
	RCALL SUBOPT_0x9
; 0000 00B8 					PORTB.2 = 1;
	SBI  0x18,2
; 0000 00B9 					delay_ms(100);
	RCALL SUBOPT_0x9
; 0000 00BA 
; 0000 00BB 					PORTB.0 = 0;
	CBI  0x18,0
; 0000 00BC 					PORTB.3 = 1;
	SBI  0x18,3
; 0000 00BD 					delay_ms(100);
	RCALL SUBOPT_0x9
; 0000 00BE 					PORTB.1 = 0;
	CBI  0x18,1
; 0000 00BF 					PORTB.4 = 1;
	SBI  0x18,4
; 0000 00C0 					delay_ms(100);
	RCALL SUBOPT_0x9
; 0000 00C1 
; 0000 00C2 					PORTB.2 = 0;
	CBI  0x18,2
; 0000 00C3 					PORTB.5 = 1;
	RCALL SUBOPT_0x8
; 0000 00C4 					delay_ms(100);
; 0000 00C5 
; 0000 00C6 					PORTB.3 = 0;
	CBI  0x18,3
; 0000 00C7 					delay_ms(100);
	RCALL SUBOPT_0x9
; 0000 00C8 
; 0000 00C9 					PORTB.4 = 0;
	CBI  0x18,4
; 0000 00CA 					delay_ms(100);
	RCALL SUBOPT_0x9
; 0000 00CB 
; 0000 00CC 					PORTB.5 = 0;
	RCALL SUBOPT_0xA
; 0000 00CD 					delay_ms(100);
; 0000 00CE 
; 0000 00CF 					break;
	RJMP _0x24
; 0000 00D0 				}
; 0000 00D1             case 4:
_0x84:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x9D
; 0000 00D2                 {
; 0000 00D3                   PORTB.0 = 1;
	RCALL SUBOPT_0xB
; 0000 00D4 				  PORTB.1 = 0;
; 0000 00D5 				  PORTB.2 = 1;
; 0000 00D6 				  PORTB.3 = 0;
; 0000 00D7 				  PORTB.4 = 1;
; 0000 00D8 				  PORTB.5 = 0;
; 0000 00D9 				  delay_ms(100);
; 0000 00DA 				  PORTB.0 = 0;
	RCALL SUBOPT_0xC
; 0000 00DB 			  	  PORTB.1 = 1;
; 0000 00DC 				  PORTB.2 = 0;
; 0000 00DD 				  PORTB.3 = 1;
; 0000 00DE 				  PORTB.4 = 0;
; 0000 00DF 				  PORTB.5 = 1;
; 0000 00E0 				  delay_ms(100);
; 0000 00E1 				  break;
	RJMP _0x24
; 0000 00E2                 }
; 0000 00E3             case 5:
_0x9D:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x1A3
; 0000 00E4                 {
; 0000 00E5                   PORTB.0 = 1;
	SBI  0x18,0
; 0000 00E6                   PORTB.1 = 1;
	SBI  0x18,1
; 0000 00E7 				  delay_ms(100);
	RCALL SUBOPT_0x9
; 0000 00E8                   PORTB.0 = 0;
	CBI  0x18,0
; 0000 00E9 				  PORTB.1 = 0;
	CBI  0x18,1
; 0000 00EA 				  PORTB.2 = 1;
	RCALL SUBOPT_0x5
; 0000 00EB                   delay_ms(100);
; 0000 00EC 				  PORTB.2 = 0;
; 0000 00ED 				  PORTB.3 = 1;
	RCALL SUBOPT_0x6
; 0000 00EE 				  delay_ms(100);
; 0000 00EF 				  PORTB.3 = 0;
; 0000 00F0 			  	  PORTB.4 = 1;
	RCALL SUBOPT_0x7
; 0000 00F1                   delay_ms(100);
; 0000 00F2 				  PORTB.4 = 0;
; 0000 00F3 				  PORTB.5 = 1;
	RCALL SUBOPT_0x8
; 0000 00F4                   delay_ms(100);
; 0000 00F5 				  PORTB.5 = 0;
	RCALL SUBOPT_0xA
; 0000 00F6 				  delay_ms(100);
; 0000 00F7                   PORTB.4 = 1;
	RCALL SUBOPT_0x7
; 0000 00F8                   delay_ms(100);
; 0000 00F9                   PORTB.4 = 0;
; 0000 00FA                   PORTB.3 = 1;
	RCALL SUBOPT_0x6
; 0000 00FB                   delay_ms(100);
; 0000 00FC                   PORTB.3 = 0;
; 0000 00FD                   PORTB.2 = 1;
	RCALL SUBOPT_0x5
; 0000 00FE                   delay_ms(100);
; 0000 00FF                   PORTB.2 = 0;
; 0000 0100                   PORTB.1 = 1;
	RCALL SUBOPT_0x4
; 0000 0101                   delay_ms(100);
; 0000 0102                   PORTB.1 = 0;
; 0000 0103                   PORTB.0 = 1;
	RCALL SUBOPT_0x3
; 0000 0104                   delay_ms(100);
; 0000 0105 
; 0000 0106                   PORTB.0 = 1;
	SBI  0x18,0
; 0000 0107                   PORTB.1 = 1;
	SBI  0x18,1
; 0000 0108 				  delay_ms(100);
	RCALL SUBOPT_0x9
; 0000 0109                   PORTB.0 = 0;
	CBI  0x18,0
; 0000 010A 				  PORTB.1 = 0;
	CBI  0x18,1
; 0000 010B 				  PORTB.2 = 1;
	RCALL SUBOPT_0x5
; 0000 010C                   delay_ms(100);
; 0000 010D 				  PORTB.2 = 0;
; 0000 010E 				  PORTB.3 = 1;
	RCALL SUBOPT_0x6
; 0000 010F 				  delay_ms(100);
; 0000 0110 				  PORTB.3 = 0;
; 0000 0111 			  	  PORTB.4 = 1;
	RCALL SUBOPT_0x7
; 0000 0112                   delay_ms(100);
; 0000 0113 				  PORTB.4 = 0;
; 0000 0114 				  PORTB.5 = 1;
	RCALL SUBOPT_0x8
; 0000 0115                   delay_ms(100);
; 0000 0116 				  PORTB.5 = 0;
	RCALL SUBOPT_0xA
; 0000 0117 				  delay_ms(100);
; 0000 0118                   PORTB.4 = 1;
	RCALL SUBOPT_0x7
; 0000 0119                   delay_ms(100);
; 0000 011A                   PORTB.4 = 0;
; 0000 011B                   PORTB.3 = 1;
	RCALL SUBOPT_0x6
; 0000 011C                   delay_ms(100);
; 0000 011D                   PORTB.3 = 0;
; 0000 011E                   PORTB.2 = 1;
	RCALL SUBOPT_0x5
; 0000 011F                   delay_ms(100);
; 0000 0120                   PORTB.2 = 0;
; 0000 0121                   PORTB.1 = 1;
	RCALL SUBOPT_0x4
; 0000 0122                   delay_ms(100);
; 0000 0123                   PORTB.1 = 0;
; 0000 0124                   PORTB.0 = 1;
	RCALL SUBOPT_0x3
; 0000 0125                   delay_ms(100);
; 0000 0126 
; 0000 0127                   PORTB.0 = 1;
	RCALL SUBOPT_0xD
; 0000 0128                   PORTB.1 = 1;
; 0000 0129 				  delay_ms(300);
; 0000 012A                   PORTB.0 = 0;
; 0000 012B 				  PORTB.1 = 0;
; 0000 012C                   PORTB.2 = 1;
; 0000 012D                   PORTB.3 = 1;
; 0000 012E                   delay_ms(300);
; 0000 012F 				  PORTB.2 = 0;
; 0000 0130 				  PORTB.3 = 0;
; 0000 0131                   PORTB.4 = 1;
; 0000 0132                   PORTB.5 = 1;
; 0000 0133 				  delay_ms(300);
; 0000 0134 				  PORTB.4 = 0;
; 0000 0135 			  	  PORTB.5 = 0;
; 0000 0136                   PORTB.3 = 1;
; 0000 0137                   PORTB.2 = 1;
; 0000 0138                   delay_ms(300);
; 0000 0139 				  PORTB.3 = 0;
; 0000 013A 				  PORTB.2 = 0;
; 0000 013B                   PORTB.1 = 1;
; 0000 013C                   PORTB.0 = 1;
; 0000 013D                   delay_ms(300);
; 0000 013E                   PORTB.1 = 0;
; 0000 013F 				  PORTB.0 = 0;
; 0000 0140 				  delay_ms(300);
	LDI  R26,LOW(300)
	LDI  R27,HIGH(300)
	RCALL _delay_ms
; 0000 0141 
; 0000 0142                   PORTB.0 = 1;
	RCALL SUBOPT_0xD
; 0000 0143                   PORTB.1 = 1;
; 0000 0144 				  delay_ms(300);
; 0000 0145                   PORTB.0 = 0;
; 0000 0146 				  PORTB.1 = 0;
; 0000 0147                   PORTB.2 = 1;
; 0000 0148                   PORTB.3 = 1;
; 0000 0149                   delay_ms(300);
; 0000 014A 				  PORTB.2 = 0;
; 0000 014B 				  PORTB.3 = 0;
; 0000 014C                   PORTB.4 = 1;
; 0000 014D                   PORTB.5 = 1;
; 0000 014E 				  delay_ms(300);
; 0000 014F 				  PORTB.4 = 0;
; 0000 0150 			  	  PORTB.5 = 0;
; 0000 0151                   PORTB.3 = 1;
; 0000 0152                   PORTB.2 = 1;
; 0000 0153                   delay_ms(300);
; 0000 0154 				  PORTB.3 = 0;
; 0000 0155 				  PORTB.2 = 0;
; 0000 0156                   PORTB.1 = 1;
; 0000 0157                   PORTB.0 = 1;
; 0000 0158                   delay_ms(300);
; 0000 0159                   PORTB.1 = 0;
; 0000 015A 				  PORTB.0 = 0;
; 0000 015B 				  delay_ms(300);
	LDI  R26,LOW(300)
	LDI  R27,HIGH(300)
	RCALL _delay_ms
; 0000 015C 
; 0000 015D                   PORTB.0 = 1;
	RCALL SUBOPT_0xB
; 0000 015E 				  PORTB.1 = 0;
; 0000 015F 				  PORTB.2 = 1;
; 0000 0160 				  PORTB.3 = 0;
; 0000 0161 				  PORTB.4 = 1;
; 0000 0162 				  PORTB.5 = 0;
; 0000 0163 				  delay_ms(100);
; 0000 0164 				  PORTB.0 = 0;
	RCALL SUBOPT_0xC
; 0000 0165 			  	  PORTB.1 = 1;
; 0000 0166 				  PORTB.2 = 0;
; 0000 0167 				  PORTB.3 = 1;
; 0000 0168 				  PORTB.4 = 0;
; 0000 0169 				  PORTB.5 = 1;
; 0000 016A 				  delay_ms(100);
; 0000 016B 				  break;
	RJMP _0x24
; 0000 016C 
; 0000 016D                   PORTB.0 = 1;
; 0000 016E 				  PORTB.1 = 0;
; 0000 016F 				  PORTB.2 = 1;
; 0000 0170 				  PORTB.3 = 0;
; 0000 0171 				  PORTB.4 = 1;
; 0000 0172 				  PORTB.5 = 0;
; 0000 0173                   PORTB.0 = 0;
; 0000 0174 			  	  PORTB.1 = 1;
; 0000 0175 				  PORTB.2 = 0;
; 0000 0176 				  PORTB.3 = 1;
; 0000 0177 				  PORTB.4 = 0;
; 0000 0178 				  PORTB.5 = 1;
; 0000 0179 				  delay_ms(100);
; 0000 017A 				  PORTB.0 = 0;
; 0000 017B 			  	  PORTB.1 = 1;
; 0000 017C 				  PORTB.2 = 0;
; 0000 017D 				  PORTB.3 = 1;
; 0000 017E 				  PORTB.4 = 0;
; 0000 017F 				  PORTB.5 = 1;
; 0000 0180                   PORTB.0 = 1;
; 0000 0181 				  PORTB.1 = 0;
; 0000 0182 				  PORTB.2 = 1;
; 0000 0183 				  PORTB.3 = 0;
; 0000 0184 				  PORTB.4 = 1;
; 0000 0185 				  PORTB.5 = 0;
; 0000 0186 				  delay_ms(100);
; 0000 0187 
; 0000 0188                 }
; 0000 0189 			default:
_0x1A3:
; 0000 018A 				{
; 0000 018B 					PORTB.0 = 1;
	SBI  0x18,0
; 0000 018C 					delay_ms(500);
	RCALL SUBOPT_0x2
; 0000 018D 					PORTB.0 = 0;
	CBI  0x18,0
; 0000 018E 				}
; 0000 018F 		}
_0x24:
; 0000 0190 
; 0000 0191 
; 0000 0192 	}
	RJMP _0x3
; 0000 0193 }
_0x1A8:
	RJMP _0x1A8
; .FEND

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x0:
	SBI  0x18,0
	SBI  0x18,1
	SBI  0x18,2
	SBI  0x18,3
	SBI  0x18,4
	SBI  0x18,5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1:
	CBI  0x18,0
	CBI  0x18,1
	CBI  0x18,2
	CBI  0x18,3
	CBI  0x18,4
	CBI  0x18,5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2:
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x3:
	SBI  0x18,0
	LDI  R26,LOW(100)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x4:
	SBI  0x18,1
	LDI  R26,LOW(100)
	LDI  R27,0
	RCALL _delay_ms
	CBI  0x18,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x5:
	SBI  0x18,2
	LDI  R26,LOW(100)
	LDI  R27,0
	RCALL _delay_ms
	CBI  0x18,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x6:
	SBI  0x18,3
	LDI  R26,LOW(100)
	LDI  R27,0
	RCALL _delay_ms
	CBI  0x18,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x7:
	SBI  0x18,4
	LDI  R26,LOW(100)
	LDI  R27,0
	RCALL _delay_ms
	CBI  0x18,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:16 WORDS
SUBOPT_0x8:
	SBI  0x18,5
	LDI  R26,LOW(100)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 20 TIMES, CODE SIZE REDUCTION:36 WORDS
SUBOPT_0x9:
	LDI  R26,LOW(100)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xA:
	CBI  0x18,5
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xB:
	SBI  0x18,0
	CBI  0x18,1
	SBI  0x18,2
	CBI  0x18,3
	SBI  0x18,4
	RJMP SUBOPT_0xA

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xC:
	CBI  0x18,0
	SBI  0x18,1
	CBI  0x18,2
	SBI  0x18,3
	CBI  0x18,4
	RJMP SUBOPT_0x8

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:32 WORDS
SUBOPT_0xD:
	SBI  0x18,0
	SBI  0x18,1
	LDI  R26,LOW(300)
	LDI  R27,HIGH(300)
	RCALL _delay_ms
	CBI  0x18,0
	CBI  0x18,1
	SBI  0x18,2
	SBI  0x18,3
	LDI  R26,LOW(300)
	LDI  R27,HIGH(300)
	RCALL _delay_ms
	CBI  0x18,2
	CBI  0x18,3
	SBI  0x18,4
	SBI  0x18,5
	LDI  R26,LOW(300)
	LDI  R27,HIGH(300)
	RCALL _delay_ms
	CBI  0x18,4
	CBI  0x18,5
	SBI  0x18,3
	SBI  0x18,2
	LDI  R26,LOW(300)
	LDI  R27,HIGH(300)
	RCALL _delay_ms
	CBI  0x18,3
	CBI  0x18,2
	SBI  0x18,1
	SBI  0x18,0
	LDI  R26,LOW(300)
	LDI  R27,HIGH(300)
	RCALL _delay_ms
	CBI  0x18,1
	CBI  0x18,0
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x3E8
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
