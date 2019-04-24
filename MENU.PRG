*************************************************************************
*   Programa menu - tela de apresentacao do Fluxo de Caixa              *
*   Joacir - 5§ termo B                                                 *
*************************************************************************
function menu()

local coluna, tempo, tecla, tela, real, valor := 0
tela := savescreen(11,00,15,79)
coluna := 01
tempo := 1
do while .t.
   tecla := inkey()
   restscreen(11,00,15,79,tela)
   @ 22, 03 say padc("Tecle <Enter> para Come‡ar !!!",73) color("w+*/n")
   @ 11, coluna say "    ± ±±±± ±± ± ±± ±    ±±±   ±±    ±±±    ±±  ±± ± ±± ±±  ±"
   @ 12, coluna say " ±±±± ±±±± ±± ±±  ±± ±± ±±± ±± ± ±±±±±± ±±±± ±± ± ±±  ±± ±± "
   @ 13, coluna say "  ±±± ±±±± ±± ±±  ±± ±± ±±± ±± ±  ±±±±± ±±±±    ± ±±  ±±    "
   @ 14, coluna say " ±±±± ±±±± ±± ±±  ±± ±± ±±± ±± ± ±±±±±± ±±±± ±± ± ±±  ±± ±± "
   @ 15, coluna say " ±±±±    ±    ± ±± ±    ±±±   ±±    ±±±    ± ±± ± ± ±± ± ±± "
   if !empty(tecla)
       exit
   endif
   do while .t.
     tempo := tempo + 1
     if tempo = 8000
        coluna := coluna + 1
        tempo := 0
        exit
      endif
   enddo
   if coluna = 20
     coluna := coluna -1
     do while coluna > 0
       tecla := inkey()
       restscreen(11,00,15,79,tela)
       @ 11, coluna say "    ± ±±±± ±± ± ±± ±    ±±±   ±±    ±±±    ±±  ±± ± ±± ±±  ±"
       @ 12, coluna say " ±±±± ±±±± ±± ±±  ±± ±± ±±± ±± ± ±±±±±± ±±±± ±± ± ±±  ±± ±± "
       @ 13, coluna say "  ±±± ±±±± ±± ±±  ±± ±± ±±± ±± ±  ±±±±± ±±±±    ± ±±  ±±    "
       @ 14, coluna say " ±±±± ±±±± ±± ±±  ±± ±± ±±± ±± ± ±±±±±± ±±±± ±± ± ±±  ±± ±± "
       @ 15, coluna say " ±±±±    ±    ± ±± ±    ±±±   ±±    ±±±    ± ±± ± ± ±± ± ±± "
       if !empty(tecla)
           exit
       endif
       do while .t.
         tempo := tempo + 1
         if tempo = 8000
            coluna := coluna - 1
            tempo := 0
            exit
         endif
       enddo
       if !empty(tecla)
           exit
       endif
     enddo
     coluna := 1
   endif
   if !empty(tecla)
        exit
   endif
enddo
return nil

