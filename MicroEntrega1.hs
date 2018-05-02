--     TP Funcional 2018 - Microprocesador - Primera entrega
--     Paradigmas de Programación
--     Realizado por: 
--					del Burgo, María Abril
--					Gagliardi, Diego
--					Laye, Matías
--					Rodríguez Cary, Hernán

module MicroEntrega1 where

--PUNTO 3.1
data Microprocesador = Microprocesador { memoriaDeDatos :: [Int], acumuladorA :: Int, acumuladorB :: Int, programCounter :: Int, etiqueta :: String } deriving(Show)

xt8088 = Microprocesador { memoriaDeDatos=[], acumuladorA = 0, acumuladorB = 0, programCounter = 0, etiqueta = "" }

--PUNTO 3.2.1
nop :: Microprocesador -> Microprocesador
nop unMicrocontrolador = unMicrocontrolador {programCounter = programCounter unMicrocontrolador + 1} 

--PUNTO 3.2.2
avanzarTresVecespc :: Microprocesador -> Microprocesador
avanzarTresVecespc = nop.nop.nop

--PUNTO 3.3.1
lodv :: Int -> Microprocesador -> Microprocesador
lodv val = nop.cargarValorEna val

cargarValorEna :: Int -> Microprocesador -> Microprocesador
cargarValorEna val unMicrocontrolador = unMicrocontrolador {acumuladorA = val}

swap :: Microprocesador -> Microprocesador
swap = nop.intercambiarValores

intercambiarValores :: Microprocesador -> Microprocesador
intercambiarValores unMicrocontrolador = unMicrocontrolador {acumuladorA = acumuladorB unMicrocontrolador, acumuladorB = acumuladorA unMicrocontrolador}

crearTupla :: Microprocesador -> (Int, Int)
crearTupla unMicrocontrolador = (acumuladorA unMicrocontrolador, acumuladorB unMicrocontrolador)


add :: Microprocesador -> Microprocesador
add = nop.sumarValores

sumarValores :: Microprocesador -> Microprocesador
sumarValores unMicrocontrolador = unMicrocontrolador {acumuladorA = acumuladorB unMicrocontrolador + acumuladorA unMicrocontrolador, acumuladorB = 0}

--PUNTO 3.3.2
sumar10mas22 :: Microprocesador -> Microprocesador
sumar10mas22 = add.lodv 22.swap.lodv 10

--PUNTO 3.4.1
divide :: Microprocesador -> Microprocesador
divide = nop.dividirAcumuladores

dividirAcumuladores :: Microprocesador -> Microprocesador
dividirAcumuladores unMicrocontrolador
    | (acumuladorB unMicrocontrolador) == 0 = unMicrocontrolador {etiqueta = "ERROR DIVISION BY ZERO"} 
    | otherwise =  unMicrocontrolador { acumuladorA = quot (acumuladorA unMicrocontrolador) (acumuladorB unMicrocontrolador), acumuladorB = 0} 

str :: Int -> Int -> Microprocesador -> Microprocesador
str addr val = nop.guardarValorEnMemoria addr val

guardarValorEnMemoria :: Int -> Int -> Microprocesador -> Microprocesador
guardarValorEnMemoria addr val unMicrocontrolador = unMicrocontrolador { memoriaDeDatos = ( take (addr-1) (memoriaDeDatos unMicrocontrolador) ) ++ [val] ++ ( drop addr (memoriaDeDatos unMicrocontrolador) )}

lod :: Int -> Microprocesador -> Microprocesador
lod addr = nop.cargaraDesdeMemoria addr

cargaraDesdeMemoria :: Int -> Microprocesador -> Microprocesador
cargaraDesdeMemoria addr unMicrocontrolador = unMicrocontrolador { acumuladorA = (memoriaDeDatos unMicrocontrolador) !! (addr-1) }

--PUNTO 3.4.2
dividir2por0 :: Microprocesador -> Microprocesador
dividir2por0 = divide.lod 1.swap.lod 2.str 2 0.str 1 2


-- CASOS DE PRUEBA 
fp20 = Microprocesador {memoriaDeDatos=[], acumuladorA = 7, acumuladorB = 24, programCounter = 0, etiqueta = ""}

at8086 = Microprocesador {memoriaDeDatos=[1..20], acumuladorA = 0, acumuladorB = 0, programCounter = 0, etiqueta = ""}

dividir12por4 :: Microprocesador -> Microprocesador
dividir12por4 = divide . lod 1 . swap . lod 2 . str 2 4 . str 1 12
testxt8088 = Microprocesador { memoriaDeDatos= replicate 1024 0, acumuladorA = 0, acumuladorB = 0, programCounter = 0, etiqueta = ""}
