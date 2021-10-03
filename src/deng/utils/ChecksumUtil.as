package deng.utils
{
   import flash.utils.ByteArray;
   
   public class ChecksumUtil
   {
      
      private static var var_1867:Array = makeCRCTable();
       
      
      public function ChecksumUtil()
      {
         super();
      }
      
      private static function makeCRCTable() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = 0;
         var _loc1_:* = [];
         _loc2_ = 0;
         while(_loc2_ < 256)
         {
            _loc4_ = uint(_loc2_);
            _loc3_ = 0;
            while(_loc3_ < 8)
            {
               if(_loc4_ & 1)
               {
                  _loc4_ = uint(3988292384 ^ _loc4_ >>> 1);
               }
               else
               {
                  _loc4_ >>>= 1;
               }
               _loc3_++;
            }
            _loc1_.push(_loc4_);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public static function CRC32(param1:ByteArray, param2:uint = 0, param3:uint = 0) : uint
      {
         var _loc4_:* = 0;
         if(param2 >= param1.length)
         {
            param2 = param1.length;
         }
         if(param3 == 0)
         {
            param3 = param1.length - param2;
         }
         if(param3 + param2 > param1.length)
         {
            param3 = param1.length - param2;
         }
         var _loc5_:* = 4294967295;
         _loc4_ = uint(param2);
         while(_loc4_ < param3)
         {
            _loc5_ = uint(uint(var_1867[(_loc5_ ^ param1[_loc4_]) & 255]) ^ _loc5_ >>> 8);
            _loc4_++;
         }
         return _loc5_ ^ 4294967295;
      }
      
      public static function Adler32(param1:ByteArray, param2:uint = 0, param3:uint = 0) : uint
      {
         var _loc7_:* = 0;
         if(param2 >= param1.length)
         {
            param2 = param1.length;
         }
         if(param3 == 0)
         {
            param3 = param1.length - param2;
         }
         if(param3 + param2 > param1.length)
         {
            param3 = param1.length - param2;
         }
         var _loc4_:uint = param2;
         var _loc5_:* = 1;
         var _loc6_:* = 0;
         while(param3)
         {
            _loc7_ = uint(param3 > 5550 ? 5550 : uint(param3));
            param3 -= _loc7_;
            do
            {
               _loc5_ += param1[_loc4_++];
               _loc6_ += _loc5_;
            }
            while(--_loc7_);
            
            _loc5_ = uint((_loc5_ & 65535) + (_loc5_ >> 16) * 15);
            _loc6_ = uint((_loc6_ & 65535) + (_loc6_ >> 16) * 15);
         }
         if(_loc5_ >= 65521)
         {
            _loc5_ -= 65521;
         }
         _loc6_ = uint((_loc6_ & 65535) + (_loc6_ >> 16) * 15);
         if(_loc6_ >= 65521)
         {
            _loc6_ -= 65521;
         }
         return _loc6_ << 16 | _loc5_;
      }
   }
}
