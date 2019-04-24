*****************************************************************************
* Funcao   : RelMov()                                                       *
* Objetivo : Relatorio de movimento bancario                                *
*****************************************************************************
Function Relmov()
local nPagina, linha1, linha2, data1, data2, tela, entra, saida
local total, totreg:=0
private getlist := {}
abreimp()
abrehis()
abremov()
abreban()
linha1 := savescreen(00,00,03,79)
linha2 := savescreen(21,00,24,79)
Setcolor ("bg+ /n,bg+ /n")
borda (03,00,21,79)
restscreen (00,00,03,79,linha1)
restscreen (21,00,24,79,linha2)
@ 02,41 say padc ("Relat¢rio de Movimento Banc rio",38) color("w+/n")
Setcolor ("bg+ /n")
Set Cursor On
@ 08,20 clear to 14,60                                     && Tela
@ 08,20 to 14,60
@ 09,21 say padc("Relat¢rio de Movimento Banc rio",39)
@ 10,20 say "Ã" + replicate("Ä",39) + "´"
@ 12,22 say "Data Inicio.: "
@ 13,22 say "Data Final..: "
tela := savescreen(03,20,14,60)
L_IMP()
if Lastkey() = 27 .or. lastkey() = 19 .or. lastkey() = 4
  dBCloseall()
  Return Nil
endif
do while .t.
    restscreen(03,20,14,60,tela)
    @ 22,01 say padc("Entre com o Per¡odo de Datas do Movimento Banc rio.",78) color('w+/n')
    data1 := ctod("  /  /    ")                            && entra com data
    data2 := ctod("  /  /    ")                            && entra com data
    @ 12,36 get data1 valid !empty(data1)
    @ 13,36 get data2 valid !empty(data2)
    read
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
   set print on                                            && ativa impressora
   set devi to printer
*  set print to arq.txt
   npagina:=0
   entra := 0
   saida := 0
   mov->(dbsetorder(2))
   mov->(dBGoTop())
   Do while mov->(!eof())
      @ 01,00  say repl("=",80)                            && cabecalho
      @ 02,00  say padc("Relat¢rio de Movimento Bancario",80)
      @ 03,00  say padc("Periodo : " + dtoc(data1) + " a " + dtoc(data2) + "        As : " + time(), 80)
      @ 04,00  say repl("=",80)
      @ 05,00  say IMP->COMPACTA
      @ 06,02  say "CODIGO    __NUMERO__    ____________CONTA_____________    __________HISTORICO___________    ___DATA___    _____VALOR____"
      ?
      do while mov->(!eof()) .and. prow() < 53             && detalhe
        if mov->dtamov >= data1 .and. mov->dtamov <= data2 &&testa periodo
          @ prow()+1,02 say mov->codmov
          @ prow(), 12  say mov->nconta
          ban->(dBSeek(str(mov->nconta,10,0)))             
          if ban->(!Found())
            @ prow(),26 say "NAO ENCONTRADO !!!"
          else
            @ prow(),26 say ban->BANCO
          endif
          his->(dBSeek(str(mov->codhis,4,0)))             
          if his->(!Found())
            @ prow(),60 say "NAO ENCONTRADO !!!"
          else
            @ prow(),60 say his->descri
          endif
          @ prow(),94 say dtoc(mov->dtamov)
          if his->tipo = "D"
             @ prow(),107 say "-"
             saida := saida + mov->valor             && soma saida
          endif
          if his->tipo = "C"
             @ prow(),107 say "+"
             entra := entra + mov->valor             && soma entrada
          endif
          @ prow(),108 say transform(mov->valor,"@E 999,999,999.99")
          totreg++
        endif
        mov->(dBSkip())
      Enddo
      total := entra - saida                               && calcula saldo
      ban->(dbseek("         1"))                          && busca conta caixa
      @ 53,00 say IMP->NORMAL
      @ 54,51 say "TOTAL DE REGISTROS = " + STRZERO(TOTREG,2,0)
      @ 55,00 say Replicate("=",80)                        && imprime rodap‚
      @ 56,01 say "Total Entradas = "
      @ 56,18 say transform(entra,"@E 999,999,999.99")
      @ 56,51 say "Saldo       = "
      @ 56,66 say transform(total,"@E 999,999,999.99")
      @ 57,01 say "Total Saidas   = "
      @ 57,18 say transform(saida,"@E 999,999,999.99")
      @ 57,51 say "Saldo Caixa = "
      @ 57,66 say transform(ban->salatu,"@E 999,999,999.99")
      @ 58,01 say "EMISSAO : " + dtoc(Date())
      nPagina++
      @ 58,69 say "PAGINA : "+ strzero(nPagina,2,0)
      @ 59,00 say Replicate("=",80)
   Enddo
   eject
   set print off                                           && desativa
   set devi to screen                                      && impressora
   exit
Enddo
Set Cursor Off
dbcloseall()
return nil
