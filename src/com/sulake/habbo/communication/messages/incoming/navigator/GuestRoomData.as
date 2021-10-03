package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IDisposable;
   
   public class GuestRoomData implements IDisposable
   {
       
      
      private var _disposed:Boolean;
      
      private var var_1531:int;
      
      private var var_1875:String;
      
      private var var_1879:int;
      
      private var var_1878:int;
      
      private var var_573:Boolean;
      
      private var var_372:int;
      
      private var var_1011:String;
      
      private var var_1695:int;
      
      private var var_1165:int;
      
      private var _ownerName:String;
      
      private var var_603:String;
      
      private var var_1876:int;
      
      private var var_1877:RoomThumbnailData;
      
      private var var_1697:Boolean;
      
      private var var_546:Array;
      
      public function GuestRoomData(param1:IMessageDataWrapper)
      {
         var _loc4_:* = null;
         var_546 = new Array();
         super();
         var_372 = param1.readInteger();
         var_573 = param1.readBoolean();
         var_603 = param1.readString();
         _ownerName = param1.readString();
         var_1695 = param1.readInteger();
         var_1531 = param1.readInteger();
         var_1876 = param1.readInteger();
         var_1011 = param1.readString();
         var_1879 = param1.readInteger();
         var_1697 = param1.readBoolean();
         var_1878 = param1.readInteger();
         var_1165 = param1.readInteger();
         var_1875 = param1.readString();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readString();
            var_546.push(_loc4_);
            _loc3_++;
         }
         var_1877 = new RoomThumbnailData(param1);
      }
      
      public function get maxUserCount() : int
      {
         return var_1876;
      }
      
      public function get roomName() : String
      {
         return var_603;
      }
      
      public function get userCount() : int
      {
         return var_1531;
      }
      
      public function get score() : int
      {
         return var_1878;
      }
      
      public function get eventCreationTime() : String
      {
         return var_1875;
      }
      
      public function get allowTrading() : Boolean
      {
         return var_1697;
      }
      
      public function get tags() : Array
      {
         return var_546;
      }
      
      public function get event() : Boolean
      {
         return var_573;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         this.var_546 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get categoryId() : int
      {
         return var_1165;
      }
      
      public function get srchSpecPrm() : int
      {
         return var_1879;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function get thumbnail() : RoomThumbnailData
      {
         return var_1877;
      }
      
      public function get doorMode() : int
      {
         return var_1695;
      }
      
      public function get flatId() : int
      {
         return var_372;
      }
      
      public function get description() : String
      {
         return var_1011;
      }
   }
}
