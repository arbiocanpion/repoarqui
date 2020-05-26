# Señales 

## Program Counter (program_counter)

program_count : Señal que le indica al PC si debe cargar el valor de Count in o seguir sumandole uno a la direccion.

neg_program_count : Señal que le indica al PC si debe de sumar uno al registro.

addres_instructions : Vector que recibe el output del PC y es entregada a la ROM.

## Instruction Memory(rom)

addres_instruction : Vector que indica el lugar donde esta la instruccion siguiente.

instrucciones : Vector que indica las instrucciones para la Control Unit, MUX-B y PC.

## Control Unit (control)

instrucciones(16 downto 0): Vector que le indica la secuencia a la Control Unit para que envie las señales correspondientes.



## Mux_b (mux_para_b)

sel_b : Vector que le indica al mux que debe dejar pasar (si el Reg b, el dataout de la Ram o 0's).

numero_derecho : Vector que es el valor que tiene guardado Reg_b.

de_la_ram : Vector que proviene con la informacion desde el dataout de la ram.

numero_derecho (que recibe el valor de enviado): Vector que se le envia a la ALU.


## Mux_a(mux_para_a)

sel_a : Vector que le indica al mux que debe dejar pasar para la ALU.

numero_izquierdo : Vector que es el valor que contiene el Reg_a.

numero_izquierdo (que recibe el valor de enviado) : Vector que es el valor de output del Mux.


## ALU(operacion_alu)

numero_derecho : Vector que proviene desde el mux_b.

numero_izquierdo : Vector que proviene desde el mux_a.

selAlu : Vector que proviene desde la Control Unit y que le indica a la ALU que operacion debe hacer.

salida : Vector que recibe el resultado de la ALU.

carry: señal que recibe el valor desde el carry de la ALU.

Z : señal que recibe el valor desde el valor z de la ALU.

n : señal que recibe el valor desde el valor n de la ALU.

## Status (status)

clk : Señal del clock que entra como input a status.

entregable_status => Vector que contiene los valor de c,z y n.

entregable_status( output) => Vector que pasa el valor que se guardo en Status antes de nuevo flanco de subida.

## Reg A (tabulador_izquierdo)

clk : Señal del clock que entra como input a reg a.

enableA(0) => valor que le indica al reg si debe cargar el valor que se le entrega en datain.

salida : Vector que contiene el resultado desde la ALU que puede ser cargado en Reg A.

numero_izquierdo : Vector que entrega el valor de Reg A.

## Reg B (tabulador_derecho)

clk: Señal del clock que entra como input a reg b.

enableB(0) => valor que le indica al reg si debe cargar el valor que se le entrega en datain.

salida : Vector que contiene el resultado desde la ALU que puede ser cargado en Reg B.

numero_derecho : Vector que entrega el valor de Reg B.

## Ram (ram)

clk: Señal del clock que entra como input a ram.

w : Señal que le indica a la ram si debe escribir en la direccion indicada por addres lo que se entrego en datain.

salida : Vector que contiene el resultado de la ALU y que se le entrega a la RAM.

de_la_ram: Vector que contiene lo que leyo la ram en la direccion indicada (en caso de haber leido).

instrucciones (28 downto 17): Vector que contiene la addres que la ROM le entrega a la RAM.



