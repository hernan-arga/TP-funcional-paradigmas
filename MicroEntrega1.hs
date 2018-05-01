

--PUNTO 3.1
data Microprocesador = Microprocesador {memoriaDeDatos :: [Int], acumuladorA :: Int, acumuladorB :: Int, programCounter :: Int, etiqueta :: String} deriving(Show)
{-	Criterios:

memoriaDeDatos: "una gran cantidad de posiciones" no me indica la cantidad de posiciones por lo que tomamos como una lista de enteros-}
xt8088 = Microprocesador {memoriaDeDatos=[], acumuladorA = 0, acumuladorB = 0, programCounter = 0, etiqueta = ""}

--PUNTO 3.2.1
nop unMicro = unMicro {programCounter = programCounter unMicro + 1} 

--PUNTO 3.2.2
--avanzarTresVecesProgramCounter = 

--PUNTO 3.3.1
lodv val unMicro = unMicro {acumuladorA = val}


swap = nop.intercambiarValores

crearTupla unMicro = (acumuladorA unMicro, acumuladorB unMicro)
intercambiarValores unMicro = unMicro {acumuladorA = snd (crearTupla unMicro), acumuladorB = fst (crearTupla unMicro)}

--add = sumarAcumuladores 
