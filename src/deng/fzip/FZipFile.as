package deng.fzip
{
   import deng.utils.ChecksumUtil;
   import flash.utils.*;
   
   public class FZipFile
   {
      
      public static const const_595:int = 8;
      
      public static const const_1315:int = 10;
      
      public static const const_1068:int = 6;
      
      private static var var_847:Boolean = describeType(ByteArray).factory.method.(@name == "uncompress").hasComplexContent();
      
      public static const const_1182:int = 0;
      
      public static const const_1326:int = 1;
      
      public static const const_1357:int = 2;
      
      public static const const_1473:int = 3;
      
      public static const const_1382:int = 4;
      
      public static const const_1390:int = 5;
      
      public static const const_1438:int = 9;
      
      public static const const_1447:int = 7;
       
      
      private var var_162:uint = 0;
      
      private var var_846:uint = 0;
      
      private var var_569:Date;
      
      private var var_1534:int = -1;
      
      private var parseFunc:Function;
      
      private var var_407:Boolean = false;
      
      private var var_2061:int = -1;
      
      private var var_1015:uint = 0;
      
      private var var_1533:String = "";
      
      private var _extraFields:Dictionary;
      
      private var var_685:uint;
      
      private var var_30:ByteArray;
      
      private var var_567:uint;
      
      private var var_1266:Boolean = false;
      
      private var var_2062:int = -1;
      
      private var var_1267:String = "2.0";
      
      private var var_161:Boolean = false;
      
      private var var_1532:Boolean = false;
      
      private var var_304:String;
      
      private var var_479:uint = 0;
      
      private var var_1014:int = 0;
      
      private var var_350:String = "";
      
      private var var_568:int = 8;
      
      private var var_1268:Boolean = false;
      
      public function FZipFile(param1:String = "utf-8")
      {
         parseFunc = parseFileHead;
         super();
         var_304 = param1;
         _extraFields = new Dictionary();
         var_30 = new ByteArray();
         var_30.endian = Endian.BIG_ENDIAN;
      }
      
      public function get sizeUncompressed() : uint
      {
         return var_479;
      }
      
      public function set method_3(param1:String) : void
      {
         var_350 = param1;
      }
      
      protected function uncompress() : void
      {
         if(var_161 && false)
         {
            var_30.position = 0;
            if(var_847)
            {
               var_30.uncompress.apply(var_30,["deflate"]);
            }
            else
            {
               var_30.uncompress();
            }
            var_30.position = 0;
            var_161 = false;
         }
      }
      
      public function get method_3() : String
      {
         return var_350;
      }
      
      public function get date() : Date
      {
         return var_569;
      }
      
      function parse(param1:IDataInput) : Boolean
      {
         while(param1.bytesAvailable && parseFunc(param1))
         {
         }
         return parseFunc === parseFileIdle;
      }
      
      private function parseFileContent(param1:IDataInput) : Boolean
      {
         if(var_1268)
         {
            parseFunc = parseFileIdle;
            throw new Error("Data descriptors are not supported.");
         }
         if(var_162 == 0)
         {
            parseFunc = parseFileIdle;
         }
         else
         {
            if(param1.bytesAvailable < var_162)
            {
               return false;
            }
            parseContent(param1);
            parseFunc = parseFileIdle;
         }
         return true;
      }
      
      public function get versionNumber() : String
      {
         return var_1267;
      }
      
      public function getContentAsString(param1:Boolean = true, param2:String = "utf-8") : String
      {
         var _loc3_:* = null;
         if(var_161)
         {
            uncompress();
         }
         var_30.position = 0;
         if(param2 == "utf-8")
         {
            _loc3_ = var_30.readUTFBytes(var_30.bytesAvailable);
         }
         else
         {
            _loc3_ = var_30.readMultiByte(var_30.bytesAvailable,param2);
         }
         var_30.position = 0;
         if(param1)
         {
            compress();
         }
         return _loc3_;
      }
      
      private function parseFileIdle(param1:IDataInput) : Boolean
      {
         return false;
      }
      
      protected function parseContent(param1:IDataInput) : void
      {
         var _loc2_:* = 0;
         if(var_568 === const_595 && !var_1266)
         {
            if(var_847)
            {
               param1.readBytes(var_30,0,var_162);
            }
            else
            {
               if(!var_407)
               {
                  throw new Error("Adler32 checksum not found.");
               }
               var_30.writeByte(120);
               _loc2_ = uint(~var_1534 << 6 & 192);
               _loc2_ += 31 - (30720 | _loc2_) % 31;
               var_30.writeByte(_loc2_);
               param1.readBytes(var_30,2,var_162);
               var_30.position = var_30.length;
               var_30.writeUnsignedInt(var_685);
            }
            var_161 = true;
         }
         else
         {
            if(var_568 != const_1182)
            {
               throw new Error("Compression method " + var_568 + " is not supported.");
            }
            param1.readBytes(var_30,0,var_162);
            var_161 = false;
         }
         var_30.position = 0;
      }
      
      private function parseFileHead(param1:IDataInput) : Boolean
      {
         if(param1.bytesAvailable >= 30)
         {
            parseHead(param1);
            if(var_846 + var_1015 > 0)
            {
               parseFunc = parseFileHeadExt;
            }
            else
            {
               parseFunc = parseFileContent;
            }
            return true;
         }
         return false;
      }
      
      public function setContentAsString(param1:String, param2:String = "utf-8") : void
      {
         var_30.length = 0;
         var_30.position = 0;
         var_161 = false;
         if(param1 != null && param1.length > 0)
         {
            if(param2 == "utf-8")
            {
               var_30.writeUTFBytes(param1);
            }
            else
            {
               var_30.writeMultiByte(param1,param2);
            }
            var_567 = ChecksumUtil.CRC32(var_30);
            var_407 = false;
         }
         compress();
      }
      
      public function set date(param1:Date) : void
      {
         var_569 = param1 != null ? param1 : new Date();
      }
      
      public function serialize(param1:IDataOutput, param2:Boolean, param3:Boolean = false, param4:uint = 0) : uint
      {
         var _loc10_:* = null;
         var _loc15_:* = null;
         var _loc16_:Boolean = false;
         if(param1 == null)
         {
            return 0;
         }
         if(param3)
         {
            param1.writeUnsignedInt(33639248);
            param1.writeShort(var_1014 << 8 | 20);
         }
         else
         {
            param1.writeUnsignedInt(67324752);
         }
         param1.writeShort(var_1014 << 8 | 20);
         param1.writeShort(var_304 == "utf-8" ? 2048 : 0);
         param1.writeShort(const_595);
         var _loc5_:Date = var_569 != null ? var_569 : new Date();
         var _loc6_:uint = uint(_loc5_.getSeconds()) | uint(_loc5_.getMinutes()) << 5 | uint(_loc5_.getHours()) << 11;
         var _loc7_:uint = uint(_loc5_.getDate()) | uint(_loc5_.getMonth() + 1) << 5 | uint(_loc5_.getFullYear() - 1980) << 9;
         param1.writeShort(_loc6_);
         param1.writeShort(_loc7_);
         param1.writeUnsignedInt(var_567);
         param1.writeUnsignedInt(var_162);
         param1.writeUnsignedInt(var_479);
         var _loc8_:ByteArray = new ByteArray();
         _loc8_.endian = Endian.LITTLE_ENDIAN;
         if(var_304 == "utf-8")
         {
            _loc8_.writeUTFBytes(var_350);
         }
         else
         {
            _loc8_.writeMultiByte(var_350,var_304);
         }
         var _loc9_:uint = _loc8_.position;
         for(_loc10_ in _extraFields)
         {
            _loc15_ = _extraFields[_loc10_] as ByteArray;
            if(_loc15_ != null)
            {
               _loc8_.writeShort(uint(_loc10_));
               _loc8_.writeShort(uint(_loc15_.length));
               _loc8_.writeBytes(_loc15_);
            }
         }
         if(param2)
         {
            if(!var_407)
            {
               _loc16_ = var_161;
               if(_loc16_)
               {
                  uncompress();
               }
               var_685 = ChecksumUtil.Adler32(var_30,0,var_30.length);
               var_407 = true;
               if(_loc16_)
               {
                  compress();
               }
            }
            _loc8_.writeShort(56026);
            _loc8_.writeShort(4);
            _loc8_.writeUnsignedInt(var_685);
         }
         var _loc11_:uint = _loc8_.position - _loc9_;
         if(param3 && false)
         {
            if(var_304 == "utf-8")
            {
               _loc8_.writeUTFBytes(var_1533);
            }
            else
            {
               _loc8_.writeMultiByte(var_1533,var_304);
            }
         }
         var _loc12_:uint = _loc8_.position - _loc9_ - _loc11_;
         param1.writeShort(_loc9_);
         param1.writeShort(_loc11_);
         if(param3)
         {
            param1.writeShort(_loc12_);
            param1.writeShort(0);
            param1.writeShort(0);
            param1.writeUnsignedInt(0);
            param1.writeUnsignedInt(param4);
         }
         if(_loc9_ + _loc11_ + _loc12_ > 0)
         {
            param1.writeBytes(_loc8_);
         }
         var _loc13_:int = 0;
         if(!param3 && var_162 > 0)
         {
            if(var_847)
            {
               _loc13_ = 0;
               param1.writeBytes(var_30,0,_loc13_);
            }
            else
            {
               _loc13_ = 4294967290;
               param1.writeBytes(var_30,2,_loc13_);
            }
         }
         var _loc14_:uint = 30 + _loc9_ + _loc11_ + _loc12_ + _loc13_;
         if(param3)
         {
            _loc14_ += 16;
         }
         return _loc14_;
      }
      
      public function get sizeCompressed() : uint
      {
         return var_162;
      }
      
      protected function compress() : void
      {
         if(!var_161)
         {
            if(false)
            {
               var_30.position = 0;
               var_479 = var_30.length;
               if(var_847)
               {
                  var_30.compress.apply(var_30,["deflate"]);
                  var_162 = var_30.length;
               }
               else
               {
                  var_30.compress();
                  var_162 = -6;
               }
               var_30.position = 0;
               var_161 = true;
            }
            else
            {
               var_162 = 0;
               var_479 = 0;
            }
         }
      }
      
      private function parseFileHeadExt(param1:IDataInput) : Boolean
      {
         if(param1.bytesAvailable >= var_846 + var_1015)
         {
            parseHeadExt(param1);
            parseFunc = parseFileContent;
            return true;
         }
         return false;
      }
      
      protected function parseHeadExt(param1:IDataInput) : void
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = null;
         if(var_304 == "utf-8")
         {
            var_350 = param1.readUTFBytes(var_846);
         }
         else
         {
            var_350 = param1.readMultiByte(var_846,var_304);
         }
         var _loc2_:uint = var_1015;
         while(_loc2_ > 4)
         {
            _loc3_ = uint(param1.readUnsignedShort());
            _loc4_ = uint(param1.readUnsignedShort());
            if(_loc4_ > _loc2_)
            {
               throw new Error("Parse error in file " + var_350 + ": Extra field data size too big.");
            }
            if(_loc3_ === 56026 && _loc4_ === 4)
            {
               var_685 = param1.readUnsignedInt();
               var_407 = true;
            }
            else if(_loc4_ > 0)
            {
               _loc5_ = new ByteArray();
               param1.readBytes(_loc5_,0,_loc4_);
               _extraFields[_loc3_] = _loc5_;
            }
            _loc2_ -= _loc4_ + 4;
         }
         if(_loc2_ > 0)
         {
            param1.readBytes(new ByteArray(),0,_loc2_);
         }
      }
      
      protected function parseHead(param1:IDataInput) : void
      {
         var _loc2_:uint = param1.readUnsignedShort();
         var_1014 = _loc2_ >> 8;
         var_1267 = Math.floor((_loc2_ & 255) / 10) + "." + (_loc2_ & 255) % 10;
         var _loc3_:uint = param1.readUnsignedShort();
         var_568 = param1.readUnsignedShort();
         var_1266 = (_loc3_ & 1) !== 0;
         var_1268 = (_loc3_ & 8) !== 0;
         var_1532 = (_loc3_ & 32) !== 0;
         if((_loc3_ & 800) !== 0)
         {
            var_304 = "utf-8";
         }
         if(var_568 === const_1068)
         {
            var_2062 = (_loc3_ & 2) !== 0 ? 8192 : 4096;
            var_2061 = (_loc3_ & 4) !== 0 ? 3 : 2;
         }
         else if(var_568 === const_595)
         {
            var_1534 = (_loc3_ & 6) >> 1;
         }
         var _loc4_:uint = param1.readUnsignedShort();
         var _loc5_:uint = param1.readUnsignedShort();
         var _loc6_:* = _loc4_ & 31;
         var _loc7_:* = (_loc4_ & 2016) >> 5;
         var _loc8_:* = (_loc4_ & 63488) >> 11;
         var _loc9_:* = _loc5_ & 31;
         var _loc10_:* = (_loc5_ & 480) >> 5;
         var _loc11_:int = ((_loc5_ & 65024) >> 9) + 1980;
         var_569 = new Date(_loc11_,_loc10_ - 1,_loc9_,_loc8_,_loc7_,_loc6_,0);
         var_567 = param1.readUnsignedInt();
         var_162 = param1.readUnsignedInt();
         var_479 = param1.readUnsignedInt();
         var_846 = param1.readUnsignedShort();
         var_1015 = param1.readUnsignedShort();
      }
      
      public function set content(param1:ByteArray) : void
      {
         if(param1 != null && param1.length > 0)
         {
            param1.position = 0;
            param1.readBytes(var_30,0,param1.length);
            var_567 = ChecksumUtil.CRC32(var_30);
            var_407 = false;
         }
         else
         {
            var_30.length = 0;
            var_30.position = 0;
            var_161 = false;
         }
         compress();
      }
      
      public function toString() : String
      {
         return "[FZipFile]\n  name:" + var_350 + "\n  date:" + var_569 + "\n  sizeCompressed:" + var_162 + "\n  sizeUncompressed:" + var_479 + "\n  versionHost:" + var_1014 + "\n  versionNumber:" + var_1267 + "\n  compressionMethod:" + var_568 + "\n  encrypted:" + var_1266 + "\n  hasDataDescriptor:" + var_1268 + "\n  hasCompressedPatchedData:" + var_1532 + "\n  filenameEncoding:" + var_304 + "\n  crc32:" + var_567.toString(16) + "\n  adler32:" + var_685.toString(16);
      }
      
      public function get content() : ByteArray
      {
         if(var_161)
         {
            uncompress();
         }
         return var_30;
      }
   }
}
