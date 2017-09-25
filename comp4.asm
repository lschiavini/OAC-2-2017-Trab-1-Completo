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

data4c:

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
            beqz $v0, break_loop    #if end of file, break
            lb      $t0, 0($s0)                 # get byte -- is it zero?
        beqz $t6, file_read14c #first time read
        move $t1, $t0
        move $t0, $t6
        j N0N1
        file_read14c:
            li      $v0, 14     # syscall de leitura
            move    $a0, $s6    # endereÃƒÂ§o do arquivo
            la      $s1, bufferIn
            la      $a1, 0($s1)    # endereÃƒÂ§o da variÃƒÂ¡vel
            li      $a2, 1 # espaÃƒÂ§o disponÃƒÂ­vel para armazenamento
            syscall
            beqz $v0, break_loop    #if end of file, break
            lb      $t1, 0($s1)                 # get byte -- is it zero?

        compareCode:
            
            N0N1:
                bne $t0, $t1, Dif4c

            N1N2:
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
                j N1N2  
            
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
        break_loop:

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
    #j   data4c      #reinicia programa  
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
