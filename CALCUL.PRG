*****************************************************************************
* FUNCAO   : CALCULADORA                                                    *
* Objetivo : Desenha Calculadora                                            *
*****************************************************************************
FUNCTION CALCUL()
LOCAL oTELINICIO,;
      oTELA,;
      oLINHAF,;
      oCURSOR  := set(_SET_CURSOR),;
      oCOR     := SETCOLOR(),;
      oDBF     := DBF(),;
      C_DIG

IF !file("CALC.MEM")
   CALC_RES   := 0
   CALC_ALG   := space(14)
   CALC_DEC   := ""
   CALC_VAR   := "CALC_ALG"
   CALC_VERD  := .F.
   CALC_UOPER := ""
   CALC_PERC  := " "
   CALC_LI    := 01
   CALC_LF    := 14
   CALC_CI    := 01
   CALC_CF    := 25
ELSE
   RESTORE FROM CALC.MEM ADDITIVE
ENDIF

C_DIG      := chr(0)
oTELINICIO := savescreen(CALC_LI ,CALC_CI ,CALC_LF ,CALC_CF )
SET CURSOR OFF

SETCOLOR("W")
@ CALC_LI ,CALC_CI  clear to CALC_LF ,CALC_CF
@ CALC_LI ,CALC_CI  to CALC_LF ,CALC_CF
@ CALC_LI +1, CALC_CI +1 say repl(chr(220),23)
@ CALC_LI +3, CALC_CI +1 say repl(chr(223),23)

SETCOLOR("W+")
@ CALC_LI +2, CALC_CI +1 say space(23)

oLINHAF := savescreen( 24,00,24,79 )

SETCOLOR("W/B+")
@ 24,05 SAY CHR(27)+CHR(24)+CHR(25)+CHR(26)+"-Movimenta  <C>-Cancela Opera‡Æo  <E>-Cancela N£mero  <ESC>-Sai"
SETCOLOR("W+")
@ CALC_LI + 05, CALC_CI + 01 say " 7 "
@ CALC_LI + 05, CALC_CI + 06 say " 8 "
@ CALC_LI + 05, CALC_CI + 11 say " 9 "
@ CALC_LI + 07, CALC_CI + 01 say " 4 "
@ CALC_LI + 07, CALC_CI + 06 say " 5 "
@ CALC_LI + 07, CALC_CI + 11 say " 6 "
@ CALC_LI + 09, CALC_CI + 01 say " 1 "
@ CALC_LI + 09, CALC_CI + 06 say " 2 "
@ CALC_LI + 09, CALC_CI + 11 say " 3 "
@ CALC_LI + 11, CALC_CI + 01 say "  0  "
@ CALC_LI + 11, CALC_CI + 09 say "  .  "

SETCOLOR("B+")
@ CALC_LI + 05, CALC_CF - 08 say " - "
@ CALC_LI + 07, CALC_CF - 08 say " + "
@ CALC_LI + 09, CALC_CF - 03 say " * "
@ CALC_LI + 11, CALC_CF - 03 say " / "

SETCOLOR("W")
@ CALC_LI + 09, CALC_CF - 08 say chr(17)+chr(196)+chr(217)
@ CALC_LI + 10, CALC_CF - 08 say "   "
@ CALC_LI + 11, CALC_CF - 08 say " = "
@ CALC_LI + 05, CALC_CF - 03 say " C "
@ CALC_LI + 07, CALC_CF - 03 say " E "

SETCOLOR("W+")
@ CALC_LI + 2, CALC_CI + 2 say " " + str(CALC_RES,19,4) + " "

WHILE C_DIG != chr(27)

   C_DIG := chr(INKEY(0))

   IF C_DIG == chr(27)
      exit
   ENDIF

   IF C_DIG == chr(19)
      oTELA := savescreen(CALC_LI ,CALC_CI ,CALC_LF ,CALC_CF )
      restscreen(CALC_LI ,CALC_CI ,CALC_LF ,CALC_CF ,oTELINICIO)
      CALC_CI --
      CALC_CF --
      IF CALC_CI  < 00
         CALC_CI ++
         CALC_CF ++
      ENDIF
      oTELINICIO := savescreen(CALC_LI ,CALC_CI ,CALC_LF ,CALC_CF )
      restscreen(CALC_LI ,CALC_CI ,CALC_LF ,CALC_CF ,oTELA)
      loop
   ENDIF

   IF C_DIG == chr(04)
      oTELA := savescreen(CALC_LI ,CALC_CI ,CALC_LF ,CALC_CF )
      restscreen(CALC_LI ,CALC_CI ,CALC_LF ,CALC_CF ,oTELINICIO)
      CALC_CI ++
      CALC_CF ++
      IF CALC_CF  > 79
         CALC_CI --
         CALC_CF --
      ENDIF
      oTELINICIO := savescreen(CALC_LI ,CALC_CI ,CALC_LF ,CALC_CF )
      restscreen(CALC_LI ,CALC_CI ,CALC_LF ,CALC_CF ,oTELA)
      loop
   ENDIF

   IF C_DIG == chr(24)
      oTELA := savescreen(CALC_LI ,CALC_CI ,CALC_LF ,CALC_CF )
      restscreen(CALC_LI ,CALC_CI ,CALC_LF ,CALC_CF ,oTELINICIO)
      CALC_LI ++
      CALC_LF ++
      IF CALC_LF  > 23
         CALC_LI --
         CALC_LF --
      ENDIF
      oTELINICIO := savescreen(CALC_LI ,CALC_CI ,CALC_LF ,CALC_CF )
      restscreen(CALC_LI ,CALC_CI ,CALC_LF ,CALC_CF ,oTELA)
      loop
   ENDIF

   IF C_DIG == chr(05)
      oTELA := savescreen(CALC_LI ,CALC_CI ,CALC_LF ,CALC_CF )
      restscreen(CALC_LI ,CALC_CI ,CALC_LF ,CALC_CF ,oTELINICIO)
      CALC_LI --
      CALC_LF --
      IF CALC_LI  < 00
         CALC_LI ++
         CALC_LF ++
      ENDIF
      oTELINICIO := savescreen(CALC_LI ,CALC_CI ,CALC_LF ,CALC_CF )
      restscreen(CALC_LI ,CALC_CI ,CALC_LF ,CALC_CF ,oTELA)
      loop
   ENDIF

   CALC_VAR  := IIF(C_DIG=".","CALC_DEC",CALC_VAR)
   CALC_ALG := IIF(C_DIG="." .and. CALC_ALG=space(14),space(13)+"0",CALC_ALG)

   IF C_DIG $ "0123456789" .and. len(ltrim(&CALC_VAR)) != IIF(CALC_VAR="CALC_DEC",4,14)
      &CALC_VAR   := IIF(CALC_VAR="CALC_DEC",&CALC_VAR+C_DIG,subs(&CALC_VAR+C_DIG,2))
      setcolor("W+")
      @ CALC_LI +2,CALC_CI +3 say CALC_ALG+"."+subs(CALC_DEC+subs("00000",LEN(CALC_DEC)+1),1,4)
      CALC_VERD := IIF(CALC_VERD .and. CALC_UOPER $ "="+chr(13),.F.,CALC_VERD)
   ELSEIF C_DIG $ "+-/*="+chr(13)
      IF CALC_VERD
         IF VAL(CALC_ALG+"."+CALC_DEC) != 0
            OPE_RA   := str(CALC_RES,19,4)+CALC_UOPER+CALC_ALG+"."+subs(CALC_DEC+subs("00000",LEN(CALC_DEC)+1),1,4)
            CALC_RES := &OPE_RA
            setcolor("W+")
            @ CALC_LI +2,CALC_CI +3 say str(CALC_RES,19,4)
         ENDIF
      ELSEIF C_DIG $ "+-/*"
         CALC_VERD := .T.
         CALC_RES := val(CALC_ALG+"."+CALC_DEC)
      ENDIF
      SETCOLOR("W+")
      @ CALC_LI +2,CALC_CI +1 say IIF(C_DIG $ "+-/*",C_DIG," ")
      @ CALC_LI +2,CALC_CF -1 say " "

      CALC_VAR   := "CALC_ALG"
      CALC_ALG  := space(14)
      CALC_DEC   := ""
      CALC_UOPER := C_DIG
      CALC_PERC   := " "

   ELSEIF C_DIG $ "EeCc"
      CALC_VAR  := "CALC_ALG"
      CALC_ALG := space(14)
      CALC_DEC  := ""
      CALC_PERC  := " "

      IF C_DIG $ "Cc"
         CALC_VERD := .F.
         CALC_RES := 0
         SETCOLOR("W+")
         @ CALC_LI +2,CALC_CI +1 say " "
         @ CALC_LI +2,CALC_CF -1 say " "
      ENDIF
      setcolor("W+")
      @ CALC_LI +2,CALC_CI +3 say space(13)+"0.0000"
   ENDIF

END
SAVE TO CALC all like CALC*
//, CALC_DEC, CALC_VAR, CALC_VERD, CALC_UOPER, CALC_PERC , CALC_LI , CALC_LF , CALC_CI , CALC_CF
SETCOLOR(oCOR)
restscreen(CALC_LI ,CALC_CI ,CALC_LF ,CALC_CF ,oTELINICIO)
restscreen(24,00,24,79,oLINHAF)
set(_SET_CURSOR,oCURSOR)
IF TYPE(oDBF) != "U"
   SELE &oDBF
ENDIF
@ 23,11 SAY SPACE(67)
RETURN(nil)
*****************************************************************************
