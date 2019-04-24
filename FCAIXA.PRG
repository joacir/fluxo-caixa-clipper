**************************************************************************
* Sistema de Fluxo de Caixa    -    Menu principal                       *
* Unimar  -  5§ termo B                                                  *
* Joacir                                                                 *
**************************************************************************
function fcaixa()

Local  OPCAO := 0, TELA
Private GETLIST := {}

Set TALK OFF
Set SCOREBOARD OFF
Set BELL OFF
Set DELETED ON
Set WRAP ON
set century on
Set DATE BRITISH
Set INTENSITY ON
Set SAFETY OFF
Set CONSOLE OFF
Set MESSAGE TO 22 CENTER
clear
Set CURSOR OFF
setcolor("w+/b")
@ 00,00 clear to 00,79
@ 00,01 say DATE()
@ 00,58 say "Anonymous Inform tica"
@ 24,00 clear to 24,79
@ 24,00 say padc("Esc - Sair    Enter - Confirma   "+chr(024)+chr(025)+chr(027)+chr(026)+" - Movimenta",78)
setcolor("bg+ /n")
borda(03,00,21,79)
@ 01,00,03,39 box('É'+'Í'+'Ë'+'º'+'Ê'+'Í'+'Ì'+'º')
@ 01,39,03,79 box('Ë'+'Í'+'»'+'º'+'¹'+'Í'+'Ê'+'º')
@ 21,00,23,79 box('Ì'+'Í'+'¹'+'º'+'¼'+'Í'+'È'+'º')
@ 05,10 to 07,70
@ 06,11 clear to 06,69
@ 02,01 say padc("Sistema de Fluxo de Caixa",38) color ("w+ /n")
@ 02,41 say padc("Seletor Principal",38)    color("w+/n")
TELA := Savescreen(01,00,24,79)
menu()
Do while .t.
   Restscreen(01,00,24,79,TELA)
   setcolor("w+/n,n/w")
   @ 06,14 prompt "Cadastro"      message "Manuten‡Æo de Cadastros"
   @ 06,27 prompt "Movimento"     message "Lan‡amento de Contas a Pagar, a Receber e Banco"
   @ 06,41 prompt "Relat¢rios"    message "EmissÆo de Relat¢rios Diversos"
   @ 06,56 prompt "Utilit rios"   message "Utilit rios do Sistema"
   menu to opcao
   Do Case
      case lastkey() = 27
           if sair()
              exit
           endif
      Case OPCAO = 1
           cadastro()
      Case OPCAO = 2
           movimen()
      Case OPCAO = 3
           relator()
      Case OPCAO = 4
           Util()
  Endcase
Enddo
dBCloseall()
Set COLOR TO
clear
Return Nil
*****************************************************************************
* Funcao   : UTIL()                                                         *
* Objetivo : Seletor do M¢dulo de Utilit rios                               *
*****************************************************************************
FUNCTION UTIL()
LOCAL  OPCAO := 0, TELA
Private GETLIST := {}
@ 22,01 clear to 22,78
@ 02,41 SAY PADC("Utilit rios do Sistema",38) color("w+/n")
@ 07,54,11,68 box('Â'+'Ä'+'Â'+'³'+'Ù'+'Ä'+'À'+'³')  color("bg+/n")
TELA := savescreen(01,00,24,79)
Do while .t.
   set key 4 to sair4()
   set key 19 to sair19()
   restscreen(01,00,24,79,TELA)
   setcolor("w+/n,n/w")
   @ 08,55 prompt " Organiza‡Æo " message "Organiza‡Æo de Arquivos do Sistema"
   @ 09,55 prompt " Calend rio  " message "Calend rio Mensal"
   @ 10,55 prompt " Calculadora " message "Calculadora"
   Menu to OPCAO
   set key 4 to 
   set key 19 to 
   Do Case
      Case Lastkey() = 27
           Exit
      Case OPCAO = 1
           organiz()
      Case OPCAO = 2
           CALEND()
      Case OPCAO = 3
           CALCUL()
   Endcase
Enddo
Return Nil
*****************************************************************************
* Funcao   : cadastro()                                                     *
* Objetivo : Seletor do M¢dulo de Cadastros                                 *
*****************************************************************************
FUNCTION cadastro()
LOCAL  OPCAO := 0, TELA
Private GETLIST := {}
@ 22,01 clear to 22,78
@ 02,41 SAY PADC("Cadastros Diversos",38) color("w+/n")
@ 07,12,12,27 box('Â'+'Ä'+'Â'+'³'+'Ù'+'Ä'+'À'+'³')  color("bg+/n")
TELA := savescreen(01,00,24,79)
Do while .t.
   set key 4 to sair4()
   set key 19 to sair19()
   restscreen(01,00,24,79,TELA)
   setcolor("w+/n,n/w")
   @ 08,13 prompt " Contas       " message "Manuten‡Æo do Cadastro de Contas"
   @ 09,13 prompt " Clientes     " message "Manuten‡Æo do Cadastro de Clientes"
   @ 10,13 prompt " Fornecedores " message "Manuten‡Æo do Cadastro de Fornecedores"
   @ 11,13 prompt " Hist¢ricos   " message "Manuten‡Æo do Cadastro de Hist¢ricos"
   Menu to OPCAO
   set key 4 to
   set key 19 to
   Do Case
      Case Lastkey() = 27
           exit
      Case OPCAO = 1
           cadban()
      Case OPCAO = 2
           CADCLI("C")
      Case OPCAO = 3
           CADCLI("F")
      Case Opcao = 4
           CADHIS()
   Endcase
Enddo
Return Nil
*****************************************************************************
* Funcao   : movimen()                                                      *
* Objetivo : Seletor do M¢dulo de Movimentos                                *
*****************************************************************************
FUNCTION movimen()
LOCAL  OPCAO := 0, TELA
Private GETLIST := {}
@ 22,01 clear to 22,78
@ 02,41 SAY PADC("Movimentos Diversos",38) color("w+/n")
@ 07,25,11,39 box('Â'+'Ä'+'Â'+'³'+'Ù'+'Ä'+'À'+'³')  color("bg+/n")
TELA := savescreen(01,00,24,79)
Do while .t.
   set key 4 to sair4()
   set key 19 to sair19()
   restscreen(01,00,24,79,TELA)
   setcolor("w+/n,n/w")
   @ 08,26 prompt " Banc rio    " message "Movimento de conta Banc ria"
   @ 09,26 prompt " Baixas      " message "Baixas nos Lan‡amentos de Contas a Pagar ou Receber"
   @ 10,26 prompt " Lan‡amentos " message "Lan‡amentos de Contas a Pagar ou Receber"
   Menu to OPCAO
   set key 4 to
   set key 19 to
   Do Case
      Case Lastkey() = 27
           exit
      Case OPCAO = 1
           cadmov()
      Case OPCAO = 2
           cadbax()
      Case OPCAO = 3
           cadlan()
   Endcase
Enddo
Return Nil
*****************************************************************************
* Funcao   : relator()                                                      *
* Objetivo : Seletor do M¢dulo de Relatorios                                *
*****************************************************************************
FUNCTION relator()
LOCAL  OPCAO := 0, TELA
Private GETLIST := {}
@ 22,01 clear to 22,78
@ 02,41 SAY PADC("Relat¢rios Diversos",38) color("w+/n")
@ 07,39,13,54 box('Â'+'Ä'+'Â'+'³'+'Ù'+'Ä'+'À'+'³')  color("bg+/n")
TELA := savescreen(01,00,24,79)
Do while .t.
   set key 4 to sair4()
   set key 19 to sair19()
   restscreen(01,00,24,79,TELA)
   setcolor("w+/n,n/w")
   @ 08,40 prompt " Fechamento   " message "Fechamento de Caixa por Per¡odo"
   @ 09,40 prompt " Clientes     " message "Relat¢rio de Clientes"
   @ 10,40 prompt " Fornecedores " message "Relat¢rio de Fornecedores"
   @ 11,40 prompt " Lan‡amentos  " message "Relat¢rio de Lan‡amentos de Contas a Pagar ou Receber"
   @ 12,40 prompt " Mov. Banc rio" message "Relat¢rio de Movimento banc rio"
   Menu to OPCAO
   set key 4 to 
   set key 19 to 
   Do Case
      Case Lastkey() = 27
           exit
      Case OPCAO = 1
           fechac()
      Case OPCAO = 2
           relcli("C")
      Case OPCAO = 3
           relcli("F")
      Case opcao = 4
           lancac()
      Case opcao = 5
           relmov()
   Endcase
Enddo
Return Nil
******************************************************************************
Function sair19()    && anda com a setinha para a esquerda
******************************************************************************
      set key 4 to
      set key 19 to
      clear typeahead
      Keyboard chr(27) + chr(19) + chr(13)
return nil
******************************************************************************
Function sair4()      && Anda com a setinha para a direita
******************************************************************************
      set key 4 to
      set key 19 to
      clear typeahead
      Keyboard chr(27) + chr(4) + chr(13)
return nil
******************************************************************************
Function sair()      && Abre janela e pergunta se deseja abandonar programa
******************************************************************************
Local Resp
Resp    := space(01)
setcolor("bg+ /n,n /w")
@ 10,25 to 15,55
@ 11,26 clear to 14,54
@ 12,26 say padc("Deseja sair do Programa ?",29)
@ 13,36 prompt "Sim"        
@ 13,40 prompt "Nao"
menu to resp
setcolor("bg+ /n,bg+ /n")
if Resp = 1
   Return .T.
endif
Return .F.
******************************************************************************    
