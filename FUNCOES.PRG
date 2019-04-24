*****************************************************************************
* Fun‡Æo     : DIVERSAS                                                     *
* Objetivo   : Fun‡äes gen‚ricas utilizadas no Sistema Biblioteca           *
* Autor      : Lurdinha                                                     *
* Data       : 21/08/98                                                     *
*****************************************************************************
* Funcao   : BORDA()                                                        *
* Objetivo : Desenhar tela usando a funcao BOX                              *
*****************************************************************************
FUNCTION BORDA(LIN1,COL1,LIN2,COL2)
LOCAL BORDA
BORDA:=CHR(201)+CHR(205)+CHR(187)+CHR(186)+CHR(188)+CHR(205)+CHR(200)+CHR(186)+CHR(177)
@ LIN1,COL1 CLEAR TO LIN2,COL2
@ LIN1,COL1,LIN2,COL2 BOX BORDA
RETURN .T.
*****************************************************************************
* Funcao   : BORDAM()                                                       *
* Objetivo : Desenhar miolo da tela utilizando a funcao BOX                 *
*****************************************************************************
FUNCTION BORDAM(LIN1,COL1,LIN2,COL2)
LOCAL BORDAM
BORDAM:=CHR(201)+CHR(205)+CHR(187)+CHR(186)+CHR(185)+CHR(205)+CHR(204)+CHR(186)
@ LIN1,COL1 CLEAR TO LIN2,COL2
@ LIN1,COL1,LIN2,COL2 BOX BORDAM
RETURN .T.
*****************************************************************************
* Funcao   : QUADRO                                                         *
* Objetivo : Desenha quadro com sombra - calculadora e calend rio           *
*****************************************************************************
FUNCTION QUADRO(ls, cs, li, ci)
LOCAL  wCor := SETCOLOR(), lin, col, I

col := savescreen(ls+1,ci+1,li+1,ci+1)
lin := savescreen(li+1,cs+1,li+1,ci+1)
FOR i = 2 to len(col) step 2
    col := stuff(col,i,1,chr(08))
NEXT
FOR i = 2 to len(lin) step 2
   lin := stuff(lin,i,1,chr(08))
NEXT
restscreen(ls+1,ci+1,li+1,ci+1,col)
restscreen(li+1,cs+1,li+1,ci+1,lin)
@ ls,cs clear to li,ci
@ ls,cs to li,ci
RETURN NIL
*****************************************************************************
* Fun‡Æo     : CONFIRMA                                                     *
* Objetivo   : Confirma‡Æo de Perguntas com resposta S/N                    *
* Parƒmetros : Perg   = Pergunta para confirma‡Æo      (default = space(01) *
* Retorna    : .T. (Resp = "S")   ou   .F. (Resp = "N")                     *
*****************************************************************************
FUNCTION CONFIRMA(Perg)
*
Local Resp     && recebe a Resposta (S/N)
Local Linha22 && guarda o conte£do da linha de mensagem para recuper -la
Local Getlist := {}
*
* Verifica se o parƒmetro foi definido
if Perg = nil
   Perg = space(01)
endif
Linha22 := savescreen(22,00,22,79)
Resp    := space(01)
*
beep("AVISO")
@ 22,01 clear to 22,78
@ 22,02 say "Confirma " + Perg + " ? "
   setcolor("bg+ /n,n /w")
   @ 22,23 prompt "Sim"
   @ 22,26 prompt "Nao"
   menu to resp
   setcolor("bg+ /n,bg+ /n")
Restscreen(22,01,22,78,Linha22)
if Resp = 1
   Return .T.
endif
Return .F.
*****************************************************************************
* Fun‡Æo     : MENS                                                         *
* Objetivo   : Emitir mensagens no V¡deo                                    *
* Parƒmetros : Mensa  = Mensagem a ser emitida         (default= space(80)) *
*              Centra = Se mensagem centralizada= .T.  (default= .F.)       *
*              Bell   = Se emite aviso sonoro   = .T.  (default= .F.)       *
*****************************************************************************
FUNCTION MENS(Mensa,Centra,Bell)
*
Local Linha22  && guarda o conte£do da linha de mensagem para recuper -la
*
* Verifica se todos os parƒmetros foram definidos
set cursor off
if Mensa = nil
   Return .F.
endif
if Centra = nil
   Centra = .F.
endif
if Bell = nil
   Bell = .F.
endif
Linha22 := savescreen(22,00,22,79)
*
@ 22,01 clear to 22,78
if Bell
   Tone(200,2)
endif
if Centra
   @ 22,01 say padc(Mensa,78)
else
   @ 22,02 say Mensa
endif
Inkey(0)
Restscreen(22,00,22,79,Linha22)
set cursor on
Return .t.
*****************************************************************************

