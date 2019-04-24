*****************************************************************************
* Funcao   : CADlan                                                         *
* Objetivo : Manuten‡Æo do Cadastro de Lancamentos                          *
*****************************************************************************
FUNCTION CADlan()
*
Local  tipo, cliente, ndoc, part, dta1, valor, dta2, historico, valorpp
Local  Tela, linha1, linha2
Private Getlist := {}
ABREabt()
abrecli()
abrehis()
linha1 := savescreen(00,00,03,79)
linha2 := savescreen(21,00,24,79)
Setcolor ("bg+ /n,bg+ /n")
borda (03,00,21,79)
restscreen (00,00,03,79,linha1)
restscreen (21,00,24,79,linha2)
@ 02,41 say padc ("Lan‡amentos Diversos",38) color("w+/n")
Setcolor ("bg+ /n")
@ 08,08 clear to 17,71
@ 08,08 to 17,71
@ 09,10 say "Cliente/Fornecedor.: "
@ 10,10 say "N§ do Documento....: "
@ 11,10 say "N§ de Parcelas.....: "
@ 12,10 say "C¢digo Hist¢rico...: "
@ 13,10 say "Data de EmissÆo....: "
@ 14,10 say "Data de Vencimento.: "
@ 15,10 say "Valor Total........: "
@ 16,10 say "Valor por Parcela..: "
@ 22,01 clear to 22,78
@ 24,00 say padc("Esc-Sair  Enter-Confirma  F2-Consulta  F5-Altera  F6-Exclui  "+chr(024)+chr(025)+chr(027)+chr(026)+" -Movimenta",78) color ("w+ /b")
Tela := Savescreen(00,00,24,79)
Do while .t.
   Restscreen(00,00,24,79,Tela)
   linha1 := savescreen(22,00,22,79)
   set cursor on
   Set Confirm off
   abt->(dBGoBottom())
   valorpp := 0.00
   cliente:= 0
   ndoc   := 0
   tipo   := space(1)
   set key -1 to l_lan()
   @ 09,31 get tipo pict "!" valid tipo $('FC')   && Entra com tipo
   @ 22,01 say padc("Entre com <F> para Fornecedor ou <C> para Cliente",78)
   read
   set confirm on
   set key -1 to
   if lastkey() = 27
     exit
   endif
   restscreen(22,00,22,79,linha1)
   @ 09,32 say "-"
   if tipo = "F"
      set key -1 to l_for()
   else
      set key -1 to l_cli()
   endif
   set confirm on                                 && Entra com Cli/For
   @ 09,33 get cliente pict "999999" valid cliente > 0
   read
   set key -1 to
   cli->(dbseek(str(cliente,6,0)+tipo))
   if cli->(found())
     @ 09,40 say cli->nome
   else
      mens("Cliente ou Fornecedor nÆo cadastrado. Tente outro !",.t.,.t.)
      loop
   endif
   if lastkey() = 27
     loop
   endif
   @ 10,31 get ndoc pict "99999999" valid ndoc > 0  && entra com n§ documento 
   read
   if lastkey() = 27
     loop
   endif
   set confirm off
   abt->(dBSeek(str(cliente,6,0)+tipo+str(ndoc,8,0)))
   if abt->(found())
     set cursor off
     @ 11,31 say abt->nparce
     @ 12,31 say abt->codhis
     his->(dbseek(str(abt->codhis,4,0)))
     if his->(found())
        @ 12,40 say his->descri
     else
        @ 12,40 say "Hist¢rico nÆo encontrado !"
     endif
     @ 13,31 say abt->dtaabt
     @ 14,31 say abt->dtavcm
     @ 15,31 say transform(abt->valorap,"@e 999,999,999.99")
     valorpp := abt->valorap / abt->nparce
     @ 16,31 say transform(valorpp,"@e 999,999,999.99")
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
     Do case
         case Lastkey() = -5           && ExclusÆo
              set cursor on
              If Confirma("ExclusÆo")
                 abt->(Dbdelete())
              Endif
              Loop
         case Lastkey() = -4           && Altera‡Æo
              set cursor on
              dta1    := abt->dtaabt
              dta2    := abt->dtavcm
              valor   := abt->valorap
              part    := abt->nparce
              @ 11,31 get part pict "99" valid part > 0  && entra com parcelas
              read
              set key -1 to l_his()
              do while .t.
                historico := abt->codhis              && consistencia para historico
                @ 12,31 get historico pict "9999" valid historico > 0
                read
                if lastkey() = 27
                   exit
                endif
                his->(dbseek(str(historico,4,0)))
                if his->(found())
                   @ 12,40 say his->descri
                   set key -1 to
                   exit
                else
                   mens("Hist¢rico nÆo cadastrado. Tente outro !",.t.,.t.)
                   loop
                endif
              enddo
              if lastkey() = 27
                loop
              endif
              @ 13,31 get dta1
              @ 14,31 get dta2  valid dta2 >= dta1
              @ 15,31 get valor pict "@e 999,999,999.99"
              read
              valorpp := valor / part
              @ 16,30 say transform(valorpp,"@e 999,999,999.99")
              If Lastkey() = 27
                 Loop
              Endif
              If Confirma("Altera‡Æo")
                 abt->codhis  := historico
                 abt->nparce  := part
                 abt->dtaabt  := dta1
                 abt->dtavcm  := dta2
                 abt->valorap := valor
              Endif
     Endcase
   else
     dta1    := date()
     dta2    := ctod("  /  /    ")
     valor   := 0
     part    := 1
     @ 11,31 get part pict "99" valid part >= 0     && entra com parcelas
     read
     set key -1 to l_his()                       && consistencia para historico
     do while .t.
        historico := 0
        @ 12,31 get historico pict "9999" valid historico > 0
        read
        if lastkey() = 27
           exit
        endif
        his->(dbseek(str(historico,4,0)))
        if his->(found())
            @ 12,40 say his->descri
            set key -1 to
            exit
        else
            mens("Hist¢rico nÆo cadastrado. Tente outro !",.t.,.t.)
            loop
        endif
     enddo
     if lastkey() = 27
       loop
     endif
     @ 13,31 get dta1
     @ 14,31 get dta2 valid dta2 >= dta1
     @ 15,31 get valor pict "@e 999,999,999.99"
     read
     valorpp := valor / part
     @ 16,31 say transform(valorpp,"@e 999,999,999.99")
     If Lastkey() = 27
       Loop
     Endif
     If Confirma("InclusÆo")
        abt->(DBAPPEND())
        abt->codcli := str(cliente,6,0)+tipo
        abt->nrodoc := str(ndoc,8,0)
        abt->nparce := part
        abt->codhis := historico
        abt->dtaabt := dta1
        abt->dtavcm := dta2
        abt->valorap:= valor
     Endif
   endif
Enddo
Dbcloseall()
set cursor off
Return Nil
