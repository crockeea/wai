{-# LANGUAGE BangPatterns, DeriveDataTypeable, DeriveGeneric, FlexibleInstances, MultiParamTypeClasses #-}
{-# OPTIONS_GHC  -fno-warn-unused-imports #-}
module CertChain.CertChainRaw (CertChainRaw(..)) where
import Prelude ((+), (/))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified GHC.Generics as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'

data CertChainRaw = CertChainRaw{chain :: !(P'.Seq P'.ByteString)}
                  deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data, Prelude'.Generic)

instance P'.Mergeable CertChainRaw where
  mergeAppend (CertChainRaw x'1) (CertChainRaw y'1) = CertChainRaw (P'.mergeAppend x'1 y'1)

instance P'.Default CertChainRaw where
  defaultValue = CertChainRaw P'.defaultValue

instance P'.Wire CertChainRaw where
  wireSize ft' self'@(CertChainRaw x'1)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size = (P'.wireSizeRep 1 12 x'1)
  wirePut ft' self'@(CertChainRaw x'1)
   = case ft' of
       10 -> put'Fields
       11 -> do
               P'.putSize (P'.wireSize 10 self')
               put'Fields
       _ -> P'.wirePutErr ft' self'
    where
        put'Fields
         = do
             P'.wirePutRep 10 12 x'1
  wireGet ft'
   = case ft' of
       10 -> P'.getBareMessageWith update'Self
       11 -> P'.getMessageWith update'Self
       _ -> P'.wireGetErr ft'
    where
        update'Self wire'Tag old'Self
         = case wire'Tag of
             10 -> Prelude'.fmap (\ !new'Field -> old'Self{chain = P'.append (chain old'Self) new'Field}) (P'.wireGet 12)
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in P'.unknown field'Number wire'Type old'Self

instance P'.MessageAPI msg' (msg' -> CertChainRaw) CertChainRaw where
  getVal m' f' = f' m'

instance P'.GPB CertChainRaw

instance P'.ReflectDescriptor CertChainRaw where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList []) (P'.fromDistinctAscList [10])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".CertChain.CertChainRaw\", haskellPrefix = [], parentModule = [MName \"CertChain\"], baseName = MName \"CertChainRaw\"}, descFilePath = [\"CertChain\",\"CertChainRaw.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".CertChain.CertChainRaw.chain\", haskellPrefix' = [], parentModule' = [MName \"CertChain\",MName \"CertChainRaw\"], baseName' = FName \"chain\", baseNamePrefix' = \"\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 10}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = True, mightPack = False, typeCode = FieldType {getFieldType = 12}, typeName = Nothing, hsRawDefault = Nothing, hsDefault = Nothing}], descOneofs = fromList [], keys = fromList [], extRanges = [], knownKeys = fromList [], storeUnknown = False, lazyFields = False, makeLenses = False}"

instance P'.TextType CertChainRaw where
  tellT = P'.tellSubMessage
  getT = P'.getSubMessage

instance P'.TextMsg CertChainRaw where
  textPut msg
   = do
       P'.tellT "chain" (chain msg)
  textGet
   = do
       mods <- P'.sepEndBy (P'.choice [parse'chain]) P'.spaces
       Prelude'.return (Prelude'.foldl (\ v f -> f v) P'.defaultValue mods)
    where
        parse'chain
         = P'.try
            (do
               v <- P'.getT "chain"
               Prelude'.return (\ o -> o{chain = P'.append (chain o) v}))