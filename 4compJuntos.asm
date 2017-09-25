#codificador
.data
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
####$s6 and $s7 file descriptors

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
            move    $a0, $s6    # endereÃƒÂ§o do arquivo
            la      $s0, bufferIn
            la      $a1, 0($s0)    # endereÃƒÂ§o da variÃƒÂ¡vel
            li      $a2, 1 # espaÃƒÂ§o disponÃƒÂ­vel para armazenamento
            syscall
            beqz $v0, break_loop1c    #if end of file, break
            lb      $t0, 0($s0)                 # get byte -- is it zero?
        beqz $t6, file_read11c #first time read
        move $t1, $t0
        move $t0, $t6
        j N0N11c
        file_read11c:
            li      $v0, 14     # syscall de leitura
            move    $a0, $s6    # endereÃƒÂ§o do arquivo
            la      $s1, bufferIn
            la      $a1, 0($s1)    # endereÃƒÂ§o da variÃƒÂ¡vel
            li      $a2, 1 # espaÃƒÂ§o disponÃƒÂ­vel para armazenamento
            syscall
            beqz $v0, break_loop1c    #if end of file, break
            lb      $t1, 0($s1)                 # get byte -- is it zero?

        compareCode1c:
            
            N0N11c:
                bne $t0, $t1, Dif1c

            N1N21c:
                file_read21c:
                    li      $v0, 14     # syscall de leitura
                    move    $a0, $s6    # endereÃƒÂ§o do arquivo
                    la      $s2, bufferIn2
                    la      $a1, 0($s2)    # endereÃƒÂ§o da variÃƒÂ¡vel
                    li      $a2, 1 # espaÃƒÂ§o disponÃƒÂ­vel para armazenamento
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
             #   li $t7, 'Ã‚Â¢'
             #   move $a0, $t7
             #   syscall
          
            ################################

                la $t3, bufferOut
                li $t7, '¢'
                sb $t7, 0($t3)         #  #(Ã‚Â¢)NUMBERchar
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
                #sb $t4, 0($t3)          #Ã‚Â¢(NUMBER)char
                ###CONV HEX TO INT
                andi $t4,$t4,0x0F # conversÃƒÂ£o de hexa para int
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
                sb $t1, 0($t3)          #Ã‚Â¢NUMBER(char)   
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
            #addi    $s0,$s0,1                   # avanÃƒÂ§a ponteiro do vetor bufferWholeFile
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
    move    $a0, $s6    # endereÃƒÂ§o do arquivo de entrada
    syscall
    li $v0, 16  # $a0 already has the file descriptor
    move    $a0, $s7    # endereÃƒÂ§o do arquivo de saÃƒÂ­da
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
            move    $a0, $s6    # endereÃƒÂ§o do arquivo
            la      $s0, bufferIn
            la      $a1, 0($s0)    # endereÃƒÂ§o da variÃƒÂ¡vel
            li      $a2, 1 # espaÃƒÂ§o disponÃƒÂ­vel para armazenamento
            syscall
            beqz $v0, break_loop2c    #if end of file, break
            lb      $t0, 0($s0)                 # get byte -- is it zero?
        beqz $t6, file_read12c #first time read
        move $t1, $t0
        move $t0, $t6
        j N0N12c
        file_read12c:
            li      $v0, 14     # syscall de leitura
            move    $a0, $s6    # endereÃƒÂ§o do arquivo
            la      $s1, bufferIn
            la      $a1, 0($s1)    # endereÃƒÂ§o da variÃƒÂ¡vel
            li      $a2, 1 # espaÃƒÂ§o disponÃƒÂ­vel para armazenamento
            syscall
            beqz $v0, break_loop2c    #if end of file, break
            lb      $t1, 0($s1)                 # get byte -- is it zero?

        compareCode2c:
            
            N0N12c:
                bne $t0, $t1, Dif2c

            N1N22c:
                file_read22c:
                    li      $v0, 14     # syscall de leitura
                    move    $a0, $s6    # endereÃƒÂ§o do arquivo
                    la      $s2, bufferIn2
                    la      $a1, 0($s2)    # endereÃƒÂ§o da variÃƒÂ¡vel
                    li      $a2, 1 # espaÃƒÂ§o disponÃƒÂ­vel para armazenamento
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
             #   li $t7, 'Ã‚Â¢'
             #   move $a0, $t7
             #   syscall
          
            ################################

                la $t3, bufferOut
                li $t7, '¢'
                sb $t7, 0($t3)         #  #(Ã‚Â¢)NUMBERchar
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
                #sb $t4, 0($t3)          #Ã‚Â¢(NUMBER)char
                ###CONV HEX TO INT
                andi $t4,$t4,0x0F # conversÃƒÂ£o de hexa para int
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
                sb $t1, 0($t3)          #Ã‚Â¢NUMBER(char)   
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
            #addi    $s0,$s0,1                   # avanÃƒÂ§a ponteiro do vetor bufferWholeFile
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
    move    $a0, $s6    # endereÃƒÂ§o do arquivo de entrada
    syscall
    li $v0, 16  # $a0 already has the file descriptor
    move    $a0, $s7    # endereÃƒÂ§o do arquivo de saÃƒÂ­da
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
            move    $a0, $s6    # endereÃƒÂ§o do arquivo
            la      $s0, bufferIn
            la      $a1, 0($s0)    # endereÃƒÂ§o da variÃƒÂ¡vel
            li      $a2, 1 # espaÃƒÂ§o disponÃƒÂ­vel para armazenamento
            syscall
            beqz $v0, break_loop3c    #if end of file, break
            lb      $t0, 0($s0)                 # get byte -- is it zero?
        beqz $t6, file_read13c #first time read
        move $t1, $t0
        move $t0, $t6
        j N0N13c
        file_read13c:
            li      $v0, 14     # syscall de leitura
            move    $a0, $s6    # endereÃƒÂ§o do arquivo
            la      $s1, bufferIn
            la      $a1, 0($s1)    # endereÃƒÂ§o da variÃƒÂ¡vel
            li      $a2, 1 # espaÃƒÂ§o disponÃƒÂ­vel para armazenamento
            syscall
            beqz $v0, break_loop3c    #if end of file, break
            lb      $t1, 0($s1)                 # get byte -- is it zero?

        compareCode3c:
            
            N0N13c:
                bne $t0, $t1, Dif3c

            N1N23c:
                file_read23c:
                    li      $v0, 14     # syscall de leitura
                    move    $a0, $s6    # endereÃƒÂ§o do arquivo
                    la      $s2, bufferIn2
                    la      $a1, 0($s2)    # endereÃƒÂ§o da variÃƒÂ¡vel
                    li      $a2, 1 # espaÃƒÂ§o disponÃƒÂ­vel para armazenamento
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
             #   li $t7, 'Ã‚Â¢'
             #   move $a0, $t7
             #   syscall
          
            ################################

                la $t3, bufferOut
                li $t7, '¢'
                sb $t7, 0($t3)         #  #(Ã‚Â¢)NUMBERchar
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
                #sb $t4, 0($t3)          #Ã‚Â¢(NUMBER)char
                ###CONV HEX TO INT
                andi $t4,$t4,0x0F # conversÃƒÂ£o de hexa para int
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
                sb $t1, 0($t3)          #Ã‚Â¢NUMBER(char)   
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
            #addi    $s0,$s0,1                   # avanÃƒÂ§a ponteiro do vetor bufferWholeFile
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
    move    $a0, $s6    # endereÃƒÂ§o do arquivo de entrada
    syscall
    li $v0, 16  # $a0 already has the file descriptor
    move    $a0, $s7    # endereÃƒÂ§o do arquivo de saÃƒÂ­da
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
            move    $a0, $s6    # endereÃƒÂ§o do arquivo
            la      $s0, bufferIn
            la      $a1, 0($s0)    # endereÃƒÂ§o da variÃƒÂ¡vel
            li      $a2, 1 # espaÃƒÂ§o disponÃƒÂ­vel para armazenamento
            syscall
            beqz $v0, break_loop4c    #if end of file, break
            lb      $t0, 0($s0)                 # get byte -- is it zero?
        beqz $t6, file_read14c #first time read
        move $t1, $t0
        move $t0, $t6
        j N0N14c
        file_read14c:
            li      $v0, 14     # syscall de leitura
            move    $a0, $s6    # endereÃƒÂ§o do arquivo
            la      $s1, bufferIn
            la      $a1, 0($s1)    # endereÃƒÂ§o da variÃƒÂ¡vel
            li      $a2, 1 # espaÃƒÂ§o disponÃƒÂ­vel para armazenamento
            syscall
            beqz $v0, break_loop4c    #if end of file, break
            lb      $t1, 0($s1)                 # get byte -- is it zero?

        compareCode4c:
            
            N0N14c:
                bne $t0, $t1, Dif4c

            N1N24c:
                file_read24c:
                    li      $v0, 14     # syscall de leitura
                    move    $a0, $s6    # endereÃƒÂ§o do arquivo
                    la      $s2, bufferIn2
                    la      $a1, 0($s2)    # endereÃƒÂ§o da variÃƒÂ¡vel
                    li      $a2, 1 # espaÃƒÂ§o disponÃƒÂ­vel para armazenamento
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
             #   li $t7, 'Ã‚Â¢'
             #   move $a0, $t7
             #   syscall
          
            ################################

                la $t3, bufferOut
                li $t7, '¢'
                sb $t7, 0($t3)         #  #(Ã‚Â¢)NUMBERchar
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
                #sb $t4, 0($t3)          #Ã‚Â¢(NUMBER)char
                ###CONV HEX TO INT
                andi $t4,$t4,0x0F # conversÃƒÂ£o de hexa para int
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
                sb $t1, 0($t3)          #Ã‚Â¢NUMBER(char)   
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
            #addi    $s0,$s0,1                   # avanÃƒÂ§a ponteiro do vetor bufferWholeFile
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
    move    $a0, $s6    # endereÃƒÂ§o do arquivo de entrada
    syscall
    li $v0, 16  # $a0 already has the file descriptor
    move    $a0, $s7    # endereÃƒÂ§o do arquivo de saÃƒÂ­da
    syscall
    j exit4c

exit4c:
    addi $v0, $zero, -1
    j continua  
