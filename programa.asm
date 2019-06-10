.model small
.stack 1000H
.data  
    
    rest                            DW 0                                                            
    
    
    BytesLidos1                     DW 0                                      ; Bytes lidos do arquivo1 
    BytesLidos2                     DW 0                                      ; Bytes lidos do arquivo2
    BytesLidos3                     DW 0                                      ; Bytes lidos do arquivo3
    buffer01                        DB 4096 DUP (?)                           ; buffer01 para armazenar dados
    buffer02                        DB 4096 DUP (?)                           ; buffer02 para armazenar dados
    buffer03                        DB 4096 DUP (?)                           ; buffer03 para armazenar dados
    buffer03Aux                     DB 4096 DUP (?)                           ; buffer03aux para armazenar dados
	buffer04 	                    DB 255  DUP ('$') 				          ; buffer04 para armazenar linha do arq de ativacoes
	buffer04est                     DB 255  DUP ('$')                         ; armazena estado correspondente da ultima ativacao lida
	buffer06                        DB 255  DUP ('$')                         ; armazena a linha para ser gerada
	bufferAtivDetectadas            DB 255  DUP ('$')                         ; armazena linha das ativacoes detectadas a ser procurada no sensores.txt  
    Fimbuffer01                     DW $-buffer01                             ; Endereco do fim do buffer01 
    Fimbuffer02                     DW $-buffer02                             ; Endereco do fim do buffer02
    Fimbuffer03                     DW $-buffer03                             ; Endereco do fim do buffer03      
    Handle1                         DW ?                                      ; para guardar o manipulador do arquivo1
    Handle2                         DW ?                                      ; para guardar o manipulador do arquivo2
    Handle3                         DW ?                                      ; para guardar o manipulador do arquivo3     
    Handle3Aux                      DW 0                                      ; para guardar o manipulador do arquivo3aux 
	Handle4 	                    DW 0        	                          ; para guardar o manipulador do arquivo4 
	HandleAtivDetectadas            DW 0                                      ; para guardar o manipulador do arquivo de ativacoes detectadas 
	
	HandleAtivValidas               DW 0                                      ; para guardar o manipulador do arquivo de ativacoes validas  
	OpenError                       DB "Ocorreu um erro(abrindo)!$"
    ReadError                       DB "Ocorreu um erro(lendo)!$"
    FileName1                       DB "D:\Arquivo de Programas\Emu8086\emu8086\MyBuild\X10Map.txt",0      ; arquivo a ser aberto1 
    FileName2                       DB "D:\Arquivo de Programas\Emu8086\emu8086\MyBuild\X10OnOff.txt",0    ; arquivo a ser aberto2
    FileName3                       DB "D:\Arquivo de Programas\Emu8086\emu8086\MyBuild\sensores.txt",0    ; arquivo a ser aberto3    
    FileNameAux                     DB "D:\Arquivo de Programas\Emu8086\emu8086\MyBuild\sensores.txt",0    ; arquivo a ser aberto3aux
	FileName4 	                    DB "D:\Arquivo de Programas\Emu8086\emu8086\MyBuild\X10ati.txt",0	  ; ativacoes
	FileNameAtivDetectadas          DB "D:\Arquivo de Programas\Emu8086\emu8086\MyBuild\X10ati.det",0	  ; arquivo de ativacoes detectadas a ser aberto 
	FileNameAtiv                    DB "D:\Arquivo de Programas\Emu8086\emu8086\MyBuild\X10ati.val",0
												  
												
 
	sensoresInstaladosTela          DB "sensores.txt"
	ativacoesTela                   DB "X10Ati.txt"
	NewLine 	                    DB 13,10,'$'
    Cont                            DW 0                                      ; quantos bytes serao lidos no arquivo3
    posLinha                        DW 0                                      ; posicao atual na validacao da soma
    sensorPos13                     DW 0                                      ; guarda primeiro e terceiro caracteres do sensor  
    sensorPos24                     DW 0                                      ; guarda segundo e quarto caracteres do sensor
    lProcessada                     DW 0                                      ; guarda linha atual de processamento
    lProcessadaAux                  DW 0                                      ; guarda linha atual de processamento que sera printada na tela  
    posX10Map                       DW 0                                      ; controle para saber em qual caracter da linha esta, zera ao trocar de linha
    posX10OnOff                     DW 0                                      ; controle para saber em qual caracter da linha esta, zera ao trocar de linha  
    validadorX10Map                 DW 0                                      ; se ao final da validacao do X10Map estiver como 4, encontrou sensor valido   
    validadorX10OnOff               DW 0                                      ; se ao final da validacao do X10OnOff estiver como 4, encontrou sensor valido   
    flagX10Map                      DW 0                                      ; ativa se X10Map for valido
    flagX10OnOff                    DW 0                                      ; ativa se X10OnOff for valido
    contLinGrav                     DW 0                                      ; contador do buffer06 
    linhaAtualSensoresInstalados    DW 0                                      ; linha atual quando estiver percorrendo o arquivo
    posSensoresInstalados           DB 0                                      ; posicao atual quando estiver percorrendo o arquivo
     
    ;MENU
    menu_title1       DB "Sensores Assembly"   
    menu_title2       DB "Maria e Samuel"
    menu_title3       DB " "
    menu_op1          DB "1 - Iniciar"
    menu_op2          DB "2 - Sair"  
    
    ;TELA LEITURA
    tela_leitura1     DB "Lendo arquivos..."    
    tela_leitura2     DB "Lendo arquivo X10Map.txt..." 
    tela_leitura3     DB "Lendo arquivo X10OnOff.txt..."
    tela_leitura4     DB "Lendo arquivo de Sensores Instalados..." 
	
	;TELA 
	linha01 DB 218,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,194,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,191,13,10
    linha02 DB 179,83,69,78,83,79,82,69,83,32,73,78,83,84,65,76,65,68,79,83,58,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,65,84,73,86,65,128,229,69,83,58,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,13,10
    linha03 DB 195,196,196,196,196,196,196,196,196,196,196,196,196,196,196,194,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,194,196,196,196,196,196,196,193,196,196,196,196,196,196,196,196,196,196,196,196,194,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,180,13,10
    linha04 DB 179,76,73,78,72,65,58,32,32,32,32,32,32,32,32,179,86,181,76,73,68,65,83,58,32,32,32,32,32,32,32,32,179,73,78,83,84,65,76,65,68,65,83,58,32,32,32,32,32,32,32,32,179,83,69,81,85,210,78,67,73,65,83,58,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,13,10
    linha05 DB 195,196,196,196,196,196,196,196,196,196,196,196,196,196,196,197,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,193,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,193,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,180,13,10
    linha06 DB 179,32,32,32,83,69,78,83,79,82,69,83,32,32,32,179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,83,69,78,83,79,82,69,83,32,69,78,67,79,78,84,82,65,68,79,83,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,13,10
    linha07 DB 179,32,32,73,78,83,84,65,76,65,68,79,83,32,32,179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,13,10
    linha08 DB 179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,13,10
    linha09 DB 179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,13,10
    linha10 DB 179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,13,10
    linha11 DB 179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,13,10
    linha12 DB 179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,13,10
    linha13 DB 179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,13,10
    linha14 DB 179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,13,10
    linha15 DB 179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,13,10
    linha16 DB 179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,13,10
    linha17 DB 179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,13,10
    linha18 DB 179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,13,10
    linha19 DB 179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,13,10
    linha20 DB 179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,13,10
    linha21 DB 179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,13,10
    linha22 DB 179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,13,10
    linha23 DB 179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,179,13,10
    linha24 DB 192,196,196,196,196,196,196,196,196,196,196,196,196,196,196,193,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,196,217,'$'
	printaLAtual        DB 0,0,0,0
    printaLAtualAux     DB 0,0,0,0  
    printaValidas       DB 0,0,0,0
    printaValidasAux    DB 0,0,0,0  
    printaInstaladas    DB 0,0,0,0
    printaInstaladasAux DB 0,0,0,0 
    
    ;linha08 col17 (ate 73)
    sensoresEncontradosL01  DB 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
    sensoresEncontradosL02  DB 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
    sensoresEncontradosL03  DB 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
    sensoresEncontradosL04  DB 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
    linSensoresEncontrados  DW 1
    colSensoresEncontrados  DW 0     
    
    sensoresInstaladosL01   DB 32,32,32,32,32,32,32,32,32,32,32,32 
    sensoresInstaladosL02   DB 32,32,32,32,32,32,32,32,32,32,32,32 
    sensoresInstaladosL03   DB 32,32,32,32,32,32,32,32,32,32,32,32 
    sensoresInstaladosL04   DB 32,32,32,32,32,32,32,32,32,32,32,32 
    sensoresInstaladosL05   DB 32,32,32,32,32,32,32,32,32,32,32,32 
    sensoresInstaladosL06   DB 32,32,32,32,32,32,32,32,32,32,32,32 
    sensoresInstaladosL07   DB 32,32,32,32,32,32,32,32,32,32,32,32 
    sensoresInstaladosL08   DB 32,32,32,32,32,32,32,32,32,32,32,32 
    linSensoresInstalados   DW 1
    colSensoresInstalados   DW 0
 
	; Arquivo de ativacoes detectadas, quando um deles passa 5 segundos da primeira ativacao ou muda sensor, grava no arquivo
	; Conj refere-se a primeira ativacao de um conjunto
	
	
	data01                          DB 0,0,0,0,0,0,0,0
	data02                          DB 0,0,0,0,0,0,0,0
	dataTemp                        DB 0,0,0,0,0,0,0,0
	dataTempConj                    DB 0,0,0,0,0,0,0,0
	hora01                          DB 0,0,0,0,0,0,0,0,0
	hora02                          DB 0,0,0,0,0,0,0,0,0
	horaTemp                        DB 0,0,0,0,0,0,0,0,0
	horaTempConj                    DB 0,0,0,0,0,0,0,0,0
	codigo01                        DB 0,0,0,0
	codigo02                        DB 0,0,0,0
	codigoTemp                      DB 0,0,0,0
	codigoTempConj                  DB 0,0,0,0
	sensorPosicao01                 DW 0                                      ; guarda primeira posicao do codigo do sensor do X10Map
	sensorPosicao01Temp             DW 0
	sensorPosicao01TempConj         DW 0
    sensorPosicao02                 DW 0                                      ; guarda segunda posicao do codigo do sensor do X10Map
    sensorPosicao02Temp             DW 0
    sensorPosicao02TempConj         DW 0
    sensorPosicao03                 DW 0                                      ; guarda terceira posicao do codigo do sensor do X10Map
    sensorPosicao03Temp             DW 0
    sensorPosicao03TempConj         DW 0
    sensorPosicao04                 DW 0                                      ; guarda quarta posicao do codigo do sensor do X10Map
    sensorPosicao04Temp             DW 0
    sensorPosicao04TempConj         DW 0
    
    codigoVerif                     DB 0,0,0,0                                ; guarda codigo hexa para verificar no Map e OnOff
    
    flagOcup01                      DB 0                                      ; flag's de ocupacao das variaveis para armazenar dados das linhas lidas
    flagOcup02                      DB 0
    flagOcupTemp                    DB 0
    flagOcupTempConj                DB 0
    
    flagCompararCodL01              DB 0
    flagCompararCodL02              DB 0
    
	nroAtivacoes                    DB 0
	somaLinha1                      DB 0                                      ; validador de soma para dupla de linha do ati
	codDecSensor                    DW 0                                      ; guarda codigo decimal lido do X10OnOff
	codDecSensorTemp                DW 0
    estadoSensor                    DW 0                                      ; guarda estado do sensor em processo de validacao (encontrado no X10OnOff)
    estadoSensorTemp                DW 0
    flagNovaAtivacao                DW 0                                      ; guarda a diferenca em segundos  
    contNovaAtiv                    DB 0                                      ; se for primeira chamada da funcao, chamar proc para guardar dados conj antes da validacao de tempo
	
	sensorFinal                     DB 0,0,0,0                                ; guarda codigo decimal do primeiro arquivo gerado
	quantPosicoes                   DW 0                                      ; quantas posicoes de codigo decimal ha na linha atual do primeiro arquivo gerado
	flagEncontrou2PosicoesCarac1    DW 0                           ;
	flagEncontrou3PosicoesCarac1    DW 0
	flagEncontrou3PosicoesCarac2    DW 0
	linhafinal                      DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	num1                            DB 0                                                       ; efetuar divisao para colocar sensorTemp em sensorFinal
    num2                            DB 0
    contTemp                        DB 0,0,0,0 
    sensorTemp                      DB 0,0,0,0 
    decimal                         DB 0,0,0
    carry                           DB 0   
    handel                          DW 0  
    flagTempo                       DB 0
    resultTempo                     DB 0,0,0,0,0,0,0,0,0 
    modeTempo                       DB 0
    contTempo                       DW 0
     
    
   
.code         
    
    ;----------------------------------------------------------------------------------------------------------------------
    ;LEITURA E ESCRITA NA TELA
    
    ; ESCREVE TEXTO NA TELA
    ; BL - [FUNDO][COR]H 
    ; CX - Tamanho STR
    ; DX - Linha Coluna H
    ; BP - Endereco da STR
    ESC_STR_VIDEO proc
        push ax
        push bx
        mov ax,1300H ; MODO
        mov bh,00H   ; PAGINA
        int 10H
        pop bx
        pop ax
        ret
    endp 
    
    ; LE CARACTER
    ; AL = caracter lido
    LE_CARACTER proc
        mov ax,0700H
        int 21h
        ret
    endp 
	
	incrementar proc 
        push ax
        push bx
        push cx
        push dx
        xor cx,cx       
        mov carry,0 
        adicionarinc: 
            xor bx,bx
            xor dx,dx
            mov bl,[si]
            mov dl,1
            add dx,bx
            cmp dl, 09h 
            jle cont_carryinc 
            add dx,6h
        cont_carryinc:    
            cmp carry,0
            jg addCarryinc
            jmp calcCarryinc
        addCarryinc:
            cmp dl,09h
            jz dc
            jmp cc 
          dc:  
            add dx,6h
          cc:  
            add dl,carry
            mov carry,0        
        calcCarryinc:
            cmp dl,09h
            jle adddxinc
            jmp dividirinc
        adddxinc:         
            mov [si],dl  
            jmp fim_somac
        dividirinc:
            mov num1,dl
            mov num2,10h
            call divide 
            mov al, num1
            mov ah, num2
            add carry,al  
            mov [si],ah
            dec si    
            mov bx,[si]
            add bx,ax
            cmp bl, 09h 
            jle trocar2 
            add bx,6h
            mov num1,bl
            mov num2,10h
            call divide 
            mov al, num1
            mov ah, num2
            mov [si],ah
            dec si
            mov bx,[si]
            add bx,ax
            mov [si],bl
            jmp fim_somac
        trocar2:
            mov [si],bl 
       fim_somac:
        pop dx
        pop cx
        pop bx
        pop ax 
        ret
	 endp
	
	clear_screen proc
	
        push ax
        push bx
        push cx
        push dx
            
        xor cx,cx      ; Posicao Inicial
        mov dx,184FH   ; Posicao Final
        mov bh,00h     ; Texto Fundo H
        mov ax,0600h   ; Codigo da Interrupcao
        int 10h
        
        pop dx
        pop cx
        pop bx
        pop ax
		
        ret
    
    endp
	
	print_string proc
    	
		push ax
		push bx
		push cx
		push dx
		
		mov dx,OFFSET bufferAtivDetectadas
        mov ah,09
        int 21h 
				
		pop dx
		pop cx
		pop bx
		pop ax
        
		ret
        		
	endp    
 
	print_sensores_encontrados proc 
	    
	    push ax  
	    push si
	    
	    mov si,colSensoresEncontrados
	    ;cmp si,37
	    ;jge novaLinhaPrintSensoresEncontrados
	    cmp si,37h
	    jge novaLinhaPrintSensoresEncontrados
	    jmp continua_print_sensores_encontrados
	                                         
        novaLinhaPrintSensoresEncontrados:
            mov colSensoresEncontrados,0
            mov si,colSensoresEncontrados
            inc linSensoresEncontrados 
            	                                        
	    continua_print_sensores_encontrados:
	    
	    cmp linSensoresEncontrados,1
	    jz linha01PrintSensoresEncontrados                  
	    cmp linSensoresEncontrados,2
	    jz linha02PrintSensoresEncontrados                  
	    cmp linSensoresEncontrados,3
	    jz linha03PrintSensoresEncontrados                  
	    cmp linSensoresEncontrados,4
	    jz linha04PrintSensoresEncontrados                  
	    	    
	    linha01PrintSensoresEncontrados:
	        mov al,codigo01[0]
	        call toAsc
	        mov sensoresEncontradosL01[si],al 
	        inc si
	        mov al,codigo01[1]
	        call toAsc
	        mov sensoresEncontradosL01[si],al 
	        inc si
	        mov al,codigo01[2]
	        call toAsc
	        mov sensoresEncontradosL01[si],al 
	        inc si
	        mov al,codigo01[3]
	        call toAsc
	        mov sensoresEncontradosL01[si],al 
	        inc si
	        inc si
	    
    	    ; L01
    	    mov bl,0FH
    		mov cx,56
    		mov dl,17
    		mov dh,8
    		mov bp,offset sensoresEncontradosL01
    		call ESC_STR_VIDEO
    		jmp fim_print_sensores_encontrados
    		
    	linha02PrintSensoresEncontrados:
	        mov al,codigo01[0]
	        call toAsc
	        mov sensoresEncontradosL02[si],al 
	        inc si
	        mov al,codigo01[1]
	        call toAsc
	        mov sensoresEncontradosL02[si],al 
	        inc si
	        mov al,codigo01[2]
	        call toAsc
	        mov sensoresEncontradosL02[si],al 
	        inc si
	        mov al,codigo01[3]
	        call toAsc
	        mov sensoresEncontradosL02[si],al 
	        inc si
	        inc si
	    
    	    ; L02
    	    mov bl,0FH
    		mov cx,56
    		mov dl,17
    		mov dh,10
    		mov bp,offset sensoresEncontradosL02
    		call ESC_STR_VIDEO
    		jmp fim_print_sensores_encontrados
    		
    	linha03PrintSensoresEncontrados:
	        mov al,codigo01[0]
	        call toAsc
	        mov sensoresEncontradosL03[si],al 
	        inc si
	        mov al,codigo01[1]
	        call toAsc
	        mov sensoresEncontradosL03[si],al 
	        inc si
	        mov al,codigo01[2]
	        call toAsc
	        mov sensoresEncontradosL03[si],al 
	        inc si
	        mov al,codigo01[3]
	        call toAsc
	        mov sensoresEncontradosL03[si],al 
	        inc si
	        inc si
	    
    	    ; L03
    	    mov bl,0FH
    		mov cx,56
    		mov dl,17
    		mov dh,12
    		mov bp,offset sensoresEncontradosL03
    		call ESC_STR_VIDEO
    		jmp fim_print_sensores_encontrados
    		
    		
		linha04PrintSensoresEncontrados:
	        mov al,codigo01[0]
	        call toAsc
	        mov sensoresEncontradosL04[si],al 
	        inc si
	        mov al,codigo01[1]
	        call toAsc
	        mov sensoresEncontradosL04[si],al 
	        inc si
	        mov al,codigo01[2]
	        call toAsc
	        mov sensoresEncontradosL04[si],al 
	        inc si
	        mov al,codigo01[3]
	        call toAsc
	        mov sensoresEncontradosL04[si],al 
	        inc si
	        inc si
	    
    	    ; L04
    	    mov bl,0FH
    		mov cx,56
    		mov dl,17
    		mov dh,14
    		mov bp,offset sensoresEncontradosL04
    		call ESC_STR_VIDEO
    		jmp fim_print_sensores_encontrados
		
		fim_print_sensores_encontrados:
    		mov colSensoresEncontrados,si
    		pop si
    		pop ax   
    	    ret
    endp
    
    print_sensores_instalados proc 
	    push ax  
	    push si
	    
	    mov si,colSensoresInstalados
	    cmp si,9h
	    jge novaLinhaPrintSensoresInstalados
	    jmp continua_print_sensores_instalados
	                                         
        novaLinhaPrintSensoresInstalados:
            mov colSensoresInstalados,0
            mov si,colSensoresInstalados
            inc linSensoresInstalados 
            	                                        
	    continua_print_sensores_instalados:
	    
	    cmp linSensoresInstalados,1
	    jz linha01PrintSensoresInstalados
	    cmp linSensoresInstalados,2
	    jz linha02PrintSensoresInstalados
	    cmp linSensoresInstalados,3
	    jz linha03PrintSensoresInstalados
	    cmp linSensoresInstalados,4
	    jz linha04PrintSensoresInstalados
		cmp linSensoresInstalados,5
	    jz linha05PrintSensoresInstalados
		cmp linSensoresInstalados,6
	    jz linha06PrintSensoresInstalados
		cmp linSensoresInstalados,7
	    jz linha07PrintSensoresInstalados
		cmp linSensoresInstalados,8
	    jz linha08PrintSensoresInstalados
	    	    
	    linha01PrintSensoresInstalados:
	        mov al,sensorFinal[0]
	        mov sensoresInstaladosL01[si],al 
	        inc si
	        mov al,sensorFinal[1]
	        mov sensoresInstaladosL01[si],al 
	        inc si
	        mov al,sensorFinal[2]
	        mov sensoresInstaladosL01[si],al 
	        inc si
	        mov al,sensorFinal[3]
	        mov sensoresInstaladosL01[si],al 
	        inc si
	        inc si
	    
    	    ; L01
    	    mov bl,0FH
    		mov cx,13
    		mov dl,2
    		mov dh,8
    		mov bp,offset sensoresInstaladosL01
    		call ESC_STR_VIDEO
    		jmp fim_print_sensores_instalados
    		
        linha02PrintSensoresInstalados:
	        mov al,sensorFinal[0]
	        mov sensoresInstaladosL02[si],al 
	        inc si
	        mov al,sensorFinal[1]
	        mov sensoresInstaladosL02[si],al 
	        inc si
	        mov al,sensorFinal[2]
	        mov sensoresInstaladosL02[si],al 
	        inc si
	        mov al,sensorFinal[3]
	        mov sensoresInstaladosL02[si],al 
	        inc si
	        inc si
	    
    	    ; L02
    	    mov bl,0FH
    		mov cx,13
    		mov dl,2
    		mov dh,10
    		mov bp,offset sensoresInstaladosL02
    		call ESC_STR_VIDEO
    		jmp fim_print_sensores_instalados
    		
    	linha03PrintSensoresInstalados:
	        mov al,sensorFinal[0]
	        mov sensoresInstaladosL03[si],al 
	        inc si
	        mov al,sensorFinal[1]
	        mov sensoresInstaladosL03[si],al 
	        inc si
	        mov al,sensorFinal[2]
	        mov sensoresInstaladosL03[si],al 
	        inc si
	        mov al,sensorFinal[3]
	        mov sensoresInstaladosL03[si],al 
	        inc si
	        inc si
	    
    	    ; L03
    	    mov bl,0FH
    		mov cx,13
    		mov dl,2
    		mov dh,12
    		mov bp,offset sensoresInstaladosL03
    		call ESC_STR_VIDEO
    		jmp fim_print_sensores_instalados
    		
    	linha04PrintSensoresInstalados:
	        mov al,sensorFinal[0]
	        mov sensoresInstaladosL04[si],al 
	        inc si
	        mov al,sensorFinal[1]
	        mov sensoresInstaladosL04[si],al 
	        inc si
	        mov al,sensorFinal[2]
	        mov sensoresInstaladosL04[si],al 
	        inc si
	        mov al,sensorFinal[3]
	        mov sensoresInstaladosL04[si],al 
	        inc si
	        inc si
	    
    	    ; L04
    	    mov bl,0FH
    		mov cx,13
    		mov dl,2
    		mov dh,14
    		mov bp,offset sensoresInstaladosL04
    		call ESC_STR_VIDEO
    		jmp fim_print_sensores_instalados
    		
    	linha05PrintSensoresInstalados:
	        mov al,sensorFinal[0]
	        mov sensoresInstaladosL05[si],al 
	        inc si
	        mov al,sensorFinal[1]
	        mov sensoresInstaladosL05[si],al 
	        inc si
	        mov al,sensorFinal[2]
	        mov sensoresInstaladosL05[si],al 
	        inc si
	        mov al,sensorFinal[3]
	        mov sensoresInstaladosL05[si],al 
	        inc si
	        inc si
	    
    	    ; L05
    	    mov bl,0FH
    		mov cx,13
    		mov dl,2
    		mov dh,16
    		mov bp,offset sensoresInstaladosL05
    		call ESC_STR_VIDEO
    		jmp fim_print_sensores_instalados
    		
    	linha06PrintSensoresInstalados:
	        mov al,sensorFinal[0]
	        mov sensoresInstaladosL06[si],al 
	        inc si
	        mov al,sensorFinal[1]
	        mov sensoresInstaladosL06[si],al 
	        inc si
	        mov al,sensorFinal[2]
	        mov sensoresInstaladosL06[si],al 
	        inc si
	        mov al,sensorFinal[3]
	        mov sensoresInstaladosL06[si],al 
	        inc si
	        inc si
	    
    	    ; L06
    	    mov bl,0FH
    		mov cx,13
    		mov dl,2
    		mov dh,18
    		mov bp,offset sensoresInstaladosL06
    		call ESC_STR_VIDEO
    		jmp fim_print_sensores_instalados
    		
    	linha07PrintSensoresInstalados:
	        mov al,sensorFinal[0]
	        mov sensoresInstaladosL07[si],al 
	        inc si
	        mov al,sensorFinal[1]
	        mov sensoresInstaladosL07[si],al 
	        inc si
	        mov al,sensorFinal[2]
	        mov sensoresInstaladosL07[si],al 
	        inc si
	        mov al,sensorFinal[3]
	        mov sensoresInstaladosL07[si],al 
	        inc si
	        inc si
	    
    	    ; L07
    	    mov bl,0FH
    		mov cx,13
    		mov dl,2
    		mov dh,20
    		mov bp,offset sensoresInstaladosL07
    		call ESC_STR_VIDEO
    		jmp fim_print_sensores_instalados
    		
    	linha08PrintSensoresInstalados:
	        mov al,sensorFinal[0]
	        mov sensoresInstaladosL08[si],al 
	        inc si
	        mov al,sensorFinal[1]
	        mov sensoresInstaladosL08[si],al 
	        inc si
	        mov al,sensorFinal[2]
	        mov sensoresInstaladosL08[si],al 
	        inc si
	        mov al,sensorFinal[3]
	        mov sensoresInstaladosL08[si],al 
	        inc si
	        inc si
	    
    	    ; L08
    	    mov bl,0FH
    		mov cx,13
    		mov dl,2
    		mov dh,22
    		mov bp,offset sensoresInstaladosL08
    		call ESC_STR_VIDEO
    		jmp fim_print_sensores_instalados    		
    	
		
		fim_print_sensores_instalados:
    		mov colSensoresInstalados,si
    		pop si
    		pop ax   
    	    ret
    endp	    	    
	
		
	print_screen proc
	
		mov bl,0FH
		mov cx,79
		mov dl,0
		mov dh,0
		mov bp,offset linha01
		call ESC_STR_VIDEO
		
		mov dh,1 
		mov bp,offset linha02
		call ESC_STR_VIDEO
     
     
		mov dh,2 
		mov bp,offset linha03
		call ESC_STR_VIDEO
     
     
		mov dh,3 
		mov bp,offset linha04
		call ESC_STR_VIDEO
     
     
		mov dh,4 
		mov bp,offset linha05
		call ESC_STR_VIDEO
		
		mov dh,5 
		mov bp,offset linha06
		call ESC_STR_VIDEO
     
     
		mov dh,6 
		mov bp,offset linha07
		call ESC_STR_VIDEO
     
		mov dh,7 
		mov bp,offset linha08
		call ESC_STR_VIDEO
     
		mov dh,8 
		mov bp,offset linha09
		call ESC_STR_VIDEO   
     
		mov dh,9 
		mov bp,offset linha10
		call ESC_STR_VIDEO
		
		mov dh,10 
		mov bp,offset linha11
		call ESC_STR_VIDEO
     
		mov dh,11 
		mov bp,offset linha12
		call ESC_STR_VIDEO
     
		mov dh,12 
		mov bp,offset linha13
		call ESC_STR_VIDEO
     
		mov dh,13 
		mov bp,offset linha14
		call ESC_STR_VIDEO
     
		mov dh,14 
		mov bp,offset linha15
		call ESC_STR_VIDEO
     
		mov dh,15 
		mov bp,offset linha16
		call ESC_STR_VIDEO
		
		mov dh,16 
		mov bp,offset linha17
		call ESC_STR_VIDEO
     
		mov dh,17 
		mov bp,offset linha18
		call ESC_STR_VIDEO
     
		mov dh,18 
		mov bp,offset linha19
		call ESC_STR_VIDEO
     
		mov dh,19 
		mov bp,offset linha20
		call ESC_STR_VIDEO
     
		mov dh,20 
		mov bp,offset linha21
		call ESC_STR_VIDEO
     
		mov dh,21 
		mov bp,offset linha22
		call ESC_STR_VIDEO
     
		mov dh,22 
		mov bp,offset linha23
		call ESC_STR_VIDEO 
     
		mov dh,23 
		mov bp,offset linha24
		call ESC_STR_VIDEO 
		
		mov cx,12
		mov dl,22
		mov dh,1
		mov bp,offset sensoresInstaladosTela
		call ESC_STR_VIDEO
		
		mov cx,10
		mov dl,51
		mov dh,1
		mov bp,offset ativacoesTela
		call ESC_STR_VIDEO
    	ret
	endp 
	
	printa_linha_atual proc
	    
	    push ax
	    push bx
	    push cx
	    push dx 
	    push si
	      
	    xor si,si  
	    ;incrementar vetor printaLAtual   
	    mov si, offset printaLAtual 
        add si,3
	    call incrementar
	    
    	mov bl,0100b
    	mov cx,1
    	mov dh,3
    	mov dl,8   
    	mov al,printaLAtual[0]
    	add al,30h
    	mov printaLAtualAux[0],al 
    	mov bp,offset printaLAtualAux[0]
    	call ESC_STR_VIDEO  
    	
    	mov bl,0100b
    	mov cx,1
    	mov dh,3
    	mov dl,9   
    	mov al,printaLAtual[1]
    	add al,30h
    	mov printaLAtualAux[1],al 
    	mov bp,offset printaLAtualAux[1]
    	call ESC_STR_VIDEO  
    	
    	mov bl,0100b
    	mov cx,1
    	mov dh,3
    	mov dl,10   
    	mov al,printaLAtual[2]
    	add al,30h
    	mov printaLAtualAux[2],al 
    	mov bp,offset printaLAtualAux[2]
    	call ESC_STR_VIDEO             
    	
    	mov bl,0100b
    	mov cx,1
    	mov dh,3
    	mov dl,11   
    	mov al,printaLAtual[3]
    	add al,30h
    	mov printaLAtualAux[3],al 
    	mov bp,offset printaLAtualAux[3]
    	call ESC_STR_VIDEO  
    	 
    	pop si
    	pop dx
    	pop cx
    	pop bx
    	pop ax
	    
	    ret
	endp  
    ;----------------------------------------------------------------------------------------------------------------------
    
    
    
    ;----------------------------------------------------------------------------------------------------------------------
    ;LE OPCOES TELAS DE MENU
    ; LE A OPCAO
    ; AL = num lido
    OPCAO_MENU proc
      LACO:
        call LE_CARACTER
        cmp al,'1'
        jb LACO
        cmp al,'2'
        jg LACO
        sub al,'0'
        ret
    endp  
    
    OPCAO_MENU_LEITURA proc
      LACO2:
        call LE_CARACTER
        cmp al,'0'
        jb LACO2
        cmp al,'0'
        jg LACO2
        sub al,'0'
        ret
    endp 
    
	printa_validas proc
	    
	    push ax
	    push bx
	    push cx
	    push dx 
		push si
	    
		xor si,si
	    ;incrementar vetor printaValidas
		mov si, offset printaValidas
		add si,3
		call incrementar
	    
    	mov bl,0010b
    	mov cx,1
    	mov dh,3
    	mov dl,25   
    	mov al,printaValidas[0]
    	add al,30h
    	mov printaValidasAux[0],al 
    	mov bp,offset printaValidasAux[0]
    	call ESC_STR_VIDEO  
    	
    	mov bl,0010b
    	mov cx,1
    	mov dh,3
    	mov dl,26   
    	mov al,printaValidas[1]
    	add al,30h
    	mov printaValidasAux[1],al 
    	mov bp,offset printaValidasAux[1]
    	call ESC_STR_VIDEO  
    	
    	mov bl,0010b
    	mov cx,1
    	mov dh,3
    	mov dl,27   
    	mov al,printaValidas[2]
    	add al,30h
    	mov printaValidasAux[2],al 
    	mov bp,offset printaValidasAux[2]
    	call ESC_STR_VIDEO             
    	
    	mov bl,0010b
    	mov cx,1
    	mov dh,3
    	mov dl,28   
    	mov al,printaValidas[3]
    	add al,30h
    	mov printaValidasAux[3],al 
    	mov bp,offset printaValidasAux[3]
    	call ESC_STR_VIDEO  
    	
		pop si
    	pop dx
    	pop cx
    	pop bx
    	pop ax
	    
	    ret
	endp
	
	printa_instaladas proc
	    
	    push ax
	    push bx
	    push cx
	    push dx 
		push si
	    
		xor si,si
	    ;incrementar vetor printaInstaladas
		mov si, offset printaInstaladas
		add si,3
		call incrementar
		
    	mov bl,0110b
    	mov cx,1
    	mov dh,3
    	mov dl,45  
    	mov al,printaInstaladas[0]
    	add al,30h
    	mov printaInstaladasAux[0],al 
    	mov bp,offset printaInstaladasAux[0]
    	call ESC_STR_VIDEO      	
    	
    	mov bl,0110b
    	mov cx,1
    	mov dh,3
    	mov dl,46   
    	mov al,printaInstaladas[1]
    	add al,30h
    	mov printaInstaladasAux[1],al 
    	mov bp,offset printaInstaladasAux[1]
    	call ESC_STR_VIDEO  
    	
    	mov bl,0110b
    	mov cx,1
    	mov dh,3
    	mov dl,47   
    	mov al,printaInstaladas[2]
    	add al,30h
    	mov printaInstaladasAux[2],al 
    	mov bp,offset printaInstaladasAux[2]
    	call ESC_STR_VIDEO             
    	
    	mov bl,0110b
    	mov cx,1
    	mov dh,3
    	mov dl,48   
    	mov al,printaInstaladas[3]
    	add al,30h
    	mov printaInstaladasAux[3],al 
    	mov bp,offset printaInstaladasAux[3]
    	call ESC_STR_VIDEO  
    	
		pop si
    	pop dx
    	pop cx
    	pop bx
    	pop ax
	    
	    ret
	endp
    ;----------------------------------------------------------------------------------------------------------------------
    
    ;----------------------------------------------------------------------------------------------------------------------
    ;GRAVACAO
     
      geraArquivoVal proc
        call printa_instaladas 
        call print_sensores_instalados 
        mov ah, 3dh
        mov al, 2
        lea dx,FileNameAtiv 
        int 21h
        jc err_openval  
         mov HandleAtivValidas, ax       
          xor dx,dx
           mov ax,HandleAtivValidas    
           mov bx, ax
           mov ah, 42h  ; "lseek"
           mov al, 2    ; position relative to end of file
           mov cx, 0    ; offset MSW
           mov dx, 0    ; offset LSW
           int 21h
           jc err_seekval
        
           lea dx, bufferAtivDetectadas
           mov bx, HandleAtivValidas
           mov cx, 28
           mov ah, 40h
           int 21h ; write to file...
           jc err_writeval
        
           mov bx, HandleAtivValidas
           mov ah, 3eh
           int 21h ; close file...
           jc err_closeval
        
            exitval:
               ret  
            err_openval:            
               jmp error        
            err_seekval:          
               jmp error
            err_writeval:
             jmp error
            err_closeval:
            errorval:
               mov ah, 09h
               int 21h
               mov ax, 4c01h
               int 21h
            err_exitval: 
             
               ret
     endp
     
     gera_arquivo proc   
        call load
        mov si, offset codDecSensor
        mov dx, [si]
        mov num1,dl
        mov num2,10h
        call divide 
        mov al, num1
        mov ah, num2
        mov contTemp[0],0
        mov contTemp[1],0 
        mov contTemp[2],al
        mov contTemp[3],ah  
        call copy 
        call somar
        call gerarLinha
        call save
        call printa_validas  
        call print_sensores_encontrados
	    ret
     endp      
    
     load proc
        mov ah, 3dh
        mov al, 2
        lea dx,FileNameAtivDetectadas 
        int 21h
        jc err_open  
        mov handel, ax
        ret
     endp
	 save proc 
       xor dx,dx
       
       mov ax,handel   
       mov bx, ax
       mov ah, 42h  ; "lseek"
       mov al, 2    ; position relative to end of file
       mov cx, 0    ; offset MSW
       mov dx, 0    ; offset LSW
       int 21h
       jc err_seek
    
       lea dx, linhafinal
       mov bx, handel
       mov cx, 28
       mov ah, 40h
       int 21h ; write to file...
       jc err_write
    
       mov bx, handel
       mov ah, 3eh
       int 21h ; close file...
       jc err_close
    
        exit:
           ret  
        err_open:            
           jmp error        
        err_seek:          
           jmp error
        err_write:
         jmp error
        err_close:
        error:
           mov ah, 09h
           int 21h
        
           mov ax, 4c01h
           int 21h
        err_exit:
           ret
        
    endp
    
    gerarLinha proc 
        xor si,si  
        xor dx,dx
        mov dl, data01[0]
        mov linhaFinal[si],dl
        inc si 
        xor dx,dx
        mov dl, data01[1]
        mov linhaFinal[si],dl
        inc si 
        xor dx,dx
        mov dl, data01[2]
        mov linhaFinal[si],dl
        inc si 
        xor dx,dx
        mov dl, data01[3]
        mov linhaFinal[si],dl
        inc si 
        xor dx,dx
        mov dl, data01[4]
        mov linhaFinal[si],dl
        inc si 
        xor dx,dx
        mov dl, data01[5]
        mov linhaFinal[si],dl
        inc si 
        xor dx,dx
        mov dl, data01[6]
        mov linhaFinal[si],dl
        inc si 
        xor dx,dx
        mov dl, data01[7]
        mov linhaFinal[si],dl
        inc si 
        mov linhaFinal[si],09h
        inc si 
        xor dx,dx
        mov dl, hora01[0]
        mov linhaFinal[si],dl
        inc si 
        xor dx,dx
        mov dl, hora01[1]
        mov linhaFinal[si],dl
        inc si 
        xor dx,dx
        mov dl, hora01[2]
        mov linhaFinal[si],dl
        inc si
        xor dx,dx
        mov dl, hora01[3]
        mov linhaFinal[si],dl
        inc si
        xor dx,dx
        mov dl, hora01[4]
        mov linhaFinal[si],dl
        inc si
        xor dx,dx
        mov dl, hora01[5]
        mov linhaFinal[si],dl
        inc si 
        xor dx,dx
        mov dl, hora01[6]
        mov linhaFinal[si],dl
        inc si
        xor dx,dx
        mov dl, hora01[7]
        mov linhaFinal[si],dl
        inc si
        xor dx,dx  
        mov dl, hora01[8]
        mov linhaFinal[si],dl
        inc si 
        mov linhaFinal[si],09h
        inc si 
        xor dx,dx
        mov dl,sensorFinal[0]   
        add dl,30h
        mov linhaFinal[si],dl
        inc si
        xor dx,dx
        mov dl,sensorFinal[1] 
        add dl,30h 
        mov linhaFinal[si],dl
        inc si
        xor dx,dx
        mov dl,sensorFinal[2] 
        add dl,30h 
        mov linhaFinal[si],dl
        inc si
        xor dx,dx
        mov dl,sensorFinal[3]
        add dl,30h
        mov linhaFinal[si],dl
        inc si 
        
        mov linhaFinal[si],09h
        inc si 
        xor dx,dx
        mov dx,estadoSensor
        add dx,30h
        mov linhaFinal[si],dl
        inc si 
        mov linhaFinal[si],09h 
        inc si
        xor dx,dx
        mov dl, nroAtivacoes
        add dx,30h
        mov linhaFinal[si],dl        
        inc si 
        mov linhaFinal[si],0Ah  
        ret     
    endp 
    
    divide proc 
        push ax
        push bx
        push cx
        MOV BL, num1
        MOV CL, num2
    
        ; divide
        MOV AH, 0 ; prepare dividend
        MOV AL, BL
        DIV CL
        MOV NUM1, AL
        MOV NUM2, AH
        
        pop cx
        pop bx
        pop ax
        ret 
    endp
    
    copy proc
        xor si,si
        xor dx,dx
        
        mov dx,sensorPosicao01
        mov sensorTemp[si],dl
        cmp dx,20h
        jz zera1
        cmp dx,09h
        jz zera1
        cmp dx,29h
        jz zera1 
        cmp dx,0Ah
        jz zera1 
        jmp sensor2
        zera1:
            mov dx,0h
            mov sensorTemp[si],dl 
        sensor2:
            inc si
            xor dx,dx
            mov dx,sensorPosicao02  
             mov sensorTemp[si],dl
            cmp dx,20h
            jz zera2
            cmp dx,09h
            jz zera2
            cmp dx,29h
            jz zera2 
            cmp dx,0Ah
            jz zera2 
            jmp sensor3
        zera2:
            mov dx,0h  
            mov sensorTemp[si],dl
            call desloca2  
        sensor3:
            inc si
            xor dx,dx
            mov dx,sensorPosicao03 
            mov sensorTemp[si],dl
            cmp dx,20h
            jz zera3
            cmp dx,09h
            jz zera3
            cmp dx,29h
            jz zera3 
            cmp dx,0Ah
            jz zera3 
            jmp sensor4
        zera3:   
            mov dx,0h
            mov sensorTemp[si],dl
            call desloca3 
        sensor4:   
            inc si
            xor dx,dx  
            mov dx,sensorPosicao04
            mov sensorTemp[si],dl
            cmp dx,20h
            jz zera4
            cmp dx,09h
            jz zera4
            cmp dx,29h
            jz zera4 
            cmp dx,0Ah
            jz zera4 
            jmp fimcpy
        zera4:       
            mov dx,0h 
            mov sensorTemp[si],dl
            call desloca4
        fimcpy:    
        ret
    endp
     
    
    desloca2 proc
        push si
        push bx
        xor si,si
        xor bx,bx
        mov si,0
        mov bl,sensorTemp[si]
        mov si,1
        mov sensorTemp[si],bl
        dec si
        mov sensorTemp[si],0
        pop bx
        pop si
        ret
    endp   
	
    desloca3 proc
        push si
        push bx
        xor si,si
        xor bx,bx
        mov si,1
        mov bh,sensorTemp[si]
        dec si
        mov bl,sensorTemp[si]
        mov si,2
        mov sensorTemp[si],bh
        dec si
        mov sensorTemp[si],bl
        dec si
        mov sensorTemp[si],0
        pop bx
        pop si
        ret
    endp
	
    desloca4 proc
        push si
        push bx
        push dx
        xor si,si
        xor bx,bx
        mov si,2
        mov bh,sensorTemp[si]
        dec si
        mov bl,sensorTemp[si]
        dec si
        mov dl,sensorTemp[si]
        mov si,3
        mov sensorTemp[si],bh
        dec si
        mov sensorTemp[si],bl
        dec si
        mov sensorTemp[si],dl 
        dec si
        mov sensorTemp[si],0
        pop dx
        pop bx
        pop si
        ret
    endp
	
    somar proc 
        push si 
        push ax
        push bx
        push cx
        push dx
       
        xor si,si
        xor cx,cx
        mov si,3h
        mov cl,4h
        mov carry,0
        adicionar: 
            xor bx,bx
            xor dx,dx
            mov bl,sensorTemp[si]
            mov dl,contTemp[si]
            add dx,bx
            cmp dl, 09h 
            jle cont_carry 
            add dx,6h
        cont_carry:    
            cmp carry,0
            jg addCarry
            jmp calcCarry
        addCarry:
            cmp dl,09h
            jz d
            jmp c 
          d:  
            add dx,6h
          c:  
            add dl,carry
            mov carry,0        
        calcCarry:
            cmp dl,09h
            jle adddx
            jmp dividir
        adddx: 
            mov sensorFinal[si],dl  
            jmp fimloop
        dividir:
            mov num1,dl
            mov num2,10h
            call divide 
            mov al, num1
            mov ah, num2
            add carry,al
            mov sensorFinal[si],ah 
        
        fimloop:
        dec si
        loop adicionar 
       fim_soma:
        pop dx
        pop cx
        pop bx
        pop ax
        pop si 
        ret
    endp

    ;----------------------------------------------------------------------------------------------------------------------
           
    ;----------------------------------------------------------------------------------------------------------------------
    ;VALIDACOES
    
	toHex proc
	  cmp AL,30h
	  jge Menor
	  jmp Fim
	  Menor: 
	   cmp AL,39h
	   jle Sub1
	   jmp Maiorh 
	  Sub1:
	    SUB AL,30h
	  Maiorh:
	      cmp AL,61h
	      jge Menorh
	      jmp Fim 
	  Menorh:
	    cmp AL,66h
	    jle Sub2
	    jmp Fim
	  Sub2:
	    SUB AL,51h
	  
	Fim:
		ret
	endp
	
	toAsc proc
	    cmp al,9h
	    jle menor10
	    jmp maior10
	    
	    menor10:
	        add al,30h
	        jmp fimToAsc
	    
	    maior10:
	        add al,51h
	    
	    fimToAsc:
	        ret
	endp
	 
 verifica_tempo proc  
	    push ax
	    push bx
	    push cx
	    push dx
	    push si
	    
	    mov resultTempo[0],0
	    mov resultTempo[1],0
	    mov resultTempo[2],0
	    mov resultTempo[3],0
	    mov resultTempo[4],0
	    mov resultTempo[5],0
	    mov resultTempo[6],0
	    mov resultTempo[7],0
	    mov resultTempo[8],0 
	     
        xor cx,cx
        xor si,si   
    
        mov flagTempo,1      
        mov contTempo,0
     
          
        subtrai:
            mov contTempo,0h            
            call sb
            
            xor bx,bx             
            mov si,4
            mov cl,2
            call toNumber
            cmp bl,40h
            jge sub40
            jmp teste 
            
        sub40: 
            sub bl,40h
            mov NUM1,bl
            mov NUM2,10H
            call divide 
            mov resultTempo[4],ah
            mov resultTempo[5],al                     
                                 
        teste:
            cmp flagTempo,0
            jz fimcode
            cmp modeTempo,0
            jz mode1
            jmp mode2
    
        mode1:
            xor bx,bx   
            mov cl,2
            mov si,4  
		   
            call toNumber  
            cmp bl,5h
            jz cmpseg
            jl recebe0
            jg recebe1
        cmpseg:  
            xor bx,bx 
            mov cl,3
            mov si,6
		   
            call toNumber
            cmp bl,0  
            jg recebe1
					 
            jmp recebe0 
        mode2: 
            xor bx,bx 
            mov cl,2
            mov si,4
            call toNumber
            cmp bx,0h
            jz cmpmili
					
            jmp recebe0
        cmpmili:     
            xor bx,bx 
            mov cl,3
            mov si,6
				 
            call toNumber
            cmp bx,20h
            jle recebe1
					
            jmp recebe0
        recebe0:
            mov flagTempo,0
            jmp fimcode
        recebe1:
            mov flagTempo,1
            jmp fimcode   
        fimcode:
            pop si
            pop dx
            pop cx
            pop bx
            pop ax          
            ret
	endp 
	
	sb proc 
				
        xor cx,cx 
        mov cl,9
        loopsub: 
            call setBxDX
            sub bl,dl
            cmp bl,0
            jge maiors
            jmp menors
        maiors:
            mov resultTempo[si],bl
            jmp fimloopsub
        menors:
            dec si
            mov dl,resultTempo[si]
            inc si
            cmp dl, 0
            jge carry2
            jmp invalido
        carry2:
            sub dl,1
            add bl,10
            mov resultTempo[si],bl
            dec si
            mov resultTempo[si],dl
            inc si
            jmp fimloopsub 
        invalido:
            mov flagTempo,0
            jmp fimsub
    
        fimloopsub:
            inc si
            loop loopsub    
        fimsub: 
            ret
    endp  
	     
	toNumber proc 
	    xor bx,bx
        xor ax,ax
        resultloop: 
            mov al,resultTempo[si]    
            xor ah,ah
            add bx,ax
            cmp cl,1
            jz fimresult
            mov al,10h  
            mul bx
            mov bx,ax
            inc SI  
            loop resultloop  
        fimresult:
            ret 
	endp
	
	      
    setBxDX proc   
        push si 
        xor si,si
        mov si,contTempo
        cmp modeTempo,0
        jz mode1l
        jmp mode2l
        mode1l:
            mov bl, horaTemp[si]
            sub bl,30h
            mov dl,hora01[si]
            sub dl,30h    
            jmp fimstore
        mode2l:
            mov bl,horaTempConj[si]
            sub bl,30h
            mov dl,horaTemp[si]
            sub dl,30h
            jmp fimstore
        fimstore:
            inc si
            mov contTempo,si  
        pop si
        ret
    endp    
    
    isEquals proc 
        xor cx,cx
        xor bx,bx
        xor dx,dx
        mov cl,4
        mov si,0
        loopeq:   
            call setBxDX
            cmp bx,dx
            jnz notEquals     
            jmp fimloopeq            
        fimloopeq:
            loop loopeq
            jmp fimequals
        notEquals:
            mov flagTempo,0 
        fimequals:   
            ret
    endp      
	     
    valida_soma_lin01 proc          ; valida a soma da primeira linha
        push dx
        push bx
        mov dx,0
        mov bx,0
         
        mov si,OFFSET buffer04      ; DS:SI - endereco da string
        add si,17h                  ; Posiciona o SI no 5 caracter 
        mov cl,5                    ; Coloca o contador do loads b em 5 
        
        mov somaLinha1,0
        
        Itera:
    
            lodsb                   ; AL = proximo caracter da string
            cmp cl, 5
            jz copiaDH
        Continuarv1: 
            cmp cl, 4
            jz copiaBH
        Continuarv2: 
            cmp cl, 3
            jz copiaDL
        Continuarv3:
            cmp cl, 2
            jz copiaBL
        loop1:
            loop Itera
            jmp FINALvs
            
        copiaDH:
          call toHex
          mov dh, al
          jmp Continuarv1
          
        copiaBH:
          call toHex
          mov bh, al
          jmp Continuarv2
         
        copiaDL:
          call toHex
          mov dl,al 
          jmp Continuarv3 
          
        copiaBL:
          call toHex
          mov bl,al
          jmp Adiciona  
          
        Adiciona:
        
            add dh,dl
            add bh,bl
            cmp dh,15H               ; se o RG estiver com 15
            jz Compara
            
            cmp dh,15                ; se o RG estiver com F
            jz Compara
            
            mov somaLinha1,0
            jmp FINALvs

            
        Compara:
            cmp bh,15               ; se o RG estiver com 15
            jz soma_validada
            
            cmp bh,15h                ; se o RG estiver com F
            jz soma_validada
            
            mov somaLinha1,0
            jmp FINALvs

            
        soma_validada:               ; se a soma estiver correta,
            mov somaLinha1,1             
        
        FINALvs:
        
        pop bx
        pop dx
        ret
    endp 
    
        
    valida_arquivo proc
        
        call ler_arq04    
        
        ret
    endp 
    
    validarX10Map proc 
        

        mov validadorX10Map, 0              ; quando comecar a validar arquivo, zerar validador
        mov flagX10Map, 0                   ; caso finalizar com 1, validara X10OnOff
        mov posX10Map,0                     ; zera a cada nova validacao

        mov si,OFFSET buffer01              ; DS:SI - endereco da string
                      
        ;---------------------------------------LACO PRINCIPAL
        iteraX10Map:
            lodsb
            inc posX10Map
            
            cmp validadorX10Map, 4           ; linha e valida, guardar codigo do sensor
            jz guardaCodigoSensor
            
        continuaCodigoGravado:
            ;cmp posX10Map, 10H              ; se chegou ao final da linha, muda para 1 para indicar primeiro caracter da proxima linha
            cmp AL,0AH                       ; nova condicao para troca de linha
            jz novaLinhaX10Map
            
            
        ContinuaX10Map:
        
            ;para os primeiros 4 caracteres da linha que possuem identificacao hexa do sensor
            cmp posX10Map,1
            jz comparaCarac1X10Map
            
            cmp posX10Map,2 
            jz comparaCarac2X10Map
            
            cmp posX10Map,3 
            jz comparaCarac3X10Map
            
            cmp posX10Map,4 
            jz comparaCarac4X10Map
            
         continuaFimIDSensor:   
            
              
            ;finaliza iteracao se chegar ao final do arquivo ou se encontrar sensor valido
            cmp al, 0H
            jz fimIteraX10Map
            cmp validadorX10Map, 4
            jz fimIteraX10Map
            jmp iteraX10Map
        ;---------------------------------------FIM LACO PRINCIPAL             
            
        guardaCodigoSensor:                 ; verifica em qual posicao esta
            cmp posX10Map, 8
            jz guardaPosicao01
            
            cmp posX10Map, 9
            jz guardaPosicao02
            
            cmp posX10Map, 10
            jz guardaPosicao03
            
            cmp posX10Map, 11
            jz guardaPosicao04 
            
            jmp continuaCodigoGravado
       
       
       ; quando linha for validada, guardara posicao 8, 9, 10 e 11 da linha como codigo do sensor (pode ser 2, 3 ou 4 caracteres)     
       guardaPosicao01: 
           call toHex 
           mov b.sensorPosicao01Temp, AL
           jmp continuaCodigoGravado
       
       guardaPosicao02: 
           call toHex
           mov b.sensorPosicao02Temp, AL
           jmp continuaCodigoGravado
       
       guardaPosicao03:
           call toHex
           mov b.sensorPosicao03Temp, AL
           jmp continuaCodigoGravado 
       
       guardaPosicao04:
           call toHex
           mov b.sensorPosicao04Temp, AL
           jmp continuaCodigoGravado                    
                
            
                        
        novaLinhaX10Map:   
            cmp validadorX10Map, 4          ; se ver que e nova linha mas a linha atual tiver validada, nao permitir ir para nova linha
            jz continuaX10Map
            mov posX10Map,0
            mov validadorX10Map, 0
            jmp iteraX10Map 
            
        comparaCarac1X10Map:
            call toHex
            cmp AL,DH
            jz incrementaValidadorX10Map
            jmp continuaFimIdSensor
        
        comparaCarac2X10Map:
            call toHex
            cmp AL,BH
            jz incrementaValidadorX10Map
            jmp continuaFimIdSensor

        comparaCarac3X10Map:             
            call toHex 
            cmp AL,DL
            jz incrementaValidadorX10Map
            jmp continuaFimIdSensor

        comparaCarac4X10Map:             
            call toHex 
            cmp AL,BL
            jz incrementaValidadorX10Map
            jmp continuaFimIdSensor
            
            
        incrementaValidadorX10Map:                  ; se for 4, achou sensor valido
            inc validadorX10Map
            jmp continuaFimIdSensor
            
        X10MapValido:
            mov flagX10Map,1
            jmp returnX10Map                      
                                   
        ; para execucao se acabou arquivo ou achou sensor valido, achando sensor valido percorre ate final da linha
        fimIteraX10Map:
            cmp posX10Map, 15                       ; para ser final deve estar no final da linha, protecao caso encontrar 0 na linha
            jl iteraX10Map
            
            ;se realmente sai, verifica se encontrou identificacao valida
            cmp validadorX10Map, 4
            jz X10MapValido                         ; seta flag
        
        returnX10Map:     
            
            ret
    endp
    
    validarX10OnOff proc
        
        ;TESTE
                
        mov validadorX10OnOff, 0             ; quando comecar a validar arquivo, zerar validador
        mov flagX10OnOff, 0                  ; caso finalizar com 1 considerara conjunto das duas linhas como valido
        mov posX10OnOff, 0                   ; zera a cada nova validacao
                
        mov si,OFFSET buffer02              ; DS:SI - endereco da string
        
        ;---------------------------------------LACO PRINCIPAL
        iteraX10OnOff:
        	lodsb
        	inc posX10OnOff
        	
        	cmp validadorX10OnOff, 4
        	jz guardaCodigoInteiro
        	
        continuaCodigoInteiroGravado:
        	cmp AL,0AH
        	jz novaLinhaX10OnOff
        	
        continuaX10OnOff:
        	cmp posX10OnOff,1
            jz comparaCarac1X10OnOff
                    
            cmp posX10OnOff,2 
            jz comparaCarac2X10OnOff
                    
            cmp posX10OnOff,3 
            jz comparaCarac3X10OnOff
                    
            cmp posX10OnOff,4 
            jz comparaCarac4X10OnOff
        	
        continuaFimIdSensorOnOff:
        	cmp AL,0H
        	jz fimIteraX10OnOff
        	cmp validadorX10OnOff,4
        	jz fimIteraX10OnOff
        	loop iteraX10OnOff
        	
        ;---------------------------------------FIM LACO PRINCIPAL             	
        	
        guardaCodigoInteiro:
        	cmp posX10OnOff, 7
        	jz guardaPosicao07       	
        	cmp posX10OnOff, 9
        	jz guardaPosicao9
        	jmp continuaCodigoInteiroGravado
        	
        guardaPosicao07:
            call toHex
        	mov b.codDecSensorTemp,AL
        	jmp continuaCodigoInteiroGravado
        	
        guardaPosicao9:
            call toHex
        	mov b.estadoSensorTemp,AL
        	jmp continuaCodigoInteiroGravado        	
        	
        novaLinhaX10OnOff:
        	cmp validadorX10OnOff,4
        	jz continuaX10OnOff
        	mov posX10OnOff,0
        	mov validadorX10OnOff,0
        	jmp iteraX10OnOff
        	
        comparaCarac1X10OnOff:
            call toHex
            cmp AL,DH
            jz incrementaValidadorX10OnOff
            jmp continuaFimIdSensorOnOff
        
        comparaCarac2X10OnOff:
            call toHex
            cmp AL,BH
            jz incrementaValidadorX10OnOff
            jmp continuaFimIdSensorOnOff
        
        comparaCarac3X10OnOff:
            call toHex
            cmp AL,DL
            jz incrementaValidadorX10OnOff
            jmp continuaFimIdSensorOnOff
        
        comparaCarac4X10OnOff:
            call toHex
            cmp AL,BL
            jz incrementaValidadorX10OnOff
            jmp continuaFimIdSensorOnOff
        
        incrementaValidadorX10OnOff:
        	inc validadorX10OnOff
        	jmp continuaFimIdSensorOnOff
        	
        fimIteraX10OnOff:
        	cmp posX10OnOff, 10                     ; para dar linha como valida, tem que estar no final dessa, previne que ao ler 0
        	jl iteraX10OnOff                        ; no meio da linha, de arquivo como finalizado
        	
        	;realmente saira da proc
        	cmp validadorX10OnOff,4
        	jz X10OnOffValido
        	jmp returnX10OnOff
        	
        X10OnOffValido:                             ; para ativar flag de validacao
            mov flagX10OnOff,1
        	
        returnX10OnOff:
      		ret
    		
    endp  
    
    compararCodL02 proc                             ; comparar codigo hexa da linha 2 com o codigo hexa da linha atual do ati
        push ax
        mov flagCompararCodL02,0
        
        mov al,codigoTempConj[0]
        cmp al,codigo02[0]
        jz continuaCompararCodL02V1
        jmp fimCompararCodL02
        
        continuaCompararCodL02V1:
            mov al,codigoTempConj[1]
            cmp al,codigo02[1]
            jz continuaCompararCodL02V2
            jmp fimCompararCodL02
            
        continuaCompararCodL02V2:
            mov al,codigoTempConj[2]
            cmp al,codigo02[2]
            jz continuaCompararCodL02V3
            jmp fimCompararCodL02
            
        continuaCompararCodL02V3:
            mov al,codigoTempConj[3]
            cmp al,codigo02[3]
            mov flagCompararCodL02,1
            jmp fimCompararCodL02        
        
        fimCompararCodL02:
            pop ax
            ret
            
    endp
    
    compararCodL01 proc                             ; comparar codigo hexa da linha 1 com o codigo hexa da linha atual do ati
        push ax
        mov flagCompararCodL01,0
       
        mov al,codigoTemp[0]
        cmp al,codigo01[0]
        jz continuaCompararCodL01V1
        jmp fimCompararCodL01
       
        continuaCompararCodL01V1:
		    mov al,codigoTemp[1]
		    cmp al,codigo01[1]
            jz continuaCompararCodL01V2
            jmp fimCompararCodL01
            
        continuaCompararCodL01V2:
            mov al,codigoTemp[2]
            cmp al,codigo01[2]
            jz continuaCompararCodL01V3
            jmp fimCompararCodL01
            
        continuaCompararCodL01V3:
            mov al,codigoTemp[3]
            cmp al,codigo01[3]
            mov flagCompararCodL01,1
            jmp fimCompararCodL01        
        
        fimCompararCodL01:
            pop ax
            ret
            
    endp    
    
    guardaCodSensorValidaMapEOnOff proc             ; guarda codigo em hexa do sensor para buscar no map e no OnOff
        mov si,OFFSET buffer04
        mov cl,28h 
        
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb  
        
        lodsb
        call toHex
        mov codigoVerif[0],al
        lodsb
        call toHex
        mov codigoVerif[1],al
        lodsb             
        call toHex
        mov codigoVerif[2],al
        lodsb             
        call toHex
        mov codigoVerif[3],al

        ret
        
    endp
    
    
    guardaDadosAtivacaoL01 proc       ; para realizar testes depois da soma
        
        ;LINHA1 ---------------------------------------------------------------
        
        push ax
        mov si,OFFSET buffer04        ; DS:SI - endereco da string
        mov cl,28H   
                
        mov flagOcup01,1
        
        lodsb
        lodsb
        lodsb
        lodsb
        
        lodsb
        mov data01[0],al
        lodsb
        mov data01[1],al
        lodsb
        mov data01[2],al 
        lodsb
        mov data01[3],al
        lodsb
        mov data01[4],al 
        lodsb
        mov data01[5],al 
        lodsb
        mov data01[6],al
        lodsb
        mov data01[7],al 
        
        lodsb
        
        lodsb
        mov hora01[0],al         
        lodsb
        mov hora01[1],al        
        lodsb
        mov hora01[2],al        
        lodsb
        mov hora01[3],al
        lodsb
        mov hora01[4],al
        lodsb
        mov hora01[5],al
        lodsb
        mov hora01[6],al
        lodsb
        mov hora01[7],al
        lodsb
        mov hora01[8],al
        
        lodsb
        
        lodsb
        call toHex
        mov codigo01[0],al
        lodsb
        call toHex
        mov codigo01[1],al
        lodsb             
        call toHex
        mov codigo01[2],al
        lodsb             
        call toHex
        mov codigo01[3],al
        
        mov ax,sensorPosicao01Temp
        mov sensorPosicao01,ax   
        
        mov ax,sensorPosicao02Temp
        mov sensorPosicao02,ax
        
        mov ax,sensorPosicao03Temp
        mov sensorPosicao03,ax
        
        mov ax,sensorPosicao04Temp
        mov sensorPosicao04,ax
           
        mov ax,codDecSensorTemp
        mov codDecSensor,ax
        
        mov ax,estadoSensorTemp
        mov estadoSensor,ax   
           
           
		pop ax
		ret
    endp	
    
    guardaDadosAtivacaoTemp proc     
                
        
        mov si,OFFSET buffer04	      ; DS:SI - endereco da string
        mov cl,28H
        
        mov flagOcupTemp,1
        
        lodsb
        lodsb
        lodsb
        lodsb
        
        lodsb
        mov dataTemp[0],al
        lodsb
        mov dataTemp[1],al
        lodsb
        mov dataTemp[2],al 
        lodsb
        mov dataTemp[3],al
        lodsb
        mov dataTemp[4],al 
        lodsb
        mov dataTemp[5],al 
        lodsb
        mov dataTemp[6],al
        lodsb
        mov dataTemp[7],al 
        
        lodsb
        
        lodsb
        mov horaTemp[0],al         
        lodsb
        mov horaTemp[1],al        
        lodsb
        mov horaTemp[2],al        
        lodsb
        mov horaTemp[3],al
        lodsb
        mov horaTemp[4],al
        lodsb
        mov horaTemp[5],al
        lodsb
        mov horaTemp[6],al
        lodsb
        mov horaTemp[7],al
        lodsb
        mov horaTemp[8],al
        
        lodsb
        
        lodsb
        call toHex
        mov codigoTemp[0],al
        lodsb
        call toHex
        mov codigoTemp[1],al
        lodsb  
        call toHex
        mov codigoTemp[2],al
        lodsb
        call toHex
        mov codigoTemp[3],al
            
        ret
        
    endp         
    
    
    guardaDadosAtivacaoTempConj proc     
                
        
        mov si,OFFSET buffer04	      ; DS:SI - endereco da string
        mov cl,28H
        
        mov flagOcupTempConj,1
        
        lodsb
        lodsb
        lodsb
        lodsb
        
        lodsb
        mov dataTempConj[0],al
        lodsb
        mov dataTempConj[1],al
        lodsb
        mov dataTempConj[2],al 
        lodsb
        mov dataTempConj[3],al
        lodsb
        mov dataTempConj[4],al 
        lodsb
        mov dataTempConj[5],al 
        lodsb
        mov dataTempConj[6],al
        lodsb
        mov dataTempConj[7],al 
        
        lodsb
        
        lodsb
        mov horaTempConj[0],al         
        lodsb
        mov horaTempConj[1],al        
        lodsb
        mov horaTempConj[2],al        
        lodsb
        mov horaTempConj[3],al
        lodsb
        mov horaTempConj[4],al
        lodsb
        mov horaTempConj[5],al
        lodsb
        mov horaTempConj[6],al
        lodsb
        mov horaTempConj[7],al
        lodsb
        mov horaTempConj[8],al
        
        lodsb
        
        lodsb
        call toHex
        mov codigoTempConj[0],al
        lodsb
        call toHex
        mov codigoTempConj[1],al
        lodsb  
        call toHex
        mov codigoTempConj[2],al
        lodsb
        call toHex
        mov codigoTempConj[3],al
            
        ret
        
    endp
    
    limpaL01L02 proc
        
        mov flagOcup01,0
        mov flagOcup02,0          
        
        ; LINHA1 ---------------------------------------------------------------
        
        mov data01[0],0
        mov data01[1],0
        mov data01[2],0 
        mov data01[3],0
        mov data01[4],0 
        mov data01[5],0 
        mov data01[6],0
        mov data01[7],0 
        
        mov hora01[0],0         
        mov hora01[1],0        
        mov hora01[2],0        
        mov hora01[3],0
        mov hora01[4],0
        mov hora01[5],0
        mov hora01[6],0
        mov hora01[7],0
        mov hora01[8],0
        
        mov codigo01[0],0
        mov codigo01[1],0
        mov codigo01[2],0
        mov codigo01[3],0
		
        ;----------------------------------------------------------------------
        
        ; LINHA2 ---------------------------------------------------------------   
        
        mov data02[0],0
        mov data02[1],0
        mov data02[2],0 
        mov data02[3],0
        mov data02[4],0 
        mov data02[5],0 
        mov data02[6],0
        mov data02[7],0 
        

        mov hora02[0],0         
        mov hora02[1],0        
        mov hora02[2],0        
        mov hora02[3],0
        mov hora02[4],0
        mov hora02[5],0
        mov hora02[6],0
        mov hora02[7],0
        mov hora02[8],0

        mov codigo02[0],0
        mov codigo02[1],0
        mov codigo02[2],0
        mov codigo02[3],0
  
        ;----------------------------------------------------------------------

        ret
    endp
    
    limpaTemp proc          
        
        mov flagOcupTemp,0
        
        mov dataTemp[0],0
        mov dataTemp[1],0
        mov dataTemp[2],0 
        mov dataTemp[3],0
        mov dataTemp[4],0 
        mov dataTemp[5],0 
        mov dataTemp[6],0
        mov dataTemp[7],0 
            
        mov horaTemp[0],0         
        mov horaTemp[1],0        
        mov horaTemp[2],0        
        mov horaTemp[3],0
        mov horaTemp[4],0
        mov horaTemp[5],0
        mov horaTemp[6],0
        mov horaTemp[7],0
        mov horaTemp[8],0
           
        mov codigoTemp[0],0
        mov codigoTemp[1],0
        mov codigoTemp[2],0
        mov codigoTemp[3],0

        ret
    endp 
    
    movConteudoTempParaL01 proc          
        
		push ax
		mov flagOcup01,1
                
        mov al,dataTemp[0]
		mov data01[0],al
		
		mov al,dataTemp[1]
		mov data01[1],al
		
		mov al,dataTemp[2]
		mov data01[2],al
		
		mov al,dataTemp[3]
		mov data01[3],al
        
        mov al,dataTemp[4]
		mov data01[4],al 
        
		mov al,dataTemp[5]
		mov data01[5],al
        
        mov al,dataTemp[6]
		mov data01[6],al
		
		mov al,dataTemp[7]
		mov data01[7],al
		
		mov al,horaTemp[0]
		mov hora01[0],al
        
		mov al,horaTemp[1]
		mov hora01[1],al
        
		mov al,horaTemp[2]
		mov hora01[2],al
        
        mov al,horaTemp[3]
		mov hora01[3],al
		
		mov al,horaTemp[4]
		mov hora01[4],al
        
        mov al,horaTemp[5]
		mov hora01[5],al
		
		mov al,horaTemp[6]
		mov hora01[6],al
        
        mov al,horaTemp[7]
		mov hora01[7],al
		
        mov al,horaTemp[8]
		mov hora01[8],al
		
		mov al,codigoTemp[0]
		mov codigo01[0],al
		
        mov al,codigoTemp[1]
		mov codigo01[1],al
		
		mov al,codigoTemp[2]
		mov codigo01[2],al
		
		mov al,codigoTemp[3]
		mov codigo01[3],al   
		
		mov ax,sensorPosicao01Temp
        mov sensorPosicao01,ax   
        
        mov ax,sensorPosicao02Temp
        mov sensorPosicao02,ax
        
        mov ax,sensorPosicao03Temp
        mov sensorPosicao03,ax
        
        mov ax,sensorPosicao04Temp
        mov sensorPosicao04,ax  
        
        mov ax,codDecSensorTemp
        mov codDecSensor,ax
        
        mov ax,estadoSensorTemp
        mov estadoSensor,ax  
		
        pop ax
        ret
    endp
         
     movConteudoTempConjParaL02 proc          
        
		push ax
		mov flagOcup02,1
                
        mov al,dataTempConj[0]
		mov data02[0],al
		
		mov al,dataTempConj[1]
		mov data02[1],al
		
		mov al,dataTempConj[2]
		mov data02[2],al
		
		mov al,dataTempConj[3]
		mov data02[3],al
        
        mov al,dataTempConj[4]
		mov data02[4],al 
        
		mov al,dataTempConj[5]
		mov data02[5],al
        
        mov al,dataTempConj[6]
		mov data02[6],al
		
		mov al,dataTempConj[7]
		mov data02[7],al
		
		mov al,horaTempConj[0]
		mov hora02[0],al
        
		mov al,horaTempConj[1]
		mov hora02[1],al
        
		mov al,horaTempConj[2]
		mov hora02[2],al
        
        mov al,horaTempConj[3]
		mov hora02[3],al
		
		mov al,horaTempConj[4]
		mov hora02[4],al
        
        mov al,horaTempConj[5]
		mov hora02[5],al
		
		mov al,horaTempConj[6]
		mov hora02[6],al
        
        mov al,horaTempConj[7]
		mov hora02[7],al
		
        mov al,horaTempConj[8]
		mov hora02[8],al
		
		mov al,codigoTempConj[0]
		mov codigo02[0],al
		
        mov al,codigoTempConj[1]
		mov codigo02[1],al
		
		mov al,codigoTempConj[2]
		mov codigo02[2],al
		
		mov al,codigoTempConj[3]
		mov codigo02[3],al   
		
		        
        mov ax,codDecSensorTemp
        mov codDecSensor,ax
        
        mov ax,estadoSensorTemp
        mov estadoSensor,ax  
		
        pop ax
        ret
    endp     
    ; ---------------------------------------------------------- VERIFICAR ALTERACOES 
    
    verifica_ativacao_valida proc

		push dx
        push bx
        mov dx,0
        mov bx,0    

        ; iterar no arquivo de ativacoes detectadas para pegar o codigo decimal para buscar no arquivo de sensores instalados
        
        mov si,OFFSET bufferAtivDetectadas 
        
        mov flagEncontrou2PosicoesCarac1,0              ;ok    
        mov flagEncontrou3PosicoesCarac1,0              ;ok      
        mov flagEncontrou3PosicoesCarac2,0              ;ok
        
        
        
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        lodsb
        mov sensorFinal[0], al
        cmp al,30h
        jz posicoes3
        continua3Posicoes:
            lodsb
            mov sensorFinal[1], al
            cmp al,30h
            jz posicoes2
        continua2Posicoes:
            lodsb 
            mov sensorFinal[2], al
            cmp al,30h
            jz posicao1
        continua1Posicao:
            lodsb
            mov sensorFinal[3], al
            jmp procura_arquivo_sensores_instalados  
            
        
        posicoes3:
            mov quantPosicoes,3
            jmp continua3Posicoes
        
        
        posicoes2:
            mov quantPosicoes,2
            jmp continua2Posicoes
        
        
        posicao1:
            mov quantPosicoes,1
            jmp continua1Posicao
        
        
        procura_arquivo_sensores_instalados:    
        
        
            mov si,OFFSET buffer03Aux
            mov linhaAtualSensoresInstalados,0
			mov posSensoresInstalados,0
            
            cmp quantPosicoes,3
            jz analisa3Posicoes
            
            cmp quantPosicoes,2
            jz analisa2Posicoes
            
            cmp quantPosicoes,1
            jz analisa1Posicao
            
            analisa1Posicao:
                
                itera_sensores_instalados1Posicao:
                    lodsb
                    inc posSensoresInstalados
                    cmp posSensoresInstalados,1
                    jz compara1Posicao
                continua1PosicaoSensoresInstalados:
                    cmp al,10
                    jz nova_linha_sensores_instalados1Posicao
                continua_itera_sensores_instalados1Posicao:            
                    cmp al,0 
                    jz fim_itera_sensores_instalados
                    jmp itera_sensores_instalados1Posicao
                
                nova_linha_sensores_instalados1Posicao:
                    mov posSensoresInstalados,0 
                    inc linhaAtualSensoresInstalados
                    jmp continua_itera_sensores_instalados1Posicao
                    
                compara1Posicao:
                    cmp al,sensorFinal[3]
                    jz comparaTab
                    jmp continua1PosicaoSensoresInstalados  
                    
                comparaTab:                                                     ; se proximo caractere for tab, pode gravar
                    lodsb
                    inc posSensoresInstalados 
                    cmp al,09
                    jz encontrou1Posicao
                    jmp itera_sensores_instalados1Posicao 
                                       

                encontrou1Posicao:
                    ;acao
                     call geraArquivoVal
                     jmp fim_itera_sensores_instalados

             analisa2Posicoes:
                
                itera_sensores_instalados2Posicoes:
                    inc posSensoresInstalados
					lodsb
                    cmp posSensoresInstalados,1
                    jz compara2PosicoesCarac1
                    cmp posSensoresInstalados,2
                    jz compara2PosicoesCarac2
                continua2PosicoesSensoresInstalados:
                    cmp al,10
                    jz nova_linha_sensores_instalados2Posicoes
                continua_itera_sensores_instalados2Posicoes:            
                    cmp al,0 
                    jz fim_itera_sensores_instalados
                    loop itera_sensores_instalados2Posicoes
                
                nova_linha_sensores_instalados2Posicoes:
                    mov posSensoresInstalados,0 
                    inc linhaAtualSensoresInstalados
                    jmp continua_itera_sensores_instalados2Posicoes
                    
                compara2PosicoesCarac1:
                    cmp al,sensorFinal[2]
                    jz encontrou2PosicoesCarac1
                    jmp continua2PosicoesSensoresInstalados
                    
                compara2PosicoesCarac2:
                    cmp al,sensorFinal[3]
                    jz encontrou2Posicoes
                    jmp continua2PosicoesSensoresInstalados  
                
                encontrou2PosicoesCarac1:
                    mov flagEncontrou2PosicoesCarac1,1
                    jmp itera_sensores_instalados2Posicoes
                    
                encontrou2Posicoes:
                    cmp flagEncontrou2PosicoesCarac1,1
                    jz grava2Posicoes                    
                    jmp itera_sensores_instalados2Posicoes                    
                grava2Posicoes:
                    call geraArquivoVal 
                    jmp fim_itera_sensores_instalados

				analisa3Posicoes:  

													   
                itera_sensores_instalados3Posicoes:
                    lodsb
                    inc posSensoresInstalados
                    cmp posSensoresInstalados,1
                    jz compara3PosicoesCarac1
                    cmp posSensoresInstalados,2
                    jz compara3PosicoesCarac2
					cmp posSensoresInstalados,3
                    jz compara3PosicoesCarac3
                continua3PosicoesSensoresInstalados:
                    cmp al,10
                    jz nova_linha_sensores_instalados3Posicoes
                continua_itera_sensores_instalados3Posicoes:            
                    cmp al,0 
                    jz fim_itera_sensores_instalados
                    loop itera_sensores_instalados3Posicoes
                
                nova_linha_sensores_instalados3Posicoes:
                    mov posSensoresInstalados,0 
                    inc linhaAtualSensoresInstalados
                    jmp continua_itera_sensores_instalados3Posicoes
                    
                compara3PosicoesCarac1:
                    cmp al,sensorFinal[1]
                    jz encontrou3PosicoesCarac1
                    jmp continua3PosicoesSensoresInstalados
                    
                compara3PosicoesCarac2:
                    cmp al,sensorFinal[2]
                    jz encontrou3PosicoesCarac2
                    jmp continua3PosicoesSensoresInstalados  
					
				compara3PosicoesCarac3:
                    cmp al,sensorFinal[3]
                    jz encontrou3Posicoes
                    jmp continua3PosicoesSensoresInstalados
					
                encontrou3PosicoesCarac1:
                    mov flagEncontrou3PosicoesCarac1,1
                    jmp itera_sensores_instalados3Posicoes
					
				encontrou3PosicoesCarac2:
                    mov flagEncontrou3PosicoesCarac2,1
                    jmp itera_sensores_instalados3Posicoes
                    
                encontrou3Posicoes:

                    cmp flagEncontrou3PosicoesCarac1,1
                    jz comparaProxFlag3Pos
                    jmp itera_sensores_instalados3Posicoes
                    
                comparaProxFlag3Pos:
                    cmp flagEncontrou3PosicoesCarac2,1
                    jz grava3Posicoes
                    jmp itera_sensores_instalados3Posicoes
                grava3Posicoes:
                    call geraArquivoVal 
                                            
                    jmp fim_itera_sensores_instalados 
            
                               
            
            fim_itera_sensores_instalados:
				pop bx
                pop dx
                ret
        
    endp  
    
    ; ---------------------------------------------------------- VERIFICAR ALTERACOES
    
         
    
    ;----------------------------------------------------------------------------------------------------------------------
    
    
    ;----------------------------------------------------------------------------------------------------------------------
    ;ARQUIVOS TXT
    
    ler_arq01 proc
        
        ;read file1
        mov dx,OFFSET FileName1     ; coloca o endereco do nome do arquivo em dx
        mov al,2                    ; modo de acesso - leitura e escrita
        mov ah,3Dh                  ; funcao 3Dh - abre um arquivo
        int 21h                     ; chama servico do DOS 
        
        mov Handle1,ax              ; guarda o manipulador do arquivo para mais tarde
        jc ErrorOpening             ; desvia se carry flag estiver ligada - erro!
        mov dx,offset buffer01      ; endereco do buffer01 em dx 
    
        LerBloco:                   ; inicio da leitura do bloco          
            
            
            mov bx,Handle1          ; manipulador em bx
            mov cx,5                ; quantidade de bytes a serem lidos, blocos fixos
            mov ah,3Fh              ; funcao 3Fh - leitura de arquivo
            int 21h                 ; chama servico do DOS
    
            jc ErrorReading         ; desvia se carry flag estiver ligada - erro!
    
            add [BytesLidos1], cx   ; adiciona a quantidade de bytes lidos
            cmp ax, cx              ; compara quantos bytes foram lidos com a quantidade solicitada na funcao            
            jb  Continuar           ; sair da leitura, caso seja menor (final do arquivo encontrado!)
    
            add dx,5                ; avanca o buffer01 de leitura
            cmp dx, Fimbuffer01     ; verifica se chegou no final do buffer01
            jae Continuar           ; se dx for maior ou igual ao final, sair da leitura
            jmp LerBloco
    
        Continuar:
    
            mov bx,Handle1          ; coloca manipulador do arquivo em bx
            mov ah,3Eh              ; funcao 3Eh - fechar um arquivo
            int 21h                 ; chama servico do DOS
   
            jmp Final               ; quando nao for necessario escrever na tela         
            
        NextChar:
    
            lodsb                   ; AL = proximo caracter da string
            int 10h                 ; chama servico da BIOS
            loop NextChar
            jmp FINAL
              
        ErrorOpening:
    
            mov dx,offset OpenError     ; exibe um erro
            mov ah,09h                  ; usando a funcao 09h
            int 21h                     ; chama servico do DOS
            mov ax,4C01h                ; termina programa com um errorlevel =1 
            int 21h        
                                                                  
        ErrorReading:
            mov dx,offset ReadError ; exibe um erro         
            mov ah,09h              ; usando a funcao 09h
            int 21h                 ; chama servico do DOS
            mov ax,4C02h            ; termina programa com um errorlevel =2
            int 21h                                                        
            
        FINAL:    
            ret
    endp  
    
    
    ler_arq02 proc
        ;read file2
        mov dx,OFFSET FileName2     ; coloca o endereco do nome do arquivo2 em dx
        mov al,2                    ; modo de acesso - leitura e escrita
        mov ah,3Dh                  ; funcao 3Dh - abre um arquivo
        int 21h                     ; chama servico do DOS 
        mov Handle2,ax              ; guarda o manipulador do arquivo2 para mais tarde
        jc ErrorOpening2            ; desvia se carry flag estiver ligada - erro!
        mov dx,offset buffer02      ; endereco do buffer02 em dx 
        LerBloco2:                  ; inicio da leitura do bloco          
            mov bx,Handle2          ; manipulador em bx
            mov cx,5                ; quantidade de bytes a serem lidos, blocos fixos
            mov ah,3Fh              ; funcao 3Fh - leitura de arquivo
            int 21h                 ; chama servico do DOS
            jc ErrorReading2        ; desvia se carry flag estiver ligada - erro!
            add [BytesLidos2], cx   ; adiciona a quantidade de bytes lidos
            cmp ax, cx              ; compara quantos bytes foram lidos com a quantidade solicitada na funcao            
            jb  Continuar2          ; sair da leitura, caso seja menor (final do arquivo encontrado!)
            add dx,5                ; avanca o buffer02 de leitura
            cmp dx, Fimbuffer02     ; verifica se chegou no final do buffer02
            jae Continuar2          ; se dx for maior ou igual ao final, sair da leitura
            jmp LerBloco2
        Continuar2:
            mov bx,Handle2          ; coloca manipulador do arquivo em bx
            mov ah,3Eh              ; funcao 3Eh - fechar um arquivo
            int 21h                 ; chama servico do DOS   
            jmp FINAL2              ; quando nao for necessario escrever na tela 
        NextChar2:
            lodsb                   ; AL = proximo caracter da string
            int 10h                 ; chama servico da BIOS
            loop NextChar2
            jmp FINAL2
        ErrorOpening2:
            mov dx,offset OpenError     ; exibe um erro
            mov ah,09h                  ; usando a funcao 09h
            int 21h                     ; chama servico do DOS
            mov ax,4C01h                ; termina programa com um errorlevel =1 
            int 21h                                                    
        ErrorReading2:
            mov dx,offset ReadError ; exibe um erro         
            mov ah,09h              ; usando a funcao 09h
            int 21h                 ; chama servico do DOS
            mov ax,4C02h            ; termina programa com um errorlevel =2
            int 21h                                                        
            
        FINAL2:    
            ret
    endp
    
    ler_arq03aux proc
     
        MOV AH, 3Dh                 ; Abre um arquivo |AL modo de operacao | retorna AX |
        MOV AL,0                    ; 0 - leitura. 1 - escrita. 2 - ambos
        MOV DX,offset FileNameAux   ; Coloca o ponteiro em relacao ao nome do arquivo
        INT 21h                     ; Chamar tela
        MOV Handle3Aux,AX           ; Salva o retorno da funcao 3dh
    
        MOV AH,3Fh                  ; Le um arquivo.
        MOV CX,65535                ; Maxima capacidade do RG
        MOV DX,offset buffer03Aux   ; DX recebe o ponteiro do buffer.
        MOV BX,Handle3Aux           ; BX recebe cabecalho do arquivo.
        INT 21h                     ; DOS   
        
        mov bx,Handle3Aux           ; coloca manipulador do arquivo em bx
        mov ah,3Eh                  ; funcao 3Eh - fechar um arquivo
        int 21h                     ; chama servico do DOS 
           
        FinalAux: 
            dec Cont   
            jmp ler_arq03 proc
            ret
    endp
           
    ler_arq03 proc
     
        MOV AH, 3Dh                 ; Abre um arquivo |AL modo de operacao | retorna AX |
        MOV AL,0                    ; 0 - leitura. 1 - escrita. 2 - ambos
        MOV DX,offset FileName3     ; Coloca o ponteiro em relacao ao nome do arquivo
        INT 21h                     ; Chamar tela
        MOV Handle3,AX              ; Salva o retorno da funcao 3dh
    
        MOV AH,3Fh                  ; Le um arquivo.
        MOV CX,Cont                 ; Bytes a serem lidos
        MOV DX,offset buffer03      ; DX recebe o ponteiro do buffer.
        MOV BX,Handle3              ; BX recebe cabecalho do arquivo.
        INT 21h                     ; DOS   
        
        mov bx,Handle3              ; coloca manipulador do arquivo em bx
        mov ah,3Eh                  ; funcao 3Eh - fechar um arquivo
        int 21h                     ; chama servico do DOS
        
        Final3: 
            ret
    endp 

	ler_arq04 proc
	
		mov AH,3Dh                      ; abre um arquivo
        mov AL,0                        ; 0 - para ler 1 - para escrever 2 - ambos
        mov DX,offset FileName4         ; pointer para FileName4
        int 21h                         ; call DOS
        mov Handle4,AX
		
        Leitura_ativacoes:
        
            ;le primeira linha do par
            mov ah,3Fh                      ; 3Fh le de um arquivo
		    mov cx,28                       ; cada linha tem 28 bytes
		    mov dx,offset buffer04            
		    mov bx,Handle4                  ; BX precisa do handle do arquivo
		    int 21h                         ; call DOS
            cmp AL,0
            jz Fim_leitura 
            call printa_linha_atual         ; printa na tela a linha atual          
            call valida_soma_lin01          ; validar soma da linha 1 do ati
            cmp somaLinha1,1
            jz preVerifMap
            jmp verificaContinuacaoLeitura  
            
            preVerifMap:
                call guardaCodSensorValidaMapEOnOff
                cmp flagOcupTemp,1
                jz validaX10OnOff
                jmp  validaX10Map
            
            validaX10Map:
                mov DH, codigoVerif[0]                 ; pos1
	            mov DL, codigoVerif[2]                 ; pos3
	    
	            mov BH, codigoVerif[1]                 ; pos2
	            mov BL, codigoVerif[3]                 ; pos4  
                call validarX10Map
                cmp flagX10Map,1
                jz  verificaL01Vazia
                jmp validaX10OnOff
            
            validaX10OnOff:
                mov DH, codigoVerif[0]                 ; pos1
	            mov DL, codigoVerif[2]                 ; pos3
	    
	            mov BH, codigoVerif[1]                 ; pos2
	            mov BL, codigoVerif[3]                 ; pos4  
	            call validarX10OnOff
	            cmp flagX10OnOff,1
	            jz verificaL01Vaziav2
	            jmp verificaContinuacaoLeitura
            verificaL01Vazia:
                cmp flagOcup01,0
                jz armazenaLinha01
                jmp comparaCodL01   
            armazenaLinha01:
                call guardaDadosAtivacaoL01 
                call guardaDadosAtivacaoTemp   
                jmp verificaContinuacaoLeitura
            verificaL01Vaziav2:
                cmp flagOcup01,0
                jz verificaContinuacaoLeitura
                jmp verificaL02Vazia    
                
            verificaL02Vazia:
                call guardaDadosAtivacaoTempConj
                cmp flagOcup02,0
                jz varificar20p 
                jmp comparaCodL02
            varificar20p:
                call guardaDadosAtivacaoTempConj
                mov modeTempo,1
                call verifica_tempo
                cmp flagTempo,1
                jz guardarDadosAtivacaoL02                 
                jmp limpar
            
            limpar:
               call limpaL01L02
               jmp verificaContinuacaoLeitura 
                
            comparaCodL02:
                call compararCodL02
                cmp flagCompararCodL02,1
                jz cp1
                jmp verificaConteudoTemp
            cp1:
                call compararCodL01
                cmp flagCompararCodL01,1 
                jz verificar20ms 
                jmp verificaConteudoTemp
			
            comparaCodL01:
                call compararCodL01
                cmp flagCompararCodL01,1 
                jz limparTemp
                jmp armazenaNaTemp
                
            armazenaNaTemp:
                call guardaDadosAtivacaoTemp
                jmp verificaContinuacaoLeitura 
                
            limparTemp:
                call limpaTemp
                call guardaDadosAtivacaoTemp
                jmp verificaContinuacaoLeitura
            guardarDadosAtivacaoL02: 
                call movConteudoTempConjParaL02
                inc nroAtivacoes
                mov flagOcupTemp,0
                mov flagOcupTempConj,0 
                jmp verificaContinuacaoLeitura 
                
            guardarDadosAtivacaoL01:
                call limpaL01L02
                call movConteudoTempParaL01 
                call movConteudoTempConjParaL02
                call limpaTemp
                mov nroAtivacoes,1                 
                jmp verificaContinuacaoLeitura 
                
            verificar20ms:  
                call guardaDadosAtivacaoTempConj
                mov modeTempo,1
                call verifica_tempo
                cmp flagTempo,1
                jz verificar5s                
                jmp verificaContinuacaoLeitura
                
            verificar5s:
                mov modeTempo,0
                call verifica_tempo
                cmp flagTempo,1
                jz  verificaConteudoTemp
                jmp continuar5s 
            
            continuar5s:
                mov flagOcupTemp,0
                mov flagOcupTempConj,0    
                inc nroAtivacoes
                jmp verificaContinuacaoLeitura            
            
            verificaConteudoTemp:
                cmp flagOcupTemp,1
                jz  gravaArq01
                jmp verificaContinuacaoLeitura
                
            gravaArq01:
                call gera_arquivo
                push ax
                xor ax,ax
                pop ax
                jmp guardarDadosAtivacaoL01
                
                                       
            verificaContinuacaoLeitura:
            
                loop Leitura_ativacoes
            
        Fim_leitura:
            cmp flagOcup01,1
            jz verificaOcup02
            jmp return
            
            verificaOcup02:
            
                cmp flagOcup02,1
                jz gravaFinal
                jmp return
                           
            gravaFinal:                  
	            call gera_arquivo
	        
	        return: 
	            
		        ret
		
	endp
	
	ler_arq_ativ_detectadas proc 
	    	
		mov AH,3Dh                      			 ; abre um arquivo
        mov AL,0                        			 ; 0 - para ler 1 - para escrever 2 - ambos
        mov DX,offset FileNameAtivDetectadas         ; pointer para FileNameAtivDetectadas
        int 21h                         			 ; call DOS
        mov HandleAtivDetectadas,AX
		
        Leitura_arq_ativ_detectadas:
        
            ;le linha
            mov ah,3Fh                      		; 3Fh le de um arquivo
		    mov cx,28                     		    ; cada linha tem 29 bytes
		    mov dx,offset bufferAtivDetectadas            
		    mov bx,HandleAtivDetectadas       		; BX precisa do handle do arquivo
		    int 21h                         		; call DOS
            
            cmp AL,0
            jz Fim_leitura_ativ_detectadas
			
			call verifica_ativacao_valida

						
			loop Leitura_arq_ativ_detectadas        ; ao sair da verifica_ativacao_valida pode nao encontrar, forca dar mais um loop para nao sair dessa proc


			Fim_leitura_ativ_detectadas:
			
				ret
		
	endp
	
    leitura proc
        
        
        mov bl,0FH
        mov cx,17
        mov dl,23
        mov dh,12
        mov bp,offset tela_leitura1
        call ESC_STR_VIDEO
        
        mov cx,27
        mov dh,14
        mov bp,offset tela_leitura2
        call ESC_STR_VIDEO 
        
        mov cx,29
        mov dh,15
        mov bp,offset tela_leitura3
        call ESC_STR_VIDEO 
        
        mov cx,39
        mov dh,16
        mov bp,offset tela_leitura4
        call ESC_STR_VIDEO     
       
        call ler_arq01
        call ler_arq02
        call ler_arq03aux
         
		call clear_screen
		call print_screen
       
        call ler_arq04
		; GERACAO DO 2 ARQUIVO
		call ler_arq_ativ_detectadas
	
        jmp finaliza 
        ret
    endp
    
    ;----------------------------------------------------------------------------------------------------------------------
    
    
    ;----------------------------------------------------------------------------------------------------------------------
    ;main 
    
    
    inicio:
        mov ax,@DATA
        mov ds,ax
        mov es,ax
        mov rest, ax
        
        mov bl,09H
        mov cx,17
        mov dl,31
        mov dh,11
        mov bp,offset menu_title1
        call ESC_STR_VIDEO

        mov bl,0FH
        mov cx,14
        mov dl,33
        mov dh,12
        mov bp,offset menu_title2
        call ESC_STR_VIDEO
        
        mov cx,1
        mov dh,13
        mov bp,offset menu_title3
        call ESC_STR_VIDEO
        
        mov cx,11
        mov dh,14
        mov bp,offset menu_op1
        call ESC_STR_VIDEO
        
        mov cx,8
        mov dh,15
        mov bp,offset menu_op2
        call ESC_STR_VIDEO
        
        call opcao_menu
        call clear_screen 
        
        cmp al,2
        jz finaliza 
        
        cmp al,1
        jz leitura proc
            
       finaliza:
            mov ah,04CH                                     ; Finaliza a aplicacao
            mov al,00H
            int 21h    
    end inicio

;----------------------------------------------------------------------------------------------------------------------