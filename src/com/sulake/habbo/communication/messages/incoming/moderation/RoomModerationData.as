package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IDisposable;
   
   public class RoomModerationData implements IDisposable
   {
       
      
      private var var_118:RoomData;
      
      private var _disposed:Boolean;
      
      private var var_1531:int;
      
      private var var_372:int;
      
      private var var_573:RoomData;
      
      private var var_1529:int;
      
      private var _ownerName:String;
      
      private var var_1530:Boolean;
      
      public function RoomModerationData(param1:IMessageDataWrapper)
      {
         super();
         var_372 = param1.readInteger();
         var_1531 = param1.readInteger();
         var_1530 = param1.readBoolean();
         var_1529 = param1.readInteger();
         _ownerName = param1.readString();
         var_118 = new RoomData(param1);
         var_573 = new RoomData(param1);
      }
      
      public function get userCount() : int
      {
         return var_1531;
      }
      
      public function get event() : RoomData
      {
         return var_573;
      }
      
      public function get room() : RoomData
      {
         return var_118;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(var_118 != null)
         {
            var_118.dispose();
            var_118 = null;
         }
         if(var_573 != null)
         {
            var_573.dispose();
            var_573 = null;
         }
      }
      
      public function get flatId() : int
      {
         return var_372;
      }
      
      public function get ownerId() : int
      {
         return var_1529;
      }
      
      public function get ownerInRoom() : Boolean
      {
         return var_1530;
      }
   }
}
