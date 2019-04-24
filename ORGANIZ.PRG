*****************************************************************************
* Fun‡Æo     : organiza.prg                                                 *
* Objetivo   : Compacta‡Æo de Arquivos e Reconstru‡Æo dos Öndices           *
*****************************************************************************
FUNCTION organiz()
Private Getlist := {}
@ 02,41 say PADC("Organiza‡Æo de Arquivos",38)   color("W+/n")
if Confirma("Organiza‡Æo")
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
   alert("Organiza‡Æo completa !")
endif
Return nil
