*****************************************************************************
* Funcao   : lancac()                                                       *
* Objetivo : Lan‡amentos de Contas a Pagar ou Receber                       *
*****************************************************************************
Function Lancac()
local nPagina, linha1, linha2, data1, data2, tela, entra, saida
local total, totreg:=0
private getlist := {}
abreimp()
abrehis()
abreabt()
abrecli()
abreban()
linha1 := savescreen(00,00,03,79)
linha2 := savescreen(21,00,24,79)
Setcolor ("bg+ /n,bg+ /n")
borda (03,00,21,79)
restscreen (00,00,03,79,linha1)
restscreen (21,00,24,79,linha2)
@ 02,41 say padc ("Relat¢rio de Lan‡amentos de Contas",38) color("w+/n")
Setcolor ("bg+ /n")
Set Cursor On
@ 08,20 clear to 14,60                                     && Tela
@ 08,20 to 14,60
@ 09,21 say padc("Relat¢rio de Lan‡amentos de Contas",39)
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
    @ 22,01 say padc("Entre com o Per¡odo de Datas para os Lan‡amentos.",78) color('w+/n')
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
       total := entra - saida                               && calcula saldo
      ban->(dbseek("         1"))                          && busca conta caixa
      @ 53,00 say IMP->NORMAL
      @ 54,51 say "TOTAL DE REGISTROS = "+ strzero(totreg,2,0)
      @ 55,00 say Replicate("=",80)                        && imprime rodap‚
      @ 56,01 say "Total a Receber= "
      @ 56,18 say transform(entra,"@E 999,999,999.99")
      @ 56,51 say "Saldo       = "
      @ 56,66 say transform(total,"@E 999,999,999.99")
      @ 57,01 say "Total a Pagar  = "
      @ 57,18 say transform(saida,"@E 999,999,999.99")
      @ 57,51 say "Saldo Caixa = "
      @ 57,66 say transform(ban->salatu,"@E 999,999,999.99")
      @ 58,01 say "EMISSAO : " + dtoc(Date())
      npagina++
      @ 58,69 say "PAGINA : "+ strzero(npagina,2,0)
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
