*****************************************************************************
* Funcao   : CADHIS                                                         *
* Objetivo : Manuten‡Æo do Cadastro de HISTORICOS                           *
* Data     : 04/03/99                                                       *
* Autor    : LAERCIO                                                        *
*****************************************************************************
FUNCTION CADHIS()
Local  cod, desc, tip
Local  Tela, linha1, linha2
Private Getlist := {}
Set Cursor on
ABREHIS()
linha1 := savescreen(00,00,03,79)
linha2 := savescreen(21,00,24,79)
setcolor ("bg+/n,bg+/n")
borda (03,00,21,79)
restscreen(00,00,03,79,linha1)
restscreen(21,00,24,79,linha2)
@ 02,41 say PADC("Cadastro de Hist¢ricos",38) color ("w+/n")
@ 09,12 clear to 13,66
@ 09,12 to 13,66
@ 10,14 say "C¢digo Hist¢rico: "
@ 11,14 say "Descri‡Æo.......: "
@ 12,14 say "Tipo............: "
@ 24,00 say padc("Esc-Sair  Enter-Confirma  F2-Consulta  F5-Altera  F6-Exclui  "+chr(024)+chr(025)+chr(027)+chr(026)+" -Movimenta",78) color ("w+ /b")
tela := savescreen(00,00,24,79)
Do while .t.
   restscreen(00,00,24,79,tela)
   Set Confirm on
   set cursor on
   HIS->(dBGoBottom())
   Cod := his->codigo + 1
   @ 22,01 CLEAR TO 22,78
   set key -1 to l_his()
   @ 10,32 get Cod pict "9999" valid Cod > 0
   read
   Set Confirm off
   set key -1 to
   @ 22,01 clear to 22,78
   If Lastkey() = 27
      Exit
   Endif
   HIS->(dBSeek(str(Cod,4,0)))
   if HIS->(Found())
      @ 11,32 say HIS->DESCRI
      if his->tipo = "D"
           @ 12,32 say his->tipo + " - D‚bito"
      else
           @ 12,32 say his->tipo + " - Cr‚dito"
      endif
      Set Cursor off
      Do While .t.
         Inkey(0)
         @ 22,01 clear to 22,78
         If lastkey() # 27 .and. Lastkey() # 13 .and. Lastkey() # -4 .and. Lastkey() # -5
            Mens("Tecla Inv lida!!!",.t.,.t.)
            Loop
         Endif
         Exit
      Enddo
      if lastkey() = 27 .or. lastkey() = 13
          loop
      endif
      Set Cursor on
      Do case
         case Lastkey() = -5           && ExclusÆo
              If Confirma("ExclusÆo")
                 HIS->(Dbdelete())
              Endif
              Loop
         case Lastkey() = -4           && Altera‡Æo
              Desc := HIS->DESCRI
              tip  := his->tipo
              linha1 := savescreen(23,01,23,78)
              @ 11,32 get Desc pict "@!" valid !empty(Desc)
              read
              @ 12,32 get tip  pict "!" valid tip $('CD')
              @ 22,01 say padc("Digite D - D‚bito ou C - Cr‚dito",78)
              read
              restscreen(22,01,22,78,linha1)
              If Lastkey() = 27
                 Loop
              Endif
              If Confirma("Altera‡Æo")
                 HIS->DESCRI  := desc
                 his->tipo    := tip
              Endif
              Loop
      Endcase
   else
      desc  := space(30)
      tip   := space(01)
      linha1 := savescreen(23,01,23,78)
      @ 11,32 get desc pict "@!" valid !empty(desc)
      read
      @ 12,32 get tip  pict "!" valid tip $('CD')
      @ 22,01 say padc("Digite D - D‚bito ou C - Cr‚dito",78)
      read
      restscreen(22,01,22,78,linha1)
      If Lastkey() = 27
         Loop
      Endif
      If Confirma("InclusÆo")
         HIS->(DBAPPEND())
         HIS->CODIGO  := cod
         HIS->DESCRI  := desc
         his->tipo    := tip
      Endif
   Endif
Enddo
Dbcloseall()
Set Cursor off
Return Nil
****************************************************************************
