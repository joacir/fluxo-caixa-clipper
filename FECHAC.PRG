*****************************************************************************
* Funcao   : fechac()                                                       *
* Objetivo : Fechamento de Caixa                                            *
*****************************************************************************
Function Fechac()
local nPagina, linha1, linha2, data1, data2, tela, entra, saida
local tipo, total
private getlist := {}
abreimp()
abrehis()
abremov()
abrepag()
abrecli()
abreban()
linha1 := savescreen(00,00,03,79)
linha2 := savescreen(21,00,24,79)
Setcolor ("bg+ /n,bg+ /n")
borda (03,00,21,79)
restscreen (00,00,03,79,linha1)
restscreen (21,00,24,79,linha2)
@ 02,41 say padc ("Fechamento de Caixa",38) color("w+/n")
Setcolor ("bg+ /n")
Set Cursor On
@ 08,20 clear to 14,60                                     && Tela
@ 08,20 to 14,60
@ 09,21 say padc("Fechamento de Caixa",39)
@ 10,20 say "Ã" + replicate("Ä",39) + "´"
@ 12,22 say "Data Inicio.: "
@ 13,22 say "Data Final..: "
tela := savescreen(03,10,14,50)
L_IMP()
if Lastkey() = 27 .or. lastkey() = 19 .or. lastkey() = 4
  dBCloseall()
  Return Nil
endif
do while .t.
    restscreen(03,10,14,50,tela)
    @ 22,01 say padc("Entre com o Per¡odo de Datas para o Fechamento.",78) color('w+/n')
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
   PAG->(dbsetorder(2))
   pag->(dBGoTop())
   tipo := "C"
   Do while pag->(!eof()) 
      @ 01,00  say repl("=",80)                            && cabecalho
      @ 02,00  say padc("Fechamento de Caixa",80)
      @ 03,00  say padc("Periodo : " + dtoc(data1) + " a " + dtoc(data2) + "        As : " + time(), 80)
      @ 04,00  say repl("=",80)
      if tipo = "C"
        @ 06,02  say "ENTRADAS ; "
      else
        @ 06,02  say "SAIDAS ;"
      endif
      @ 07,00  say IMP->COMPACTA
      @ 08,02  say "DUPLICATA     _____CLIENTE/FORNECEDOR______     ___________HISTORICO__________     ___DATA___     _____VALOR____"
      ?
      do while pag->(!eof()) .and. prow() < 53             && detalhe
        his->(dbseek(str(pag->codhis,4,0)))                && busca historico
        if his->(found())
          if his->tipo = tipo
            if pag->dtapag >= data1 .and. pag->dtapag <= data2 &&testa periodo
              @ prow()+1,03  say pag->ndupli pict "99999999"
              cli->(dBSeek(pag->clifor))                   && busca cliente
              if cli->(!Found())
                 @ prow(),16 say "NAO ENCONTRADO !!!"
              else
                 @ prow(),16 say  cli->NOME
              endif
              @ prow(),50 say his->descri
              @ prow(),85 say dtoc(pag->dtapag)
              @ prow(),100 say transform(pag->valorpg,"@E 999,999,999.99")
              if tipo = "C"
                 entra := entra + pag->valorpg             && soma entrada
              else
                 saida := saida + pag->valorpg             && soma saida
              endif
            endif
          endif
        endif
        pag->(dBSkip())
        if pag->(eof()) .and. tipo = "C"                     && muda de entrada
           pag->(dbgotop())                                  && para saida
           tipo := "D"                                       && vai para o comeco
           ?                                                 && do arquivo
           ?
           @ prow(), 85 say "Sub total ==>"                  && mostra subtotal
           @ prow(),100 say transform(entra,"@E 999,999,999.99")
           ?
           @ prow(), 00 say imp->normal
           ?
           @ prow(), 02 say "SAIDAS ;"
           ?
           @ prow(), 00 say imp->compacta
           ?
        endif
        if pag->(eof()) .and. tipo = "D"
           ?
           ?
           @ prow(), 85 say "Sub total ==>"                 && mostra subtotal
           @ prow(),100 say transform(saida,"@E 999,999,999.99")
        endif
      Enddo
      total := entra - saida                               && calcula saldo
      ban->(dbseek("         1"))                          && busca conta caixa
      @ 54,00 say IMP->NORMAL
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
return nil
