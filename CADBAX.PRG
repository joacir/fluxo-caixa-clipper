*****************************************************************************
* Funcao   : CADbax                                                         *
* Objetivo : Manuten‡Æo do Cadastro de Baixas                               *
* Autor    : Joacir Gon‡alves dos Santos                                    *
*****************************************************************************
FUNCTION CADbax()
Local  tipo, cliente, ndoc, valorpp
local  ndupl, npp, valorp, datap
Local  Tela, linha1, linha2
Private Getlist := {}
ABREabt()                             && Abre arquivo de lancamentos
abrecli()                             && Abre arquivo de clientes fornecedores
abrehis()                             && Abre arquivo de historicos
abrepag()                             && Abre arquivo de baixas
abreban()                             && Abre arquivo de contas
linha1 := savescreen(00,00,03,79)
linha2 := savescreen(21,00,24,79)
Setcolor ("bg+ /n,bg+ /n")
borda (03,00,21,79)
restscreen (00,00,03,79,linha1)
restscreen (21,00,24,79,linha2)
@ 02,41 say padc ("Baixas Diversos",38) color("w+/n")
Setcolor ("bg+ /n")
@ 05,08 clear to 18,71
@ 05,08 to 18,71
@ 06,10 say "N§ da duplicata....: "
@ 07,10 say "Cliente/Fornecedor.:  -"
@ 08,10 say "N§ do Documento....: "
@ 09,10 say "N§ de Parcelas.....: "
@ 10,10 say "C¢digo Hist¢rico...: "
@ 11,10 say "Data de EmissÆo....: "
@ 12,10 say "Data de Vencimento.: "
@ 13,10 say "Valor Total........: "
@ 14,10 say "Valor por Parcela..: "
@ 15,10 say "Parcelas pagas.....: "
@ 16,10 say "Valor pago.........: "
@ 17,10 say "Data do pagamento..: "
@ 22,01 clear to 22,78
@ 24,00 say padc("Esc-Sair  Enter-Confirma  F2-Consulta  F5-Altera  F6-Exclui  "+chr(024)+chr(025)+chr(027)+chr(026)+" -Movimenta",78) color ("w+ /b")
Tela := Savescreen(00,00,24,79)
Do while .t.
   Restscreen(00,00,24,79,Tela)
   set cursor on
   Set Confirm off
   ndupl  := 0
   valorpp:= 0.00
   pag->(dbgobottom())
   set key -1 to l_bax()
   ndupl := pag->ndupli + 1
   @ 06,31 get ndupl pict "99999999" valid ndupl > 0 && Entra com nduplicata  
   read
   set key -1 to
   if lastkey() = 27
      exit
   endif
   ban->(dbseek("         1"))                     && busca conta caixa
   if ban->(!found())
      mens("Conta do Caixa ainda nÆo foi criada !!",.t.,.t.)
      exit
   endif
   pag->(dbseek(str(ndupl,8,0)))
   if pag->(found())
     set cursor off
     @ 07,31 say substr(pag->clifor,7,1) + "-" + substr(pag->clifor,1,6)
     cli->(dbseek(pag->clifor))
     if cli->(found())
        @ 07,40 say cli->nome
     else
        @ 07,40 say "NÆo encontrado !"
     endif
     @ 08,31 say pag->nrodoc
     @ 09,31 say pag->npapag
     @ 10,31 say pag->codhis
     his->(dbseek(str(pag->codhis,4,0)))
     if his->(found())
        @ 10,40 say his->descri
     else
        @ 10,40 say "Hist¢rico nÆo encontrado !"
     endif
     @ 11,31 say pag->dtaabt
     @ 12,31 say pag->dtavcm
     @ 13,31 say transform(pag->valorap,"@e 999,999,999.99")
     valorpp := pag->valorap / pag->npapag
     @ 14,31 say transform(valorpp,"@e 999,999,999.99")
     @ 15,31 say pag->nppaga
     @ 16,31 say transform(pag->valorpg,"@e 999,999,999.99")
     @ 17,31 say pag->dtapag
     do while .t.
        Inkey(0)
        @ 22,01 clear to 22,78
        If lastkey() # 27 .and. lastkey() # 13 .and. Lastkey() # -4 .and. Lastkey() # -5
            Mens("Tecla Inv lida!!!",.t.,.t.)
            Loop
        Endif
        exit
     enddo
     if lastkey() = 27 .or. lastkey() = 13 
        loop
     endif
     Do Case
        case Lastkey() = -5           && ExclusÆo
           set cursor on
           If Confirma("ExclusÆo")
              if his->tipo = "D"
                  ban->salatu := ban->salatu + pag->valorpg
              else                                          && atualiza saldo
                  ban->salatu := ban->salatu - pag->valorpg
              endif
              abt->(dbseek(pag->clifor + pag->nrodoc))      && busca lancamento
              if abt->(found())
                 abt->nparce := abt->nparce +  pag->nppaga 
                 abt->valorap:= abt->valorap + pag->valorpg
              else
                 abt->(dbappend())                   && reinclui lancamento
                 abt->codcli  := pag->clifor
                 abt->nrodoc  := pag->nrodoc
                 abt->nparce  := pag->nppaga
                 abt->dtaabt  := pag->dtaabt
                 abt->valorap := pag->valorpg
                 abt->dtavcm  := pag->dtavcm
                 abt->codhis  := pag->codhis
              endif
              pag->(Dbdelete())                   && remove baixa
           Endif
           Loop
        case Lastkey() = -4           && Altera‡Æo
           set cursor on
           npp := 1
           datap := date()
           @ 15,31 get npp pict "99" valid npp > 0 .and. npp <= pag->npapag
           read
           if lastkey() = 27
              loop
           endif
           valorp := valorpp * npp
           @ 16,31 get valorp pict "@E 999,999,999.99"
           @ 17,31 get datap  valid datap >= abt->dtaabt
           read
           if lastkey() = 27
              loop
           endif
           If Confirma("Altera‡Æo")
              abt->(dbseek(pag->clifor + pag->nrodoc))   && busca lancamento
              if his->tipo = "D"
                 ban->salatu := ban->salatu + pag->valorpg
                 ban->salatu := ban->salatu - valorp
                 abt->valorap:= abt->valorap + pag->valorpg
                 abt->valorap:= abt->valorap - valorp
              else
                 ban->salatu := ban->salatu - pag->valorpg
                 ban->salatu := ban->salatu + valorp
                 abt->valorap:= abt->valorap - pag->valorpg
                 abt->valorap:= abt->valorap + valorp
              endif
              abt->nparce  := abt->nparce + pag->nppaga
              abt->nparce  := abt->nparce - npp
              if abt->nparce = 0
                 abt->(dbdelete())
              endif
              pag->nppaga  := npp
              pag->dtapag  := datap
              pag->valorpg := valorp
           Endif
     Endcase
   else
     cliente:= 0
     ndoc   := 0
     tipo   := space(1)
     l_lan()                                             && Mostra lanc/tos
     if lastkey() = 27
        loop
     endif
     @ 07,31 get tipo pict "!"                           && Entra com tipo
     read
     set key -1 to
     set confirm on
     @ 07,33 get cliente pict "999999" valid cliente > 0 && entra com cli/for
     @ 08,31 get ndoc pict "99999999" valid ndoc > 0     && entra com n§ docto 
     read
     cli->(dbseek(str(cliente,6,0)+tipo))
     @ 07,40 say cli->nome
     abt->(dBSeek(str(cliente,6,0)+tipo+str(ndoc,8,0)))
     if abt->(!Found())
        loop
     endif
     @ 09,31 say abt->nparce
     @ 10,31 say abt->codhis
     his->(dbseek(str(abt->codhis,4,0)))
     if his->(found())
        @ 10,40 say his->descri
     else
        @ 10,40 say "Hist¢rico nÆo encontrado !"
     endif
     @ 11,31 say abt->dtaabt
     @ 12,31 say abt->dtavcm
     @ 13,31 say transform(abt->valorap,"@e 999,999,999.99")
     valorpp := abt->valorap / abt->nparce
     @ 14,31 say transform(valorpp,"@e 999,999,999.99")
     set cursor on
     npp := 1
     datap := date()
     @ 15,31 get npp pict "99" valid npp > 0 .and. npp <= abt->nparce
     read
     if lastkey() = 27
       loop
     endif
     valorp := valorpp * npp
     @ 16,31 get valorp pict "@E 999,999,999.99"
     @ 17,31 get datap  valid datap >= abt->dtaabt
     read
     if lastkey() = 27
        loop
     endif
     If Confirma("InclusÆo")
        pag->(dbappend())
        pag->ndupli  := ndupl
        pag->nrodoc  := str(ndoc,8,0)
        pag->clifor  := str(cliente,6,0) + tipo
        pag->nppaga  := npp
        pag->npapag  := abt->nparce
        pag->dtapag  := datap
        pag->valorpg := valorp
        pag->valorap := abt->valorap
        pag->dtaabt  := abt->dtaabt
        pag->dtavcm  := abt->dtavcm
        pag->codhis  := abt->codhis
        if his->tipo = "D"
            ban->salatu := ban->salatu - valorp         && decrementa saldo
        else
            ban->salatu := ban->salatu + valorp         && incrementa saldo
        endif
        if abt->nparce - npp = 0
           abt->(dbdelete())                            && apaga lancamento
        else
           abt->nparce  := abt->nparce - npp            && decrementa parcela
           abt->valorap := abt->valorap - valorp        && decrementa valor
        endif
     Endif
   endif
Enddo
Dbcloseall()
set cursor off
Return Nil   
                                     
