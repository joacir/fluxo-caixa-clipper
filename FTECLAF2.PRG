*****************************************************************************
* Fun‡Æo     : FTECLAF2.PRG                                                 *
* Objetivo   : Fun‡äes de Consulta pela Tecla F2                            *
* Autor      : Joacir                                                       *
* Data       : 16/03/99                                                     *
*****************************************************************************
* Fun‡Æo     : L_his()                                                      *
* Objetivo   : Abre janela com hist¢ricos Cadastrados                       *
*****************************************************************************
FUNCTION L_his()
local Janela
local Linha22 := savescreen(22,00,22,79)
local nOpcao := 0
local aCod := {}
local getlist := {}
Set Key -1 to
setcolor("bg+ /n,n/ w")
his->(dBSetOrder(2))
his->(dBGoTop())
Do while his->(!EOF())
   aadd(aCod,str(his->CODIGO,4,0) + "  -  " + his->descri)
   his->(dBSkip())
Enddo
his->(dBSetOrder(1))
@ 22,01 clear to 22,78
if len(aCod) = 0
   Mens("NÆo Existem Hist¢ricos Cadastrados !!!",.t.,.t.)
else
   Janela := savescreen(07,38,19,78)
   @ 07,38 clear to 19,78
   @ 07,38 to 19,78
   @ 08,39 say padc("Hist¢ricos Cadastrados",39)
   @ 09,38 say "Ã" + replicate("Ä",39) + "´"
   nOpcao := Achoice(10,40,18,76,aCod)
   restscreen(07,38,19,78,Janela)
   if nOpcao # 0
      clear typeahead                                && Limpa Buffer do Teclado
      Keyboard(Substr(aCod[nOpcao],1,4)) + chr(13)   && Manda C¢digo para o Teclado
   endif
endif
restscreen(22,00,22,79,Linha22)
setcolor("bg+ /n,bg+ /n")
Set Key -1 to L_his()
Return nil
*****************************************************************************
* Fun‡Æo     : L_ban()                                                      *
* Objetivo   : Abre janela com Bancos Cadastradas                           *
*****************************************************************************
FUNCTION L_Ban()
local Janela
local Linha22 := savescreen(22,00,22,79)
local nOpcao := 0
local aCod := {}
local getlist := {}
setcolor("bg+ /n,n /w")
Set Key -1 to
ban->(dBSetOrder(2))
ban->(dBGoTop())
Do while ban->(!EOF())
   aadd(aCod,str(ban->nconta,10,0) + "  -  " + ban->banco)
   ban->(dBSkip())
Enddo
ban->(dBSetOrder(1))
@ 22,01 clear to 22,78
if len(aCod) = 0
   Mens("NÆo Existem Bancos Cadastrados !!!",.t.,.t.)
else
   Janela := savescreen(07,38,19,78)
   @ 07,38 clear to 19,78
   @ 07,38 to 19,78
   @ 08,39 say padc("Bancos Cadastrados",39)
   @ 09,38 say "Ã" + replicate("Ä",39) + "´"
   nOpcao := Achoice(10,40,18,76,aCod)
   restscreen(07,38,19,78,Janela)
   if nOpcao # 0
      clear typeahead
      Keyboard(Substr(aCod[nOpcao],1,10)) + chr(13)
   endif
endif
restscreen(22,00,22,79,Linha22)
setcolor("bg+ /n,bg+ /n")
Set Key -1 to L_ban()
Return nil
*****************************************************************************
* Fun‡Æo     : L_CLI()                                                      *
* Objetivo   : Abre janela com CLIENTES CadastradoS                         *
*****************************************************************************
FUNCTION L_CLI()
local Janela
local Linha22 := savescreen(22,00,22,79)
local nOpcao := 0
local aCod := {}
local getlist := {}
Set Key -1 to
setcolor("bg+ /n,n /w")
cli->(dBSetOrder(2))
cli->(dbgotop())
Do while cli->(!EOF())
 if cli->tipocf = "C"
   aadd(aCod,str(cli->CODIGO,6,0) + "  -  " + cli->nome)
 endif
 cli->(dBSkip())
Enddo
cli->(dBSetOrder(1))
@ 22,01 clear to 22,78
if len(aCod) = 0
   Mens("NÆo Existem Clientes Cadastrados !!!",.t.,.t.)
else
   Janela := savescreen(07,36,19,78)
   @ 07,36 clear to 19,78
   @ 07,36 to 19,78
   @ 08,37 say padc("Clientes Cadastrados",41)
   @ 09,36 say "Ã" + replicate("Ä",41) + "´"
   nOpcao := Achoice(10,38,18,76,aCod)
   restscreen(07,36,19,78,Janela)
   if nOpcao # 0
      clear typeahead
      Keyboard(Substr(aCod[nOpcao],1,6)) + chr(13)
   endif
endif
restscreen(22,00,22,79,Linha22)
setcolor("bg+ /n,bg+ /n")
Set Key -1 to L_cli()
Return nil
*****************************************************************************
* Fun‡Æo     : L_for()                                                      *
* Objetivo   : Abre janela com Fornecedores cadastrados                     *
*****************************************************************************
FUNCTION L_for()
local Janela
local Linha22 := savescreen(22,00,22,79)
local nOpcao := 0
local aCod := {}
local getlist := {}
Set Key -1 to
setcolor("bg+ /n,n /w")
cli->(dBSetOrder(2))
cli->(dbgotop())
Do while cli->(!EOF())
 if cli->tipocf = "F"
   aadd(aCod,str(cli->CODIGO,6,0) + "  -  " + cli->nome)
 endif
 cli->(dBSkip())
Enddo
cli->(dBSetOrder(1))
@ 22,01 clear to 22,78
if len(aCod) = 0
   Mens("NÆo Existem Fornecedores Cadastrados !!!",.t.,.t.)
else
   Janela := savescreen(07,36,19,78)
   @ 07,36 clear to 19,78
   @ 07,36 to 19,78
   @ 08,37 say padc("Fornecedores Cadastrados",41)
   @ 09,36 say "Ã" + replicate("Ä",41) + "´"
   nOpcao := Achoice(10,38,18,76,aCod)
   restscreen(07,36,19,78,Janela)
   if nOpcao # 0
      clear typeahead
      Keyboard(Substr(aCod[nOpcao],1,6)) + chr(13)
   endif
endif
restscreen(22,00,22,79,Linha22)
setcolor("bg+ /n,bg+ /n")
Set Key -1 to L_for()
Return nil
*****************************************************************************
* Fun‡Æo     : L_lan()                                                      *
* Objetivo   : Abre janela com Lancamentos cadastrados                      *
*****************************************************************************
FUNCTION L_lan()
local Janela
local Linha22 := savescreen(22,00,22,79)
local nOpcao := 0
local aCod := {}
local hist := space(30)
local getlist := {}
set key -1 to
setcolor("bg+ /n,n /w")
abt->(dBSetOrder(2))
abt->(dbgotop())
Do while abt->(!EOF())
 his->(dbseek(str(abt->codhis,4,0)))
 if his->(found())
     hist := his->descri
 else
     hist := "Hist¢rico nÆo encontrado !"
 endif
 aadd(aCod,substr(abt->CODcli,7,1) + substr(abt->codcli,1,6) + abt->nrodoc + " - " + substr(hist,1,23) + " - " + dtoc(abt->dtavcm) + " - " + str(abt->valorap,12,2))
 abt->(dBSkip())
Enddo
abt->(dBSetOrder(1))
@ 22,01 clear to 22,78
if len(aCod) = 0
   Mens("NÆo Existem Lan‡amentos Cadastrados !!!",.t.,.t.)
else
   Janela := savescreen(05,04,19,76)
   @ 05,04 clear to 19,76
   @ 05,04 to 19,76
   @ 06,05 say padc("Lan‡amentos de Contas a Pagar e Receber",70)
   @ 07,04 say "Ã" + replicate("Ä",71) + "´"
   nOpcao := Achoice(08,06,18,74,aCod)
   restscreen(05,04,19,76,Janela)
   if nOpcao # 0
      clear typeahead
      Keyboard(Substr(aCod[nOpcao],1,1)+substr(acod[nopcao],2,6)+chr(13)+substr(acod[nopcao],8,8)+chr(13))
   endif
endif
set key -1 to l_lan()
restscreen(22,00,22,79,Linha22)
setcolor("bg+ /n,bg+ /n")
return nil
*****************************************************************************
* Fun‡Æo     : L_bax()                                                      *
* Objetivo   : Abre janela com Baixas cadastrados                           *
*****************************************************************************
FUNCTION L_bax()
local Janela
local Linha22 := savescreen(22,00,22,79)
local nOpcao := 0
local aCod := {}
local hist := space(30), clif := space(30)
local getlist := {}
set key -1 to
setcolor("bg+ /n,n /w")
pag->(dBSetOrder(2))
pag->(dbgotop())
Do while pag->(!EOF())
 his->(dbseek(str(pag->codhis,4,0)))
 if his->(found())
     hist := his->descri
 else
     hist := "Hist¢rico nÆo encontrado !"
 endif
 cli->(dbseek(pag->clifor))
 if cli->(found())
     clif := cli->nome  
 else
     clif := "NÆo encontrado !"
 endif
 aadd(aCod,str(pag->ndupli,8,0) + " " + substr(clif,1,19) + " " + substr(hist,1,16) + " " + dtoc(pag->dtapag) + " " + str(pag->valorpg,12,2))
 pag->(dBSkip())
Enddo
pag->(dBSetOrder(1))
@ 22,01 clear to 22,78
if len(aCod) = 0
   Mens("NÆo Existem Baixas Cadastradas !!!",.t.,.t.)
else
   Janela := savescreen(05,04,19,76)
   @ 05,04 clear to 19,76
   @ 05,04 to 19,76
   @ 06,05 say padc("Baixas dos Lan‡amentos de Contas a Pagar e Receber",70)
   @ 07,04 say "Ã" + replicate("Ä",71) + "´"
   nOpcao := Achoice(08,06,18,74,aCod)
   restscreen(05,04,19,76,Janela)
   if nOpcao # 0
      clear typeahead
      Keyboard(Substr(aCod[nOpcao],1,8)+chr(13))
   endif
endif
set key -1 to l_bax()
restscreen(22,00,22,79,Linha22)
setcolor("bg+ /n,bg+ /n")
return nil
*****************************************************************************
* Fun‡Æo     : L_mov()                                                      *
* Objetivo   : Abre janela de Movimentos banc rios                          *
*****************************************************************************
FUNCTION L_Mov()
local Janela
local Linha22 := savescreen(22,00,22,79)
local nOpcao := 0
local aCod := {}
local hist := space(30)
local getlist := {}
setcolor("bg+ /n,n /w")
Set Key -1 to
mov->(dBSetOrder(2))
mov->(dBGoTop())
Do while mov->(!EOF())
  ban->(dbseek(str(mov->nconta,10,0)))
    if ban->(found())
      hist := ban->banco   
  else
     hist := "Conta nÆo encontrado !"
  endif
  aadd(aCod,str(mov->codmov,6,0) + " - " + hist + "   - " + dtoc(mov->dtamov) + " - " + str(mov->valor,12,2))
  mov->(dBSkip())
Enddo
mov->(dBSetOrder(1))
@ 22,01 clear to 22,78
if len(aCod) = 0
   Mens("NÆo Existem Movimentos Cadastrados !!!",.t.,.t.)
else
   Janela := savescreen(05,04,19,76)
   @ 05,04 clear to 19,76
   @ 05,04 to 19,76
   @ 06,05 say padc("Movimentos Banc rios",70)
   @ 07,04 say "Ã" + replicate("Ä",71) + "´"
   nOpcao := Achoice(08,06,18,74,aCod)
   restscreen(05,04,19,76,Janela)
   if nOpcao # 0
      clear typeahead
      Keyboard(Substr(aCod[nOpcao],1,6)+chr(13))
   endif
endif
Set key -1 to l_mov()
restscreen(22,00,22,79,Linha22)
setcolor("bg+ /n,bg+ /n")
Return nil
*****************************************************************************
* Fun‡Æo     : L_IMP()                                                      *
* Objetivo   : Abre janela com IMPRESSORAS Cadastradas                      *
*****************************************************************************
FUNCTION L_IMP()
local Janela
local Linha22 := savescreen(22,00,22,79)
local nOpcao := 0
local aCod := {}
local getlist := {}
setcolor("bg+ /n,n /w")
IMP->(dBSetOrder(2))
IMP->(dBGoTop())
Do while IMP->(!EOF())
   aadd(aCod,str(IMP->CODI_IMP,1,0) + "  -  " + IMP->NOME_IMP)
   IMP->(dBSkip())
Enddo
IMP->(dBSetOrder(1))
@ 22,01 clear to 22,78
if len(aCod) = 0
   Mens("NÆo Existem Impressoras Cadastradas !!!  <ENTER>:",.t.,.t.)
else
   Janela := savescreen(08,51,14,71)             
   @ 09,21 say padc("Impressoras",39)
   @ 22,01 say padc("Selecione a Impressora correta.",78) color("W+/n")
   nOpcao := Achoice(11,21,13,59,aCod)
   if nOpcao # 0
      clear typeahead
      imp->(dbseek(substr(acod[nopcao],1,1)))
   endif
endif
setcolor("bg+ /n,bg+ /n")
restscreen(22,00,22,79,Linha22)
Return nil
*****************************************************************************
