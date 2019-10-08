--Alunos:
--Diogo Teles Sant Anna RA:169966

-- Descricao do programa:
-- 0) Recebe a string completa da entrada, divide em linhas e da um split na linha vazia.
-- 1) Funcao que recebe uma string multi linhas, o dicionario parcialmente preenchido (como um acumulador) e retorna uma tupla com o restante da string ainda a ser lida e o dicionario preenchido
-- Le os pontos e organiza em um dicionario pSemLabel com nomes como chave e lista com as coordenadas como valor
--
-- 2) Le os pontos e seus labels, os organizam no dicionario pComLabel(como chave, o nome, e como valor uma tupla com o label, e a lista com as coordenadas), mas também em uma lista de tuplas listaFinal  com o primeiro elemento o label e segundo uma lista ordenada com os nomes dos pontos com aquele label. Para cada ponto lido nessa etapa, retira o dado ponto do dicionario pSemLabel e coloca no dicionario pComLabel e na lista listaFinal
-- 3) Recursao ate pSemLabel for vazio
--	3.1) Cria uma lista com tuplas registrando as distancias entre os ponto com label e sem label. Em cada tupla o primeiro elemento é a distancia entre os dois pontos e o segundo é uma tupla com ponto sem label, e o ponto com label, respectivamente.
--	3.2) Usa a funcao minimum nessa lista para obter a tupla com a menor distancia
--	3.3) Obtem o label do ponto com label p1. Adiciona o ponto sem label p2 no dicionario labels, na lista listaFinal, o retira do dicio pSemLabel e adiciona no pComLabel
-- 4) Imprime listaFinal de acordo com o solicitado no enunciado

import qualified Data.Text as T
import qualified Data.Map.Strict as Map

main = do
        content <- getContents
	mapM_ print (proc content)


proc :: String -> [(Int, [String])]
proc content = let
				splittedList = map T.unpack (T.splitOn (T.pack "\n\n") (T.pack content)) -- Splits the entry by the blank line
				fstPart = filter (\s -> s /= "") (lines $ head splittedList) -- gets list of lines on the upper part of the entry
				sndPart = filter (\s -> s /= "") (lines $ head $ tail $ splittedList) -- gets list of line on bottom part
				mapWithoutLabels' = getMapWithoutLabels fstPart Map.empty
				(mapWithoutLabels,mapWithLabels,finalList') = processLabels sndPart mapWithoutLabels' Map.empty Map.empty
				finalList = computeLabelToAllPoints mapWithoutLabels mapWithLabels finalList'
				in Map.assocs finalList

-- Processes points and their coordinates, grouping in a map, coordinates already parsed to Float by the funcion read
getMapWithoutLabels :: [String] -> Map.Map String [Float] -> Map.Map String [Float]
getMapWithoutLabels [] dic = dic
getMapWithoutLabels (p:ps) dic = getMapWithoutLabels ps (Map.insert (head splittedP) (map (read::String->Float) (tail splittedP)) dic) 
				where splittedP = filter (\s -> s /= "") (words p)

-- Processes the inicial labels given. For each point that receives a label, it's taken out of the mapWithoutLabels, and put into mapWithLabels and finalList
processLabels :: [String] -> Map.Map String [Float] -> Map.Map String (String, [Float]) -> Map.Map Int [String] -> (Map.Map String [Float], Map.Map String (String, [Float]), Map.Map Int [String])
processLabels [] withoutLabels withLabels finList = (withoutLabels, withLabels, finList)
processLabels (p:ps) withoutLabels withLabels finList = let 
						(name:label:_) = filter (\s -> s /= "") (words p) -- gets name and label of point from line
						coordinates = withoutLabels Map.! name -- gets coordinates of point form map of point without labels
						in processLabels ps (Map.delete name withoutLabels) (Map.insert name (label, coordinates) withLabels) (insertFinList name label finList) 

-- na listaFinal armazenamos os labels como Int para facilitar a impressao no final
insertFinList :: String -> String -> Map.Map Int [String] -> Map.Map Int [String]
insertFinList name label finList = Map.insertWith (insertSorted) ((read::String->Int) label) [name] finList -- We convert the label to Int to ease the printing at the end of program

-- Receives a list with a single element and inserts this element on the second list, keeping this last one sorted
insertSorted :: Ord x => [x] -> [x] -> [x]
insertSorted newList [] = newList
insertSorted newList (x:xs) = if val <= x then (val:x:xs) else (x:(insertSorted newList xs))
							where val = head newList

-- Based on all points given, their coordinates and on the labels initially given, it recursively computes the labels of the points without label
computeLabelToAllPoints :: Map.Map String [Float] -> Map.Map String (String, [Float]) -> Map.Map Int [String] -> Map.Map Int [String]
computeLabelToAllPoints withoutLabels withLabels finList = if (Map.null withoutLabels) then finList 
	else let
		distancesList = getDistanceList withoutLabels withLabels
		minDistance = minimum distancesList -- gets the tuple with the minimum distance
		(_, (pWithoutLabel, pWithLabel)) = minDistance -- gets the correspondent points
		coordinatesPWithoutLabel = withoutLabels Map.! pWithoutLabel
		(label,_) = withLabels Map.! pWithLabel
		in computeLabelToAllPoints (Map.delete pWithoutLabel withoutLabels) (Map.insert pWithLabel (label, coordinatesPWithoutLabel) withLabels) (insertFinList pWithoutLabel label finList)

-- Given the maps of point with labels and without labels, applies the "getDistance" function on each combination of points between those two groups
getDistanceList :: Map.Map String [Float] -> Map.Map String (String, [Float]) -> [(Float, (String, String))]
getDistanceList withoutLabels withLabels = getDistance <$> (Map.toList withoutLabels) <*> (map (\tup -> (fst tup, snd $ snd tup)) (Map.toList withLabels))

-- Computes the distance between two named points, grouping in a tuple like (distance,(p1, label))
getDistance :: (String, [Float]) -> (String, [Float]) -> (Float, (String, String))
getDistance tupla1 tupla2 = (distance (snd tupla1) (snd tupla2), (fst tupla1, fst tupla2))

-- Calculates the distance between 2 points with n dimensions
distance :: [Float] -> [Float] -> Float
distance [] [] = 0          
distance (u:_) [] = 0   -- 0 por simplicidade de implementacao
distance [] (v:_) = 0   
distance (u:us) (v:vs) = sqrt ((distance us vs)**2 + (u-v)**2)
