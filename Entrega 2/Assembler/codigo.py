from sys import argv

assembly_dict = {
    ## MOV
    "MOV A,B":		"00000000000000000",
    "MOV B,A":		"00000000000000001",
    "MOV A,Lit":	"00000000000000010",
    "MOV B,Lit":	"00000000000000011",
    "MOV A,(Dir)":	"00000000000000100",
    "MOV B,(Dir)":	"00000000000000101",
    "MOV (Dir),A":	"00000000000000110",
    "MOV (Dir),B":	"00000000000000111",
    
    ## ADD
    "ADD A,B":		"00000000000001000", ## A, B
    "ADD B,A":		"00000000000001001", ## B, A
    "ADD A,Lit":	"00000000000001010", ## A,Lit
    "ADD B,Lit":	"00000000000001011", ## B,Lit
    "ADD A,(Dir)":	"00000000000001100", ## A,(Dir)
    "ADD B,(Dir)":	"00000000000001101", ## B,(Dir)
    "ADD (Dir)":	"00000000000001110", ## (Dir)
    
		## SUB
	"SUB A,B":		"00000000000001111", ## A,B
	"SUB B,A":		"00000000000010000", ## B,A
	"SUB A,Lit":	"00000000000010001", ## A,Lit
	"SUB B,Lit":	"00000000000010010", ## B,Lit
	"SUB A,(Dir)":	"00000000000010011", ## A,(Dir) 0011001
	"SUB B,(Dir)":	"00000000000010100", ## B,(Dir) 0011010
	"SUB (Dir)":	"00000000000010101", ## (Dir) 0011011
	
		## AND
	"AND A,B":		"00000000000010110", ## A, B
	"AND B,A":		"00000000000010111", ## B, A
	"AND A,Lit":	"00000000000011000", ## A, Lit
	"AND B,Lit":	"00000000000011001", ## B, Lit
	"AND A,(Dir)":	"00000000000011010", ## A, (Dir)
	"AND B,(Dir)":	"00000000000011011", ## B, (Dir)
	"AND (Dir)":	"00000000000011100", ## (Dir)
	
		## OR
	"OR A,B":		"00000000000011101", ## A, B
	"OR B,A":		"00000000000011110", ## B, A
	"OR A,Lit":		"00000000000011111", ## A, Lit
	"OR B,Lit":		"00000000000100000", ## B, Lit
	"OR A,(Dir)":	"00000000000100001", ## A, (Dir)
	"OR B,(Dir)":	"00000000000100010", ## B, (Dir)
	"OR (Dir)":		"00000000000100011", ## (Dir)	
	
	## XOR	
	"XOR A,B":		"00000000000100100", ## A, B
	"XOR B,A":		"00000000000100101", ## B, A
	"XOR A,Lit":	"00000000000100110", ## A, Lit
	"XOR B,Lit":	"00000000000100111", ## B, Lit
	"XOR A,(Dir)":	"00000000000101000", ## A, (Dir)
	"XOR B,(Dir)":	"00000000000101001", ## B, (Dir)
	"XOR (Dir)":	"00000000000101010", ## (Dir)
	"NOT A":		"00000000000101011", ## A
	"NOT B,A":		"00000000000101100", ## B, A
	"NOT (Dir),A":	"00000000000101101", ## (Dir), A
	"SHL A":		"00000000000101110", ## A
	"SHL B,A":		"00000000000101111", ## B, A
	"SHL (Dir),A":	"00000000000110000", ## (Dir), A
	"SHR A":		"00000000000110001", ## A
	"SHR B,A":		"00000000000110010", ## B, A
	"SHR (Dir),A":	"00000000000110100", ## (Dir), A
	"INC A":		"00000000000110101", ## A
	"INC B":		"00000000000110110", ## B
	"INC (Dir)":	"00000000000110111", ## (Dir)		
	"DEC A":		"00000000000111000", ## DEC A
	"CMP A,B":		"00000000000111001", ## A, B
	"CMP A,Lit":	"00000000000111010", ## A, Lit
	"CMP A,(Dir)":	"00000000000111011", ## A, (Dir)
	"JMP (Dir)":	"00000000000111100", ## JMP (Dir)
  	"JEQ (B),A":	"00000000000111101", ## JEQ (Dir)
  	"JNE A":		"00000000000111110", ## JNE (Dir)
	"JGT A":		"00000000000111111", ## JGT (Dir)
	"JGE B,A":		"00000000001000000", ## JGE (Dir)
	"JLT (Dir),A":	"00000000001000001", ## JLT (Dir)
	"JLE A":		"00000000001000010", ## JLE (Dir)
	"JCR B":		"00000000001000011", ## JCR (Dir) ####### ver que hacer con status
	"NOP":			"00000000001000100", ## NOP NOP
}
direcciones=dict()
direcciones_en_bin = dict()

def convertir_binario(numero):
    binario = bin(numero)[2:].zfill(16)
    if numero > 65535:
        return(bin(0)[2:].zfill(16))
    return(binario)

bin_text=""
with open("../Test/"+argv[1], "r") as data:
	var_counter=0
	code= False
	data.readline()
	for line in data:
		print(line.strip())
		line=line.strip().split(" ")
		
		if "CODE" in line[0]:
			code=True
		elif not code:
			if line[0]!="":
				direcciones[line[0]] = var_counter ##en vez de varcounter va la funcion num_binario(var_counter)
				direcciones_en_bin[var_counter] = convertir_binario(int(line[1]))
				var_counter+=1
		else:
			if len(line)==1:
				if ":" in line[0]:
					print(f"direcciones = {direcciones}")
				elif line[0]!="":
					print(assembly_dict[line[0]])
			else:
				line1=line[1].split(",")
				if len(line1)==1:
					if line1[0] in "AB":
						## Estructura: bin_text = lo que habia antes en el bin_text
						## '0000000000000000' es si hay un A o B como segundo argumento de la instruccion. En otro caso, se da el literal o la direccion de memoria en binario
						## '000000' son 6 ceros que estan para llegar a los 33 bits
						## assembly_dict[...] es el opcode que esta en el diccionario assembly y esta definido por lo que esta dentro de los corchetes
						## \n para dar un enter
						bin_text = bin_text +'0000000000000000' + '000000' + assembly_dict[line[0]+" "+line1[0]] + '\n'
						print(assembly_dict[line[0]+" "+line1[0]])
					elif "(" in line1[0]:
						line1[0] = line1[0][1 : len(line1[0]) - 1]
						bin_text = bin_text + direcciones_en_bin[direcciones[line1[0]]] + '000000' + assembly_dict[line[0]+" (Dir)"] + '\n'
						print(assembly_dict[line[0]+" (Dir)"])
					else:
						## jumps: estructura especial
						## convertir_binario(...) representa la direccion de memoria en la que se almacena. por ejemplo, si D0 esta en 2, esto es 2 en binario -> 0...010
						## el resto todo igual
						try: 
							bin_text = bin_text + convertir_binario(int(direcciones[line1[0]])) + '000000' + assembly_dict["JMP (Dir)"] + '\n'
						except:
							direcciones[line1[0][ : len(line1[0])]] = var_counter
							var_counter+=1
							bin_text = bin_text + convertir_binario(int(direcciones[line1[0]])) + '000000' + assembly_dict["JMP (Dir)"] + '\n'
						print(assembly_dict["JMP (Dir)"])
				else:
					if line1[0] in "AB":
						if "(" in line1[1]:
							line1[1] = line1[1][1 : len(line1[1]) - 1]
							bin_text = bin_text + direcciones_en_bin[direcciones[line1[1]]] + '000000' + assembly_dict[line[0]+" "+line1[0]+",(Dir)"] + '\n'
							print(assembly_dict[line[0]+" "+line1[0]+",(Dir)"])
						elif line1[1] in "AB":
							bin_text = bin_text + '0000000000000000' + '000000' + assembly_dict[line[0]+" "+line1[0]+","+line1[1]] + '\n'
							print(assembly_dict[line[0]+" "+line1[0]+","+line1[1]])
						else:
							lit = convertir_binario(int(line1[1]))
							bin_text = bin_text + lit + '000000' + assembly_dict[line[0]+" "+line1[0]+",Lit"] + '\n'
							print(assembly_dict[line[0]+" "+line1[0]+",Lit"])

					elif line1[1] in "AB":
						if "(" in line1[0]:
							bin_text = bin_text + '0000000000000000' + '000000' + assembly_dict[line[0]+" (Dir),"+line1[1]] + '\n'
							print(assembly_dict[line[0]+" (Dir),"+line1[1]])
					else:
						##jumps
						##falta agregar otros casos de JMP (JEQ, JGT....)
						pass

print(f"direcciones = {direcciones}")
print(f"direcciones bin = {direcciones_en_bin}")



					



		
# print(assembly_dict["SUB A,B"])


with open(argv[1][:len(argv[1])-4]+"_bin.txt", "w") as output:
	output.write(bin_text)