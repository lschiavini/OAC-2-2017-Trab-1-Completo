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
data1c: .asciiz "C:/Users/Danielle/Documents/Engenharia Mecatrônica/Semestre 7/Organização e Arquitetura de Computadores/Trabalho1/OAC22017/data1.rle"	# arquivos codificados data1.rle
data2c: .asciiz "C:/Users/Danielle/Documents/Engenharia Mecatrônica/Semestre 7/Organização e Arquitetura de Computadores/Trabalho1/OAC22017/data2.rle"	# data2.rle
data3c: .asciiz "C:/Users/Danielle/Documents/Engenharia Mecatrônica/Semestre 7/Organização e Arquitetura de Computadores/Trabalho1/OAC22017/data3.rle"	# data3.rle
data4c: .asciiz "C:/Users/Danielle/Documents/Engenharia Mecatrônica/Semestre 7/Organização e Arquitetura de Computadores/Trabalho1/OAC22017/data4.rle"	# data4.rle
data1d: .asciiz "C:/Users/Danielle/Documents/Engenharia Mecatrônica/Semestre 7/Organização e Arquitetura de Computadores/Trabalho1/OAC22017/data1d.txt"	# arquivos decodificados data1d.txt
data2d: .asciiz "C:/Users/Danielle/Documents/Engenharia Mecatrônica/Semestre 7/Organização e Arquitetura de Computadores/Trabalho1/OAC22017/data2d.txt"	# data2d.txt
data3d: .asciiz "C:/Users/Danielle/Documents/Engenharia Mecatrônica/Semestre 7/Organização e Arquitetura de Computadores/Trabalho1/OAC22017/data3d.txt"	# data3d.txt
data4d: .asciiz "C:/Users/Danielle/Documents/Engenharia Mecatrônica/Semestre 7/Organização e Arquitetura de Computadores/Trabalho1/OAC22017/data4d.txt"	# data4d.txt
data1o: .asciiz "data1.txt"	# arquivos originais
data2o: .asciiz "data2.txt"
data3o: .asciiz "data3.txt"
data4o: .asciiz "data4.txt"
buffer0:   .space 1
buffer1:   .space 1
controle: .byte '¢'

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
cod_data1:
	
cod_data2:

cod_data3:

cod_data4:

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
	li   $v0, 14 # chamada de sistema para leitura do próximo elemento do arquivo 
	move $a0, $s6 
	la $t5, buffer0
	la $a1, 0($t5) # endereço do buffer
	li $a2, 1 
	syscall
	lb $s1, 0($t5) # $s1 contém a quantidade de caracteres a serem repetidos
	andi $s1,$s1,0x0F # conversão de hexa para int
	li $v0, 14 # chamada de sistema para leitura do próximo elemento do arquivo
	move $a0, $s6
	la $t6, buffer0	
	la $a1, 0($t6) # endereço do buffer
	li $a2, 1 
	syscall
	lb $s2, 0($t6) # $s2 contém o caractere a ser repetido
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
    	move $a0, $s6 # endereço do arquivo codificado (leitura)
    	syscall
   	li $v0, 16  # $a0 already has the file descriptor
    	move $a0, $s7 # endereço do arquivo decodificado (escrita)
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
	li   $v0, 14 # chamada de sistema para leitura do próximo elemento do arquivo 
	move $a0, $s6 
	la $t5, buffer0
	la $a1, 0($t5) # endereço do buffer
	li $a2, 1 
	syscall
	lb $s1, 0($t5) # $s1 contém a quantidade de caracteres a serem repetidos
	andi $s1,$s1,0x0F # conversão de hexa para int
	li $v0, 14 # chamada de sistema para leitura do próximo elemento do arquivo
	move $a0, $s6
	la $t6, buffer0	
	la $a1, 0($t6) # endereço do buffer
	li $a2, 1 
	syscall
	lb $s2, 0($t6) # $s2 contém o caractere a ser repetido
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
	li   $v0, 14 # chamada de sistema para leitura do próximo elemento do arquivo 
	move $a0, $s6 
	la $t5, buffer0
	la $a1, 0($t5) # endereço do buffer
	li $a2, 1 
	syscall
	lb $s1, 0($t5) # $s1 contém a quantidade de caracteres a serem repetidos
	andi $s1,$s1,0x0F # conversão de hexa para int
	li $v0, 14 # chamada de sistema para leitura do próximo elemento do arquivo
	move $a0, $s6
	la $t6, buffer0	
	la $a1, 0($t6) # endereço do buffer
	li $a2, 1 
	syscall
	lb $s2, 0($t6) # $s2 contém o caractere a ser repetido
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
	li   $v0, 14 # chamada de sistema para leitura do próximo elemento do arquivo 
	move $a0, $s6 
	la $t5, buffer0
	la $a1, 0($t5) # endereço do buffer
	li $a2, 1 
	syscall
	lb $s1, 0($t5) # $s1 contém a quantidade de caracteres a serem repetidos
	andi $s1,$s1,0x0F # conversão de hexa para int
	li $v0, 14 # chamada de sistema para leitura do próximo elemento do arquivo
	move $a0, $s6
	la $t6, buffer0	
	la $a1, 0($t6) # endereço do buffer
	li $a2, 1 
	syscall
	lb $s2, 0($t6) # $s2 contém o caractere a ser repetido
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