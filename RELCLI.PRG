*****************************************************************************
* Funcao   : relcli                                                     *
* Objetivo : Fornecedores                                               *
*****************************************************************************
Function relcli(tipo)
local nPagina, linha1, linha2, opcao, tela, ncodigo, cnome, relnome, total:=0 
private getlist := {}
abrecli()
abreimp()
setcolor("bg+ /n,n /w")
linha1 := savescreen(00,00,03,79)
linha2 := savescreen(21,00,24,79)
borda (03,00,21,79)
restscreen (00,00,03,79,linha1)
restscreen (21,00,24,79,linha2)
if tipo = "F"
  relnome := "Fornecedores"
else
  relnome := "Clientes"
endif
@ 02,41 say padc ("Relat¢rio de " + relnome,38) color("w+/n")
Set Cursor On
set confirm on
@ 08,20 clear to 14,60
@ 08,20 to 14,60
@ 09,21 say padc("Rela‡Æo de " + relnome,39)
@ 10,20 say "Ã" + replicate("Ä",39) + "´"
tela := savescreen(08,20,14,60)
L_IMP()
if Lastkey() = 27 .or. lastkey() = 19 .or. lastkey() = 4
  dBCloseall()
  Return Nil
endif
opcao := 0
do while .t.
    Setcolor ("bg+ /n,n /w")
    restscreen(08,20,14,60,tela)
    @ 22,01 say padc("Entre com a ordem dos " + relnome,78) color('w+/n')
    @ 12,22 prompt "             Por C¢digo              "
    @ 13,22 prompt "              Por Nome               "
    menu to opcao
    if opcao = 1
       cli->(dbsetorder(1))
    else
       cli->(dbsetorder(2))
    endif
    @ 22,01 clear to 22,78
    if Lastkey() = 27
       dBCloseall()
       Return Nil
    endif
    if confirma("ImpressÆo")
        exit
    endif
    loop
enddo
Do While .t.
   if lastkey() = 27
      exit
   endif
   if !Isprinter()
      Mens("Impressora Desligada ou Desconectada... Verifique!!!",.t.,.t.)
      loop
   endif
   @ 22,02 say " Aguarde Emissao...."
   set print on
   set devi to printer
*  set print to arq.txt
   npagina:=0
   cli->(dBGoTop())
   Do while cli->(!eof())
      @ 01,00  say repl("=",80)
      @ 02,00  say padc("Cadastro de " + relnome,80)
      @ 03,00  say repl("=",80)
      @ 04,00  say IMP->COMPACTA
      @ 05,02  say "CODIGO    _____________NOME_____________    ____RG_____    _INSCRICAO"
      @ 05,74  say "__________ENDERECO____________    _______CIDADE_______    _____TELEFONE____"
      ?
      do while cli->(!eof()) .and. prow() < 55
         if cli->tIpocf = tipo
           @ prow()+1,02 say cli->codigo pict "999999"
           @ prow(),12 say cli->NOME
           @ prow(),46 say cli->rg
           @ prow(),61 say dtoc(cli->dtains)
           @ prow(),74 say cli->ender
           @ prow(),108 say cli->cidade
           @ prow(),132 say cli->fone
           total++
         endif
         cli->(dBSkip())
      Enddo
      @ 55,00 say IMP->NORMAL
      @ 56,51 say "TOTAL DE REGISTROS = "+ STRZERO(TOTAL,2,0)
      @ 57,00 say Replicate("=",80)
      @ 58,01 say "EMISSAO : " + dtoc(Date())
      nPagina++
      @ 58,69 say "PAGINA : "+ strzero(nPagina,2,0)
      @ 59,00 say Replicate("=",80)
   Enddo
   eject
   set print off
   set devi to screen
   exit
Enddo
Set Cursor Off
dbcloseall()
return nil


