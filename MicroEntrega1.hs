--PUNTO 3.1
data Microprocesador = Microprocesador {memoriaDeDatos :: [Int], acumuladorA :: Int, acumuladorB :: Int, programCounter :: Int, etiqueta :: String} deriving(Show)
xt8088 = Microprocesador {memoriaDeDatos=[], acumuladorA = 0, acumuladorB = 0, programCounter = 0, etiqueta = ""}

--PUNTO 3.2.1
nop = xt8088 {programCounter = programCounter xt8088 + 1} 

--PUNTO 3.2.2
--avanzarTresVecesProgramCounter = 

--PUNTO 3.3.1
lodv val = xt8088 {acumuladorA = val}
