*****************************************************************************
* Funcao   : CADCLI                                                         *
* Objetivo : Manuten‡Æo do Cadastro de Clientes e Fornecedores              *
*****************************************************************************
FUNCTION CADCLI(tipo)
*
Local  CODIGO, NOME, RG,CIC, ENDER, CIDADE, ESTADO, CEP, FONE, DTAINS, OBS
Local  Tela, linha1, linha2
Private Getlist := {}
ABRECLI()
linha1 := savescreen(00,00,03,79)
linha2 := savescreen(21,00,24,79)
Setcolor ("bg+ /n,bg+ /n")
borda (03,00,21,79)
restscreen (00,00,03,79,linha1)
restscreen (21,00,24,79,linha2)
if tipo = "C"
   @ 02,41 say padc("Cadastro de Clientes",38) color("w+/n")
else
  @ 02,41 say padc("Cadastro de Fornecedores",38) color("w+/n")
endif
Setcolor ("bg+ /n")
@ 06,09 clear to 18,71
@ 06,09 to 18,71
@ 07,11 say "Codigo............: "
@ 08,11 say "Nome..............: "
@ 09,11 say "RG................: "
@ 10,11 say "CIC...............: "
@ 11,11 say "Endere‡o..........: "
@ 12,11 say "Cidade............: "
@ 13,11 say "Estado............: "
@ 14,11 say "CEP...............: "
@ 15,11 say "Telefone..........: "
@ 16,11 say "Data de Inscri‡Æo.: "
@ 17,11 say "Observa‡äes.......: "
@ 22,01 clear to 22,78
@ 24,00 say padc("Esc-Sair  Enter-Confirma  F2-Consulta  F5-Altera  F6-Exclui  "+chr(024)+chr(025)+chr(027)+chr(026)+" -Movimenta",78) color ("w+ /b")
Tela := Savescreen(00,00,24,79)
Do while .t.
   Restscreen(00,00,24,79,Tela)
   if tipo = "C"
      set key -1 to l_cli()
   else
      set key -1 to l_for()
   endif
   set cursor on
   Set Confirm on
   codigo := 1
   cli->(dbgotop())
   do while cli->(!eof())
      if cli->tipocf = tipo
         CODIGO := cli->codigo + 1
      endif
      cli->(dbskip())
   enddo
   @ 07,31 get CODIGO pict "999999" valid CODIGO > 0
   read
   @ 22,01 clear to 22,78
   set key -1 to
   set confirm off
   If Lastkey() = 27
      Exit
   Endif
   CLI->(dBSeek(str(CODIGO,6,0) + tipo))
   if CLI->(Found())
      set cursor off
      @ 08,31 say CLI->NOME
      @ 09,31 say CLI->RG
      @ 10,31 say CLI->CIC
      @ 11,31 say CLI->ENDER
      @ 12,31 say CLI->CIDADE
      @ 13,31 say CLI->ESTADO
      @ 14,31 say CLI->CEP
      @ 15,31 say CLI->FONE
      @ 16,31 say CLI->DTAINS
      @ 17,31 say CLI->OBS
      Do While .t.
         Inkey(0)
         @ 22,01 clear to 22,78
         If lastkey() # 27 .and. Lastkey() # 13 .and. Lastkey() # -4 .and. Lastkey() # -5
            Mens("Tecla Inv lida!!!",.t.,.t.)
            Loop
         Endif
         Exit
      Enddo
      if lastkey() = 13 .or. lastkey() = 27
         loop
      endif
      Do case
         case Lastkey() = -5           && ExclusÆo
              set cursor on
              If Confirma("ExclusÆo")
                 CLI->(Dbdelete())
              Endif
              Loop
         case Lastkey() = -4           && Altera‡Æo
              set cursor on
              NOME    := CLI->NOME
              RG      := CLI->RG
              CIC     := CLI->CIC
              ENDER   := CLI->ENDER
              CIDADE  := CLI->CIDADE
              ESTADO  := CLI->ESTADO
              CEP     := CLI->CEP
              FONE    := CLI->FONE
              DTAINS  := CLI->DTAINS
              OBS     := CLI->OBS
              @ 08,31 get NOME   pict "@!" valid !empty(NOME)
              @ 09,31 get RG     pict "@!" valid !empty(RG)
              @ 10,31 get CIC    pict "999.999.999-99"
              @ 11,31 get ENDER  pict "@!" valid !empty(ENDER)
              @ 12,31 get CIDADE pict "@!" valid !empty(CIDADE)
              @ 13,31 get ESTADO pict "@!" valid !empty(ESTADO)
              @ 14,31 get CEP    pict "99999-999"
              @ 15,31 get FONE   pict "(!!999) !999-9999"
              @ 16,31 get DTAINS
              @ 17,31 get OBS    pict "@!"
              read
              If Lastkey() = 27
                 Loop
              Endif
              If Confirma("Altera‡Æo")
                 CLI->NOME   := NOME
                 CLI->RG     := RG
                 CLI->CIC    := CIC
                 CLI->ENDER  := ENDER
                 CLI->CIDADE := CIDADE
                 CLI->ESTADO := ESTADO
                 CLI->CEP    := CEP
                 CLI->FONE   := FONE
                 CLI->DTAINS := DTAINS
                 CLI->OBS    := OBS
              Endif
              Loop
      Endcase
   else
      NOME    := space(30)
      RG      := space(12)
      CIC     := space(14)
      ENDER   := space(40)
      CIDADE  := space(20)
      ESTADO  := space(02)
      CEP     := space(10)
      FONE    := space(17)
      DTAINS  := date()
      OBS     := space(40)
      @ 08,31 get NOME   pict "@!" valid !empty(NOME)
      @ 09,31 get RG     pict "@!" valid !empty(RG)
      @ 10,31 get CIC    pict "999.999.999-99"
      @ 11,31 get ENDER  pict "@!" valid !empty(ENDER)
      @ 12,31 get CIDADE pict "@!" valid !empty(CIDADE)
      @ 13,31 get ESTADO pict "@!" valid !empty(ESTADO)
      @ 14,31 get CEP    pict "99999-999"
      @ 15,31 get FONE   pict "(!!999) !999-9999"
      @ 16,31 get DTAINS
      @ 17,31 get OBS    pict "@!"
      read
      If Lastkey() = 27
         Loop
      Endif
      If Confirma("InclusÆo")
         CLI->(DBAPPEND())
         CLI->CODIGO := CODIGO
         cli->tipocf := tipo
         CLI->NOME   := NOME
         CLI->RG     := RG
         CLI->CIC    := CIC
         CLI->ENDER  := ENDER
         CLI->CIDADE := CIDADE
         CLI->ESTADO := ESTADO
         CLI->CEP    := CEP
         CLI->FONE   := FONE
         CLI->DTAINS := DTAINS
         CLI->OBS    := OBS
      Endif
   Endif         
Enddo
Dbcloseall()
Set Cursor off
Return Nil
****************************************************************************

