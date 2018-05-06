--     TP Funcional 2018 - Microprocesador - Primera entrega
--     Paradigmas de Programación
--     Realizado por: 
--					del Burgo, María Abril
--					Gagliardi, Diego
--					Laye, Matías
--					Rodríguez Cary, Hernán

module MicroEntrega1 where

--PUNTO 3.1
type Micro = Microprocesador -> Microprocesador
type Valor = Int
type Posicion = Int

data Microprocesador = Microprocesador { memoriaDeDatos :: [Int], acumuladorA :: Int, acumuladorB :: Int, programCounter :: Int, etiqueta :: String } deriving(Show)

xt8088 = Microprocesador { memoriaDeDatos=[], acumuladorA = 0, acumuladorB = 0, programCounter = 0, etiqueta = "" }

--PUNTO 3.2.1
nop :: Micro
nop unMicrocontrolador = unMicrocontrolador {programCounter = programCounter unMicrocontrolador + 1} 

--PUNTO 3.2.2
avanzarTresVecespc :: Micro
avanzarTresVecespc = nop.nop.nop

--PUNTO 3.3.1
lodv :: Valor -> Microprocesador -> Microprocesador
lodv val = nop.cargarValorEnAcumuladorA val

cargarValorEnAcumuladorA :: Valor -> Microprocesador -> Microprocesador
cargarValorEnAcumuladorA val unMicrocontrolador = unMicrocontrolador {acumuladorA = val}

swap :: Micro
swap = nop.intercambiarValores

intercambiarValores :: Micro
intercambiarValores unMicrocontrolador = unMicrocontrolador {acumuladorA = acumuladorB unMicrocontrolador, acumuladorB = acumuladorA unMicrocontrolador}

add :: Micro
add = nop.sumarValores

sumarValores :: Micro
sumarValores unMicrocontrolador = unMicrocontrolador {acumuladorA = acumuladorB unMicrocontrolador + acumuladorA unMicrocontrolador, acumuladorB = 0}

--PUNTO 3.3.2
sumar10mas22 :: Micro
sumar10mas22 = add.lodv 22.swap.lodv 10

--PUNTO 3.4.1
divide :: Micro
divide = nop.dividirAcumuladores

dividirAcumuladores :: Micro
dividirAcumuladores unMicrocontrolador
    | acumuladorB unMicrocontrolador == 0 = unMicrocontrolador {etiqueta = "ERROR DIVISION BY ZERO"} 
    | otherwise =  unMicrocontrolador { acumuladorA = quot (acumuladorA unMicrocontrolador) (acumuladorB unMicrocontrolador), acumuladorB = 0} 

str :: Posicion -> Valor -> Microprocesador -> Microprocesador
str addr val = nop.guardarValorEnMemoria addr val

guardarValorEnMemoria :: Posicion -> Valor -> Microprocesador -> Microprocesador
guardarValorEnMemoria addr val unMicrocontrolador = unMicrocontrolador { memoriaDeDatos = ( take (addr-1) (memoriaDeDatos unMicrocontrolador) ) ++ [val] ++ ( drop (addr-1) (memoriaDeDatos unMicrocontrolador) )}

lod :: Posicion -> Microprocesador -> Microprocesador
lod addr = nop.cargaraDesdeMemoria addr

cargaraDesdeMemoria :: Posicion -> Microprocesador -> Microprocesador
cargaraDesdeMemoria addr unMicrocontrolador = unMicrocontrolador { acumuladorA = (memoriaDeDatos unMicrocontrolador) !! (addr-1) }

--PUNTO 3.4.2
dividir2por0 :: Micro
dividir2por0 = divide.lod 1.swap.lod 2.str 2 0.str 1 2


-- CASOS DE PRUEBA 
fp20 = Microprocesador {memoriaDeDatos=[], acumuladorA = 7, acumuladorB = 24, programCounter = 0, etiqueta = ""}

at8086 = Microprocesador {memoriaDeDatos=[1..20], acumuladorA = 0, acumuladorB = 0, programCounter = 0, etiqueta = ""}

dividir12por4 :: Micro
dividir12por4 = divide . lod 1 . swap . lod 2 . str 2 4 . str 1 12

testxt8088 = Microprocesador { memoriaDeDatos= replicate 1024 0, acumuladorA = 0, acumuladorB = 0, programCounter = 0, etiqueta = ""}
