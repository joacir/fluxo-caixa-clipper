*****************************************************************************
* FUNCAO   : CALENDARIO                                                     *
* Objetivo : Desenha Calendario                                             *
*****************************************************************************
FUNCTION CALEND()
LOCAL  wCursor  := set(_SET_CURSOR),;
       wTela    := savescreen(00,00,13,29),;
       oCOR     := SETCOLOR(),;
       ca_mes   := month(date()),;
       ca_ano   := year(date())

LOCAL  ca_data  := ctod("01/"+str(ca_mes,2)+"/"+subs(str(ca_ano,4),3)),;
       ca_var,;
       c_vardia,;
       wAr,;
       wContador,;
       wMesAno,;
       tecla,;
       wLinhaF := savescreen( 24,00,24,80 )

SET CURSOR OFF
SET DATE BRIT
set century off

@ 24,01 SAY padc(chr(24)+chr(25)+"-Altera Ano    "+chr(27)+chr(26)+"-Altera Mˆs       <ESC>-Sai",78) color("w+/b")

c_vardia := "  1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17"
C_vardia += "  18  19  20  21  22  23  24  25  26  27  28  29  30  31 "

WHILE lastkey() != 27

   SETCOLOR("W+")
   quadro( 00,00,12,28 )

   SETCOLOR("B+")
   @ 01, 01 say "Dom Seg Ter Qua Qui Sex Sab"
   SETCOLOR("W+")
   @ 09, 00 say "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"

   SETCOLOR("B+")
   @ 10, 01 say "Data atual: "
   SETCOLOR("W+")
   @ 10, 20 say date()

   SETCOLOR("B+")
   @ 11, 01 say "Hora atual: "
   SETCOLOR("W+")
   @ 11, 20 say time()

   IF at(subs(str(ca_mes+100,3),2),"01 03 05 07 08 10 12") != 0
      ca_var := c_vardia + space(25)
   ELSE
      *
      IF ca_mes != 2
         CA_VAR=subs(c_vardia,1,120) + space(25)
      ELSE
         *
         IF int(ca_mes/4) = ca_mes/4
            ca_var := subs(c_vardia,1,116) + space(25)
         ELSE
            ca_var := subs(c_vardia,1,112) + space(25)
         ENDIF
      ENDIF
   ENDIF

   wAr       := iif(dow(ca_data) > 1, repl("    ",dow(ca_data)-1)+ca_var,ca_var)
   wContador := 1

   WHILE  .T.
      IF len(wAr) < wContador*28
         exit
      ENDIF
      @ 1+wContador,0 say "³"+subs(wAr,(28*wContador)-27,27)+"³"
      wContador++
   END

   wMesAno := " "+trim(subs("Janeiro  Fevereiro   Marco    Abril    Maio     Junho    Julho   Agosto  Setembro Outubro  Novembro Dezembro ",ca_mes*9-8,9))+" - "+str(year(ca_data),4)+" "

   SETCOLOR("B+")
   @ 8,0+( 29 - len( wMesAno ) ) /2 say wMesAno
   SETCOLOR("W+")

   WHILE .T.
      tecla := inkey()
      @ 11, 20 say time()
      IF !empty( tecla )
        exit
      ENDIF
   END

   ca_ano := ca_ano+IIF( tecla= 24, -1, IIF( tecla = 05,1,0 ))
   ca_mes := ca_mes+IIF( tecla= 19, -1, IIF( tecla = 04,1,0 ))
   ca_mes := IIF( ca_mes < 1, 12,IIF(ca_mes>12,1,ca_mes))
   set century ON
   ca_data := ctod("01/"+str(ca_mes,2)+"/"+str(ca_ano,4))
   set century OFF
END
*
SETCOLOR(oCOR)
@ 23,11 SAY SPACE(67)
set(_SET_CURSOR,wCursor)
restscreen(24,00,24,80,wLinhaF)
restscreen(00,00,13,29,wTela)
set century on
RETURN NIL
****************************************************************************
