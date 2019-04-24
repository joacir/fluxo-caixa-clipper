*****************************************************************************
* Funcao   : CADMOV                                                         *
* Objetivo : Manuten‡Æo de movimento de banc rio                            *
*****************************************************************************
FUNCTION CADMOV()
*
Local  ncodmov, conta, historico, valmov, data, vconta, vvalor, vhist
Local  Tela, linha1, linha2
Private Getlist := {}
set bell on
ABREMOV()
ABREBAN()
ABREHIS()
linha1 := savescreen(00,00,03,79)
linha2 := savescreen(21,00,24,79)
Setcolor ("bg+ /n,bg+ /n")
borda (03,00,21,79)
restscreen (00,00,03,79,linha1)
restscreen (21,00,24,79,linha2)
@ 02,41 say padc (" Movimento Banc rio ",38) color("w+/n")
Setcolor ("bg+ /n")
@ 08,05 clear to 15,74
@ 08,05 to 15,74
@ 09,07 say "N£mero do movimento..: "
@ 10,07 say "N£mero da conta......: "
@ 11,07 say "C¢digo do hist¢rico..: "
@ 12,07 say "Descri‡Æo............: "
@ 13,07 say "Valor................: "
@ 14,07 say "Data.................: "
@ 22,01 clear to 22,78
@ 24,00 say padc("Esc-Sair  Enter-Confirma  F2-Consulta  F5-Altera  F6-Exclui  "+chr(024)+chr(025)+chr(027)+chr(026)+" -Movimenta",78) color ("w+ /b")
Tela := Savescreen(00,00,24,79)
Do while .t.
   Restscreen(00,00,24,79,Tela)
   set key - 1 to l_mov()
   set cursor on
   Set Confirm on
   MOV->(dBGoBottom())
   nCODMOV := mov->codmov + 1
   @ 09,31 get nCODMOV pict "999999" valid nCODMOV > 0
   read
   @ 22,01 clear to 22,78
   set confirm on
   set key -1 to
   set confirm off
   If Lastkey() = 27
      Exit
   Endif
   MOV->(dBSeek(str(nCODMOV,6,0)))
   if MOV->(Found())
      set cursor off
      @ 10,31 say MOV->NCONTA
      BAN->(dbseek(str(mov->nconta,10,0)))
      if ban->(found())
        @ 10,42 say BAN -> banco
      else
        @ 10,42 say " Conta nÆo cadastrada! "
      endif
      @ 11,31 say MOV->CODHIS
      his->(dbseek(str(mov->codhis,4,0)))
      if his->(found())
         @ 12,31 say his->descri
      else
         @ 12,31 say "Hist¢rico nÆo encontrado !"
      endif
      @ 13,31 say transform(MOV->VALOR,"@e 999,999,999.99")
      @ 14,31 say MOV->DTAMOV
      do while .t.
        Inkey(0)
        @ 22,01 clear to 22,78
        If lastkey() # 27 .and. lastkey() # 13 .and. Lastkey() # -4 .and. Lastkey() # -5
            Mens("Tecla Inv lida!!!",.t.,.t.)
            Loop
        Endif
        exit
      enddo
      if lastkey() = 27 .or. lastkey() = 13 
        loop
      endif
      Do case
         case Lastkey() = -5           && ExclusÆo
              set cursor on
              If Confirma("ExclusÆo")
              if his->tipo = "C"
                 ban->salatu := ban->salatu - mov->valor
              else
                 ban->salatu := ban->salatu + mov->valor
              endif
                 MOV->(Dbdelete())
              Endif
              Loop
         case Lastkey() = -4           && Altera‡Æo
              set cursor on
              vconta    := mov->nconta
              vvalor    := mov->valor
              vhist     := mov->codhis
              valmov    := mov->valor
              data      := mov->dtamov
              read
              set key - 1 to l_ban()
                do while .t.
                  conta := mov->nconta
                  @ 10,31 get conta pict "9999999999" valid conta > 0
                  read
                  if lastkey() = 27
                    exit
                  endif
                  BAN ->(dbseek(str(conta,10,0)))
                  if ban->(found())
                     @ 10,42 say BAN -> banco
                     set key -1 to
                     exit
                  else
                     mens("Conta nÆo cadastrada! Tente outra!",.t.,.t.)
                     loop
                  endif
                enddo
                if lastkey() = 27
                  loop
                endif
                set key -1 to l_his()                       && consistencia para historico
                do while .t.
                  historico := mov->codhis
                  @ 11,31 get historico pict "9999" valid historico > 0
                  read
                  if lastkey() = 27
                    exit
                  endif
                  his->(dbseek(str(historico,4,0)))
                  if his->(found())
                     @ 12,31 say his->descri
                     set key -1 to
                     exit
                  else
                     mens("Hist¢rico nÆo cadastrado. Tente outro !",.t.,.t.)
                     loop
                  endif
               enddo
               @ 13,31 get valmov pict "@E 999,999,999.99"
               @ 14,31 get data
               read
               If Lastkey() = 27
                  Loop
               Endif
               If Confirma("Altera‡Æo")
                  his->(dbseek(str(vhist,4,0)))
                  if his->(found())
                     ban->(dbseek(str(vconta,10,0)))
                     if ban->(found())
                        if his->tipo = "D"
                           ban->salatu := ban->salatu + vvalor
                        else
                           ban->salatu := ban->salatu - vvalor
                        endif
                     else
                        mens("NÆo foi poss¡vel alterar o saldo da Conta !",.t.,.t.)
                     endif
                  else
                     mens("NÆo foi poss¡vel alterar o saldo da Conta !",.t.,.t.)
                  endif
                  his->(dbseek(str(historico,4,0)))
                  ban->(dbseek(str(conta,10,0)))
                  if his->tipo = "D"
                     ban->salatu := ban->salatu - valmov
                  else
                     ban->salatu := ban->salatu + valmov
                  endif
                  mov->nconta  := conta
                  MOV->CODHIS  := historico
                  MOV->VALOR   := valmov
                  MOV->DTAMOV  := data
               Endif
               Loop
      Endcase
   else
      conta     := 0
      historico := 0
      valmov    := 0
      data      := date()
      read
      set key - 1 to l_ban()
      do while .t.
        conta := mov->nconta
        @ 10,31 get conta pict "9999999999" valid conta > 0
        read
        if lastkey() = 27
           exit
        endif
        ban->(dbseek(str(conta,10,0)))
        if ban->(found())
           @ 10,42 say BAN -> banco
           set key -1 to
           exit
        else
           mens("Conta nÆo cadastrada! Tente outra!",.t.,.t.)
           loop
        endif
      enddo
      if lastkey() = 27
        loop
      endif
      set key -1 to l_his()                       && consistencia para historico
      do while .t.
         historico := 0
         @ 11,31 get historico pict "9999" valid historico > 0
         read
         if lastkey() = 27
            exit
         endif
         his->(dbseek(str(historico,4,0)))
         if his->(found())
            @ 12,31 say his->descri
            set key -1 to
            exit
         else
            mens("Hist¢rico nÆo cadastrado. Tente outro !",.t.,.t.)
            loop
         endif
      enddo
      @ 13,31 get valmov  pict "@E 9,999,999.99"
      @ 14,31 get data
      read
      If Lastkey() = 27
         Loop
      Endif
      If Confirma("InclusÆo")
         MOV->(DBAPPEND())
         MOV->CODMOV  := NCODMOV
         MOV->NCONTA  := CONTA
         MOV->CODHIS  := HISTORICO
         MOV->VALOR   := VALMOV
         MOV->DTAMOV  := DATA
         if his->tipo = "D"
             ban->salatu := ban->salatu - valmov
         else
             ban->salatu := ban->salatu + valmov
         endif
      Endif
   Endif
Enddo
Dbcloseall()
set bell off
Set Cursor off
Return Nil
*****************************************************************************
