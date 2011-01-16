module FuzzyTime.Danish (showFuzzyTimeDa) where

import {-# SOURCE #-} FuzzyTime


-- Danish (by M_ller from bbs.archlinux.org, with my modifications) ---------------------------------------------------------------------------------------------------------------


showFuzzyTimeDa :: FuzzyTime -> String
showFuzzyTimeDa ft@(FuzzyTime clock hour _ min night style)
	| min == 0	= getHour hour
	| min < 30	= getMin min ++ " over " ++ getHour hour
	| min == 30	= "halv " ++ getHour (nextFTHour ft)
	| min > 30	= getMin (60-min) ++ " i " ++ getHour (nextFTHour ft)
	| otherwise	= "Oops, it looks like it's " ++ show hour ++ ":" ++ show min ++ "."
	where
	getHour :: Int -> String
	getHour h
		| h `mod` 12 == 0	= if style==1 then
								if clock==12 then numeralDa 12 else numeralDa h
								else
								if night then
									"midnat"
									else
									if min `elem` [0, 30] then "aften" else numeralDa h
		| otherwise			= numeralDa h
	getMin :: Int -> String
	getMin m
		| m `elem` [15, 45]	= "kvart"
		| otherwise 		= numeralDa m


numeralDa :: Int -> String
numeralDa n
	| n < 20			= numeralDaHelper1 n
	| n `mod` 10 == 0	= numeralDaHelper10 (n `div` 10)
	| otherwise			= numeralDaHelper1 (n `mod` 10) ++ "og" ++ numeralDaHelper10 (n `div` 10)
	where
	numeralDaHelper1 :: Int -> String
	numeralDaHelper1 i = ["en", "to", "tre", "fire", "fem", "seks", "syv", "otte", "ni", "ti", "elleve", "tolv", "tretten", "fjorten", "femten", "seksten", "sytten", "atten", "nitten"] !! (i-1)
	numeralDaHelper10 :: Int -> String
	numeralDaHelper10 i = ["tyve", "tredive", "fyrre", "halvtreds"] !! (i-2)