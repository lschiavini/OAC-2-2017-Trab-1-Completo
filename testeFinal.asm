#	OAC
#	Univerdade de Brasilia 
#	Danielle Almeida Lima - 14/0135740
#	Lucas dos Santos Schiavini - 14/0150749
#
#
.data 

errod: .asciiz "Arquivo nao encontrado.\nPrimeiro e necessario que o arquivo esteja codificado, entao retorne ao menu principal e selecione a opcao codificacao e o arquivo que voce deseja\n"
menu_string: .asciiz "\nSelecione uma opcao:\n1. Codificacao\n2. Decodificacao\n3. Sair\n\nOpcao: "
menu_cod: .asciiz "\nSelecione um arquivo:\n1. data1.txt\n2. data2.txt\n3. data3.txt\n4. data4.txt\n5. Retornar ao menu principal\n\nOpcao: "
menu_decod: .asciiz "\nSelecione um arquivo:\n1. data1.rle\n2. data2.rle\n3. data3.rle\n4. data4.rle\n5. Retornar ao menu principal\n\nOpcao: "
msg_invalida: .asciiz "\n\nOpcao invalida. Digite uma opcao do menu!\n"
data1c: .asciiz "data1.rle"	# arquivos codificados data1.rle
data2c: .asciiz "data2.rle"	# data2.rle
data3c: .asciiz "data3.rle"	# data3.rle
data4c: .asciiz "data4.rle"	# data4.rle
data1d: .asciiz "data1d.txt"	# arquivos decodificados data1d.txt
data2d: .asciiz "data2d.txt"	# data2d.txt
data3d: .asciiz "data3d.txt"	# data3d.txt
data4d: .asciiz "data4d.txt"	# data4d.txt


#data1c: .asciiz "C:/Users/Danielle/Documents/Engenharia Mecatr�nica/Semestre 7/Organiza��o e Arquitetura de Computadores/Trabalho1/OAC22017/data1.rle"	# arquivos codificados data1.rle
#data2c: .asciiz "C:/Users/Danielle/Documents/Engenharia Mecatr�nica/Semestre 7/Organiza��o e Arquitetura de Computadores/Trabalho1/OAC22017/data2.rle"	# data2.rle
#data3c: .asciiz "C:/Users/Danielle/Documents/Engenharia Mecatr�nica/Semestre 7/Organiza��o e Arquitetura de Computadores/Trabalho1/OAC22017/data3.rle"	# data3.rle
#data4c: .asciiz "C:/Users/Danielle/Documents/Engenharia Mecatr�nica/Semestre 7/Organiza��o e Arquitetura de Computadores/Trabalho1/OAC22017/data4.rle"	# data4.rle
#data1d: .asciiz "C:/Users/Danielle/Documents/Engenharia Mecatr�nica/Semestre 7/Organiza��o e Arquitetura de Computadores/Trabalho1/OAC22017/data1d.txt"	# arquivos decodificados data1d.txt
#data2d: .asciiz "C:/Users/Danielle/Documents/Engenharia Mecatr�nica/Semestre 7/Organiza��o e Arquitetura de Computadores/Trabalho1/OAC22017/data2d.txt"	# data2d.txt
#data3d: .asciiz "C:/Users/Danielle/Documents/Engenharia Mecatr�nica/Semestre 7/Organiza��o e Arquitetura de Computadores/Trabalho1/OAC22017/data3d.txt"	# data3d.txt
#data4d: .asciiz "C:/Users/Danielle/Documents/Engenharia Mecatr�nica/Semestre 7/Organiza��o e Arquitetura de Computadores/Trabalho1/OAC22017/data4d.txt"	# data4d.txt



data1o: .asciiz "data1.txt"	# arquivos originais
data2o: .asciiz "data2.txt"
data3o: .asciiz "data3.txt"
data4o: .asciiz "data4.txt"
buffer0:   .space 1
buffer1:   .space 1
controle: .byte '�'

    fin:        .asciiz "Lucas.txt"
    fout:       .asciiz "Lucas.rle"

    fin1:       .asciiz "data1.txt"
    fout1:      .asciiz "data1.rle"

    fin2:       .asciiz "data2.txt"
    fout2:      .asciiz "data2.rle"

    fin3:       .asciiz "data3.txt"
    fout3:      .asciiz "data3.rle"

    fin4:       .asciiz "data4.txt"
    fout4:      .asciiz "data4.rle"

    

    
    erro: .asciiz "Arquivo nao encontrado.\n"
    bufferIn:   .space 1
    bufferIn1:  .space 1
    bufferIn2:  .space 1
    
    bufferOut:  .space 1
    bufferOut_end:


.text 
main:	
	menu_loop:
		jal menu
		beq $v0, 3, fim_menu
		j menu_loop
	fim_menu:
	li $v0, 10
	syscall
menu:
	addi $sp, $sp, -4
	sw $ra, 0($sp)  
	li $v0, 4
	la $a0, menu_string
	syscall   # imprime o menu
	
	li $v0, 5       
 	syscall	  # leitura da opcao
 	
 	slti $t0, $v0, 1
 	slti $t1, $v0, 4
	xor $t2, $t1, $t0
	
	beq $t2, 1, continua
	li $v0, 4
	la $a0, msg_invalida
	syscall   # imprime a mensagem
	j menu
		continua:
			beq $v0, 1, menu_codificacao
			beq $v0, 2, menu_decodificacao
			lw $ra, 0($sp)
			addi $sp, $sp, 4 
			jr $ra
	
menu_codificacao:
	addi $sp, $sp, -4
	sw $ra, 0($sp)  
	li $v0, 4
	la $a0, menu_cod
	syscall
	
	li $v0, 5
	syscall
	
	slti $t0, $v0, 1
 	slti $t1, $v0, 6
	xor $t2, $t1, $t0
	
	beq $t2, 1, escolha_arquivo
	li $v0, 4
	la $a0, msg_invalida
	syscall   # imprime a mensagem
	j menu_codificacao
		
		escolha_arquivo:
			beq $v0, 1, cod_data1
			beq $v0, 2, cod_data2
			beq $v0, 3, cod_data3
			beq $v0, 4, cod_data4
			lw $ra, 0($sp)
			addi $v0, $zero, -1 
			j continua

menu_decodificacao:
	addi $sp, $sp, -4
	sw $ra, 0($sp)  
	li $v0, 4
	la $a0, menu_decod
	syscall
	
	li $v0, 5
	syscall
	
	slti $t0, $v0, 1
 	slti $t1, $v0, 6
	xor $t2, $t1, $t0
	
	beq $t2, 1, escolha_arquivo1
	li $v0, 4
	la $a0, msg_invalida
	syscall   # imprime a mensagem
	j menu_decodificacao
		
		escolha_arquivo1:
			beq $v0, 1, decod_data1
			beq $v0, 2, decod_data2
			beq $v0, 3, decod_data3
			beq $v0, 4, decod_data4
			lw $ra, 0($sp)
			addi $v0, $zero, -1
			j continua

decod_data1:
	li $v0, 13 # chamada do sistema para abrir o arquivo para escrita
    	la $a0, data1d
    	li $a1, 1
    	li $a2, 0
    	syscall 
   	move $s7, $v0
   	li   $v0, 13 # chamada do sistema para abrir o arquivo para leitura
	la   $a0, data1c 
	li   $a1, 0 # abre para leitura
	li $a2, 0 
	syscall # abre o arquivo
	blt	$v0, 0, arqNEncontradod	# arquivo nao disponivel
	move $s6, $v0 
	addi $t0, $0, 0
	addi $t5, $0, 0
	addi $t6, $0, 0
   	
leitura1d:
	li   $v0, 14 
	move $a0, $s6 
	la $t2, buffer0	
	la $a1, 0($t2) 
	li $a2, 1
	syscall
	move $t4, $v0
	beqz $v0, its_over_and_doned
	li $v0, 11        
	lb $s1, 0($t2)
	addi $t3,$0,0
	lb $t3, controle
	beq $s1, $t3, descomprimir1d
	jal escreve_arquivo1d
	
	j leitura1d  		

descomprimir1d:
	li   $v0, 14 # chamada de sistema para leitura do pr�ximo elemento do arquivo 
	move $a0, $s6 
	la $t5, buffer0
	la $a1, 0($t5) # endere�o do buffer
	li $a2, 1 
	syscall
	lb $s1, 0($t5) # $s1 cont�m a quantidade de caracteres a serem repetidos
	andi $s1,$s1,0x0F # convers�o de hexa para int
	li $v0, 14 # chamada de sistema para leitura do pr�ximo elemento do arquivo
	move $a0, $s6
	la $t6, buffer0	
	la $a1, 0($t6) # endere�o do buffer
	li $a2, 1 
	syscall
	lb $s2, 0($t6) # $s2 cont�m o caractere a ser repetido
	loop1d:
		beq $s1, 0x0, leitura1d
		jal escreve_arquivo1d
		addi $s1, $s1, -1
		j loop1d

escreve_arquivo1d:
	move $a0, $s7
	li $v0, 15
	la $a1, buffer0
	la $a2,1
	syscall
	jr $ra

arqNEncontradod:
	li $v0, 4 # syscall de impressao de string
	la $a0, errod # mensagem de erro
	syscall
	j its_over_and_doned # reinicia programa
		
its_over_and_doned:

	li $v0, 16
    	move $a0, $s6 # endere�o do arquivo codificado (leitura)
    	syscall
   	li $v0, 16  # $a0 already has the file descriptor
    	move $a0, $s7 # endere�o do arquivo decodificado (escrita)
    	syscall
    	addi $v0, $zero, -1
	j continua

decod_data2:
	li $v0, 13 # chamada do sistema para abrir o arquivo para escrita
    	la $a0, data2d
    	li $a1, 1
    	li $a2, 0
    	syscall 
   	move $s7, $v0
   	li   $v0, 13 # chamada do sistema para abrir o arquivo para leitura
	la   $a0, data2c 
	li   $a1, 0 # abre para leitura
	li $a2, 0 
	syscall # abre o arquivo
	blt	$v0, 0, arqNEncontradod	# arquivo nao disponivel
	move $s6, $v0 
	addi $t0, $0, 0
	addi $t5, $0, 0
	addi $t6, $0, 0
   	
leitura2d:
	li   $v0, 14 
	move $a0, $s6 
	la $t2, buffer0	
	la $a1, 0($t2) 
	li $a2, 1
	syscall
	move $t4, $v0
	beqz $v0, its_over_and_doned
	li $v0, 11        
	lb $s1, 0($t2)
	addi $t3,$0,0
	lb $t3, controle
	beq $s1, $t3, descomprimir2d
	jal escreve_arquivo2d
	
	j leitura2d  		

descomprimir2d:
	li   $v0, 14 # chamada de sistema para leitura do pr�ximo elemento do arquivo 
	move $a0, $s6 
	la $t5, buffer0
	la $a1, 0($t5) # endere�o do buffer
	li $a2, 1 
	syscall
	lb $s1, 0($t5) # $s1 cont�m a quantidade de caracteres a serem repetidos
	andi $s1,$s1,0x0F # convers�o de hexa para int
	li $v0, 14 # chamada de sistema para leitura do pr�ximo elemento do arquivo
	move $a0, $s6
	la $t6, buffer0	
	la $a1, 0($t6) # endere�o do buffer
	li $a2, 1 
	syscall
	lb $s2, 0($t6) # $s2 cont�m o caractere a ser repetido
	loop2d:
		beq $s1, 0x0, leitura2d
		jal escreve_arquivo2d
		addi $s1, $s1, -1
		j loop2d

escreve_arquivo2d:
	move $a0, $s7
	li $v0, 15
	la $a1, buffer0
	la $a2,1
	syscall
	jr $ra

decod_data3:
	li $v0, 13 # chamada do sistema para abrir o arquivo para escrita
    	la $a0, data3d
    	li $a1, 1
    	li $a2, 0
    	syscall 
   	move $s7, $v0
   	li   $v0, 13 # chamada do sistema para abrir o arquivo para leitura
	la   $a0, data3c 
	li   $a1, 0 # abre para leitura
	li $a2, 0 
	syscall # abre o arquivo
	blt	$v0, 0, arqNEncontradod	# arquivo nao disponivel
	move $s6, $v0 
	addi $t0, $0, 0
	addi $t5, $0, 0
	addi $t6, $0, 0
   	
leitura3d:
	li   $v0, 14 
	move $a0, $s6 
	la $t2, buffer0	
	la $a1, 0($t2) 
	li $a2, 1
	syscall
	move $t4, $v0
	beqz $v0, its_over_and_doned
	li $v0, 11        
	lb $s1, 0($t2)
	addi $t3,$0,0
	lb $t3, controle
	beq $s1, $t3, descomprimir3d
	jal escreve_arquivo3d
	
	j leitura3d		

descomprimir3d:
	li   $v0, 14 # chamada de sistema para leitura do pr�ximo elemento do arquivo 
	move $a0, $s6 
	la $t5, buffer0
	la $a1, 0($t5) # endere�o do buffer
	li $a2, 1 
	syscall
	lb $s1, 0($t5) # $s1 cont�m a quantidade de caracteres a serem repetidos
	andi $s1,$s1,0x0F # convers�o de hexa para int
	li $v0, 14 # chamada de sistema para leitura do pr�ximo elemento do arquivo
	move $a0, $s6
	la $t6, buffer0	
	la $a1, 0($t6) # endere�o do buffer
	li $a2, 1 
	syscall
	lb $s2, 0($t6) # $s2 cont�m o caractere a ser repetido
	loop3d:
		beq $s1, 0x0, leitura3d
		jal escreve_arquivo3d
		addi $s1, $s1, -1
		j loop3d

escreve_arquivo3d:
	move $a0, $s7
	li $v0, 15
	la $a1, buffer0
	la $a2,1
	syscall
	jr $ra

decod_data4:
	li $v0, 13 # chamada do sistema para abrir o arquivo para escrita
    	la $a0, data4d
    	li $a1, 1
    	li $a2, 0
    	syscall 
   	move $s7, $v0
   	li   $v0, 13 # chamada do sistema para abrir o arquivo para leitura
	la   $a0, data4c 
	li   $a1, 0 # abre para leitura
	li $a2, 0 
	syscall # abre o arquivo
	blt	$v0, 0, arqNEncontradod	# arquivo nao disponivel
	move $s6, $v0 
	addi $t0, $0, 0
	addi $t5, $0, 0
	addi $t6, $0, 0
   	
leitura4d:
	li   $v0, 14 
	move $a0, $s6 
	la $t2, buffer0	
	la $a1, 0($t2) 
	li $a2, 1
	syscall
	move $t4, $v0
	beqz $v0, its_over_and_doned
	li $v0, 11        
	lb $s1, 0($t2)
	addi $t3,$0,0
	lb $t3, controle
	beq $s1, $t3, descomprimir4d
	jal escreve_arquivo4d
	
	j leitura4d  		

descomprimir4d:
	li   $v0, 14 # chamada de sistema para leitura do pr�ximo elemento do arquivo 
	move $a0, $s6 
	la $t5, buffer0
	la $a1, 0($t5) # endere�o do buffer
	li $a2, 1 
	syscall
	lb $s1, 0($t5) # $s1 cont�m a quantidade de caracteres a serem repetidos
	andi $s1,$s1,0x0F # convers�o de hexa para int
	li $v0, 14 # chamada de sistema para leitura do pr�ximo elemento do arquivo
	move $a0, $s6
	la $t6, buffer0	
	la $a1, 0($t6) # endere�o do buffer
	li $a2, 1 
	syscall
	lb $s2, 0($t6) # $s2 cont�m o caractere a ser repetido
	loop4d:
		beq $s1, 0x0, leitura4d
		jal escreve_arquivo4d
		addi $s1, $s1, -1
		j loop4d

escreve_arquivo4d:
	move $a0, $s7
	li $v0, 15
	la $a1, buffer0
	la $a2,1
	syscall
	jr $ra

	#codificador


cod_data1:

    jal file_open_w1c
    jal file_open_r1c
    addi $t0, $0, 0     #set initial parameter to compare
    addi $t1, $0, 0
    addi $t2, $0, 0
    addi $t3, $0, 0    
    addi $t4, $0, 0
    addi $t5, $0, 0
    addi $t6, $0, 0
    addi $t7, $0, 0
loop_write1c:
        #USEFUL VARIABLES
        addi $t5, $0, 3 # minimum rep to encode
        addi $t4, $0, 2 #repeated bytes
        
        file_read1c:
            li      $v0, 14     # syscall de leitura
            move    $a0, $s6    # endereÃ§o do arquivo
            la      $s0, bufferIn
            la      $a1, 0($s0)    # endereÃ§o da variÃ¡vel
            li      $a2, 1 # espaÃ§o disponÃ­vel para armazenamento
            syscall
            beqz $v0, break_loop1c    #if end of file, break
            lb      $t0, 0($s0)                 # get byte -- is it zero?
        beqz $t6, file_read11c #first time read
        move $t1, $t0
        move $t0, $t6
        j N0N11c
        file_read11c:
            li      $v0, 14     # syscall de leitura
            move    $a0, $s6    # endereÃ§o do arquivo
            la      $s1, bufferIn
            la      $a1, 0($s1)    # endereÃ§o da variÃ¡vel
            li      $a2, 1 # espaÃ§o disponÃ­vel para armazenamento
            syscall
            beqz $v0, break_loop1c    #if end of file, break
            lb      $t1, 0($s1)                 # get byte -- is it zero?

        compareCode1c:
            
            N0N11c:
                bne $t0, $t1, Dif1c

            N1N21c:
                file_read21c:
                    li      $v0, 14     # syscall de leitura
                    move    $a0, $s6    # endereÃ§o do arquivo
                    la      $s2, bufferIn2
                    la      $a1, 0($s2)    # endereÃ§o da variÃ¡vel
                    li      $a2, 1 # espaÃ§o disponÃ­vel para armazenamento
                    syscall
                    lb      $t2, 0($s2)
                bne $t1, $t2, Dif21c  #if different
                beqz $v0, Dif21c      #if EOF
                addi    $t4, $t4, 1             #add 1 to repeated byte count
                j N1N21c  
            
            Dif1c:
            ####DEBUG
            #beqz    $t0, exit                       # quando acaba os valores do arquivo sai do programa
            #li      $v0, 11                     #imprime um unico caracter
            #move    $a0, $t0
            #syscall
            ####END DEBUG 
                #how to load byte
                #la $t3, bufferOut #
                #sb $a0, 0($t3)    #  origin -> destination
                la $t3, bufferOut
                sb $t0, 0($t3)
                move $t6, $t1       #save last value read

                j file_write1c

            Dif21c:
                slt $t7, $t4, $t5   # t6 = 0 if t4 >= 3
                beqz $t7, count3More1c
           
           countLess31c:
                ##########
                #li      $v0, 11                     #imprime um unico caracter
                #move    $a0, $t0
                #syscall
                #li      $v0, 11                     #imprime um unico caracter
                #move    $a0, $t1
                #syscall

                ###########

                la $t3, bufferOut
                sb $t0, 0($t3)
                file_write01c:
                    move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
                    li $v0, 15
                    la $a1, bufferOut
                    la $a2, 1
                    syscall

                la $t3, bufferOut
                sb $t1, 0($t3)
     
                file_write11c:
                    move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
                    li $v0, 15
                    la $a1, bufferOut
                    la $a2, 1
                    syscall

                #la $t3, bufferOut
                #sb $t2, 0($t3)
                #file_write2:
                #    move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
                #    li $v0, 15
                #    la $a1, bufferOut
                #    la $a2, 1
                #    syscall
                move $t6, $t2    #save last value
                j continue1c

            count3More1c:
            ###############################
             #   li      $v0, 11                     #imprime um unico caracter
             #   li $t7, 'Â¢'
             #   move $a0, $t7
             #   syscall
          
            ################################

                la $t3, bufferOut
                li $t7, '�'
                sb $t7, 0($t3)         #  #(Â¢)NUMBERchar
                file_write011c:
                    move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
                    li $v0, 15
                    la $a1, bufferOut
                    la $a2, 1
                    syscall


                #li      $v0, 1                      #imprime um unico caracter
                #move    $a0, $t4
                #syscall
                

                la $t3, bufferOut
                #sb $t4, 0($t3)          #Â¢(NUMBER)char
                ###CONV HEX TO INT
                andi $t4,$t4,0x0F # conversÃ£o de hexa para int
                addi $t4, $t4, 48
                ###CONV HEX TO INT
                sb $t4, 0($t3)
                file_write111c:
                    move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
                    li $v0, 15
                    la $a1, bufferOut
                    la $a2, 1
                    syscall
       
   
                la $t3, bufferOut
                sb $t1, 0($t3)          #Â¢NUMBER(char)   
                file_write211c:
                    move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
                    li $v0, 15
                    la $a1, bufferOut
                    la $a2, 1
                    syscall
                move $t6, $t2    #save last value
                
                #li      $v0, 11                     #imprime um unico caracter
                #move    $a0, $t0
                #syscall

                j continue1c          

            j files_close1c

        ###############################
        file_write1c:
            move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
            li $v0, 15
            la $a1, bufferOut
            la $a2, 1
            syscall
        ###############################
    
        continue1c:
            #addi    $s0,$s0,1                   # avanÃ§a ponteiro do vetor bufferWholeFile
            bne     $s0,$zero,loop_write1c        #enquanto t0 nao for 0(EOF) continua a ler
        break_loop1c:

    j files_close1c

file_open_r1c:
    li $v0, 13
    la $a0, fin1
    li $a1, 0
    li $a2, 0
    syscall  # File descriptor gets returned in $v0
    move $s6, $v0
    bltz $v0, arqNEncontrado1c
    jr $ra


file_open_w1c:
    li $v0, 13
    la $a0, fout1
    li $a1, 1
    li $a2, 0
    syscall  # File descriptor gets returned in $v0
    move $s7, $v0
    jr $ra

arqNEncontrado1c:
	li	$v0, 4		# syscall de impressao de string
	la	$a0, erro	# mensagem de erro
	syscall
	#j	cod_data1		#reinicia programa
    addi $v0, $zero, -1
    j continua  	

files_close1c:
    li $v0, 16  # $a0 already has the file descriptor
    move    $a0, $s6    # endereÃ§o do arquivo de entrada
    syscall
    li $v0, 16  # $a0 already has the file descriptor
    move    $a0, $s7    # endereÃ§o do arquivo de saÃ­da
    syscall
    j exit1c

exit1c:
    addi $v0, $zero, -1
    j continua  

cod_data2:

    jal file_open_w2c
    jal file_open_r2c
    addi $t0, $0, 0     #set initial parameter to compare
    addi $t1, $0, 0
    addi $t2, $0, 0
    addi $t3, $0, 0    
    addi $t4, $0, 0
    addi $t5, $0, 0
    addi $t6, $0, 0
    addi $t7, $0, 0
loop_write2c:
        #USEFUL VARIABLES
        addi $t5, $0, 3 # minimum rep to encode
        addi $t4, $0, 2 #repeated bytes
        
        file_read2c:
            li      $v0, 14     # syscall de leitura
            move    $a0, $s6    # endereÃ§o do arquivo
            la      $s0, bufferIn
            la      $a1, 0($s0)    # endereÃ§o da variÃ¡vel
            li      $a2, 1 # espaÃ§o disponÃ­vel para armazenamento
            syscall
            beqz $v0, break_loop2c    #if end of file, break
            lb      $t0, 0($s0)                 # get byte -- is it zero?
        beqz $t6, file_read12c #first time read
        move $t1, $t0
        move $t0, $t6
        j N0N12c
        file_read12c:
            li      $v0, 14     # syscall de leitura
            move    $a0, $s6    # endereÃ§o do arquivo
            la      $s1, bufferIn
            la      $a1, 0($s1)    # endereÃ§o da variÃ¡vel
            li      $a2, 1 # espaÃ§o disponÃ­vel para armazenamento
            syscall
            beqz $v0, break_loop2c    #if end of file, break
            lb      $t1, 0($s1)                 # get byte -- is it zero?

        compareCode2c:
            
            N0N12c:
                bne $t0, $t1, Dif2c

            N1N22c:
                file_read22c:
                    li      $v0, 14     # syscall de leitura
                    move    $a0, $s6    # endereÃ§o do arquivo
                    la      $s2, bufferIn2
                    la      $a1, 0($s2)    # endereÃ§o da variÃ¡vel
                    li      $a2, 1 # espaÃ§o disponÃ­vel para armazenamento
                    syscall
                    lb      $t2, 0($s2)
                bne $t1, $t2, Dif22c  #if different
                beqz $v0, Dif22c      #if EOF
                addi    $t4, $t4, 1             #add 1 to repeated byte count
                j N1N22c  
            
            Dif2c:
            ####DEBUG
            #beqz    $t0, exit                       # quando acaba os valores do arquivo sai do programa
            #li      $v0, 11                     #imprime um unico caracter
            #move    $a0, $t0
            #syscall
            ####END DEBUG 
                #how to load byte
                #la $t3, bufferOut #
                #sb $a0, 0($t3)    #  origin -> destination
                la $t3, bufferOut
                sb $t0, 0($t3)
                move $t6, $t1       #save last value read

                j file_write2c

            Dif22c:
                slt $t7, $t4, $t5   # t6 = 0 if t4 >= 3
                beqz $t7, count3More2c
           
           countLess32c:
                ##########
                #li      $v0, 11                     #imprime um unico caracter
                #move    $a0, $t0
                #syscall
                #li      $v0, 11                     #imprime um unico caracter
                #move    $a0, $t1
                #syscall

                ###########

                la $t3, bufferOut
                sb $t0, 0($t3)
                file_write02c:
                    move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
                    li $v0, 15
                    la $a1, bufferOut
                    la $a2, 1
                    syscall

                la $t3, bufferOut
                sb $t1, 0($t3)
     
                file_write12c:
                    move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
                    li $v0, 15
                    la $a1, bufferOut
                    la $a2, 1
                    syscall

                #la $t3, bufferOut
                #sb $t2, 0($t3)
                #file_write2:
                #    move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
                #    li $v0, 15
                #    la $a1, bufferOut
                #    la $a2, 1
                #    syscall
                move $t6, $t2    #save last value
                j continue2c

            count3More2c:
            ###############################
             #   li      $v0, 11                     #imprime um unico caracter
             #   li $t7, 'Â¢'
             #   move $a0, $t7
             #   syscall
          
            ################################

                la $t3, bufferOut
                li $t7, '�'
                sb $t7, 0($t3)         #  #(Â¢)NUMBERchar
                file_write012c:
                    move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
                    li $v0, 15
                    la $a1, bufferOut
                    la $a2, 1
                    syscall


                #li      $v0, 1                      #imprime um unico caracter
                #move    $a0, $t4
                #syscall
                

                la $t3, bufferOut
                #sb $t4, 0($t3)          #Â¢(NUMBER)char
                ###CONV HEX TO INT
                andi $t4,$t4,0x0F # conversÃ£o de hexa para int
                addi $t4, $t4, 48
                ###CONV HEX TO INT
                sb $t4, 0($t3)
                file_write112c:
                    move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
                    li $v0, 15
                    la $a1, bufferOut
                    la $a2, 1
                    syscall
       
   
                la $t3, bufferOut
                sb $t1, 0($t3)          #Â¢NUMBER(char)   
                file_write212c:
                    move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
                    li $v0, 15
                    la $a1, bufferOut
                    la $a2, 1
                    syscall
                move $t6, $t2    #save last value
                
                #li      $v0, 11                     #imprime um unico caracter
                #move    $a0, $t0
                #syscall

                j continue2c          

            j files_close2c

        ###############################
        file_write2c:
            move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
            li $v0, 15
            la $a1, bufferOut
            la $a2, 1
            syscall
        ###############################
    
        continue2c:
            #addi    $s0,$s0,1                   # avanÃ§a ponteiro do vetor bufferWholeFile
            bne     $s0,$zero,loop_write2c        #enquanto t0 nao for 0(EOF) continua a ler
        break_loop2c:

    j files_close2c

file_open_r2c:
    li $v0, 13
    la $a0, fin2
    li $a1, 0
    li $a2, 0
    syscall  # File descriptor gets returned in $v0
    bltz $v0, arqNEncontrado2c
    move $s6, $v0
    jr $ra


file_open_w2c:
    li $v0, 13
    la $a0, fout2
    li $a1, 1
    li $a2, 0
    syscall  # File descriptor gets returned in $v0
    move $s7, $v0
    jr $ra

arqNEncontrado2c:
    li  $v0, 4      # syscall de impressao de string
    la  $a0, erro   # mensagem de erro
    syscall
    #j   cod2c      #reinicia programa
    addi $v0, $zero, -1
    j continua  

files_close2c:
    li $v0, 16  # $a0 already has the file descriptor
    move    $a0, $s6    # endereÃ§o do arquivo de entrada
    syscall
    li $v0, 16  # $a0 already has the file descriptor
    move    $a0, $s7    # endereÃ§o do arquivo de saÃ­da
    syscall
    j exit2c

exit2c:
    addi $v0, $zero, -1
    j continua  

cod_data3:

    jal file_open_w3c
    jal file_open_r3c
    addi $t0, $0, 0     #set initial parameter to compare
    addi $t1, $0, 0
    addi $t2, $0, 0
    addi $t3, $0, 0    
    addi $t4, $0, 0
    addi $t5, $0, 0
    addi $t6, $0, 0
    addi $t7, $0, 0
loop_write3c:
        #USEFUL VARIABLES
        addi $t5, $0, 3 # minimum rep to encode
        addi $t4, $0, 2 #repeated bytes
        
        file_read3c:
            li      $v0, 14     # syscall de leitura
            move    $a0, $s6    # endereÃ§o do arquivo
            la      $s0, bufferIn
            la      $a1, 0($s0)    # endereÃ§o da variÃ¡vel
            li      $a2, 1 # espaÃ§o disponÃ­vel para armazenamento
            syscall
            beqz $v0, break_loop3c    #if end of file, break
            lb      $t0, 0($s0)                 # get byte -- is it zero?
        beqz $t6, file_read13c #first time read
        move $t1, $t0
        move $t0, $t6
        j N0N13c
        file_read13c:
            li      $v0, 14     # syscall de leitura
            move    $a0, $s6    # endereÃ§o do arquivo
            la      $s1, bufferIn
            la      $a1, 0($s1)    # endereÃ§o da variÃ¡vel
            li      $a2, 1 # espaÃ§o disponÃ­vel para armazenamento
            syscall
            beqz $v0, break_loop3c    #if end of file, break
            lb      $t1, 0($s1)                 # get byte -- is it zero?

        compareCode3c:
            
            N0N13c:
                bne $t0, $t1, Dif3c

            N1N23c:
                file_read23c:
                    li      $v0, 14     # syscall de leitura
                    move    $a0, $s6    # endereÃ§o do arquivo
                    la      $s2, bufferIn2
                    la      $a1, 0($s2)    # endereÃ§o da variÃ¡vel
                    li      $a2, 1 # espaÃ§o disponÃ­vel para armazenamento
                    syscall
                    lb      $t2, 0($s2)
                bne $t1, $t2, Dif23c  #if different
                beqz $v0, Dif23c      #if EOF
                addi    $t4, $t4, 1             #add 1 to repeated byte count
                j N1N23c  
            
            Dif3c:
            ####DEBUG
            #beqz    $t0, exit                       # quando acaba os valores do arquivo sai do programa
            #li      $v0, 11                     #imprime um unico caracter
            #move    $a0, $t0
            #syscall
            ####END DEBUG 
                #how to load byte
                #la $t3, bufferOut #
                #sb $a0, 0($t3)    #  origin -> destination
                la $t3, bufferOut
                sb $t0, 0($t3)
                move $t6, $t1       #save last value read

                j file_write3c

            Dif23c:
                slt $t7, $t4, $t5   # t6 = 0 if t4 >= 3
                beqz $t7, count3More3c
           
           countLess33c:
                ##########
                #li      $v0, 11                     #imprime um unico caracter
                #move    $a0, $t0
                #syscall
                #li      $v0, 11                     #imprime um unico caracter
                #move    $a0, $t1
                #syscall

                ###########

                la $t3, bufferOut
                sb $t0, 0($t3)
                file_write03c:
                    move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
                    li $v0, 15
                    la $a1, bufferOut
                    la $a2, 1
                    syscall

                la $t3, bufferOut
                sb $t1, 0($t3)
     
                file_write13c:
                    move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
                    li $v0, 15
                    la $a1, bufferOut
                    la $a2, 1
                    syscall

                #la $t3, bufferOut
                #sb $t2, 0($t3)
                #file_write2:
                #    move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
                #    li $v0, 15
                #    la $a1, bufferOut
                #    la $a2, 1
                #    syscall
                move $t6, $t2    #save last value
                j continue3c

            count3More3c:
            ###############################
             #   li      $v0, 11                     #imprime um unico caracter
             #   li $t7, 'Â¢'
             #   move $a0, $t7
             #   syscall
          
            ################################

                la $t3, bufferOut
                li $t7, '�'
                sb $t7, 0($t3)         #  #(Â¢)NUMBERchar
                file_write013c:
                    move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
                    li $v0, 15
                    la $a1, bufferOut
                    la $a2, 1
                    syscall


                #li      $v0, 1                      #imprime um unico caracter
                #move    $a0, $t4
                #syscall
                

                la $t3, bufferOut
                #sb $t4, 0($t3)          #Â¢(NUMBER)char
                ###CONV HEX TO INT
                andi $t4,$t4,0x0F # conversÃ£o de hexa para int
                addi $t4, $t4, 48
                ###CONV HEX TO INT
                sb $t4, 0($t3)
                file_write113c:
                    move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
                    li $v0, 15
                    la $a1, bufferOut
                    la $a2, 1
                    syscall
       
   
                la $t3, bufferOut
                sb $t1, 0($t3)          #Â¢NUMBER(char)   
                file_write213c:
                    move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
                    li $v0, 15
                    la $a1, bufferOut
                    la $a2, 1
                    syscall
                move $t6, $t2    #save last value
                
                #li      $v0, 11                     #imprime um unico caracter
                #move    $a0, $t0
                #syscall

                j continue3c          

            j files_close3c

        ###############################
        file_write3c:
            move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
            li $v0, 15
            la $a1, bufferOut
            la $a2, 1
            syscall
        ###############################
    
        continue3c:
            #addi    $s0,$s0,1                   # avanÃ§a ponteiro do vetor bufferWholeFile
            bne     $s0,$zero,loop_write3c        #enquanto t0 nao for 0(EOF) continua a ler
        break_loop3c:

    j files_close3c

file_open_r3c:
    li $v0, 13
    la $a0, fin3
    li $a1, 0
    li $a2, 0
    syscall  # File descriptor gets returned in $v0
    bltz $v0, arqNEncontrado3c
    move $s6, $v0
    jr $ra


file_open_w3c:
    li $v0, 13
    la $a0, fout3
    li $a1, 1
    li $a2, 0
    syscall  # File descriptor gets returned in $v0
    move $s7, $v0
    jr $ra

arqNEncontrado3c:
    li  $v0, 4      # syscall de impressao de string
    la  $a0, erro   # mensagem de erro
    syscall
    #j   cod3c      #reinicia programa  
    addi $v0, $zero, -1
    j continua  
    
files_close3c:
    li $v0, 16  # $a0 already has the file descriptor
    move    $a0, $s6    # endereÃ§o do arquivo de entrada
    syscall
    li $v0, 16  # $a0 already has the file descriptor
    move    $a0, $s7    # endereÃ§o do arquivo de saÃ­da
    syscall
    j exit3c

exit3c:
    addi $v0, $zero, -1
    j continua  


cod_data4:

    jal file_open_w4c
    jal file_open_r4c
    addi $t0, $0, 0     #set initial parameter to compare
    addi $t1, $0, 0
    addi $t2, $0, 0
    addi $t3, $0, 0    
    addi $t4, $0, 0
    addi $t5, $0, 0
    addi $t6, $0, 0
    addi $t7, $0, 0
loop_write4c:
        #USEFUL VARIABLES
        addi $t5, $0, 3 # minimum rep to encode
        addi $t4, $0, 2 #repeated bytes
        
        file_read4c:
            li      $v0, 14     # syscall de leitura
            move    $a0, $s6    # endereÃ§o do arquivo
            la      $s0, bufferIn
            la      $a1, 0($s0)    # endereÃ§o da variÃ¡vel
            li      $a2, 1 # espaÃ§o disponÃ­vel para armazenamento
            syscall
            beqz $v0, break_loop4c    #if end of file, break
            lb      $t0, 0($s0)                 # get byte -- is it zero?
        beqz $t6, file_read14c #first time read
        move $t1, $t0
        move $t0, $t6
        j N0N14c
        file_read14c:
            li      $v0, 14     # syscall de leitura
            move    $a0, $s6    # endereÃ§o do arquivo
            la      $s1, bufferIn
            la      $a1, 0($s1)    # endereÃ§o da variÃ¡vel
            li      $a2, 1 # espaÃ§o disponÃ­vel para armazenamento
            syscall
            beqz $v0, break_loop4c    #if end of file, break
            lb      $t1, 0($s1)                 # get byte -- is it zero?

        compareCode4c:
            
            N0N14c:
                bne $t0, $t1, Dif4c

            N1N24c:
                file_read24c:
                    li      $v0, 14     # syscall de leitura
                    move    $a0, $s6    # endereÃ§o do arquivo
                    la      $s2, bufferIn2
                    la      $a1, 0($s2)    # endereÃ§o da variÃ¡vel
                    li      $a2, 1 # espaÃ§o disponÃ­vel para armazenamento
                    syscall
                    lb      $t2, 0($s2)
                bne $t1, $t2, Dif24c  #if different
                beqz $v0, Dif24c      #if EOF
                addi    $t4, $t4, 1             #add 1 to repeated byte count
                j N1N24c  
            
            Dif4c:
            ####DEBUG
            #beqz    $t0, exit                       # quando acaba os valores do arquivo sai do programa
            #li      $v0, 11                     #imprime um unico caracter
            #move    $a0, $t0
            #syscall
            ####END DEBUG 
                #how to load byte
                #la $t3, bufferOut #
                #sb $a0, 0($t3)    #  origin -> destination
                la $t3, bufferOut
                sb $t0, 0($t3)
                move $t6, $t1       #save last value read

                j file_write4c

            Dif24c:
                slt $t7, $t4, $t5   # t6 = 0 if t4 >= 3
                beqz $t7, count3More4c
           
           countLess34c:
                ##########
                #li      $v0, 11                     #imprime um unico caracter
                #move    $a0, $t0
                #syscall
                #li      $v0, 11                     #imprime um unico caracter
                #move    $a0, $t1
                #syscall

                ###########

                la $t3, bufferOut
                sb $t0, 0($t3)
                file_write04c:
                    move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
                    li $v0, 15
                    la $a1, bufferOut
                    la $a2, 1
                    syscall

                la $t3, bufferOut
                sb $t1, 0($t3)
     
                file_write14c:
                    move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
                    li $v0, 15
                    la $a1, bufferOut
                    la $a2, 1
                    syscall

                #la $t3, bufferOut
                #sb $t2, 0($t3)
                #file_write2:
                #    move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
                #    li $v0, 15
                #    la $a1, bufferOut
                #    la $a2, 1
                #    syscall
                move $t6, $t2    #save last value
                j continue4c

            count3More4c:
            ###############################
             #   li      $v0, 11                     #imprime um unico caracter
             #   li $t7, 'Â¢'
             #   move $a0, $t7
             #   syscall
          
            ################################

                la $t3, bufferOut
                li $t7, '�'
                sb $t7, 0($t3)         #  #(Â¢)NUMBERchar
                file_write014c:
                    move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
                    li $v0, 15
                    la $a1, bufferOut
                    la $a2, 1
                    syscall


                #li      $v0, 1                      #imprime um unico caracter
                #move    $a0, $t4
                #syscall
                

                la $t3, bufferOut
                #sb $t4, 0($t3)          #Â¢(NUMBER)char
                ###CONV HEX TO INT
                andi $t4,$t4,0x0F # conversÃ£o de hexa para int
                addi $t4, $t4, 48
                ###CONV HEX TO INT
                sb $t4, 0($t3)
                file_write114c:
                    move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
                    li $v0, 15
                    la $a1, bufferOut
                    la $a2, 1
                    syscall
       
   
                la $t3, bufferOut
                sb $t1, 0($t3)          #Â¢NUMBER(char)   
                file_write214c:
                    move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
                    li $v0, 15
                    la $a1, bufferOut
                    la $a2, 1
                    syscall
                move $t6, $t2    #save last value
                
                #li      $v0, 11                     #imprime um unico caracter
                #move    $a0, $t0
                #syscall

                j continue4c          

            j files_close4c

        ###############################
        file_write4c:
            move $a0, $s7 # Syscall 15 requieres file descriptor in $a0
            li $v0, 15
            la $a1, bufferOut
            la $a2, 1
            syscall
        ###############################
    
        continue4c:
            #addi    $s0,$s0,1                   # avanÃ§a ponteiro do vetor bufferWholeFile
            bne     $s0,$zero,loop_write4c        #enquanto t0 nao for 0(EOF) continua a ler
        break_loop4c:

    j files_close4c

file_open_r4c:
    li $v0, 13
    la $a0, fin4
    li $a1, 0
    li $a2, 0
    syscall  # File descriptor gets returned in $v0
    bltz $v0, arqNEncontrado4c
    move $s6, $v0
    jr $ra


file_open_w4c:
    li $v0, 13
    la $a0, fout4
    li $a1, 1
    li $a2, 0
    syscall  # File descriptor gets returned in $v0
    move $s7, $v0
    jr $ra

arqNEncontrado4c:
    li  $v0, 4      # syscall de impressao de string
    la  $a0, erro   # mensagem de erro
    syscall
    #j   cod4c      #reinicia programa  
    addi $v0, $zero, -1
    j continua  
files_close4c:
    li $v0, 16  # $a0 already has the file descriptor
    move    $a0, $s6    # endereÃ§o do arquivo de entrada
    syscall
    li $v0, 16  # $a0 already has the file descriptor
    move    $a0, $s7    # endereÃ§o do arquivo de saÃ­da
    syscall
    j exit4c

exit4c:
    addi $v0, $zero, -1
    j continua  
