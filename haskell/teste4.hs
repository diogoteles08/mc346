import qualified Data.Char as C
import Data.List
import qualified Data.Set as S
import qualified Data.Text as T

splitStr s = filter (\s -> s /= "") $ map T.unpack $ T.split (\c -> elem c " \n.,;:?!") (T.pack s)

toLowerList list = map (\s -> map C.toLower s) list

countWords list = S.size $ S.fromList list

main = do
        content <- getContents
	print . countWords $ toLowerList $ splitStr content
