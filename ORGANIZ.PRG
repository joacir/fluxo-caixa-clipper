*****************************************************************************
* Fun��o     : organiza.prg                                                 *
* Objetivo   : Compacta��o de Arquivos e Reconstru��o dos �ndices           *
*****************************************************************************
FUNCTION organiz()
Private Getlist := {}
@ 02,41 say PADC("Organiza��o de Arquivos",38)   color("W+/n")
if Confirma("Organiza��o")
   @ 22,01 say padc("Aguarde...  Organizando Arquivos do Sistema !!",77) color('w+*/n')
   abreban()
   pack
   abrecli()
   pack
   abrehis()
   pack
   abreabt()
   pack
   abrepag()
   pack
   abremov()
   pack
   dbcloseall()
   @ 22,01 clear to 22,78
   alert("Organiza��o completa !")
endif
Return nil
