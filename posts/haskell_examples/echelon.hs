-- Eliminates leading number in a row
subRow :: [Float] -> [Float] -> [Float]
subRow row1 row2
  | head row1 /= 0  = zipWith (\x y-> x - (head row2)/(head row1)*y) row2　row1
  | otherwise       = 0 : (subRow (tail row1) (tail row2))

-- Performs a gaussian elimination step
eliminate :: [[Float]] -> [Float] -> [[Float]]
eliminate matrix row =
  matrix ++ [foldr subRow row (reverse $ matrix)]

-- Matrix in echelon form
echelon :: [[Float]] -> [[Float]]
echelon matrix =
  foldl eliminate [(head matrix)] (tail matrix)
