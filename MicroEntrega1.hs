--     TP Funcional 2018 - Microprocesador - Primera entrega
--     Paradigmas de Programación
--     Realizado por: 
--					del Burgo, María Abril
--					Gagliardi, Diego
--					Laye, Matías
--					Rodríguez Cary, Hernán

module MicroEntrega1 where

--PUNTO 3.1
data Microprocesador = Microprocesador { memoriaDeDatos :: [Int], a :: Int, b :: Int, pc :: Int, etiqueta :: String } deriving(Show)

xt8088 = Microprocesador { memoriaDeDatos=[], a = 0, b = 0, pc = 0, etiqueta = "" }

--PUNTO 3.2.1
nop :: Microprocesador -> Microprocesador
nop unMicrocontrolador = unMicrocontrolador {pc = pc unMicrocontrolador + 1} 

--PUNTO 3.2.2
avanzarTresVecespc :: Microprocesador -> Microprocesador
avanzarTresVecespc = nop.nop.nop

--PUNTO 3.3.1
lodv :: Int -> Microprocesador -> Microprocesador
lodv val = nop.cargarValorEna val

cargarValorEna :: Int -> Microprocesador -> Microprocesador
cargarValorEna val unMicrocontrolador = unMicrocontrolador {a = val}

swap :: Microprocesador -> Microprocesador
swap = nop.intercambiarValores

intercambiarValores :: Microprocesador -> Microprocesador
intercambiarValores unMicrocontrolador = unMicrocontrolador {a = snd (crearTupla unMicrocontrolador), b = fst (crearTupla unMicrocontrolador)}

crearTupla :: Microprocesador -> (Int, Int)
crearTupla unMicrocontrolador = (a unMicrocontrolador, b unMicrocontrolador)


add :: Microprocesador -> Microprocesador
add = nop.sumarValores

sumarValores :: Microprocesador -> Microprocesador
sumarValores unMicrocontrolador = unMicrocontrolador {a = b unMicrocontrolador + a unMicrocontrolador, b = 0}

--PUNTO 3.3.2
sumar10mas22 :: Microprocesador -> Microprocesador
sumar10mas22 = add.lodv 22.swap.lodv 10

--PUNTO 3.4.1
divide :: Microprocesador -> Microprocesador
divide = nop.dividirAcumuladores

dividirAcumuladores :: Microprocesador -> Microprocesador
dividirAcumuladores unMicrocontrolador
    | (b unMicrocontrolador) == 0 = unMicrocontrolador {etiqueta = "ERROR DIVISION BY ZERO"} 
    | otherwise =  unMicrocontrolador { a = quot (a unMicrocontrolador) (b unMicrocontrolador), b = 0} 

str :: Int -> Int -> Microprocesador -> Microprocesador
str addr val = nop.guardarValorEnMemoria addr val

guardarValorEnMemoria :: Int -> Int -> Microprocesador -> Microprocesador
guardarValorEnMemoria addr val unMicrocontrolador = unMicrocontrolador { memoriaDeDatos = ( take (addr-1) (memoriaDeDatos unMicrocontrolador) ) ++ [val] ++ ( drop addr (memoriaDeDatos unMicrocontrolador) )}

lod :: Int -> Microprocesador -> Microprocesador
lod addr = nop.cargaraDesdeMemoria addr

cargaraDesdeMemoria :: Int -> Microprocesador -> Microprocesador
cargaraDesdeMemoria addr unMicrocontrolador = unMicrocontrolador { a = (memoriaDeDatos unMicrocontrolador) !! (addr-1) }

--PUNTO 3.4.2
dividir2por0 :: Microprocesador -> Microprocesador
dividir2por0 = divide.lod 1.swap.lod 2.str 2 0.str 1 2


-- CASOS DE PRUEBA 
fp20 = Microprocesador {memoriaDeDatos=[], a = 7, b = 24, pc = 0, etiqueta = ""}

at8086 = Microprocesador {memoriaDeDatos=[1..20], a = 0, b = 0, pc = 0, etiqueta = ""}

dividir12por4 :: Microprocesador -> Microprocesador
dividir12por4 = divide . lod 1 . swap . lod 2 . str 2 4 . str 1 12
testxt8088 = Microprocesador { memoriaDeDatos= replicate 1024 0, a = 0, b = 0, pc = 0, etiqueta = ""}


-- RESTRICCIONES
programCounter :: Microprocesador -> Int
programCounter unMicrocontrolador = pc unMicrocontrolador
acumuladorA :: Microprocesador -> Int
acumuladorA unMicrocontrolador = a unMicrocontrolador
acumuladorB :: Microprocesador -> Int
acumuladorB unMicrocontrolador = b unMicrocontrolador
memoria :: Microprocesador -> [Int]
memoria unMicrocontrolador = memoriaDeDatos unMicrocontrolador
mensajeError :: Microprocesador -> String
mensajeError unMicrocontrolador = etiqueta unMicrocontrolador
