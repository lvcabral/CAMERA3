****************************************************************************
**  Sistema..........: Camera 3 v1.1 (C) Copyright 1992                   **
**  Programa.........: CAM3.CH                                            **
**  Autor............: Marcelo Leal Limaverde Cabral                      **
**  Linguagem........: Clipper Summer'87 & Turbo "C" v2.0                 **
**  Descri‡„o........: Arquivo de Defini‡”es do Sistema                   **
**  Data de Cria‡„o..: 18/06/92  Ultima Altera‡„o..:   /  /               **
****************************************************************************
/* Defini‡”es dos Comandos Set para acentua‡„o e tecla insert*/

#command SET ACCENT <x:ON,OFF,&>   => Acentua(if(Upper( <(x)> )=="ON",.t.,.f.))
                                        
#command SET ACCENT (<x>)          => Acentua( <(x)> ) 

#command SET INSCURSOR <x:ON,OFF,&> => Inskey(if(Upper( <(x)> )=="ON",.t.,.f.))

#command SET INSCURSOR (<x>)        => Inskey( <(x)> ) 

/* Defini‡”es dos ¡ndices do vetor de acentua‡„o */
#define AMAAG 1
#define AMIAG 2
#define EMAAG 3
#define EMIAG 4
#define IMAAG 5 
#define IMIAG 6
#define OMAAG 7
#define OMIAG 8
#define UMAAG 9
#define UMIAG 10
#define AMACR 11
#define AMICR 12
#define AMACI 13
#define AMICI 14
#define EMACI 15
#define EMICI 16
#define OMACI 17
#define OMICI 18
#define AMATI 19
#define AMITI 20
#define OMATI 21
#define OMITI 22
#define CMACE 23
#define CMICE 24
#define FF    25
