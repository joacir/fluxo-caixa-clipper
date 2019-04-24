*****************************************************************************
* Funcao   : ABRE.PRG                                                       *
* Objetivo : Cria‡Æo / Abertura de Arquivos do Sistema de Fluxo de Caixa    *
* Data     : 02/03/99                                                       *
* Autor    : Joacir                                                         *
*****************************************************************************
* Funcao   : ABRECLI                                                        *
* Objetivo : Cria‡Æo / Abertura do Arquivo de CLIENTES e Fornecedores       *
*****************************************************************************
FUNCTION ABRECLI()
Local aCampos := {{"CODIGO"       ,"n",06,0},;
                  {"TIPOCF"       ,"C",01,0},;
                  {"NOME"         ,"C",30,0},;
                  {"RG"           ,"C",12,0},;
                  {"CIC"          ,"C",14,0},;
                  {"ENDER"        ,"C",40,0},;
                  {"CIDADE"       ,"C",20,0},;
                  {"ESTADO"       ,"C",02,0},;
                  {"CEP"          ,"C",10,0},;
                  {"FONE"         ,"C",17,0},;
                  {"DTAINS"       ,"D",10,0},;
                  {"OBS"          ,"C",40,0}}
If !File("CLIFOR.DBF")
   DBCREATE("CLIFOR.DBF",aCampos)
Endif
Use CLIFOR new alias CLI
If !File("CLICOD.NTX") .or. !File("CLINOM.NTX")
   index on str(cli->CODIGO,6,0) + cli->tipocf to CLICOD
   index on CLI->NOME   to CLINOM
Endif
Set index to CLICOD,CLINOM
Return Nil
*****************************************************************************
* Funcao   : ABREPAG                                                        *
* Objetivo : Cria‡Æo / Abertura do Arquivo de DUPLICATAS PAGAS              *
*****************************************************************************
FUNCTION ABREPAG()
Local aCampos := {{"NDUPLI"         ,"n",08,0},; && Chave (duplicata)
                  {"NROdoc"         ,"c",08,0},; && numero do documento
                  {"clifor"         ,"c",07,0},; && cliente / fornecedor
                  {"nppaga"         ,"n",02,0},; && nro. parcelas pagas
                  {"npapag"         ,"n",02,0},; && nro. parcelas a pagar
                  {"DTAPAG"         ,"D",10,0},; && data do pagamento
                  {"VALORPG"        ,"N",12,2},; && valor pago
                  {"VALORAP"        ,"N",12,2},; && valor a pagar
                  {"dtaabt"         ,"D",10,0},; && data do lancamento
                  {"DTAVCM"         ,"D",10,0},; && dta do vencimento
                  {"CODHIS"         ,"n",04,0}}  && codigo do historico
If !File("PAGAS.DBF")
   DBCREATE("PAGAS.DBF",aCampos)
Endif
Use PAGAS new alias PAG
If !File("PAGAS.NTX") .or. !File("PGDTA.NTX")
   index on str(PAG->NDUPLI,8,0) to pagas
   index on dtoc(pag->dtapag) to pgdta
endif
Set index to PAGAS, PGDTA
Return Nil
*****************************************************************************
* Funcao   : ABREBAN                                                        *
* Objetivo : Cria‡Æo / Abertura do Arquivo de Bancos                        *
*****************************************************************************
FUNCTION ABREBAN()
Local aCampos := {{"NCONTA"       ,"n",10,0},; && numero do documento
                  {"BANCO"        ,"C",30,0},; && descricao da conta/banco
                  {"AGENC"        ,"N",05,0},; && agencia 
                  {"SALINI"       ,"N",12,2},; && saldo inicial
                  {"SALATU"       ,"N",12,2},; && saldo atual
                  {"DTA"          ,"D",10,0}}  && data de inscricao da conta
If !File("BANCO.DBF")
   DBCREATE("BANCO.DBF",aCampos)
Endif
Use BANCO new alias BAN
If !File("bannro.NTX") .or. !File("bancont.NTX")
   index on str(BAN->NCONTA,10,0) to bannro
   index on BAN->BANCO  to bancont
Endif
Set index to bannro, bancont
Return Nil
*****************************************************************************
* Funcao   : ABREMOV                                                        *
* Objetivo : Cria‡Æo / Abertura do Arquivo de Movimento bancario            *
*****************************************************************************
FUNCTION ABREMOV()
Local aCampos := {{"CODMOV"       ,"n",06,0},;
                  {"NCONTA"       ,"n",10,0},;
                  {"codhis"       ,"n",04,0},;
                  {"VALOR"        ,"N",12,2},;
                  {"DTAMOV"       ,"D",10,0}}
If !File("MOVIMENTO.DBF")
   DBCREATE("MOVIMENTO.DBF",aCampos)
Endif
Use MOVIMENTO new alias MOV
If !File("MOVCOD.NTX") .or. !File("MOVdta.NTX") 
   index on str(mov->CODmov,6,0)  to MOVCOD
   index on dtoc(MOV->dtamov) to MOVdta
Endif
Set index to MOVCOD,MOVdta
Return Nil
*****************************************************************************
* Funcao   : ABREABT                                                        *
* Objetivo : Cria‡Æo / Abertura do Arquivo de DUPLICATAS EM ABERTO          *
*****************************************************************************
FUNCTION ABREABT()
Local aCampos := {{"CODCLI"         ,"C",07,0},; && codigo cliente/fornecedor
                  {"NRODOC"         ,"C",08,0},; && numero do documento
                  {"nparce"         ,"N",02,0},; && numero de parcelas
                  {"DTAABT"         ,"D",10,0},; && data do lancamento
                  {"VALORAP"        ,"N",12,2},; && valor a pagar
                  {"DTAVCM"         ,"D",10,0},; && data do vencimento
                  {"CODHIS"         ,"N",04,0}}  && codigo do historico
If !File("ABERTAS.DBF")                                                         
   DBCREATE("ABERTAS.DBF",aCampos)
Endif
Use ABERTAS new alias ABT
If !File("ABERTAS.NTX") .or. !file("abtdat.ntx")
   index on ABT->CODCLI + ABT->NRODOC to ABERTAS  
   index on dtoc(abt->dtaabt) to abtdat
Endif
Set index to ABERTAS abtdat
Return Nil
*****************************************************************************
* Funcao   : ABREHIS                                                        *
* Objetivo : Cria‡Æo / Abertura do Arquivo de HISTORICOS                    *
*****************************************************************************
FUNCTION ABREHIS()
Local aCampos := {{"CODIGO"         ,"N",04,0},;
                  {"DESCRI"         ,"C",30,0},;
                  {"Tipo"           ,"c",01,0}}
If !File("HISTORIC.DBF")
   DBCREATE("HISTORIC.DBF",aCampos)
Endif
Use HISTORIC new alias HIS
If !File("CODHIS.NTX") .OR. !FILE("DESHIS.NTX")
   index on str(HIS->CODIGO,4,0) to CODHIS
   INDEX ON HIS->DESCRI TO DESHIS
Endif
Set index to CODHIS, DESHIS
Return Nil
*****************************************************************************
* Funcao   : ABREimp                                                        *
* Objetivo : Cria‡Æo / Abertura do Arquivo de impressoras                   *
*****************************************************************************
FUNCTION ABREimp()
Local aCampos := {{"CODI_imp"         ,"N",01,0},;
                  {"nome_imp"         ,"C",10,0},;
                  {"normal"           ,"c",30,0},;
                  {"compacta"         ,"c",30,0}}
If !File("impress.DBF")
   DBCREATE("impress.DBF",aCampos)
Endif
Use impress new alias imp
If !File("impcod.NTX") .OR. !FILE("impnom.NTX")
   index on str(imp->codi_imp,1,0) to impcod
   INDEX ON imp->nome_imp to impnom
Endif
Set index to impcod, impnom
Return Nil

