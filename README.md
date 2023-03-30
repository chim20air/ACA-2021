# ACA-2021

Repositorio personal con las soluciones de la materia de Arquitectura de Computadoras Avanzada dictada durante el año 2021 para la creación de distintos microprocesadores de arquitectura RISC-V para FPGA. La misma, es la proveniente del kit de desarrollo Digilent Zybo Z7-20 versión B.2. La herramienta con la que se sintetizó el código es Vivado 2020.2. Por razones de facilidad de cálculo, se modfició el xdc para que, en vez de tener un clock de 125 MHz (8ns), se tenga uno de 50MHz (20ns)

Se escribieron los códigos en SystemVerilog para 3 modelos distintos de RV32i basados tanto en el ISA documentado en [The RISC-V Instruction Set Manual v.20191213, versión sin privilegios](https://github.com/riscv/riscv-isa-manual/releases/download/Ratified-IMAFDQC/riscv-spec-20191213.pdf) como en el libro **Digital Design and Computer Architecture - RISC-V Edition** por Harris y Harris. Del libro es que salen las bases para las arquitecturas de todos los modelos de microprocesador.

Se debe destacar, que los códigos implementados en todo este repositorio, no fueron optimizados para alguna plataforma en especial.

Los modelos de RV32i son:
1. monociclo (carpeta riscv32i)
2. multiciclo
3. pipelined

## RV32i monociclo
Para el mismo, se siguió como template la arquitectura propuesta en el libro
![arquitectura monociclo](https://user-images.githubusercontent.com/19641322/228695797-16086187-bcb8-4ba5-8700-068384a69c5d.png)

Ahora se muestra la arquitectura resultante en nivel RTL
![image](https://user-images.githubusercontent.com/19641322/228698376-2fe8f091-4710-4a79-912f-0f85a2521908.png)

Detalle del camino de datos
![image](https://user-images.githubusercontent.com/19641322/228698638-3d73d458-19b9-42cc-9f36-6beb396c02d7.png)

A continuación, se muestran los resultados de la implementación que devuelve la herramienta
![implementacion monociclo](https://user-images.githubusercontent.com/19641322/228696852-819ca3c7-f260-4e96-9341-91a64633c00e.png)
![timing monociclo](https://user-images.githubusercontent.com/19641322/228696398-86a7738a-5676-42e8-ad95-13db6c3b202b.png)
![recursos monociclo](https://user-images.githubusercontent.com/19641322/228691717-62de0153-52c8-488e-88ab-a9d038f6342c.png)

Siguiendo los lineamientos de [Xilinx](https://support.xilinx.com/s/article/57304?language=en_US) para encontrar la frecuencia máxima, tenemos que:

f<sub>m</sub> = 1/(T-WNS) = 1/(20ns - 1.617ns) = 54.4MHz

