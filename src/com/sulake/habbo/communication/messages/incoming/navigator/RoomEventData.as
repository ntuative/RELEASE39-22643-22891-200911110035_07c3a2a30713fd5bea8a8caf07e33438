package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IDisposable;
   
   public class RoomEventData implements IDisposable
   {
       
      
      private var _disposed:Boolean;
      
      private var var_1660:String;
      
      private var var_372:int;
      
      private var var_1662:String;
      
      private var var_1659:String;
      
      private var var_1661:int;
      
      private var var_1664:String;
      
      private var var_1663:int;
      
      private var var_546:Array;
      
      private var var_942:Boolean;
      
      public function RoomEventData(param1:IMessageDataWrapper)
      {
         var _loc5_:* = null;
         var_546 = new Array();
         super();
         var _loc2_:String = param1.readString();
         if(_loc2_ == "-1")
         {
            Logger.log("Got null room event");
            this.var_942 = false;
            return;
         }
         this.var_942 = true;
         var_1661 = int(_loc2_);
         var_1662 = param1.readString();
         var_372 = int(param1.readString());
         var_1663 = param1.readInteger();
         var_1660 = param1.readString();
         var_1659 = param1.readString();
         var_1664 = param1.readString();
         var _loc3_:int = param1.readInteger();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1.readString();
            var_546.push(_loc5_);
            _loc4_++;
         }
      }
      
      public function get eventType() : int
      {
         return var_1663;
      }
      
      public function get eventName() : String
      {
         return var_1660;
      }
      
      public function get eventDescription() : String
      {
         return var_1659;
      }
      
      public function get ownerAvatarName() : String
      {
         return var_1662;
      }
      
      public function get tags() : Array
      {
         return var_546;
      }
      
      public function get creationTime() : String
      {
         return var_1664;
      }
      
      public function get exists() : Boolean
      {
         return var_942;
      }
      
      public function get ownerAvatarId() : int
      {
         return var_1661;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
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
      
      public function get flatId() : int
      {
         return var_372;
      }
   }
}
