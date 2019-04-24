*****************************************************************************
* Funcao   : CADBAN                                                         *
* Objetivo : Manuten‡Æo do Cadastro de BANCOS                               *
*****************************************************************************
FUNCTION CADBAN()
*
Local  NCONTA, BANCO, AGENC, SALINI, SALATU, DTA
Local  Tela, linha1, linha2
Private Getlist := {}
ABREBAN()
linha1 := savescreen(00,00,03,79)
linha2 := savescreen(21,00,24,79)
Setcolor ("bg+ /n,bg+ /n")
borda (03,00,21,79)
restscreen (00,00,03,79,linha1)
restscreen (21,00,24,79,linha2)
@ 02,41 say padc (" Cadastro de Contas ",38) color("w+/n")
Setcolor ("bg+ /n")
@ 08,14 clear to 15,65
@ 08,14 to 15,65
@ 09,16 say "N£mero da Conta..: "
@ 10,16 say "Conta / Banco....: "
@ 11,16 say "Agˆncia..........: "
@ 12,16 say "Saldo Inicial....: "
@ 13,16 say "Saldo Atual......: "
@ 14,16 say "Data.............: "
@ 22,01 clear to 22,78
@ 24,00 say padc("Esc-Sair  Enter-Confirma  F2-Consulta  F5-Altera  F6-Exclui  "+chr(024)+chr(025)+chr(027)+chr(026)+" -Movimenta",78) color ("w+ /b")
Tela := Savescreen(00,00,24,79)
Do while .t.
   SALINI  := 0
   SALATU  := 0
   DTA     := date()
   BANCO   := space(30)
   AGENC   := 0
   Restscreen(00,00,24,79,Tela)
   set key -1 to l_ban()
   set cursor on
   Set Confirm on
   BAN->(dBGoBottom())
   NCONTA := ban->nconta + 1
   if nconta = 1
      banco  := 'Conta do Caixa'
      agenc  := 0
      @ 09,35 say nconta
      @ 10,35 say BANCO
      @ 11,35 say AGENC
      @ 12,35 get SALINI pict "@e 999,999,999.99"
      read
      salatu := salini
      @ 13,35 get SALATU pict "@e 999,999,999.99"
      @ 14,35 get DTA
      read
      If Lastkey() = 27
         Loop
      Endif
      If Confirma("InclusÆo")
         BAN->(DBAPPEND())
         BAN->NCONTA := NCONTA
         BAN->BANCO  := BANCO
         BAN->AGENC  := AGENC
         BAN->SALINI := SALINI
         BAN->SALATU := SALATU
         BAN->DTA    := DTA
      Endif
      loop
   else
      @ 09,35 get NCONTA pict "9999999999" valid NCONTA > 0
      read
   endif
   @ 22,01 clear to 22,78
   set key -1 to
   set confirm off
   If Lastkey() = 27
     Exit
   Endif
   BAN->(dBSeek(str(NCONTA,10,0)))
   if BAN->(Found())
      set cursor off
      @ 10,35 say BAN->BANCO
      @ 11,35 say BAN->AGENC
      @ 12,35 say transform(BAN->SALINI,"@e 999,999,999.99")
      @ 13,35 say transform(BAN->SALatu,"@e 999,999,999.99")
      @ 14,35 say BAN->DTA
      Do While .t.
         Inkey(0)
         @ 22,01 clear to 22,78
         If Lastkey() # 27 .and. Lastkey() # 13 .and. Lastkey() # -4 .and. Lastkey() # -5
            Mens("Tecla Inv lida!!!",.t.,.t.)
            Loop
         Endif
         Exit
      Enddo
      if lastkey() = 27 .or. lastkey() = 13
         loop
      endif
      Do case
         case Lastkey() = -5           && ExclusÆo
              set cursor on
              If Confirma("ExclusÆo")
                if ban->nconta != 1
                   BAN->(Dbdelete())
                else
                   mens('NÆo ‚ poss¡vel excluir conta do caixa !',.t.,.t.)
                endif
              Endif
              Loop
         case Lastkey() = -4           && Altera‡Æo
              set cursor on
*              NCONTA  := BAN->NCONTA
              BANCO   := BAN->BANCO
              AGENC   := BAN->AGENC
              SALINI  := BAN->SALINI
              SALATU  := BAN->SALATU
              DTA     := BAN->DTA
*              @ 09,35 get NCONTA pict "9999999999" valid nconta > 0
              @ 10,35 get BANCO  pict "@!" valid !empty(BANCO)
              @ 11,35 get AGENC  pict "99999"
              @ 12,35 get SALINI pict "@e 999,999,999.99"
              @ 13,35 get SALATU pict "@e 999,999,999.99"
              @ 14,35 get DTA
              read
              If Lastkey() = 27
                 Loop
              Endif
              If Confirma("Altera‡Æo")
                 BAN->BANCO   := BANCO
                 BAN->AGENC   := AGENC
                 BAN->SALINI  := SALINI
                 BAN->SALATU  := SALATU
                 BAN->DTA     := DTA
              Endif
              Loop
      Endcase
   else
      @ 10,35 get BANCO  pict "@!" valid !empty(BANCO)
      @ 11,35 get AGENC  pict "99999"
      @ 12,35 get SALINI pict "@e 999,999,999.99"
      read
      salatu := salini
      @ 13,35 get SALATU pict "@e 999,999,999.99"
      @ 14,35 get DTA
      read
      If Lastkey() = 27
         Loop
      Endif
      If Confirma("InclusÆo")
         BAN->(DBAPPEND())
         BAN->NCONTA := NCONTA
         BAN->BANCO  := BANCO
         BAN->AGENC  := AGENC
         BAN->SALINI := SALINI
         BAN->SALATU := SALATU
         BAN->DTA    := DTA
      Endif
   Endif
Enddo
Dbcloseall()
Set Cursor off
Return Nil
